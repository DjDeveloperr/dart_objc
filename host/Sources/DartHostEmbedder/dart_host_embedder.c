#include "dart_host_embedder.h"

#include <dart_api.h>
#include <dlfcn.h>
#include <pthread.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef char* (*Dart_SetVMFlagsFn)(int argc, const char** argv);
typedef char* (*Dart_InitializeFn)(Dart_InitializeParams* params);
typedef char* (*Dart_CleanupFn)(void);
typedef Dart_Isolate (*Dart_CreateIsolateGroupFromKernelFn)(
    const char* script_uri,
    const char* name,
    const uint8_t* kernel_buffer,
    intptr_t kernel_buffer_size,
    Dart_IsolateFlags* flags,
    void* isolate_group_data,
    void* isolate_data,
    char** error);
typedef void (*Dart_EnterScopeFn)(void);
typedef void (*Dart_ExitScopeFn)(void);
typedef void (*Dart_EnterIsolateFn)(Dart_Isolate isolate);
typedef void (*Dart_ExitIsolateFn)(void);
typedef Dart_Handle (*Dart_RootLibraryFn)(void);
typedef bool (*Dart_IsNullFn)(Dart_Handle object);
typedef Dart_Handle (*Dart_LoadScriptFromKernelFn)(const uint8_t* kernel_buffer,
                                                    intptr_t kernel_size);
typedef Dart_Handle (*Dart_NewStringFromCStringFn)(const char* str);
typedef Dart_Handle (*Dart_InvokeFn)(Dart_Handle target,
                                     Dart_Handle name,
                                     int number_of_arguments,
                                     Dart_Handle* arguments);
typedef bool (*Dart_IsErrorFn)(Dart_Handle handle);
typedef const char* (*Dart_GetErrorFn)(Dart_Handle handle);
typedef void (*Dart_ShutdownIsolateFn)(void);
typedef void (*Dart_KillIsolateFn)(Dart_Isolate isolate);

typedef struct {
  Dart_SetVMFlagsFn Dart_SetVMFlags;
  Dart_InitializeFn Dart_Initialize;
  Dart_CleanupFn Dart_Cleanup;
  Dart_CreateIsolateGroupFromKernelFn Dart_CreateIsolateGroupFromKernel;
  Dart_EnterScopeFn Dart_EnterScope;
  Dart_ExitScopeFn Dart_ExitScope;
  Dart_EnterIsolateFn Dart_EnterIsolate;
  Dart_ExitIsolateFn Dart_ExitIsolate;
  Dart_RootLibraryFn Dart_RootLibrary;
  Dart_IsNullFn Dart_IsNull;
  Dart_LoadScriptFromKernelFn Dart_LoadScriptFromKernel;
  Dart_NewStringFromCStringFn Dart_NewStringFromCString;
  Dart_InvokeFn Dart_Invoke;
  Dart_IsErrorFn Dart_IsError;
  Dart_GetErrorFn Dart_GetError;
  Dart_ShutdownIsolateFn Dart_ShutdownIsolate;
  Dart_KillIsolateFn Dart_KillIsolate;
} DartApi;

typedef struct {
  void* dartvm_handle;
  DartApi api;
  uint8_t* kernel_buffer;
  intptr_t kernel_size;
  Dart_Isolate isolate;
  pthread_t isolate_thread;
  bool vm_initialized;
  bool isolate_entered;
  bool running;
} EmbedderState;

static EmbedderState g_state = {0};
static pthread_mutex_t g_mutex = PTHREAD_MUTEX_INITIALIZER;
static char g_last_error[4096] = {0};

static void clear_error(void) {
  g_last_error[0] = '\0';
}

__attribute__((format(printf, 1, 2)))
static void set_errorf(const char* fmt, ...) {
  va_list args;
  va_start(args, fmt);
  vsnprintf(g_last_error, sizeof(g_last_error), fmt, args);
  va_end(args);
}

static void* resolve_symbol(void* handle, const char* symbol_name) {
  dlerror();
  void* sym = dlsym(handle, symbol_name);
  if (sym == NULL) {
    const char* err = dlerror();
    set_errorf("Missing symbol %s: %s", symbol_name,
               err != NULL ? err : "unknown dlsym error");
  }
  return sym;
}

static bool load_dart_api(void) {
  DartApi api = {0};
  void* handle = g_state.dartvm_handle;

  api.Dart_SetVMFlags =
      (Dart_SetVMFlagsFn)resolve_symbol(handle, "Dart_SetVMFlags");
  api.Dart_Initialize =
      (Dart_InitializeFn)resolve_symbol(handle, "Dart_Initialize");
  api.Dart_Cleanup = (Dart_CleanupFn)resolve_symbol(handle, "Dart_Cleanup");
  api.Dart_CreateIsolateGroupFromKernel =
      (Dart_CreateIsolateGroupFromKernelFn)resolve_symbol(
          handle, "Dart_CreateIsolateGroupFromKernel");
  api.Dart_EnterScope =
      (Dart_EnterScopeFn)resolve_symbol(handle, "Dart_EnterScope");
  api.Dart_ExitScope =
      (Dart_ExitScopeFn)resolve_symbol(handle, "Dart_ExitScope");
  api.Dart_EnterIsolate =
      (Dart_EnterIsolateFn)resolve_symbol(handle, "Dart_EnterIsolate");
  api.Dart_ExitIsolate =
      (Dart_ExitIsolateFn)resolve_symbol(handle, "Dart_ExitIsolate");
  api.Dart_RootLibrary =
      (Dart_RootLibraryFn)resolve_symbol(handle, "Dart_RootLibrary");
  api.Dart_IsNull = (Dart_IsNullFn)resolve_symbol(handle, "Dart_IsNull");
  api.Dart_LoadScriptFromKernel =
      (Dart_LoadScriptFromKernelFn)resolve_symbol(handle,
                                                  "Dart_LoadScriptFromKernel");
  api.Dart_NewStringFromCString = (Dart_NewStringFromCStringFn)resolve_symbol(
      handle, "Dart_NewStringFromCString");
  api.Dart_Invoke = (Dart_InvokeFn)resolve_symbol(handle, "Dart_Invoke");
  api.Dart_IsError =
      (Dart_IsErrorFn)resolve_symbol(handle, "Dart_IsError");
  api.Dart_GetError =
      (Dart_GetErrorFn)resolve_symbol(handle, "Dart_GetError");
  api.Dart_ShutdownIsolate = (Dart_ShutdownIsolateFn)resolve_symbol(
      handle, "Dart_ShutdownIsolate");
  api.Dart_KillIsolate =
      (Dart_KillIsolateFn)resolve_symbol(handle, "Dart_KillIsolate");

  if (api.Dart_SetVMFlags == NULL || api.Dart_Initialize == NULL ||
      api.Dart_Cleanup == NULL || api.Dart_CreateIsolateGroupFromKernel == NULL ||
      api.Dart_EnterScope == NULL || api.Dart_ExitScope == NULL ||
      api.Dart_EnterIsolate == NULL || api.Dart_ExitIsolate == NULL ||
      api.Dart_RootLibrary == NULL || api.Dart_IsNull == NULL ||
      api.Dart_LoadScriptFromKernel == NULL ||
      api.Dart_NewStringFromCString == NULL || api.Dart_Invoke == NULL ||
      api.Dart_IsError == NULL || api.Dart_GetError == NULL ||
      api.Dart_ShutdownIsolate == NULL || api.Dart_KillIsolate == NULL) {
    return false;
  }

  g_state.api = api;
  return true;
}

static bool read_file(const char* path, uint8_t** buffer_out, intptr_t* size_out) {
  FILE* file = fopen(path, "rb");
  if (file == NULL) {
    set_errorf("Failed to open kernel file: %s", path);
    return false;
  }

  if (fseek(file, 0, SEEK_END) != 0) {
    fclose(file);
    set_errorf("Failed to seek kernel file: %s", path);
    return false;
  }

  long size = ftell(file);
  if (size < 0) {
    fclose(file);
    set_errorf("Failed to read kernel file length: %s", path);
    return false;
  }

  if (fseek(file, 0, SEEK_SET) != 0) {
    fclose(file);
    set_errorf("Failed to rewind kernel file: %s", path);
    return false;
  }

  uint8_t* buffer = (uint8_t*)malloc((size_t)size);
  if (buffer == NULL) {
    fclose(file);
    set_errorf("Out of memory reading kernel file (%ld bytes)", size);
    return false;
  }

  size_t bytes_read = fread(buffer, 1, (size_t)size, file);
  fclose(file);
  if (bytes_read != (size_t)size) {
    free(buffer);
    set_errorf("Failed to read kernel file: %s", path);
    return false;
  }

  *buffer_out = buffer;
  *size_out = (intptr_t)size;
  return true;
}

static void release_kernel_buffer(void) {
  if (g_state.kernel_buffer != NULL) {
    free(g_state.kernel_buffer);
    g_state.kernel_buffer = NULL;
    g_state.kernel_size = 0;
  }
}

static void unload_dartvm_handle(void) {
  if (g_state.dartvm_handle != NULL) {
    dlclose(g_state.dartvm_handle);
    g_state.dartvm_handle = NULL;
  }
  memset(&g_state.api, 0, sizeof(g_state.api));
}

static int stop_locked(void) {
  int status = 0;

  if (!g_state.running) {
    return 0;
  }

  if (g_state.isolate_entered) {
    if (!pthread_equal(g_state.isolate_thread, pthread_self())) {
      set_errorf("Embedded isolate is entered on another thread");
      return 1;
    }
  } else {
    g_state.api.Dart_EnterIsolate(g_state.isolate);
  }
  g_state.api.Dart_KillIsolate(g_state.isolate);
  g_state.api.Dart_ShutdownIsolate();

  g_state.isolate = NULL;
  memset(&g_state.isolate_thread, 0, sizeof(g_state.isolate_thread));
  g_state.isolate_entered = false;
  g_state.running = false;

  if (g_state.vm_initialized) {
    char* cleanup_error = g_state.api.Dart_Cleanup();
    g_state.vm_initialized = false;
    if (cleanup_error != NULL) {
      set_errorf("Dart_Cleanup failed: %s", cleanup_error);
      free(cleanup_error);
      status = 1;
    }
  }

  release_kernel_buffer();
  unload_dartvm_handle();

  return status;
}

int dart_host_embedder_start(const char* dartvm_path,
                             const char* kernel_path,
                             const char* script_uri,
                             const char* entrypoint) {
  pthread_mutex_lock(&g_mutex);
  clear_error();

  if (g_state.running) {
    set_errorf("Embedded Dart VM is already running");
    pthread_mutex_unlock(&g_mutex);
    return 1;
  }

  if (dartvm_path == NULL || dartvm_path[0] == '\0') {
    set_errorf("Missing dartvm path");
    pthread_mutex_unlock(&g_mutex);
    return 1;
  }

  if (kernel_path == NULL || kernel_path[0] == '\0') {
    set_errorf("Missing kernel path");
    pthread_mutex_unlock(&g_mutex);
    return 1;
  }

  if (entrypoint == NULL || entrypoint[0] == '\0') {
    entrypoint = "main";
  }

  if (script_uri == NULL || script_uri[0] == '\0') {
    script_uri = kernel_path;
  }

  if (!read_file(kernel_path, &g_state.kernel_buffer, &g_state.kernel_size)) {
    pthread_mutex_unlock(&g_mutex);
    return 1;
  }

  g_state.dartvm_handle = dlopen(dartvm_path, RTLD_NOW | RTLD_LOCAL);
  if (g_state.dartvm_handle == NULL) {
    set_errorf("Failed to load dartvm at %s: %s", dartvm_path, dlerror());
    release_kernel_buffer();
    pthread_mutex_unlock(&g_mutex);
    return 1;
  }

  if (!load_dart_api()) {
    unload_dartvm_handle();
    release_kernel_buffer();
    pthread_mutex_unlock(&g_mutex);
    return 1;
  }

  char* flags_error = g_state.api.Dart_SetVMFlags(0, NULL);
  if (flags_error != NULL) {
    set_errorf("Dart_SetVMFlags failed: %s", flags_error);
    free(flags_error);
    unload_dartvm_handle();
    release_kernel_buffer();
    pthread_mutex_unlock(&g_mutex);
    return 1;
  }

  Dart_InitializeParams init_params;
  memset(&init_params, 0, sizeof(init_params));
  init_params.version = DART_INITIALIZE_PARAMS_CURRENT_VERSION;

  char* init_error = g_state.api.Dart_Initialize(&init_params);
  if (init_error != NULL) {
    set_errorf("Dart_Initialize failed: %s", init_error);
    free(init_error);
    unload_dartvm_handle();
    release_kernel_buffer();
    pthread_mutex_unlock(&g_mutex);
    return 1;
  }
  g_state.vm_initialized = true;

  char* isolate_error = NULL;
  Dart_Isolate isolate = g_state.api.Dart_CreateIsolateGroupFromKernel(
      script_uri, entrypoint, g_state.kernel_buffer, g_state.kernel_size,
      NULL, NULL, NULL, &isolate_error);
  if (isolate == NULL) {
    set_errorf("Dart_CreateIsolateGroupFromKernel failed: %s",
               isolate_error != NULL ? isolate_error : "unknown error");
    if (isolate_error != NULL) {
      free(isolate_error);
    }
    char* cleanup_error = g_state.api.Dart_Cleanup();
    if (cleanup_error != NULL) {
      free(cleanup_error);
    }
    g_state.vm_initialized = false;
    unload_dartvm_handle();
    release_kernel_buffer();
    pthread_mutex_unlock(&g_mutex);
    return 1;
  }

  g_state.isolate = isolate;
  g_state.isolate_thread = pthread_self();
  g_state.isolate_entered = true;

  g_state.api.Dart_EnterScope();

  Dart_Handle root_library = g_state.api.Dart_RootLibrary();
  if (g_state.api.Dart_IsNull(root_library)) {
    root_library =
        g_state.api.Dart_LoadScriptFromKernel(g_state.kernel_buffer,
                                              g_state.kernel_size);
    if (g_state.api.Dart_IsError(root_library)) {
      set_errorf("Dart_LoadScriptFromKernel failed: %s",
                 g_state.api.Dart_GetError(root_library));
      g_state.api.Dart_ExitScope();
      g_state.api.Dart_ShutdownIsolate();
      g_state.isolate = NULL;
      memset(&g_state.isolate_thread, 0, sizeof(g_state.isolate_thread));
      g_state.isolate_entered = false;
      char* cleanup_error = g_state.api.Dart_Cleanup();
      if (cleanup_error != NULL) {
        free(cleanup_error);
      }
      g_state.vm_initialized = false;
      unload_dartvm_handle();
      release_kernel_buffer();
      pthread_mutex_unlock(&g_mutex);
      return 1;
    }
  }

  Dart_Handle entrypoint_name = g_state.api.Dart_NewStringFromCString(entrypoint);
  if (g_state.api.Dart_IsError(entrypoint_name)) {
    set_errorf("Dart_NewStringFromCString failed: %s",
               g_state.api.Dart_GetError(entrypoint_name));
    g_state.api.Dart_ExitScope();
    g_state.api.Dart_ShutdownIsolate();
    g_state.isolate = NULL;
    memset(&g_state.isolate_thread, 0, sizeof(g_state.isolate_thread));
    g_state.isolate_entered = false;
    char* cleanup_error = g_state.api.Dart_Cleanup();
    if (cleanup_error != NULL) {
      free(cleanup_error);
    }
    g_state.vm_initialized = false;
    unload_dartvm_handle();
    release_kernel_buffer();
    pthread_mutex_unlock(&g_mutex);
    return 1;
  }

  Dart_Handle invoke_result =
      g_state.api.Dart_Invoke(root_library, entrypoint_name, 0, NULL);
  if (g_state.api.Dart_IsError(invoke_result)) {
    set_errorf("Dart entrypoint failed: %s",
               g_state.api.Dart_GetError(invoke_result));
    g_state.api.Dart_ExitScope();
    g_state.api.Dart_ShutdownIsolate();
    g_state.isolate = NULL;
    memset(&g_state.isolate_thread, 0, sizeof(g_state.isolate_thread));
    g_state.isolate_entered = false;
    char* cleanup_error = g_state.api.Dart_Cleanup();
    if (cleanup_error != NULL) {
      free(cleanup_error);
    }
    g_state.vm_initialized = false;
    unload_dartvm_handle();
    release_kernel_buffer();
    pthread_mutex_unlock(&g_mutex);
    return 1;
  }

  g_state.api.Dart_ExitScope();

  g_state.running = true;
  pthread_mutex_unlock(&g_mutex);
  return 0;
}

int dart_host_embedder_stop(void) {
  pthread_mutex_lock(&g_mutex);
  clear_error();
  int status = stop_locked();
  pthread_mutex_unlock(&g_mutex);
  return status;
}

bool dart_host_embedder_is_running(void) {
  pthread_mutex_lock(&g_mutex);
  bool running = g_state.running;
  pthread_mutex_unlock(&g_mutex);
  return running;
}

const char* dart_host_embedder_last_error(void) {
  pthread_mutex_lock(&g_mutex);
  const char* result = g_last_error;
  pthread_mutex_unlock(&g_mutex);
  return result;
}
