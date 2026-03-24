#ifndef DART_HOST_EMBEDDER_H_
#define DART_HOST_EMBEDDER_H_

#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

int dart_host_embedder_start(const char* dartvm_path,
                             const char* kernel_path,
                             const char* script_uri,
                             const char* entrypoint);

int dart_host_embedder_stop(void);

bool dart_host_embedder_is_running(void);

const char* dart_host_embedder_last_error(void);

#ifdef __cplusplus
}
#endif

#endif  // DART_HOST_EMBEDDER_H_
