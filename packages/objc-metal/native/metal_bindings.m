#include <stdint.h>
#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <Metal/Metal.h>

#if !__has_feature(objc_arc)
#error "This file must be compiled with ARC enabled"
#endif

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

typedef struct {
  int64_t version;
  void* (*newWaiter)(void);
  void (*awaitWaiter)(void*);
  void* (*currentIsolate)(void);
  void (*enterIsolate)(void*);
  void (*exitIsolate)(void);
  int64_t (*getMainPortId)(void);
  bool (*getCurrentThreadOwnsIsolate)(int64_t);
} DOBJC_Context;

id objc_retainBlock(id);

#define BLOCKING_BLOCK_IMPL(ctx, BLOCK_SIG, INVOKE_DIRECT, INVOKE_LISTENER)    \
  assert(ctx->version >= 1);                                                   \
  void* targetIsolate = ctx->currentIsolate();                                 \
  int64_t targetPort = ctx->getMainPortId == NULL ? 0 : ctx->getMainPortId();  \
  return BLOCK_SIG {                                                           \
    void* currentIsolate = ctx->currentIsolate();                              \
    bool mayEnterIsolate =                                                     \
        currentIsolate == NULL &&                                              \
        ctx->getCurrentThreadOwnsIsolate != NULL &&                            \
        ctx->getCurrentThreadOwnsIsolate(targetPort);                          \
    if (currentIsolate == targetIsolate || mayEnterIsolate) {                  \
      if (mayEnterIsolate) {                                                   \
        ctx->enterIsolate(targetIsolate);                                      \
      }                                                                        \
      INVOKE_DIRECT;                                                           \
      if (mayEnterIsolate) {                                                   \
        ctx->exitIsolate();                                                    \
      }                                                                        \
    } else {                                                                   \
      void* waiter = ctx->newWaiter();                                         \
      INVOKE_LISTENER;                                                         \
      ctx->awaitWaiter(waiter);                                                \
    }                                                                          \
  };


typedef double  (^_ProtocolTrampoline)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
double  _6utppm_protocolTrampoline_tfvuzk(id target, void * sel) {
  return ((_ProtocolTrampoline)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct __IOSurface *  (^_ProtocolTrampoline_1)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct __IOSurface *  _6utppm_protocolTrampoline_tg5r79(id target, void * sel) {
  return ((_ProtocolTrampoline_1)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTL4CompilerTaskStatus  (^_ProtocolTrampoline_2)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTL4CompilerTaskStatus  _6utppm_protocolTrampoline_4p1a36(id target, void * sel) {
  return ((_ProtocolTrampoline_2)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTL4CounterHeapType  (^_ProtocolTrampoline_3)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTL4CounterHeapType  _6utppm_protocolTrampoline_5mxbou(id target, void * sel) {
  return ((_ProtocolTrampoline_3)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_4)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_1mbt9g9(id target, void * sel) {
  return ((_ProtocolTrampoline_4)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLAccelerationStructureSizes  (^_ProtocolTrampoline_5)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
MTLAccelerationStructureSizes  _6utppm_protocolTrampoline_2e8w9h(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_5)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef MTLArgumentBuffersTier  (^_ProtocolTrampoline_6)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLArgumentBuffersTier  _6utppm_protocolTrampoline_1cth5re(id target, void * sel) {
  return ((_ProtocolTrampoline_6)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLBindingAccess  (^_ProtocolTrampoline_7)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLBindingAccess  _6utppm_protocolTrampoline_vbnp4d(id target, void * sel) {
  return ((_ProtocolTrampoline_7)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLBindingType  (^_ProtocolTrampoline_8)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLBindingType  _6utppm_protocolTrampoline_o0wqtj(id target, void * sel) {
  return ((_ProtocolTrampoline_8)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLBufferSparseTier  (^_ProtocolTrampoline_9)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLBufferSparseTier  _6utppm_protocolTrampoline_16gg0xq(id target, void * sel) {
  return ((_ProtocolTrampoline_9)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLCPUCacheMode  (^_ProtocolTrampoline_10)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLCPUCacheMode  _6utppm_protocolTrampoline_zgv4ld(id target, void * sel) {
  return ((_ProtocolTrampoline_10)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLCommandBufferErrorOption  (^_ProtocolTrampoline_11)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLCommandBufferErrorOption  _6utppm_protocolTrampoline_1uxsnii(id target, void * sel) {
  return ((_ProtocolTrampoline_11)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLCommandBufferStatus  (^_ProtocolTrampoline_12)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLCommandBufferStatus  _6utppm_protocolTrampoline_ori513(id target, void * sel) {
  return ((_ProtocolTrampoline_12)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLCommandEncoderErrorState  (^_ProtocolTrampoline_13)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLCommandEncoderErrorState  _6utppm_protocolTrampoline_e57rzo(id target, void * sel) {
  return ((_ProtocolTrampoline_13)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLSamplePosition  (^_ProtocolTrampoline_14)(void * sel, MTLSamplePosition arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
MTLSamplePosition  _6utppm_protocolTrampoline_1wv7urk(id target, void * sel, MTLSamplePosition arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_14)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef MTLDataType  (^_ProtocolTrampoline_15)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLDataType  _6utppm_protocolTrampoline_1yat1y8(id target, void * sel) {
  return ((_ProtocolTrampoline_15)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLDeviceLocation  (^_ProtocolTrampoline_16)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLDeviceLocation  _6utppm_protocolTrampoline_6ss3hz(id target, void * sel) {
  return ((_ProtocolTrampoline_16)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLDispatchType  (^_ProtocolTrampoline_17)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLDispatchType  _6utppm_protocolTrampoline_1n4cnoy(id target, void * sel) {
  return ((_ProtocolTrampoline_17)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLFunctionLogType  (^_ProtocolTrampoline_18)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLFunctionLogType  _6utppm_protocolTrampoline_6uqkey(id target, void * sel) {
  return ((_ProtocolTrampoline_18)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLFunctionOptions  (^_ProtocolTrampoline_19)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLFunctionOptions  _6utppm_protocolTrampoline_1m1xpni(id target, void * sel) {
  return ((_ProtocolTrampoline_19)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_20)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_xr62hr(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_20)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef MTLFunctionType  (^_ProtocolTrampoline_21)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLFunctionType  _6utppm_protocolTrampoline_srgf34(id target, void * sel) {
  return ((_ProtocolTrampoline_21)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLHazardTrackingMode  (^_ProtocolTrampoline_22)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLHazardTrackingMode  _6utppm_protocolTrampoline_1g8njem(id target, void * sel) {
  return ((_ProtocolTrampoline_22)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLHeapType  (^_ProtocolTrampoline_23)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLHeapType  _6utppm_protocolTrampoline_4lks1a(id target, void * sel) {
  return ((_ProtocolTrampoline_23)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLIOStatus  (^_ProtocolTrampoline_24)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLIOStatus  _6utppm_protocolTrampoline_1hwx3bi(id target, void * sel) {
  return ((_ProtocolTrampoline_24)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLLibraryType  (^_ProtocolTrampoline_25)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLLibraryType  _6utppm_protocolTrampoline_s1qd2h(id target, void * sel) {
  return ((_ProtocolTrampoline_25)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLPatchType  (^_ProtocolTrampoline_26)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLPatchType  _6utppm_protocolTrampoline_1xstr86(id target, void * sel) {
  return ((_ProtocolTrampoline_26)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLPixelFormat  (^_ProtocolTrampoline_27)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLPixelFormat  _6utppm_protocolTrampoline_1utgvu9(id target, void * sel) {
  return ((_ProtocolTrampoline_27)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLPurgeableState  (^_ProtocolTrampoline_28)(void * sel, MTLPurgeableState arg1);
__attribute__((visibility("default"))) __attribute__((used))
MTLPurgeableState  _6utppm_protocolTrampoline_eqqb4h(id target, void * sel, MTLPurgeableState arg1) {
  return ((_ProtocolTrampoline_28)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef MTLReadWriteTextureTier  (^_ProtocolTrampoline_29)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLReadWriteTextureTier  _6utppm_protocolTrampoline_wmhw8a(id target, void * sel) {
  return ((_ProtocolTrampoline_29)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct MTLResourceID  (^_ProtocolTrampoline_30)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct MTLResourceID  _6utppm_protocolTrampoline_14kff1y(id target, void * sel) {
  return ((_ProtocolTrampoline_30)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct MTLResourceID  (^_ProtocolTrampoline_31)(void * sel, id arg1, id arg2, unsigned long arg3, unsigned long arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
struct MTLResourceID  _6utppm_protocolTrampoline_1bog1kl(id target, void * sel, id arg1, id arg2, unsigned long arg3, unsigned long arg4, unsigned long arg5) {
  return ((_ProtocolTrampoline_31)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef struct MTLResourceID  (^_ProtocolTrampoline_32)(void * sel, id arg1, struct _NSRange arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
struct MTLResourceID  _6utppm_protocolTrampoline_x5pck9(id target, void * sel, id arg1, struct _NSRange arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_32)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef struct MTLResourceID  (^_ProtocolTrampoline_33)(void * sel, id arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
struct MTLResourceID  _6utppm_protocolTrampoline_vd56fb(id target, void * sel, id arg1, id arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_33)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef struct MTLResourceID  (^_ProtocolTrampoline_34)(void * sel, id arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct MTLResourceID  _6utppm_protocolTrampoline_y6v36x(id target, void * sel, id arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_34)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef MTLResourceOptions  (^_ProtocolTrampoline_35)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLResourceOptions  _6utppm_protocolTrampoline_18p282y(id target, void * sel) {
  return ((_ProtocolTrampoline_35)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLShaderValidation  (^_ProtocolTrampoline_36)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLShaderValidation  _6utppm_protocolTrampoline_toica6(id target, void * sel) {
  return ((_ProtocolTrampoline_36)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLSizeAndAlign  (^_ProtocolTrampoline_37)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLSizeAndAlign  _6utppm_protocolTrampoline_nplw35(id target, void * sel) {
  return ((_ProtocolTrampoline_37)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLSizeAndAlign  (^_ProtocolTrampoline_38)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
MTLSizeAndAlign  _6utppm_protocolTrampoline_1jrpy3r(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_38)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef MTLSizeAndAlign  (^_ProtocolTrampoline_39)(void * sel, unsigned long arg1);
__attribute__((visibility("default"))) __attribute__((used))
MTLSizeAndAlign  _6utppm_protocolTrampoline_3kzaei(id target, void * sel, unsigned long arg1) {
  return ((_ProtocolTrampoline_39)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef MTLSizeAndAlign  (^_ProtocolTrampoline_40)(void * sel, unsigned long arg1, MTLResourceOptions arg2);
__attribute__((visibility("default"))) __attribute__((used))
MTLSizeAndAlign  _6utppm_protocolTrampoline_1x5wkbj(id target, void * sel, unsigned long arg1, MTLResourceOptions arg2) {
  return ((_ProtocolTrampoline_40)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef MTLSize  (^_ProtocolTrampoline_41)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLSize  _6utppm_protocolTrampoline_8c4zsv(id target, void * sel) {
  return ((_ProtocolTrampoline_41)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLSize  (^_ProtocolTrampoline_42)(void * sel, MTLTextureType arg1, MTLPixelFormat arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
MTLSize  _6utppm_protocolTrampoline_1oj3nt4(id target, void * sel, MTLTextureType arg1, MTLPixelFormat arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_42)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef MTLSize  (^_ProtocolTrampoline_43)(void * sel, MTLTextureType arg1, MTLPixelFormat arg2, unsigned long arg3, MTLSparsePageSize arg4);
__attribute__((visibility("default"))) __attribute__((used))
MTLSize  _6utppm_protocolTrampoline_mzj6v3(id target, void * sel, MTLTextureType arg1, MTLPixelFormat arg2, unsigned long arg3, MTLSparsePageSize arg4) {
  return ((_ProtocolTrampoline_43)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef MTLSize  (^_ProtocolTrampoline_44)(void * sel, unsigned long arg1);
__attribute__((visibility("default"))) __attribute__((used))
MTLSize  _6utppm_protocolTrampoline_1phsu60(id target, void * sel, unsigned long arg1) {
  return ((_ProtocolTrampoline_44)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef MTLStages  (^_ProtocolTrampoline_45)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLStages  _6utppm_protocolTrampoline_1ajuob9(id target, void * sel) {
  return ((_ProtocolTrampoline_45)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLStorageMode  (^_ProtocolTrampoline_46)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLStorageMode  _6utppm_protocolTrampoline_1r5fu12(id target, void * sel) {
  return ((_ProtocolTrampoline_46)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLTensorDataType  (^_ProtocolTrampoline_47)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLTensorDataType  _6utppm_protocolTrampoline_teygxb(id target, void * sel) {
  return ((_ProtocolTrampoline_47)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLTensorUsage  (^_ProtocolTrampoline_48)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLTensorUsage  _6utppm_protocolTrampoline_defsxw(id target, void * sel) {
  return ((_ProtocolTrampoline_48)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLTextureCompressionType  (^_ProtocolTrampoline_49)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLTextureCompressionType  _6utppm_protocolTrampoline_1nbnwnd(id target, void * sel) {
  return ((_ProtocolTrampoline_49)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLTextureSparseTier  (^_ProtocolTrampoline_50)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLTextureSparseTier  _6utppm_protocolTrampoline_4n7ln9(id target, void * sel) {
  return ((_ProtocolTrampoline_50)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLTextureSwizzleChannels  (^_ProtocolTrampoline_51)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLTextureSwizzleChannels  _6utppm_protocolTrampoline_7y1w3d(id target, void * sel) {
  return ((_ProtocolTrampoline_51)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLTextureType  (^_ProtocolTrampoline_52)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLTextureType  _6utppm_protocolTrampoline_11q778p(id target, void * sel) {
  return ((_ProtocolTrampoline_52)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef MTLTextureUsage  (^_ProtocolTrampoline_53)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
MTLTextureUsage  _6utppm_protocolTrampoline_1o3k4e2(id target, void * sel) {
  return ((_ProtocolTrampoline_53)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_54)(void * sel, id arg1, struct _NSRange arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_19u921t(id target, void * sel, id arg1, struct _NSRange arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_54)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_55)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_1yw2rcr(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_55)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_56)(void * sel, id arg1, id arg2, unsigned long arg3, uint64_t arg4, id arg5, id arg6, long * arg7);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_1chy5b9(id target, void * sel, id arg1, id arg2, unsigned long arg3, uint64_t arg4, id arg5, id arg6, long * arg7) {
  return ((_ProtocolTrampoline_56)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
}

typedef id  (^_ProtocolTrampoline_57)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_zi5eed(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_57)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_58)(void * sel, id * arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_361moc(id target, void * sel, id * arg1) {
  return ((_ProtocolTrampoline_58)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_59)(void * sel, struct _NSRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_xzy3cf(id target, void * sel, struct _NSRange arg1) {
  return ((_ProtocolTrampoline_59)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_60)(void * sel, struct objc_selector * arg1, NSCalculationError arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_738w24(id target, void * sel, struct objc_selector * arg1, NSCalculationError arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_60)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef long  (^_ProtocolTrampoline_61)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
long  _6utppm_protocolTrampoline_fai2e9(id target, void * sel) {
  return ((_ProtocolTrampoline_61)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct _NSRange  (^_ProtocolTrampoline_62)(void * sel, id arg1, id arg2, id arg3, id * arg4);
__attribute__((visibility("default"))) __attribute__((used))
struct _NSRange  _6utppm_protocolTrampoline_xsqx6i(id target, void * sel, id arg1, id arg2, id arg3, id * arg4) {
  return ((_ProtocolTrampoline_62)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef struct _NSRange  (^_ProtocolTrampoline_63)(void * sel, id arg1, id arg2, id arg3, long * arg4, BOOL arg5);
__attribute__((visibility("default"))) __attribute__((used))
struct _NSRange  _6utppm_protocolTrampoline_1j6oadz(id target, void * sel, id arg1, id arg2, id arg3, long * arg4, BOOL arg5) {
  return ((_ProtocolTrampoline_63)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef NSRoundingMode  (^_ProtocolTrampoline_64)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSRoundingMode  _6utppm_protocolTrampoline_5cb1bj(id target, void * sel) {
  return ((_ProtocolTrampoline_64)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef unsigned long  (^_ProtocolTrampoline_65)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _6utppm_protocolTrampoline_1ckyi24(id target, void * sel) {
  return ((_ProtocolTrampoline_65)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef unsigned long  (^_ProtocolTrampoline_66)(void * sel, MTL4CounterHeapType arg1);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _6utppm_protocolTrampoline_1iy72o3(id target, void * sel, MTL4CounterHeapType arg1) {
  return ((_ProtocolTrampoline_66)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef unsigned long  (^_ProtocolTrampoline_67)(void * sel, MTLPixelFormat arg1);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _6utppm_protocolTrampoline_10cl8qu(id target, void * sel, MTLPixelFormat arg1) {
  return ((_ProtocolTrampoline_67)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef unsigned long  (^_ProtocolTrampoline_68)(void * sel, MTLSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _6utppm_protocolTrampoline_jof8uq(id target, void * sel, MTLSize arg1) {
  return ((_ProtocolTrampoline_68)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef unsigned long  (^_ProtocolTrampoline_69)(void * sel, MTLSparsePageSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _6utppm_protocolTrampoline_p2u2t7(id target, void * sel, MTLSparsePageSize arg1) {
  return ((_ProtocolTrampoline_69)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef unsigned long  (^_ProtocolTrampoline_70)(void * sel, NSFastEnumerationState * arg1, id * arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _6utppm_protocolTrampoline_17ap02x(id target, void * sel, NSFastEnumerationState * arg1, id * arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_70)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef unsigned long  (^_ProtocolTrampoline_71)(void * sel, unsigned long arg1);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _6utppm_protocolTrampoline_c19g8h(id target, void * sel, unsigned long arg1) {
  return ((_ProtocolTrampoline_71)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef uint32_t  (^_ProtocolTrampoline_72)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
uint32_t  _6utppm_protocolTrampoline_1ayzm4d(id target, void * sel) {
  return ((_ProtocolTrampoline_72)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef uint64_t  (^_ProtocolTrampoline_73)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
uint64_t  _6utppm_protocolTrampoline_k3xjiw(id target, void * sel) {
  return ((_ProtocolTrampoline_73)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_74)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6utppm_protocolTrampoline_e3qsqz(id target, void * sel) {
  return ((_ProtocolTrampoline_74)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_75)(void * sel, id arg1, id * arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6utppm_protocolTrampoline_joosg4(id target, void * sel, id arg1, id * arg2) {
  return ((_ProtocolTrampoline_75)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_76)(void * sel, MTLCounterSamplingPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6utppm_protocolTrampoline_1tv8jr(id target, void * sel, MTLCounterSamplingPoint arg1) {
  return ((_ProtocolTrampoline_76)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_77)(void * sel, MTLFeatureSet arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6utppm_protocolTrampoline_9bgrl6(id target, void * sel, MTLFeatureSet arg1) {
  return ((_ProtocolTrampoline_77)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_78)(void * sel, id arg1, id arg2, id * arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6utppm_protocolTrampoline_oqebfq(id target, void * sel, id arg1, id arg2, id * arg3) {
  return ((_ProtocolTrampoline_78)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_79)(void * sel, MTLGPUFamily arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6utppm_protocolTrampoline_o3i15y(id target, void * sel, MTLGPUFamily arg1) {
  return ((_ProtocolTrampoline_79)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_80)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6utppm_protocolTrampoline_2n06mv(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_80)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_81)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6utppm_protocolTrampoline_jk8du5(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_81)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_82)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6utppm_protocolTrampoline_1em3l8z(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_82)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_83)(void * sel, unsigned long arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6utppm_protocolTrampoline_15ssoz8(id target, void * sel, unsigned long arg1) {
  return ((_ProtocolTrampoline_83)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_84)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6utppm_protocolTrampoline_3su7tt(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_84)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_85)(void * sel, uint64_t arg1, uint64_t arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _6utppm_protocolTrampoline_19jrxa7(id target, void * sel, uint64_t arg1, uint64_t arg2) {
  return ((_ProtocolTrampoline_85)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef short  (^_ProtocolTrampoline_86)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
short  _6utppm_protocolTrampoline_p984hf(id target, void * sel) {
  return ((_ProtocolTrampoline_86)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline)(void);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _6utppm_wrapListenerBlock_1pl9qdv(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void() {
    objc_retainBlock(block);
    block();
  };
}

typedef void  (^_BlockingTrampoline)(void * waiter);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _6utppm_wrapBlockingBlock_1pl9qdv(
    _BlockingTrampoline block, _BlockingTrampoline listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(), {
    objc_retainBlock(block);
    block(nil);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter);
  });
}

typedef void  (^_ListenerTrampoline_1)(id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _6utppm_wrapListenerBlock_pfv6jd(_ListenerTrampoline_1 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_1)(void * waiter, id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _6utppm_wrapBlockingBlock_pfv6jd(
    _BlockingTrampoline_1 block, _BlockingTrampoline_1 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_2)(id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _6utppm_wrapListenerBlock_xtuoz7(_ListenerTrampoline_2 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0));
  };
}

typedef void  (^_BlockingTrampoline_2)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _6utppm_wrapBlockingBlock_xtuoz7(
    _BlockingTrampoline_2 block, _BlockingTrampoline_2 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0));
  });
}

typedef void  (^_ListenerTrampoline_3)(id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _6utppm_wrapListenerBlock_r8gdi7(_ListenerTrampoline_3 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_3)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _6utppm_wrapBlockingBlock_r8gdi7(
    _BlockingTrampoline_3 block, _BlockingTrampoline_3 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ListenerTrampoline_4)(id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _6utppm_wrapListenerBlock_f167m6(_ListenerTrampoline_4 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block(objc_retainBlock(arg0));
  };
}

typedef void  (^_BlockingTrampoline_4)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _6utppm_wrapBlockingBlock_f167m6(
    _BlockingTrampoline_4 block, _BlockingTrampoline_4 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0), {
    objc_retainBlock(block);
    block(nil, objc_retainBlock(arg0));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, objc_retainBlock(arg0));
  });
}

typedef void  (^_ListenerTrampoline_5)(NSBackgroundActivityResult arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _6utppm_wrapListenerBlock_10ssdng(_ListenerTrampoline_5 block) NS_RETURNS_RETAINED {
  return ^void(NSBackgroundActivityResult arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_5)(void * waiter, NSBackgroundActivityResult arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _6utppm_wrapBlockingBlock_10ssdng(
    _BlockingTrampoline_5 block, _BlockingTrampoline_5 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(NSBackgroundActivityResult arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_6)(id arg0, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _6utppm_wrapListenerBlock_rnu2c5(_ListenerTrampoline_6 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_6)(void * waiter, id arg0, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _6utppm_wrapBlockingBlock_rnu2c5(
    _BlockingTrampoline_6 block, _BlockingTrampoline_6 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ListenerTrampoline_7)(id arg0, BOOL arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _6utppm_wrapListenerBlock_1uqbrux(_ListenerTrampoline_7 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_7)(void * waiter, id arg0, BOOL arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _6utppm_wrapBlockingBlock_1uqbrux(
    _BlockingTrampoline_7 block, _BlockingTrampoline_7 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL arg1, BOOL * arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef void  (^_ListenerTrampoline_8)(id arg0, struct _NSRange arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _6utppm_wrapListenerBlock_1a22wz(_ListenerTrampoline_8 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_8)(void * waiter, id arg0, struct _NSRange arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _6utppm_wrapBlockingBlock_1a22wz(
    _BlockingTrampoline_8 block, _BlockingTrampoline_8 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, struct _NSRange arg1, BOOL * arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef void  (^_ListenerTrampoline_9)(id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _6utppm_wrapListenerBlock_1b3bb6a(_ListenerTrampoline_9 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(objc_retainBlock(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_9)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _6utppm_wrapBlockingBlock_1b3bb6a(
    _BlockingTrampoline_9 block, _BlockingTrampoline_9 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, objc_retainBlock(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, objc_retainBlock(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ListenerTrampoline_10)(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _6utppm_wrapListenerBlock_lmc3p5(_ListenerTrampoline_10 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_10)(void * waiter, id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _6utppm_wrapBlockingBlock_lmc3p5(
    _BlockingTrampoline_10 block, _BlockingTrampoline_10 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  });
}

typedef void  (^_ListenerTrampoline_11)(id arg0, id arg1, MTLLogLevel arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _6utppm_wrapListenerBlock_xbkiks(_ListenerTrampoline_11 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, MTLLogLevel arg2, id arg3) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_11)(void * waiter, id arg0, id arg1, MTLLogLevel arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _6utppm_wrapBlockingBlock_xbkiks(
    _BlockingTrampoline_11 block, _BlockingTrampoline_11 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, MTLLogLevel arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ListenerTrampoline_12)(id arg0, NSMatchingFlags arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _6utppm_wrapListenerBlock_6jvo9y(_ListenerTrampoline_12 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, NSMatchingFlags arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_12)(void * waiter, id arg0, NSMatchingFlags arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _6utppm_wrapBlockingBlock_6jvo9y(
    _BlockingTrampoline_12 block, _BlockingTrampoline_12 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, NSMatchingFlags arg1, BOOL * arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef void  (^_ListenerTrampoline_13)(NSURLSessionAuthChallengeDisposition arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _6utppm_wrapListenerBlock_n8yd09(_ListenerTrampoline_13 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionAuthChallengeDisposition arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_13)(void * waiter, NSURLSessionAuthChallengeDisposition arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _6utppm_wrapBlockingBlock_n8yd09(
    _BlockingTrampoline_13 block, _BlockingTrampoline_13 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(NSURLSessionAuthChallengeDisposition arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_14)(NSURLSessionDelayedRequestDisposition arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _6utppm_wrapListenerBlock_1otpo83(_ListenerTrampoline_14 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionDelayedRequestDisposition arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_14)(void * waiter, NSURLSessionDelayedRequestDisposition arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _6utppm_wrapBlockingBlock_1otpo83(
    _BlockingTrampoline_14 block, _BlockingTrampoline_14 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(NSURLSessionDelayedRequestDisposition arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_15)(NSURLSessionResponseDisposition arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _6utppm_wrapListenerBlock_16sve1d(_ListenerTrampoline_15 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionResponseDisposition arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_15)(void * waiter, NSURLSessionResponseDisposition arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _6utppm_wrapBlockingBlock_16sve1d(
    _BlockingTrampoline_15 block, _BlockingTrampoline_15 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(NSURLSessionResponseDisposition arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_16)(BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _6utppm_wrapListenerBlock_1s56lr9(_ListenerTrampoline_16 block) NS_RETURNS_RETAINED {
  return ^void(BOOL arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_16)(void * waiter, BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _6utppm_wrapBlockingBlock_1s56lr9(
    _BlockingTrampoline_16 block, _BlockingTrampoline_16 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(BOOL arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void *  (^_ProtocolTrampoline_87)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
void *  _6utppm_protocolTrampoline_3fl8pv(id target, void * sel) {
  return ((_ProtocolTrampoline_87)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_17)(void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _6utppm_wrapListenerBlock_ovsamd(_ListenerTrampoline_17 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_17)(void * waiter, void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _6utppm_wrapBlockingBlock_ovsamd(
    _BlockingTrampoline_17 block, _BlockingTrampoline_17 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ProtocolTrampoline_88)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_ovsamd(id target, void * sel) {
  return ((_ProtocolTrampoline_88)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_18)(void * arg0, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _6utppm_wrapListenerBlock_18sfmo2(_ListenerTrampoline_18 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, double arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_18)(void * waiter, void * arg0, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _6utppm_wrapBlockingBlock_18sfmo2(
    _BlockingTrampoline_18 block, _BlockingTrampoline_18 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, double arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_89)(void * sel, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_18sfmo2(id target, void * sel, double arg1) {
  return ((_ProtocolTrampoline_89)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_19)(void * arg0, MTL4TimestampGranularity arg1, MTLRenderStages arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_19 _6utppm_wrapListenerBlock_5ltbyd(_ListenerTrampoline_19 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTL4TimestampGranularity arg1, MTLRenderStages arg2, id arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  };
}

typedef void  (^_BlockingTrampoline_19)(void * waiter, void * arg0, MTL4TimestampGranularity arg1, MTLRenderStages arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_19 _6utppm_wrapBlockingBlock_5ltbyd(
    _BlockingTrampoline_19 block, _BlockingTrampoline_19 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTL4TimestampGranularity arg1, MTLRenderStages arg2, id arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  });
}

typedef void  (^_ProtocolTrampoline_90)(void * sel, MTL4TimestampGranularity arg1, MTLRenderStages arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_5ltbyd(id target, void * sel, MTL4TimestampGranularity arg1, MTLRenderStages arg2, id arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_90)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_20)(void * arg0, MTL4TimestampGranularity arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_20 _6utppm_wrapListenerBlock_1iqd6xl(_ListenerTrampoline_20 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTL4TimestampGranularity arg1, id arg2, unsigned long arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_20)(void * waiter, void * arg0, MTL4TimestampGranularity arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_20 _6utppm_wrapBlockingBlock_1iqd6xl(
    _BlockingTrampoline_20 block, _BlockingTrampoline_20 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTL4TimestampGranularity arg1, id arg2, unsigned long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_91)(void * sel, MTL4TimestampGranularity arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1iqd6xl(id target, void * sel, MTL4TimestampGranularity arg1, id arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_91)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_21)(void * arg0, MTLBarrierScope arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_21 _6utppm_wrapListenerBlock_uhmkct(_ListenerTrampoline_21 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLBarrierScope arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_21)(void * waiter, void * arg0, MTLBarrierScope arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_21 _6utppm_wrapBlockingBlock_uhmkct(
    _BlockingTrampoline_21 block, _BlockingTrampoline_21 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLBarrierScope arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_92)(void * sel, MTLBarrierScope arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_uhmkct(id target, void * sel, MTLBarrierScope arg1) {
  return ((_ProtocolTrampoline_92)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_22)(void * arg0, MTLBarrierScope arg1, MTLRenderStages arg2, MTLRenderStages arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_22 _6utppm_wrapListenerBlock_1dwjah9(_ListenerTrampoline_22 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLBarrierScope arg1, MTLRenderStages arg2, MTLRenderStages arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_22)(void * waiter, void * arg0, MTLBarrierScope arg1, MTLRenderStages arg2, MTLRenderStages arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_22 _6utppm_wrapBlockingBlock_1dwjah9(
    _BlockingTrampoline_22 block, _BlockingTrampoline_22 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLBarrierScope arg1, MTLRenderStages arg2, MTLRenderStages arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_93)(void * sel, MTLBarrierScope arg1, MTLRenderStages arg2, MTLRenderStages arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1dwjah9(id target, void * sel, MTLBarrierScope arg1, MTLRenderStages arg2, MTLRenderStages arg3) {
  return ((_ProtocolTrampoline_93)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_23)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_23 _6utppm_wrapListenerBlock_1l4hxwm(_ListenerTrampoline_23 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retainBlock(arg1));
  };
}

typedef void  (^_BlockingTrampoline_23)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_23 _6utppm_wrapBlockingBlock_1l4hxwm(
    _BlockingTrampoline_23 block, _BlockingTrampoline_23 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, objc_retainBlock(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, objc_retainBlock(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_94)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1l4hxwm(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_94)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_24)(void * arg0, id arg1, MTLPipelineOption arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_24 _6utppm_wrapListenerBlock_1vpepiy(_ListenerTrampoline_24 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, MTLPipelineOption arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_24)(void * waiter, void * arg0, id arg1, MTLPipelineOption arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_24 _6utppm_wrapBlockingBlock_1vpepiy(
    _BlockingTrampoline_24 block, _BlockingTrampoline_24 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, MTLPipelineOption arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_95)(void * sel, id arg1, MTLPipelineOption arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1vpepiy(id target, void * sel, id arg1, MTLPipelineOption arg2, id arg3) {
  return ((_ProtocolTrampoline_95)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_25)(void * arg0, MTLCullMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_25 _6utppm_wrapListenerBlock_1vmf5v7(_ListenerTrampoline_25 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLCullMode arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_25)(void * waiter, void * arg0, MTLCullMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_25 _6utppm_wrapBlockingBlock_1vmf5v7(
    _BlockingTrampoline_25 block, _BlockingTrampoline_25 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLCullMode arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_96)(void * sel, MTLCullMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1vmf5v7(id target, void * sel, MTLCullMode arg1) {
  return ((_ProtocolTrampoline_96)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_26)(void * arg0, MTLDepthClipMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_26 _6utppm_wrapListenerBlock_145pifa(_ListenerTrampoline_26 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLDepthClipMode arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_26)(void * waiter, void * arg0, MTLDepthClipMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_26 _6utppm_wrapBlockingBlock_145pifa(
    _BlockingTrampoline_26 block, _BlockingTrampoline_26 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLDepthClipMode arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_97)(void * sel, MTLDepthClipMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_145pifa(id target, void * sel, MTLDepthClipMode arg1) {
  return ((_ProtocolTrampoline_97)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_27)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_27 _6utppm_wrapListenerBlock_jk1ljc(_ListenerTrampoline_27 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  };
}

typedef void  (^_BlockingTrampoline_27)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_27 _6utppm_wrapBlockingBlock_jk1ljc(
    _BlockingTrampoline_27 block, _BlockingTrampoline_27 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_98)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_jk1ljc(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_98)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_28)(void * arg0, uint64_t arg1, MTLSize arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_28 _6utppm_wrapListenerBlock_1ke3xjs(_ListenerTrampoline_28 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, uint64_t arg1, MTLSize arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_28)(void * waiter, void * arg0, uint64_t arg1, MTLSize arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_28 _6utppm_wrapBlockingBlock_1ke3xjs(
    _BlockingTrampoline_28 block, _BlockingTrampoline_28 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, uint64_t arg1, MTLSize arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_99)(void * sel, uint64_t arg1, MTLSize arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1ke3xjs(id target, void * sel, uint64_t arg1, MTLSize arg2) {
  return ((_ProtocolTrampoline_99)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_29)(void * arg0, uint64_t arg1, MTLSize arg2, MTLSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_29 _6utppm_wrapListenerBlock_1pkuipa(_ListenerTrampoline_29 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, uint64_t arg1, MTLSize arg2, MTLSize arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_29)(void * waiter, void * arg0, uint64_t arg1, MTLSize arg2, MTLSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_29 _6utppm_wrapBlockingBlock_1pkuipa(
    _BlockingTrampoline_29 block, _BlockingTrampoline_29 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, uint64_t arg1, MTLSize arg2, MTLSize arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_100)(void * sel, uint64_t arg1, MTLSize arg2, MTLSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1pkuipa(id target, void * sel, uint64_t arg1, MTLSize arg2, MTLSize arg3) {
  return ((_ProtocolTrampoline_100)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_30)(void * arg0, uint64_t arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_30 _6utppm_wrapListenerBlock_1opdcvf(_ListenerTrampoline_30 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, uint64_t arg1, unsigned long arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_30)(void * waiter, void * arg0, uint64_t arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_30 _6utppm_wrapBlockingBlock_1opdcvf(
    _BlockingTrampoline_30 block, _BlockingTrampoline_30 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, uint64_t arg1, unsigned long arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_101)(void * sel, uint64_t arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1opdcvf(id target, void * sel, uint64_t arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_101)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_31)(void * arg0, uint64_t arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_31 _6utppm_wrapListenerBlock_xvu66s(_ListenerTrampoline_31 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, uint64_t arg1, unsigned long arg2, unsigned long arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_31)(void * waiter, void * arg0, uint64_t arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_31 _6utppm_wrapBlockingBlock_xvu66s(
    _BlockingTrampoline_31 block, _BlockingTrampoline_31 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, uint64_t arg1, unsigned long arg2, unsigned long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_102)(void * sel, uint64_t arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_xvu66s(id target, void * sel, uint64_t arg1, unsigned long arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_102)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_32)(void * arg0, MTLIntersectionFunctionSignature arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_32 _6utppm_wrapListenerBlock_10r47xz(_ListenerTrampoline_32 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLIntersectionFunctionSignature arg1, struct _NSRange arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_32)(void * waiter, void * arg0, MTLIntersectionFunctionSignature arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_32 _6utppm_wrapBlockingBlock_10r47xz(
    _BlockingTrampoline_32 block, _BlockingTrampoline_32 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLIntersectionFunctionSignature arg1, struct _NSRange arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_103)(void * sel, MTLIntersectionFunctionSignature arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_10r47xz(id target, void * sel, MTLIntersectionFunctionSignature arg1, struct _NSRange arg2) {
  return ((_ProtocolTrampoline_103)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_33)(void * arg0, MTLIntersectionFunctionSignature arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_33 _6utppm_wrapListenerBlock_10n0yx6(_ListenerTrampoline_33 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLIntersectionFunctionSignature arg1, unsigned long arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_33)(void * waiter, void * arg0, MTLIntersectionFunctionSignature arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_33 _6utppm_wrapBlockingBlock_10n0yx6(
    _BlockingTrampoline_33 block, _BlockingTrampoline_33 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLIntersectionFunctionSignature arg1, unsigned long arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_104)(void * sel, MTLIntersectionFunctionSignature arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_10n0yx6(id target, void * sel, MTLIntersectionFunctionSignature arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_104)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_34)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_34 _6utppm_wrapListenerBlock_18v1jvf(_ListenerTrampoline_34 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_34)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_34 _6utppm_wrapBlockingBlock_18v1jvf(
    _BlockingTrampoline_34 block, _BlockingTrampoline_34 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_105)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_18v1jvf(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_105)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_35)(void * arg0, MTLPrimitiveType arg1, uint64_t arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_35 _6utppm_wrapListenerBlock_122s9k6(_ListenerTrampoline_35 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLPrimitiveType arg1, uint64_t arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_35)(void * waiter, void * arg0, MTLPrimitiveType arg1, uint64_t arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_35 _6utppm_wrapBlockingBlock_122s9k6(
    _BlockingTrampoline_35 block, _BlockingTrampoline_35 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLPrimitiveType arg1, uint64_t arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_106)(void * sel, MTLPrimitiveType arg1, uint64_t arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_122s9k6(id target, void * sel, MTLPrimitiveType arg1, uint64_t arg2) {
  return ((_ProtocolTrampoline_106)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_36)(void * arg0, MTLPrimitiveType arg1, MTLIndexType arg2, uint64_t arg3, unsigned long arg4, uint64_t arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_36 _6utppm_wrapListenerBlock_s3t3e9(_ListenerTrampoline_36 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLPrimitiveType arg1, MTLIndexType arg2, uint64_t arg3, unsigned long arg4, uint64_t arg5) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4, arg5);
  };
}

typedef void  (^_BlockingTrampoline_36)(void * waiter, void * arg0, MTLPrimitiveType arg1, MTLIndexType arg2, uint64_t arg3, unsigned long arg4, uint64_t arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_36 _6utppm_wrapBlockingBlock_s3t3e9(
    _BlockingTrampoline_36 block, _BlockingTrampoline_36 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLPrimitiveType arg1, MTLIndexType arg2, uint64_t arg3, unsigned long arg4, uint64_t arg5), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4, arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4, arg5);
  });
}

typedef void  (^_ProtocolTrampoline_107)(void * sel, MTLPrimitiveType arg1, MTLIndexType arg2, uint64_t arg3, unsigned long arg4, uint64_t arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_s3t3e9(id target, void * sel, MTLPrimitiveType arg1, MTLIndexType arg2, uint64_t arg3, unsigned long arg4, uint64_t arg5) {
  return ((_ProtocolTrampoline_107)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_37)(void * arg0, MTLPrimitiveType arg1, MTLIndexType arg2, id arg3, unsigned long arg4, id arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_37 _6utppm_wrapListenerBlock_8o2638(_ListenerTrampoline_37 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLPrimitiveType arg1, MTLIndexType arg2, id arg3, unsigned long arg4, id arg5, unsigned long arg6) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4, (__bridge id)(__bridge_retained void*)(arg5), arg6);
  };
}

typedef void  (^_BlockingTrampoline_37)(void * waiter, void * arg0, MTLPrimitiveType arg1, MTLIndexType arg2, id arg3, unsigned long arg4, id arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_37 _6utppm_wrapBlockingBlock_8o2638(
    _BlockingTrampoline_37 block, _BlockingTrampoline_37 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLPrimitiveType arg1, MTLIndexType arg2, id arg3, unsigned long arg4, id arg5, unsigned long arg6), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4, (__bridge id)(__bridge_retained void*)(arg5), arg6);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4, (__bridge id)(__bridge_retained void*)(arg5), arg6);
  });
}

typedef void  (^_ProtocolTrampoline_108)(void * sel, MTLPrimitiveType arg1, MTLIndexType arg2, id arg3, unsigned long arg4, id arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_8o2638(id target, void * sel, MTLPrimitiveType arg1, MTLIndexType arg2, id arg3, unsigned long arg4, id arg5, unsigned long arg6) {
  return ((_ProtocolTrampoline_108)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef void  (^_ListenerTrampoline_38)(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_38 _6utppm_wrapListenerBlock_ynr88j(_ListenerTrampoline_38 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4, arg5);
  };
}

typedef void  (^_BlockingTrampoline_38)(void * waiter, void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_38 _6utppm_wrapBlockingBlock_ynr88j(
    _BlockingTrampoline_38 block, _BlockingTrampoline_38 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4, arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4, arg5);
  });
}

typedef void  (^_ProtocolTrampoline_109)(void * sel, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_ynr88j(id target, void * sel, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5) {
  return ((_ProtocolTrampoline_109)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_39)(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_39 _6utppm_wrapListenerBlock_1sn5gfw(_ListenerTrampoline_39 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5, unsigned long arg6) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
  };
}

typedef void  (^_BlockingTrampoline_39)(void * waiter, void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_39 _6utppm_wrapBlockingBlock_1sn5gfw(
    _BlockingTrampoline_39 block, _BlockingTrampoline_39 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5, unsigned long arg6), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
  });
}

typedef void  (^_ProtocolTrampoline_110)(void * sel, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1sn5gfw(id target, void * sel, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5, unsigned long arg6) {
  return ((_ProtocolTrampoline_110)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef void  (^_ListenerTrampoline_40)(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5, unsigned long arg6, long arg7, unsigned long arg8);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_40 _6utppm_wrapListenerBlock_y3p12v(_ListenerTrampoline_40 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5, unsigned long arg6, long arg7, unsigned long arg8) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
  };
}

typedef void  (^_BlockingTrampoline_40)(void * waiter, void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5, unsigned long arg6, long arg7, unsigned long arg8);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_40 _6utppm_wrapBlockingBlock_y3p12v(
    _BlockingTrampoline_40 block, _BlockingTrampoline_40 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5, unsigned long arg6, long arg7, unsigned long arg8), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
  });
}

typedef void  (^_ProtocolTrampoline_111)(void * sel, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5, unsigned long arg6, long arg7, unsigned long arg8);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_y3p12v(id target, void * sel, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, uint64_t arg4, unsigned long arg5, unsigned long arg6, long arg7, unsigned long arg8) {
  return ((_ProtocolTrampoline_111)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
}

typedef void  (^_ListenerTrampoline_41)(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_41 _6utppm_wrapListenerBlock_iw3rgc(_ListenerTrampoline_41 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5);
  };
}

typedef void  (^_BlockingTrampoline_41)(void * waiter, void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_41 _6utppm_wrapBlockingBlock_iw3rgc(
    _BlockingTrampoline_41 block, _BlockingTrampoline_41 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5);
  });
}

typedef void  (^_ProtocolTrampoline_112)(void * sel, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_iw3rgc(id target, void * sel, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5) {
  return ((_ProtocolTrampoline_112)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_42)(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_42 _6utppm_wrapListenerBlock_17ahrkx(_ListenerTrampoline_42 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5, unsigned long arg6) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6);
  };
}

typedef void  (^_BlockingTrampoline_42)(void * waiter, void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_42 _6utppm_wrapBlockingBlock_17ahrkx(
    _BlockingTrampoline_42 block, _BlockingTrampoline_42 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5, unsigned long arg6), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6);
  });
}

typedef void  (^_ProtocolTrampoline_113)(void * sel, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_17ahrkx(id target, void * sel, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5, unsigned long arg6) {
  return ((_ProtocolTrampoline_113)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef void  (^_ListenerTrampoline_43)(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5, unsigned long arg6, long arg7, unsigned long arg8);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_43 _6utppm_wrapListenerBlock_5qa770(_ListenerTrampoline_43 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5, unsigned long arg6, long arg7, unsigned long arg8) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6, arg7, arg8);
  };
}

typedef void  (^_BlockingTrampoline_43)(void * waiter, void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5, unsigned long arg6, long arg7, unsigned long arg8);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_43 _6utppm_wrapBlockingBlock_5qa770(
    _BlockingTrampoline_43 block, _BlockingTrampoline_43 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5, unsigned long arg6, long arg7, unsigned long arg8), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6, arg7, arg8);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6, arg7, arg8);
  });
}

typedef void  (^_ProtocolTrampoline_114)(void * sel, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5, unsigned long arg6, long arg7, unsigned long arg8);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_5qa770(id target, void * sel, MTLPrimitiveType arg1, unsigned long arg2, MTLIndexType arg3, id arg4, unsigned long arg5, unsigned long arg6, long arg7, unsigned long arg8) {
  return ((_ProtocolTrampoline_114)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
}

typedef void  (^_ListenerTrampoline_44)(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_44 _6utppm_wrapListenerBlock_eyddsj(_ListenerTrampoline_44 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_44)(void * waiter, void * arg0, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_44 _6utppm_wrapBlockingBlock_eyddsj(
    _BlockingTrampoline_44 block, _BlockingTrampoline_44 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_115)(void * sel, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_eyddsj(id target, void * sel, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_115)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_45)(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_45 _6utppm_wrapListenerBlock_1n7kxlo(_ListenerTrampoline_45 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_45)(void * waiter, void * arg0, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_45 _6utppm_wrapBlockingBlock_1n7kxlo(
    _BlockingTrampoline_45 block, _BlockingTrampoline_45 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_116)(void * sel, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1n7kxlo(id target, void * sel, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_116)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_46)(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_46 _6utppm_wrapListenerBlock_qtki81(_ListenerTrampoline_46 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, unsigned long arg5) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4, arg5);
  };
}

typedef void  (^_BlockingTrampoline_46)(void * waiter, void * arg0, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_46 _6utppm_wrapBlockingBlock_qtki81(
    _BlockingTrampoline_46 block, _BlockingTrampoline_46 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, unsigned long arg5), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4, arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4, arg5);
  });
}

typedef void  (^_ProtocolTrampoline_117)(void * sel, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_qtki81(id target, void * sel, MTLPrimitiveType arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, unsigned long arg5) {
  return ((_ProtocolTrampoline_117)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_47)(void * arg0, MTLPrimitiveType arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_47 _6utppm_wrapListenerBlock_ib7igs(_ListenerTrampoline_47 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLPrimitiveType arg1, id arg2, unsigned long arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_47)(void * waiter, void * arg0, MTLPrimitiveType arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_47 _6utppm_wrapBlockingBlock_ib7igs(
    _BlockingTrampoline_47 block, _BlockingTrampoline_47 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLPrimitiveType arg1, id arg2, unsigned long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_118)(void * sel, MTLPrimitiveType arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_ib7igs(id target, void * sel, MTLPrimitiveType arg1, id arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_118)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_48)(void * arg0, MTLRegion arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_48 _6utppm_wrapListenerBlock_1tph48i(_ListenerTrampoline_48 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLRegion arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_48)(void * waiter, void * arg0, MTLRegion arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_48 _6utppm_wrapBlockingBlock_1tph48i(
    _BlockingTrampoline_48 block, _BlockingTrampoline_48 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLRegion arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_119)(void * sel, MTLRegion arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1tph48i(id target, void * sel, MTLRegion arg1) {
  return ((_ProtocolTrampoline_119)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_49)(void * arg0, MTLRegion * arg1, MTLRegion * arg2, MTLSize arg3, MTLSparseTextureRegionAlignmentMode arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_49 _6utppm_wrapListenerBlock_2b3bq6(_ListenerTrampoline_49 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLRegion * arg1, MTLRegion * arg2, MTLSize arg3, MTLSparseTextureRegionAlignmentMode arg4, unsigned long arg5) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4, arg5);
  };
}

typedef void  (^_BlockingTrampoline_49)(void * waiter, void * arg0, MTLRegion * arg1, MTLRegion * arg2, MTLSize arg3, MTLSparseTextureRegionAlignmentMode arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_49 _6utppm_wrapBlockingBlock_2b3bq6(
    _BlockingTrampoline_49 block, _BlockingTrampoline_49 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLRegion * arg1, MTLRegion * arg2, MTLSize arg3, MTLSparseTextureRegionAlignmentMode arg4, unsigned long arg5), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4, arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4, arg5);
  });
}

typedef void  (^_ProtocolTrampoline_120)(void * sel, MTLRegion * arg1, MTLRegion * arg2, MTLSize arg3, MTLSparseTextureRegionAlignmentMode arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_2b3bq6(id target, void * sel, MTLRegion * arg1, MTLRegion * arg2, MTLSize arg3, MTLSparseTextureRegionAlignmentMode arg4, unsigned long arg5) {
  return ((_ProtocolTrampoline_120)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_50)(void * arg0, MTLRegion * arg1, MTLRegion * arg2, MTLSize arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_50 _6utppm_wrapListenerBlock_mtqqh0(_ListenerTrampoline_50 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLRegion * arg1, MTLRegion * arg2, MTLSize arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_50)(void * waiter, void * arg0, MTLRegion * arg1, MTLRegion * arg2, MTLSize arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_50 _6utppm_wrapBlockingBlock_mtqqh0(
    _BlockingTrampoline_50 block, _BlockingTrampoline_50 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLRegion * arg1, MTLRegion * arg2, MTLSize arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_121)(void * sel, MTLRegion * arg1, MTLRegion * arg2, MTLSize arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_mtqqh0(id target, void * sel, MTLRegion * arg1, MTLRegion * arg2, MTLSize arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_121)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_51)(void * arg0, MTLRegion arg1, unsigned long arg2, unsigned long arg3, void * arg4, unsigned long arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_51 _6utppm_wrapListenerBlock_117cvpq(_ListenerTrampoline_51 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLRegion arg1, unsigned long arg2, unsigned long arg3, void * arg4, unsigned long arg5, unsigned long arg6) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
  };
}

typedef void  (^_BlockingTrampoline_51)(void * waiter, void * arg0, MTLRegion arg1, unsigned long arg2, unsigned long arg3, void * arg4, unsigned long arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_51 _6utppm_wrapBlockingBlock_117cvpq(
    _BlockingTrampoline_51 block, _BlockingTrampoline_51 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLRegion arg1, unsigned long arg2, unsigned long arg3, void * arg4, unsigned long arg5, unsigned long arg6), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
  });
}

typedef void  (^_ProtocolTrampoline_122)(void * sel, MTLRegion arg1, unsigned long arg2, unsigned long arg3, void * arg4, unsigned long arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_117cvpq(id target, void * sel, MTLRegion arg1, unsigned long arg2, unsigned long arg3, void * arg4, unsigned long arg5, unsigned long arg6) {
  return ((_ProtocolTrampoline_122)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef void  (^_ListenerTrampoline_52)(void * arg0, MTLRegion arg1, unsigned long arg2, void * arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_52 _6utppm_wrapListenerBlock_dku27g(_ListenerTrampoline_52 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLRegion arg1, unsigned long arg2, void * arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_52)(void * waiter, void * arg0, MTLRegion arg1, unsigned long arg2, void * arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_52 _6utppm_wrapBlockingBlock_dku27g(
    _BlockingTrampoline_52 block, _BlockingTrampoline_52 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLRegion arg1, unsigned long arg2, void * arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_123)(void * sel, MTLRegion arg1, unsigned long arg2, void * arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_dku27g(id target, void * sel, MTLRegion arg1, unsigned long arg2, void * arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_123)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_53)(void * arg0, struct MTLResourceID arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_53 _6utppm_wrapListenerBlock_h8cvd(_ListenerTrampoline_53 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct MTLResourceID arg1, unsigned long arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_53)(void * waiter, void * arg0, struct MTLResourceID arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_53 _6utppm_wrapBlockingBlock_h8cvd(
    _BlockingTrampoline_53 block, _BlockingTrampoline_53 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct MTLResourceID arg1, unsigned long arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_124)(void * sel, struct MTLResourceID arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_h8cvd(id target, void * sel, struct MTLResourceID arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_124)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_54)(void * arg0, MTLSamplePosition * arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_54 _6utppm_wrapListenerBlock_2klnj8(_ListenerTrampoline_54 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLSamplePosition * arg1, unsigned long arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_54)(void * waiter, void * arg0, MTLSamplePosition * arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_54 _6utppm_wrapBlockingBlock_2klnj8(
    _BlockingTrampoline_54 block, _BlockingTrampoline_54 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLSamplePosition * arg1, unsigned long arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_125)(void * sel, MTLSamplePosition * arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_2klnj8(id target, void * sel, MTLSamplePosition * arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_125)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_55)(void * arg0, MTLScissorRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_55 _6utppm_wrapListenerBlock_1udoslm(_ListenerTrampoline_55 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLScissorRect arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_55)(void * waiter, void * arg0, MTLScissorRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_55 _6utppm_wrapBlockingBlock_1udoslm(
    _BlockingTrampoline_55 block, _BlockingTrampoline_55 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLScissorRect arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_126)(void * sel, MTLScissorRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1udoslm(id target, void * sel, MTLScissorRect arg1) {
  return ((_ProtocolTrampoline_126)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_56)(void * arg0, MTLScissorRect * arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_56 _6utppm_wrapListenerBlock_1onpil1(_ListenerTrampoline_56 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLScissorRect * arg1, unsigned long arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_56)(void * waiter, void * arg0, MTLScissorRect * arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_56 _6utppm_wrapBlockingBlock_1onpil1(
    _BlockingTrampoline_56 block, _BlockingTrampoline_56 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLScissorRect * arg1, unsigned long arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_127)(void * sel, MTLScissorRect * arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1onpil1(id target, void * sel, MTLScissorRect * arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_127)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_57)(void * arg0, id arg1, uint64_t arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_57 _6utppm_wrapListenerBlock_10udern(_ListenerTrampoline_57 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, uint64_t arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_57)(void * waiter, void * arg0, id arg1, uint64_t arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_57 _6utppm_wrapBlockingBlock_10udern(
    _BlockingTrampoline_57 block, _BlockingTrampoline_57 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, uint64_t arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_128)(void * sel, id arg1, uint64_t arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_10udern(id target, void * sel, id arg1, uint64_t arg2, id arg3) {
  return ((_ProtocolTrampoline_128)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_58)(void * arg0, MTLSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_58 _6utppm_wrapListenerBlock_q1bpy1(_ListenerTrampoline_58 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLSize arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_58)(void * waiter, void * arg0, MTLSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_58 _6utppm_wrapBlockingBlock_q1bpy1(
    _BlockingTrampoline_58 block, _BlockingTrampoline_58 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLSize arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_129)(void * sel, MTLSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_q1bpy1(id target, void * sel, MTLSize arg1) {
  return ((_ProtocolTrampoline_129)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_59)(void * arg0, MTLSize arg1, MTLSize arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_59 _6utppm_wrapListenerBlock_c7d6f1(_ListenerTrampoline_59 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLSize arg1, MTLSize arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_59)(void * waiter, void * arg0, MTLSize arg1, MTLSize arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_59 _6utppm_wrapBlockingBlock_c7d6f1(
    _BlockingTrampoline_59 block, _BlockingTrampoline_59 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLSize arg1, MTLSize arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_130)(void * sel, MTLSize arg1, MTLSize arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_c7d6f1(id target, void * sel, MTLSize arg1, MTLSize arg2) {
  return ((_ProtocolTrampoline_130)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_60)(void * arg0, MTLSize arg1, MTLSize arg2, MTLSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_60 _6utppm_wrapListenerBlock_105lrwx(_ListenerTrampoline_60 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLSize arg1, MTLSize arg2, MTLSize arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_60)(void * waiter, void * arg0, MTLSize arg1, MTLSize arg2, MTLSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_60 _6utppm_wrapBlockingBlock_105lrwx(
    _BlockingTrampoline_60 block, _BlockingTrampoline_60 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLSize arg1, MTLSize arg2, MTLSize arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_131)(void * sel, MTLSize arg1, MTLSize arg2, MTLSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_105lrwx(id target, void * sel, MTLSize arg1, MTLSize arg2, MTLSize arg3) {
  return ((_ProtocolTrampoline_131)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_61)(void * arg0, MTLStages arg1, MTLStages arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_61 _6utppm_wrapListenerBlock_1k7xa0x(_ListenerTrampoline_61 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLStages arg1, MTLStages arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_61)(void * waiter, void * arg0, MTLStages arg1, MTLStages arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_61 _6utppm_wrapBlockingBlock_1k7xa0x(
    _BlockingTrampoline_61 block, _BlockingTrampoline_61 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLStages arg1, MTLStages arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_132)(void * sel, MTLStages arg1, MTLStages arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1k7xa0x(id target, void * sel, MTLStages arg1, MTLStages arg2) {
  return ((_ProtocolTrampoline_132)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_62)(void * arg0, MTLStages arg1, MTLStages arg2, MTL4VisibilityOptions arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_62 _6utppm_wrapListenerBlock_q11jco(_ListenerTrampoline_62 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLStages arg1, MTLStages arg2, MTL4VisibilityOptions arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_62)(void * waiter, void * arg0, MTLStages arg1, MTLStages arg2, MTL4VisibilityOptions arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_62 _6utppm_wrapBlockingBlock_q11jco(
    _BlockingTrampoline_62 block, _BlockingTrampoline_62 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLStages arg1, MTLStages arg2, MTL4VisibilityOptions arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_133)(void * sel, MTLStages arg1, MTLStages arg2, MTL4VisibilityOptions arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_q11jco(id target, void * sel, MTLStages arg1, MTLStages arg2, MTL4VisibilityOptions arg3) {
  return ((_ProtocolTrampoline_133)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_63)(void * arg0, MTLStoreAction arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_63 _6utppm_wrapListenerBlock_p2yddn(_ListenerTrampoline_63 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLStoreAction arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_63)(void * waiter, void * arg0, MTLStoreAction arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_63 _6utppm_wrapBlockingBlock_p2yddn(
    _BlockingTrampoline_63 block, _BlockingTrampoline_63 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLStoreAction arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_134)(void * sel, MTLStoreAction arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_p2yddn(id target, void * sel, MTLStoreAction arg1) {
  return ((_ProtocolTrampoline_134)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_64)(void * arg0, MTLStoreActionOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_64 _6utppm_wrapListenerBlock_19ca9v7(_ListenerTrampoline_64 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLStoreActionOptions arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_64)(void * waiter, void * arg0, MTLStoreActionOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_64 _6utppm_wrapBlockingBlock_19ca9v7(
    _BlockingTrampoline_64 block, _BlockingTrampoline_64 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLStoreActionOptions arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_135)(void * sel, MTLStoreActionOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_19ca9v7(id target, void * sel, MTLStoreActionOptions arg1) {
  return ((_ProtocolTrampoline_135)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_65)(void * arg0, MTLStoreActionOptions arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_65 _6utppm_wrapListenerBlock_c89s3g(_ListenerTrampoline_65 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLStoreActionOptions arg1, unsigned long arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_65)(void * waiter, void * arg0, MTLStoreActionOptions arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_65 _6utppm_wrapBlockingBlock_c89s3g(
    _BlockingTrampoline_65 block, _BlockingTrampoline_65 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLStoreActionOptions arg1, unsigned long arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_136)(void * sel, MTLStoreActionOptions arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_c89s3g(id target, void * sel, MTLStoreActionOptions arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_136)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_66)(void * arg0, MTLStoreAction arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_66 _6utppm_wrapListenerBlock_15fd6bo(_ListenerTrampoline_66 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLStoreAction arg1, unsigned long arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_66)(void * waiter, void * arg0, MTLStoreAction arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_66 _6utppm_wrapBlockingBlock_15fd6bo(
    _BlockingTrampoline_66 block, _BlockingTrampoline_66 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLStoreAction arg1, unsigned long arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_137)(void * sel, MTLStoreAction arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_15fd6bo(id target, void * sel, MTLStoreAction arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_137)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_67)(void * arg0, id arg1, id arg2, void * arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_67 _6utppm_wrapListenerBlock_w066jz(_ListenerTrampoline_67 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, void * arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_67)(void * waiter, void * arg0, id arg1, id arg2, void * arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_67 _6utppm_wrapBlockingBlock_w066jz(
    _BlockingTrampoline_67 block, _BlockingTrampoline_67 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, void * arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_138)(void * sel, id arg1, id arg2, void * arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_w066jz(id target, void * sel, id arg1, id arg2, void * arg3, id arg4) {
  return ((_ProtocolTrampoline_138)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_68)(void * arg0, uint64_t * arg1, uint64_t * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_68 _6utppm_wrapListenerBlock_oyxpvl(_ListenerTrampoline_68 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, uint64_t * arg1, uint64_t * arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_68)(void * waiter, void * arg0, uint64_t * arg1, uint64_t * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_68 _6utppm_wrapBlockingBlock_oyxpvl(
    _BlockingTrampoline_68 block, _BlockingTrampoline_68 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, uint64_t * arg1, uint64_t * arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_139)(void * sel, uint64_t * arg1, uint64_t * arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_oyxpvl(id target, void * sel, uint64_t * arg1, uint64_t * arg2) {
  return ((_ProtocolTrampoline_139)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_69)(void * arg0, MTLTriangleFillMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_69 _6utppm_wrapListenerBlock_2ds1co(_ListenerTrampoline_69 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLTriangleFillMode arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_69)(void * waiter, void * arg0, MTLTriangleFillMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_69 _6utppm_wrapBlockingBlock_2ds1co(
    _BlockingTrampoline_69 block, _BlockingTrampoline_69 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLTriangleFillMode arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_140)(void * sel, MTLTriangleFillMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_2ds1co(id target, void * sel, MTLTriangleFillMode arg1) {
  return ((_ProtocolTrampoline_140)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_70)(void * arg0, MTLViewport arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_70 _6utppm_wrapListenerBlock_u4fi78(_ListenerTrampoline_70 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLViewport arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_70)(void * waiter, void * arg0, MTLViewport arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_70 _6utppm_wrapBlockingBlock_u4fi78(
    _BlockingTrampoline_70 block, _BlockingTrampoline_70 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLViewport arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_141)(void * sel, MTLViewport arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_u4fi78(id target, void * sel, MTLViewport arg1) {
  return ((_ProtocolTrampoline_141)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_71)(void * arg0, MTLViewport * arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_71 _6utppm_wrapListenerBlock_14nbhij(_ListenerTrampoline_71 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLViewport * arg1, unsigned long arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_71)(void * waiter, void * arg0, MTLViewport * arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_71 _6utppm_wrapBlockingBlock_14nbhij(
    _BlockingTrampoline_71 block, _BlockingTrampoline_71 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLViewport * arg1, unsigned long arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_142)(void * sel, MTLViewport * arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_14nbhij(id target, void * sel, MTLViewport * arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_142)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_72)(void * arg0, MTLVisibilityResultMode arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_72 _6utppm_wrapListenerBlock_1qjbcfl(_ListenerTrampoline_72 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLVisibilityResultMode arg1, unsigned long arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_72)(void * waiter, void * arg0, MTLVisibilityResultMode arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_72 _6utppm_wrapBlockingBlock_1qjbcfl(
    _BlockingTrampoline_72 block, _BlockingTrampoline_72 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLVisibilityResultMode arg1, unsigned long arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_143)(void * sel, MTLVisibilityResultMode arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1qjbcfl(id target, void * sel, MTLVisibilityResultMode arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_143)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_73)(void * arg0, MTLWinding arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_73 _6utppm_wrapListenerBlock_2mr18g(_ListenerTrampoline_73 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, MTLWinding arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_73)(void * waiter, void * arg0, MTLWinding arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_73 _6utppm_wrapBlockingBlock_2mr18g(
    _BlockingTrampoline_73 block, _BlockingTrampoline_73 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, MTLWinding arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_144)(void * sel, MTLWinding arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_2mr18g(id target, void * sel, MTLWinding arg1) {
  return ((_ProtocolTrampoline_144)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_74)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_74 _6utppm_wrapListenerBlock_fjrv01(_ListenerTrampoline_74 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_74)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_74 _6utppm_wrapBlockingBlock_fjrv01(
    _BlockingTrampoline_74 block, _BlockingTrampoline_74 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_145)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_fjrv01(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_145)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_75)(void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_75 _6utppm_wrapListenerBlock_1tz5yf(_ListenerTrampoline_75 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_75)(void * waiter, void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_75 _6utppm_wrapBlockingBlock_1tz5yf(
    _BlockingTrampoline_75 block, _BlockingTrampoline_75 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_146)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1tz5yf(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_146)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_76)(void * arg0, id arg1, id arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_76 _6utppm_wrapListenerBlock_8acz2h(_ListenerTrampoline_76 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, BOOL arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_76)(void * waiter, void * arg0, id arg1, id arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_76 _6utppm_wrapBlockingBlock_8acz2h(
    _BlockingTrampoline_76 block, _BlockingTrampoline_76 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, BOOL arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_147)(void * sel, id arg1, id arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_8acz2h(id target, void * sel, id arg1, id arg2, BOOL arg3) {
  return ((_ProtocolTrampoline_147)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_77)(void * arg0, struct _NSRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_77 _6utppm_wrapListenerBlock_xpqfd7(_ListenerTrampoline_77 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct _NSRange arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_77)(void * waiter, void * arg0, struct _NSRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_77 _6utppm_wrapBlockingBlock_xpqfd7(
    _BlockingTrampoline_77 block, _BlockingTrampoline_77 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct _NSRange arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_148)(void * sel, struct _NSRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_xpqfd7(id target, void * sel, struct _NSRange arg1) {
  return ((_ProtocolTrampoline_148)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_78)(void * arg0, id arg1, unsigned long arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_78 _6utppm_wrapListenerBlock_1cn988u(_ListenerTrampoline_78 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, id arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  };
}

typedef void  (^_BlockingTrampoline_78)(void * waiter, void * arg0, id arg1, unsigned long arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_78 _6utppm_wrapBlockingBlock_1cn988u(
    _BlockingTrampoline_78 block, _BlockingTrampoline_78 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2, id arg3, id arg4, id arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  });
}

typedef void  (^_ProtocolTrampoline_149)(void * sel, id arg1, unsigned long arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1cn988u(id target, void * sel, id arg1, unsigned long arg2, id arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_149)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_79)(void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_79 _6utppm_wrapListenerBlock_bklti2(_ListenerTrampoline_79 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_79)(void * waiter, void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_79 _6utppm_wrapBlockingBlock_bklti2(
    _BlockingTrampoline_79 block, _BlockingTrampoline_79 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_150)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_bklti2(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_150)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_80)(void * arg0, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_80 _6utppm_wrapListenerBlock_ayxzy9(_ListenerTrampoline_80 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct _NSRange arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_80)(void * waiter, void * arg0, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_80 _6utppm_wrapBlockingBlock_ayxzy9(
    _BlockingTrampoline_80 block, _BlockingTrampoline_80 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct _NSRange arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_151)(void * sel, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_ayxzy9(id target, void * sel, id arg1, struct _NSRange arg2) {
  return ((_ProtocolTrampoline_151)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void *  (^_ProtocolTrampoline_152)(void * sel, unsigned long arg1);
__attribute__((visibility("default"))) __attribute__((used))
void *  _6utppm_protocolTrampoline_1ot4dqk(id target, void * sel, unsigned long arg1) {
  return ((_ProtocolTrampoline_152)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_81)(void * arg0, unsigned long arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_81 _6utppm_wrapListenerBlock_zuf90e(_ListenerTrampoline_81 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, unsigned long arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_81)(void * waiter, void * arg0, unsigned long arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_81 _6utppm_wrapBlockingBlock_zuf90e(
    _BlockingTrampoline_81 block, _BlockingTrampoline_81 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, unsigned long arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ListenerTrampoline_82)(void * arg0, unsigned long arg1, MTLVertexAmplificationViewMapping * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_82 _6utppm_wrapListenerBlock_10qn0pm(_ListenerTrampoline_82 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, unsigned long arg1, MTLVertexAmplificationViewMapping * arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_82)(void * waiter, void * arg0, unsigned long arg1, MTLVertexAmplificationViewMapping * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_82 _6utppm_wrapBlockingBlock_10qn0pm(
    _BlockingTrampoline_82 block, _BlockingTrampoline_82 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, unsigned long arg1, MTLVertexAmplificationViewMapping * arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_153)(void * sel, unsigned long arg1, MTLVertexAmplificationViewMapping * arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_10qn0pm(id target, void * sel, unsigned long arg1, MTLVertexAmplificationViewMapping * arg2) {
  return ((_ProtocolTrampoline_153)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_83)(void * arg0, unsigned long arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_83 _6utppm_wrapListenerBlock_199s8vf(_ListenerTrampoline_83 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, unsigned long arg1, unsigned long arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_83)(void * waiter, void * arg0, unsigned long arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_83 _6utppm_wrapBlockingBlock_199s8vf(
    _BlockingTrampoline_83 block, _BlockingTrampoline_83 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, unsigned long arg1, unsigned long arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_154)(void * sel, unsigned long arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_199s8vf(id target, void * sel, unsigned long arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_154)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_84)(void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_84 _6utppm_wrapListenerBlock_1oog5zo(_ListenerTrampoline_84 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_84)(void * waiter, void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_84 _6utppm_wrapBlockingBlock_1oog5zo(
    _BlockingTrampoline_84 block, _BlockingTrampoline_84 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_155)(void * sel, unsigned long arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1oog5zo(id target, void * sel, unsigned long arg1, unsigned long arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_155)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_85)(void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_85 _6utppm_wrapListenerBlock_mbxyo5(_ListenerTrampoline_85 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6, arg7);
  };
}

typedef void  (^_BlockingTrampoline_85)(void * waiter, void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_85 _6utppm_wrapBlockingBlock_mbxyo5(
    _BlockingTrampoline_85 block, _BlockingTrampoline_85 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6, arg7);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6, arg7);
  });
}

typedef void  (^_ProtocolTrampoline_156)(void * sel, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_mbxyo5(id target, void * sel, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7) {
  return ((_ProtocolTrampoline_156)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
}

typedef void  (^_ListenerTrampoline_86)(void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7, id arg8, unsigned long arg9, unsigned long arg10);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_86 _6utppm_wrapListenerBlock_1uu7jhl(_ListenerTrampoline_86 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7, id arg8, unsigned long arg9, unsigned long arg10) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6, arg7, (__bridge id)(__bridge_retained void*)(arg8), arg9, arg10);
  };
}

typedef void  (^_BlockingTrampoline_86)(void * waiter, void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7, id arg8, unsigned long arg9, unsigned long arg10);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_86 _6utppm_wrapBlockingBlock_1uu7jhl(
    _BlockingTrampoline_86 block, _BlockingTrampoline_86 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7, id arg8, unsigned long arg9, unsigned long arg10), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6, arg7, (__bridge id)(__bridge_retained void*)(arg8), arg9, arg10);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6, arg7, (__bridge id)(__bridge_retained void*)(arg8), arg9, arg10);
  });
}

typedef void  (^_ProtocolTrampoline_157)(void * sel, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7, id arg8, unsigned long arg9, unsigned long arg10);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1uu7jhl(id target, void * sel, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7, id arg8, unsigned long arg9, unsigned long arg10) {
  return ((_ProtocolTrampoline_157)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
}

typedef void  (^_ListenerTrampoline_87)(void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_87 _6utppm_wrapListenerBlock_1dmhn7g(_ListenerTrampoline_87 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9);
  };
}

typedef void  (^_BlockingTrampoline_87)(void * waiter, void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_87 _6utppm_wrapBlockingBlock_1dmhn7g(
    _BlockingTrampoline_87 block, _BlockingTrampoline_87 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9);
  });
}

typedef void  (^_ProtocolTrampoline_158)(void * sel, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1dmhn7g(id target, void * sel, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9) {
  return ((_ProtocolTrampoline_158)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
}

typedef void  (^_ListenerTrampoline_88)(void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9, id arg10, unsigned long arg11, unsigned long arg12);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_88 _6utppm_wrapListenerBlock_zat2vc(_ListenerTrampoline_88 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9, id arg10, unsigned long arg11, unsigned long arg12) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9, (__bridge id)(__bridge_retained void*)(arg10), arg11, arg12);
  };
}

typedef void  (^_BlockingTrampoline_88)(void * waiter, void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9, id arg10, unsigned long arg11, unsigned long arg12);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_88 _6utppm_wrapBlockingBlock_zat2vc(
    _BlockingTrampoline_88 block, _BlockingTrampoline_88 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9, id arg10, unsigned long arg11, unsigned long arg12), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9, (__bridge id)(__bridge_retained void*)(arg10), arg11, arg12);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9, (__bridge id)(__bridge_retained void*)(arg10), arg11, arg12);
  });
}

typedef void  (^_ProtocolTrampoline_159)(void * sel, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9, id arg10, unsigned long arg11, unsigned long arg12);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_zat2vc(id target, void * sel, unsigned long arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9, id arg10, unsigned long arg11, unsigned long arg12) {
  return ((_ProtocolTrampoline_159)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
}

typedef void  (^_ListenerTrampoline_89)(void * arg0, unsigned long arg1, id arg2, unsigned long arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_89 _6utppm_wrapListenerBlock_1dwhg9c(_ListenerTrampoline_89 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, unsigned long arg1, id arg2, unsigned long arg3, id arg4, unsigned long arg5) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5);
  };
}

typedef void  (^_BlockingTrampoline_89)(void * waiter, void * arg0, unsigned long arg1, id arg2, unsigned long arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_89 _6utppm_wrapBlockingBlock_1dwhg9c(
    _BlockingTrampoline_89 block, _BlockingTrampoline_89 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, unsigned long arg1, id arg2, unsigned long arg3, id arg4, unsigned long arg5), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5);
  });
}

typedef void  (^_ProtocolTrampoline_160)(void * sel, unsigned long arg1, id arg2, unsigned long arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1dwhg9c(id target, void * sel, unsigned long arg1, id arg2, unsigned long arg3, id arg4, unsigned long arg5) {
  return ((_ProtocolTrampoline_160)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_90)(void * arg0, unsigned long arg1, id arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_90 _6utppm_wrapListenerBlock_14lphdv(_ListenerTrampoline_90 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, unsigned long arg1, id arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7);
  };
}

typedef void  (^_BlockingTrampoline_90)(void * waiter, void * arg0, unsigned long arg1, id arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_90 _6utppm_wrapBlockingBlock_14lphdv(
    _BlockingTrampoline_90 block, _BlockingTrampoline_90 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, unsigned long arg1, id arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7);
  });
}

typedef void  (^_ProtocolTrampoline_161)(void * sel, unsigned long arg1, id arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_14lphdv(id target, void * sel, unsigned long arg1, id arg2, unsigned long arg3, id arg4, unsigned long arg5, id arg6, unsigned long arg7) {
  return ((_ProtocolTrampoline_161)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
}

typedef void  (^_ListenerTrampoline_91)(void * arg0, id arg1, long arg2, long arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_91 _6utppm_wrapListenerBlock_15e9dqx(_ListenerTrampoline_91 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long arg2, long arg3, long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_91)(void * waiter, void * arg0, id arg1, long arg2, long arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_91 _6utppm_wrapBlockingBlock_15e9dqx(
    _BlockingTrampoline_91 block, _BlockingTrampoline_91 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long arg2, long arg3, long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_162)(void * sel, id arg1, long arg2, long arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_15e9dqx(id target, void * sel, id arg1, long arg2, long arg3, long arg4) {
  return ((_ProtocolTrampoline_162)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_92)(void * arg0, id arg1, long long arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_92 _6utppm_wrapListenerBlock_9crvvv(_ListenerTrampoline_92 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long long arg2, long long arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_92)(void * waiter, void * arg0, id arg1, long long arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_92 _6utppm_wrapBlockingBlock_9crvvv(
    _BlockingTrampoline_92 block, _BlockingTrampoline_92 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long long arg2, long long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_163)(void * sel, id arg1, long long arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_9crvvv(id target, void * sel, id arg1, long long arg2, long long arg3) {
  return ((_ProtocolTrampoline_163)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_93)(void * arg0, id arg1, long long arg2, long long arg3, long long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_93 _6utppm_wrapListenerBlock_1qf1qkl(_ListenerTrampoline_93 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long long arg2, long long arg3, long long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_93)(void * waiter, void * arg0, id arg1, long long arg2, long long arg3, long long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_93 _6utppm_wrapBlockingBlock_1qf1qkl(
    _BlockingTrampoline_93 block, _BlockingTrampoline_93 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long long arg2, long long arg3, long long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_164)(void * sel, id arg1, long long arg2, long long arg3, long long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1qf1qkl(id target, void * sel, id arg1, long long arg2, long long arg3, long long arg4) {
  return ((_ProtocolTrampoline_164)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_94)(void * arg0, id arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_94 _6utppm_wrapListenerBlock_wy9lus(_ListenerTrampoline_94 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_94)(void * waiter, void * arg0, id arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_94 _6utppm_wrapBlockingBlock_wy9lus(
    _BlockingTrampoline_94 block, _BlockingTrampoline_94 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_165)(void * sel, id arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_wy9lus(id target, void * sel, id arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_165)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_95)(void * arg0, id arg1, id arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_95 _6utppm_wrapListenerBlock_34xzuf(_ListenerTrampoline_95 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, long long arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_95)(void * waiter, void * arg0, id arg1, id arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_95 _6utppm_wrapBlockingBlock_34xzuf(
    _BlockingTrampoline_95 block, _BlockingTrampoline_95 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, long long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_166)(void * sel, id arg1, id arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_34xzuf(id target, void * sel, id arg1, id arg2, long long arg3) {
  return ((_ProtocolTrampoline_166)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_96)(void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_96 _6utppm_wrapListenerBlock_1j7coyk(_ListenerTrampoline_96 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_96)(void * waiter, void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_96 _6utppm_wrapBlockingBlock_1j7coyk(
    _BlockingTrampoline_96 block, _BlockingTrampoline_96 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_167)(void * sel, id arg1, id arg2, NSURLCacheStoragePolicy arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1j7coyk(id target, void * sel, id arg1, id arg2, NSURLCacheStoragePolicy arg3) {
  return ((_ProtocolTrampoline_167)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_97)(void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_97 _6utppm_wrapListenerBlock_xx612k(_ListenerTrampoline_97 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  };
}

typedef void  (^_BlockingTrampoline_97)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_97 _6utppm_wrapBlockingBlock_xx612k(
    _BlockingTrampoline_97 block, _BlockingTrampoline_97 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_168)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_xx612k(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_168)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_98)(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_98 _6utppm_wrapListenerBlock_ly2579(_ListenerTrampoline_98 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_98)(void * waiter, void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_98 _6utppm_wrapBlockingBlock_ly2579(
    _BlockingTrampoline_98 block, _BlockingTrampoline_98 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_169)(void * sel, id arg1, id arg2, int64_t arg3, int64_t arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_ly2579(id target, void * sel, id arg1, id arg2, int64_t arg3, int64_t arg4) {
  return ((_ProtocolTrampoline_169)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_99)(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_99 _6utppm_wrapListenerBlock_h68abb(_ListenerTrampoline_99 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4, arg5);
  };
}

typedef void  (^_BlockingTrampoline_99)(void * waiter, void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_99 _6utppm_wrapBlockingBlock_h68abb(
    _BlockingTrampoline_99 block, _BlockingTrampoline_99 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4, arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4, arg5);
  });
}

typedef void  (^_ProtocolTrampoline_170)(void * sel, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_h68abb(id target, void * sel, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5) {
  return ((_ProtocolTrampoline_170)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_100)(void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_100 _6utppm_wrapListenerBlock_8jfq1p(_ListenerTrampoline_100 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_100)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_100 _6utppm_wrapBlockingBlock_8jfq1p(
    _BlockingTrampoline_100 block, _BlockingTrampoline_100 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_171)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_8jfq1p(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_171)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_101)(void * arg0, id arg1, id arg2, int64_t arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_101 _6utppm_wrapListenerBlock_jyim80(_ListenerTrampoline_101 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, int64_t arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, objc_retainBlock(arg4));
  };
}

typedef void  (^_BlockingTrampoline_101)(void * waiter, void * arg0, id arg1, id arg2, int64_t arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_101 _6utppm_wrapBlockingBlock_jyim80(
    _BlockingTrampoline_101 block, _BlockingTrampoline_101 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, int64_t arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, objc_retainBlock(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, objc_retainBlock(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_172)(void * sel, id arg1, id arg2, int64_t arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_jyim80(id target, void * sel, id arg1, id arg2, int64_t arg3, id arg4) {
  return ((_ProtocolTrampoline_172)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_102)(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_102 _6utppm_wrapListenerBlock_l2g8ke(_ListenerTrampoline_102 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  };
}

typedef void  (^_BlockingTrampoline_102)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_102 _6utppm_wrapBlockingBlock_l2g8ke(
    _BlockingTrampoline_102 block, _BlockingTrampoline_102 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  });
}

typedef void  (^_ProtocolTrampoline_173)(void * sel, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_l2g8ke(id target, void * sel, id arg1, id arg2, id arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_173)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_103)(void * arg0, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_103 _6utppm_wrapListenerBlock_1lx650f(_ListenerTrampoline_103 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_103)(void * waiter, void * arg0, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_103 _6utppm_wrapBlockingBlock_1lx650f(
    _BlockingTrampoline_103 block, _BlockingTrampoline_103 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_174)(void * sel, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1lx650f(id target, void * sel, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4) {
  return ((_ProtocolTrampoline_174)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_104)(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_104 _6utppm_wrapListenerBlock_m09tr7(_ListenerTrampoline_104 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  };
}

typedef void  (^_BlockingTrampoline_104)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_104 _6utppm_wrapBlockingBlock_m09tr7(
    _BlockingTrampoline_104 block, _BlockingTrampoline_104 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  });
}

typedef void  (^_ProtocolTrampoline_175)(void * sel, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_m09tr7(id target, void * sel, id arg1, id arg2, id arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_175)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_105)(void * arg0, uint32_t arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_105 _6utppm_wrapListenerBlock_wjoxwn(_ListenerTrampoline_105 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, uint32_t arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_105)(void * waiter, void * arg0, uint32_t arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_105 _6utppm_wrapBlockingBlock_wjoxwn(
    _BlockingTrampoline_105 block, _BlockingTrampoline_105 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, uint32_t arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_176)(void * sel, uint32_t arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_wjoxwn(id target, void * sel, uint32_t arg1) {
  return ((_ProtocolTrampoline_176)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_106)(void * arg0, uint32_t arg1, uint32_t arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_106 _6utppm_wrapListenerBlock_1og8d8h(_ListenerTrampoline_106 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, uint32_t arg1, uint32_t arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_106)(void * waiter, void * arg0, uint32_t arg1, uint32_t arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_106 _6utppm_wrapBlockingBlock_1og8d8h(
    _BlockingTrampoline_106 block, _BlockingTrampoline_106 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, uint32_t arg1, uint32_t arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_177)(void * sel, uint32_t arg1, uint32_t arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1og8d8h(id target, void * sel, uint32_t arg1, uint32_t arg2) {
  return ((_ProtocolTrampoline_177)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_107)(void * arg0, uint64_t arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_107 _6utppm_wrapListenerBlock_1d4g4wu(_ListenerTrampoline_107 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, uint64_t arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_107)(void * waiter, void * arg0, uint64_t arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_107 _6utppm_wrapBlockingBlock_1d4g4wu(
    _BlockingTrampoline_107 block, _BlockingTrampoline_107 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, uint64_t arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_178)(void * sel, uint64_t arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1d4g4wu(id target, void * sel, uint64_t arg1) {
  return ((_ProtocolTrampoline_178)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_108)(void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_108 _6utppm_wrapListenerBlock_10lndml(_ListenerTrampoline_108 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_108)(void * waiter, void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_108 _6utppm_wrapBlockingBlock_10lndml(
    _BlockingTrampoline_108 block, _BlockingTrampoline_108 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, BOOL arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_179)(void * sel, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_10lndml(id target, void * sel, BOOL arg1) {
  return ((_ProtocolTrampoline_179)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_109)(void * arg0, float arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_109 _6utppm_wrapListenerBlock_1fcaigd(_ListenerTrampoline_109 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, float arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_109)(void * waiter, void * arg0, float arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_109 _6utppm_wrapBlockingBlock_1fcaigd(
    _BlockingTrampoline_109 block, _BlockingTrampoline_109 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, float arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_180)(void * sel, float arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1fcaigd(id target, void * sel, float arg1) {
  return ((_ProtocolTrampoline_180)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_110)(void * arg0, float arg1, float arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_110 _6utppm_wrapListenerBlock_bei7p(_ListenerTrampoline_110 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, float arg1, float arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_110)(void * waiter, void * arg0, float arg1, float arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_110 _6utppm_wrapBlockingBlock_bei7p(
    _BlockingTrampoline_110 block, _BlockingTrampoline_110 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, float arg1, float arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_181)(void * sel, float arg1, float arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_bei7p(id target, void * sel, float arg1, float arg2) {
  return ((_ProtocolTrampoline_181)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_111)(void * arg0, float arg1, float arg2, float arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_111 _6utppm_wrapListenerBlock_hb35y5(_ListenerTrampoline_111 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, float arg1, float arg2, float arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_111)(void * waiter, void * arg0, float arg1, float arg2, float arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_111 _6utppm_wrapBlockingBlock_hb35y5(
    _BlockingTrampoline_111 block, _BlockingTrampoline_111 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, float arg1, float arg2, float arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_182)(void * sel, float arg1, float arg2, float arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_hb35y5(id target, void * sel, float arg1, float arg2, float arg3) {
  return ((_ProtocolTrampoline_182)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_112)(void * arg0, float arg1, float arg2, float arg3, float arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_112 _6utppm_wrapListenerBlock_i67yw5(_ListenerTrampoline_112 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, float arg1, float arg2, float arg3, float arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_112)(void * waiter, void * arg0, float arg1, float arg2, float arg3, float arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_112 _6utppm_wrapBlockingBlock_i67yw5(
    _BlockingTrampoline_112 block, _BlockingTrampoline_112 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, float arg1, float arg2, float arg3, float arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_183)(void * sel, float arg1, float arg2, float arg3, float arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_i67yw5(id target, void * sel, float arg1, float arg2, float arg3, float arg4) {
  return ((_ProtocolTrampoline_183)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_113)(void * arg0, void * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_113 _6utppm_wrapListenerBlock_1037nh9(_ListenerTrampoline_113 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, void * arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_113)(void * waiter, void * arg0, void * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_113 _6utppm_wrapBlockingBlock_1037nh9(
    _BlockingTrampoline_113 block, _BlockingTrampoline_113 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, void * arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_184)(void * sel, void * arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1037nh9(id target, void * sel, void * arg1) {
  return ((_ProtocolTrampoline_184)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_114)(void * arg0, void * arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_114 _6utppm_wrapListenerBlock_143qaz3(_ListenerTrampoline_114 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, void * arg1, id arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_114)(void * waiter, void * arg0, void * arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_114 _6utppm_wrapBlockingBlock_143qaz3(
    _BlockingTrampoline_114 block, _BlockingTrampoline_114 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, void * arg1, id arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_185)(void * sel, void * arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_143qaz3(id target, void * sel, void * arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_185)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_115)(void * arg0, void * arg1, unsigned long arg2, MTLRegion arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_115 _6utppm_wrapListenerBlock_1rw9p8k(_ListenerTrampoline_115 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, void * arg1, unsigned long arg2, MTLRegion arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_115)(void * waiter, void * arg0, void * arg1, unsigned long arg2, MTLRegion arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_115 _6utppm_wrapBlockingBlock_1rw9p8k(
    _BlockingTrampoline_115 block, _BlockingTrampoline_115 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, void * arg1, unsigned long arg2, MTLRegion arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_186)(void * sel, void * arg1, unsigned long arg2, MTLRegion arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1rw9p8k(id target, void * sel, void * arg1, unsigned long arg2, MTLRegion arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_186)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_116)(void * arg0, void * arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_116 _6utppm_wrapListenerBlock_e4uq9v(_ListenerTrampoline_116 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, void * arg1, unsigned long arg2, unsigned long arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_116)(void * waiter, void * arg0, void * arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_116 _6utppm_wrapBlockingBlock_e4uq9v(
    _BlockingTrampoline_116 block, _BlockingTrampoline_116 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, void * arg1, unsigned long arg2, unsigned long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_187)(void * sel, void * arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_e4uq9v(id target, void * sel, void * arg1, unsigned long arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_187)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_117)(void * arg0, void * arg1, unsigned long arg2, unsigned long arg3, MTLRegion arg4, unsigned long arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_117 _6utppm_wrapListenerBlock_q8n2i(_ListenerTrampoline_117 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, void * arg1, unsigned long arg2, unsigned long arg3, MTLRegion arg4, unsigned long arg5, unsigned long arg6) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
  };
}

typedef void  (^_BlockingTrampoline_117)(void * waiter, void * arg0, void * arg1, unsigned long arg2, unsigned long arg3, MTLRegion arg4, unsigned long arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_117 _6utppm_wrapBlockingBlock_q8n2i(
    _BlockingTrampoline_117 block, _BlockingTrampoline_117 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, void * arg1, unsigned long arg2, unsigned long arg3, MTLRegion arg4, unsigned long arg5, unsigned long arg6), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
  });
}

typedef void  (^_ProtocolTrampoline_188)(void * sel, void * arg1, unsigned long arg2, unsigned long arg3, MTLRegion arg4, unsigned long arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_q8n2i(id target, void * sel, void * arg1, unsigned long arg2, unsigned long arg3, MTLRegion arg4, unsigned long arg5, unsigned long arg6) {
  return ((_ProtocolTrampoline_188)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef void  (^_ListenerTrampoline_118)(void * arg0, void * arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_118 _6utppm_wrapListenerBlock_jnydkc(_ListenerTrampoline_118 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, void * arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_118)(void * waiter, void * arg0, void * arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_118 _6utppm_wrapBlockingBlock_jnydkc(
    _BlockingTrampoline_118 block, _BlockingTrampoline_118 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, void * arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_189)(void * sel, void * arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_jnydkc(id target, void * sel, void * arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_189)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_119)(void * arg0, void * arg1, unsigned long arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_119 _6utppm_wrapListenerBlock_jpad1l(_ListenerTrampoline_119 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, void * arg1, unsigned long arg2, id arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  };
}

typedef void  (^_BlockingTrampoline_119)(void * waiter, void * arg0, void * arg1, unsigned long arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_119 _6utppm_wrapBlockingBlock_jpad1l(
    _BlockingTrampoline_119 block, _BlockingTrampoline_119 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, void * arg1, unsigned long arg2, id arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  });
}

typedef void  (^_ProtocolTrampoline_190)(void * sel, void * arg1, unsigned long arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_jpad1l(id target, void * sel, void * arg1, unsigned long arg2, id arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_190)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_120)(void * arg0, id arg1, MTLRenderStages arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_120 _6utppm_wrapListenerBlock_1baco99(_ListenerTrampoline_120 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, MTLRenderStages arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_120)(void * waiter, void * arg0, id arg1, MTLRenderStages arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_120 _6utppm_wrapBlockingBlock_1baco99(
    _BlockingTrampoline_120 block, _BlockingTrampoline_120 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, MTLRenderStages arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_191)(void * sel, id arg1, MTLRenderStages arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1baco99(id target, void * sel, id arg1, MTLRenderStages arg2) {
  return ((_ProtocolTrampoline_191)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_121)(void * arg0, id * arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_121 _6utppm_wrapListenerBlock_1050wct(_ListenerTrampoline_121 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id * arg1, unsigned long arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_121)(void * waiter, void * arg0, id * arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_121 _6utppm_wrapBlockingBlock_1050wct(
    _BlockingTrampoline_121 block, _BlockingTrampoline_121 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id * arg1, unsigned long arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_192)(void * sel, id * arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1050wct(id target, void * sel, id * arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_192)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_122)(void * arg0, id * arg1, unsigned long arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_122 _6utppm_wrapListenerBlock_l5u0sz(_ListenerTrampoline_122 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id * arg1, unsigned long arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_122)(void * waiter, void * arg0, id * arg1, unsigned long arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_122 _6utppm_wrapBlockingBlock_l5u0sz(
    _BlockingTrampoline_122 block, _BlockingTrampoline_122 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id * arg1, unsigned long arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_193)(void * sel, id * arg1, unsigned long arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_l5u0sz(id target, void * sel, id * arg1, unsigned long arg2, id arg3) {
  return ((_ProtocolTrampoline_193)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_123)(void * arg0, id arg1, struct _NSRange arg2, struct MTL4BufferRange arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_123 _6utppm_wrapListenerBlock_1ilpgxi(_ListenerTrampoline_123 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct _NSRange arg2, struct MTL4BufferRange arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  };
}

typedef void  (^_BlockingTrampoline_123)(void * waiter, void * arg0, id arg1, struct _NSRange arg2, struct MTL4BufferRange arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_123 _6utppm_wrapBlockingBlock_1ilpgxi(
    _BlockingTrampoline_123 block, _BlockingTrampoline_123 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct _NSRange arg2, struct MTL4BufferRange arg3, id arg4, id arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  });
}

typedef void  (^_ProtocolTrampoline_194)(void * sel, id arg1, struct _NSRange arg2, struct MTL4BufferRange arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1ilpgxi(id target, void * sel, id arg1, struct _NSRange arg2, struct MTL4BufferRange arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_194)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_124)(void * arg0, id arg1, id arg2, struct MTL4BufferRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_124 _6utppm_wrapListenerBlock_60qsiq(_ListenerTrampoline_124 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct MTL4BufferRange arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_124)(void * waiter, void * arg0, id arg1, id arg2, struct MTL4BufferRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_124 _6utppm_wrapBlockingBlock_60qsiq(
    _BlockingTrampoline_124 block, _BlockingTrampoline_124 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct MTL4BufferRange arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_195)(void * sel, id arg1, id arg2, struct MTL4BufferRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_60qsiq(id target, void * sel, id arg1, id arg2, struct MTL4BufferRange arg3) {
  return ((_ProtocolTrampoline_195)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_125)(void * arg0, id arg1, id arg2, id arg3, struct MTL4BufferRange arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_125 _6utppm_wrapListenerBlock_a9vel4(_ListenerTrampoline_125 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, struct MTL4BufferRange arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4);
  };
}

typedef void  (^_BlockingTrampoline_125)(void * waiter, void * arg0, id arg1, id arg2, id arg3, struct MTL4BufferRange arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_125 _6utppm_wrapBlockingBlock_a9vel4(
    _BlockingTrampoline_125 block, _BlockingTrampoline_125 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, struct MTL4BufferRange arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4);
  });
}

typedef void  (^_ProtocolTrampoline_196)(void * sel, id arg1, id arg2, id arg3, struct MTL4BufferRange arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_a9vel4(id target, void * sel, id arg1, id arg2, id arg3, struct MTL4BufferRange arg4) {
  return ((_ProtocolTrampoline_196)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_126)(void * arg0, id arg1, id arg2, id arg3, struct MTL4BufferRange arg4, MTLAccelerationStructureRefitOptions arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_126 _6utppm_wrapListenerBlock_1jkyn8u(_ListenerTrampoline_126 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, struct MTL4BufferRange arg4, MTLAccelerationStructureRefitOptions arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4, arg5);
  };
}

typedef void  (^_BlockingTrampoline_126)(void * waiter, void * arg0, id arg1, id arg2, id arg3, struct MTL4BufferRange arg4, MTLAccelerationStructureRefitOptions arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_126 _6utppm_wrapBlockingBlock_1jkyn8u(
    _BlockingTrampoline_126 block, _BlockingTrampoline_126 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, struct MTL4BufferRange arg4, MTLAccelerationStructureRefitOptions arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4, arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4, arg5);
  });
}

typedef void  (^_ProtocolTrampoline_197)(void * sel, id arg1, id arg2, id arg3, struct MTL4BufferRange arg4, MTLAccelerationStructureRefitOptions arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1jkyn8u(id target, void * sel, id arg1, id arg2, id arg3, struct MTL4BufferRange arg4, MTLAccelerationStructureRefitOptions arg5) {
  return ((_ProtocolTrampoline_197)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_127)(void * arg0, id arg1, struct MTL4BufferRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_127 _6utppm_wrapListenerBlock_1filmyc(_ListenerTrampoline_127 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct MTL4BufferRange arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_127)(void * waiter, void * arg0, id arg1, struct MTL4BufferRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_127 _6utppm_wrapBlockingBlock_1filmyc(
    _BlockingTrampoline_127 block, _BlockingTrampoline_127 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct MTL4BufferRange arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_198)(void * sel, id arg1, struct MTL4BufferRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1filmyc(id target, void * sel, id arg1, struct MTL4BufferRange arg2) {
  return ((_ProtocolTrampoline_198)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_128)(void * arg0, id arg1, id arg2, id arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_128 _6utppm_wrapListenerBlock_7j0gnq(_ListenerTrampoline_128 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, unsigned long arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), arg5);
  };
}

typedef void  (^_BlockingTrampoline_128)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_128 _6utppm_wrapBlockingBlock_7j0gnq(
    _BlockingTrampoline_128 block, _BlockingTrampoline_128 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, unsigned long arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), arg5);
  });
}

typedef void  (^_ProtocolTrampoline_199)(void * sel, id arg1, id arg2, id arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_7j0gnq(id target, void * sel, id arg1, id arg2, id arg3, id arg4, unsigned long arg5) {
  return ((_ProtocolTrampoline_199)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_129)(void * arg0, id arg1, id arg2, id arg3, id arg4, unsigned long arg5, MTLAccelerationStructureRefitOptions arg6);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_129 _6utppm_wrapListenerBlock_1xwbdv4(_ListenerTrampoline_129 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, unsigned long arg5, MTLAccelerationStructureRefitOptions arg6) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6);
  };
}

typedef void  (^_BlockingTrampoline_129)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4, unsigned long arg5, MTLAccelerationStructureRefitOptions arg6);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_129 _6utppm_wrapBlockingBlock_1xwbdv4(
    _BlockingTrampoline_129 block, _BlockingTrampoline_129 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, unsigned long arg5, MTLAccelerationStructureRefitOptions arg6), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6);
  });
}

typedef void  (^_ProtocolTrampoline_200)(void * sel, id arg1, id arg2, id arg3, id arg4, unsigned long arg5, MTLAccelerationStructureRefitOptions arg6);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1xwbdv4(id target, void * sel, id arg1, id arg2, id arg3, id arg4, unsigned long arg5, MTLAccelerationStructureRefitOptions arg6) {
  return ((_ProtocolTrampoline_200)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef void  (^_ListenerTrampoline_130)(void * arg0, id arg1, id arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_130 _6utppm_wrapListenerBlock_1oxtwsg(_ListenerTrampoline_130 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4);
  };
}

typedef void  (^_BlockingTrampoline_130)(void * waiter, void * arg0, id arg1, id arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_130 _6utppm_wrapBlockingBlock_1oxtwsg(
    _BlockingTrampoline_130 block, _BlockingTrampoline_130 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4);
  });
}

typedef void  (^_ProtocolTrampoline_201)(void * sel, id arg1, id arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1oxtwsg(id target, void * sel, id arg1, id arg2, id arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_201)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_131)(void * arg0, id arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_131 _6utppm_wrapListenerBlock_2xx4dm(_ListenerTrampoline_131 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, unsigned long arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_131)(void * waiter, void * arg0, id arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_131 _6utppm_wrapBlockingBlock_2xx4dm(
    _BlockingTrampoline_131 block, _BlockingTrampoline_131 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, unsigned long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_202)(void * sel, id arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_2xx4dm(id target, void * sel, id arg1, id arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_202)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_132)(void * arg0, id arg1, id arg2, unsigned long arg3, MTLDataType arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_132 _6utppm_wrapListenerBlock_qoprjb(_ListenerTrampoline_132 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, unsigned long arg3, MTLDataType arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_132)(void * waiter, void * arg0, id arg1, id arg2, unsigned long arg3, MTLDataType arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_132 _6utppm_wrapBlockingBlock_qoprjb(
    _BlockingTrampoline_132 block, _BlockingTrampoline_132 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, unsigned long arg3, MTLDataType arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_203)(void * sel, id arg1, id arg2, unsigned long arg3, MTLDataType arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_qoprjb(id target, void * sel, id arg1, id arg2, unsigned long arg3, MTLDataType arg4) {
  return ((_ProtocolTrampoline_203)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_133)(void * arg0, id arg1, struct _NSRange arg2, uint8_t arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_133 _6utppm_wrapListenerBlock_gne7ki(_ListenerTrampoline_133 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct _NSRange arg2, uint8_t arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_133)(void * waiter, void * arg0, id arg1, struct _NSRange arg2, uint8_t arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_133 _6utppm_wrapBlockingBlock_gne7ki(
    _BlockingTrampoline_133 block, _BlockingTrampoline_133 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct _NSRange arg2, uint8_t arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_204)(void * sel, id arg1, struct _NSRange arg2, uint8_t arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_gne7ki(id target, void * sel, id arg1, struct _NSRange arg2, uint8_t arg3) {
  return ((_ProtocolTrampoline_204)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_134)(void * arg0, id arg1, unsigned long arg2, MTLSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_134 _6utppm_wrapListenerBlock_pvhrnu(_ListenerTrampoline_134 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, MTLSize arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_134)(void * waiter, void * arg0, id arg1, unsigned long arg2, MTLSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_134 _6utppm_wrapBlockingBlock_pvhrnu(
    _BlockingTrampoline_134 block, _BlockingTrampoline_134 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2, MTLSize arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_205)(void * sel, id arg1, unsigned long arg2, MTLSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_pvhrnu(id target, void * sel, id arg1, unsigned long arg2, MTLSize arg3) {
  return ((_ProtocolTrampoline_205)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_135)(void * arg0, id arg1, unsigned long arg2, MTLSize arg3, MTLSize arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_135 _6utppm_wrapListenerBlock_mdjwdg(_ListenerTrampoline_135 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, MTLSize arg3, MTLSize arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_135)(void * waiter, void * arg0, id arg1, unsigned long arg2, MTLSize arg3, MTLSize arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_135 _6utppm_wrapBlockingBlock_mdjwdg(
    _BlockingTrampoline_135 block, _BlockingTrampoline_135 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2, MTLSize arg3, MTLSize arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_206)(void * sel, id arg1, unsigned long arg2, MTLSize arg3, MTLSize arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_mdjwdg(id target, void * sel, id arg1, unsigned long arg2, MTLSize arg3, MTLSize arg4) {
  return ((_ProtocolTrampoline_206)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_136)(void * arg0, id * arg1, unsigned long * arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_136 _6utppm_wrapListenerBlock_1h1icfp(_ListenerTrampoline_136 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id * arg1, unsigned long * arg2, struct _NSRange arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_136)(void * waiter, void * arg0, id * arg1, unsigned long * arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_136 _6utppm_wrapBlockingBlock_1h1icfp(
    _BlockingTrampoline_136 block, _BlockingTrampoline_136 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id * arg1, unsigned long * arg2, struct _NSRange arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_207)(void * sel, id * arg1, unsigned long * arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1h1icfp(id target, void * sel, id * arg1, unsigned long * arg2, struct _NSRange arg3) {
  return ((_ProtocolTrampoline_207)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_137)(void * arg0, id arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_137 _6utppm_wrapListenerBlock_c2yeeh(_ListenerTrampoline_137 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_137)(void * waiter, void * arg0, id arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_137 _6utppm_wrapBlockingBlock_c2yeeh(
    _BlockingTrampoline_137 block, _BlockingTrampoline_137 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_208)(void * sel, id arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_c2yeeh(id target, void * sel, id arg1, unsigned long arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_208)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_138)(void * arg0, id * arg1, unsigned long * arg2, unsigned long * arg3, struct _NSRange arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_138 _6utppm_wrapListenerBlock_1ed8s3e(_ListenerTrampoline_138 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id * arg1, unsigned long * arg2, unsigned long * arg3, struct _NSRange arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_138)(void * waiter, void * arg0, id * arg1, unsigned long * arg2, unsigned long * arg3, struct _NSRange arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_138 _6utppm_wrapBlockingBlock_1ed8s3e(
    _BlockingTrampoline_138 block, _BlockingTrampoline_138 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id * arg1, unsigned long * arg2, unsigned long * arg3, struct _NSRange arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_209)(void * sel, id * arg1, unsigned long * arg2, unsigned long * arg3, struct _NSRange arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1ed8s3e(id target, void * sel, id * arg1, unsigned long * arg2, unsigned long * arg3, struct _NSRange arg4) {
  return ((_ProtocolTrampoline_209)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_139)(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_139 _6utppm_wrapListenerBlock_hnwr7m(_ListenerTrampoline_139 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_139)(void * waiter, void * arg0, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_139 _6utppm_wrapBlockingBlock_hnwr7m(
    _BlockingTrampoline_139 block, _BlockingTrampoline_139 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_210)(void * sel, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_hnwr7m(id target, void * sel, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_210)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_140)(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_140 _6utppm_wrapListenerBlock_1s77zcf(_ListenerTrampoline_140 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9);
  };
}

typedef void  (^_BlockingTrampoline_140)(void * waiter, void * arg0, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_140 _6utppm_wrapBlockingBlock_1s77zcf(
    _BlockingTrampoline_140 block, _BlockingTrampoline_140 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9);
  });
}

typedef void  (^_ProtocolTrampoline_211)(void * sel, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1s77zcf(id target, void * sel, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9) {
  return ((_ProtocolTrampoline_211)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
}

typedef void  (^_ListenerTrampoline_141)(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9, MTLBlitOption arg10);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_141 _6utppm_wrapListenerBlock_1r81b3y(_ListenerTrampoline_141 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9, MTLBlitOption arg10) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9, arg10);
  };
}

typedef void  (^_BlockingTrampoline_141)(void * waiter, void * arg0, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9, MTLBlitOption arg10);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_141 _6utppm_wrapBlockingBlock_1r81b3y(
    _BlockingTrampoline_141 block, _BlockingTrampoline_141 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9, MTLBlitOption arg10), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9, arg10);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9, arg10);
  });
}

typedef void  (^_ProtocolTrampoline_212)(void * sel, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9, MTLBlitOption arg10);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1r81b3y(id target, void * sel, id arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9, MTLBlitOption arg10) {
  return ((_ProtocolTrampoline_212)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
}

typedef void  (^_ListenerTrampoline_142)(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_142 _6utppm_wrapListenerBlock_1klfs94(_ListenerTrampoline_142 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5);
  };
}

typedef void  (^_BlockingTrampoline_142)(void * waiter, void * arg0, id arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_142 _6utppm_wrapBlockingBlock_1klfs94(
    _BlockingTrampoline_142 block, _BlockingTrampoline_142 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5);
  });
}

typedef void  (^_ProtocolTrampoline_213)(void * sel, id arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1klfs94(id target, void * sel, id arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5) {
  return ((_ProtocolTrampoline_213)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_143)(void * arg0, id arg1, unsigned long arg2, id arg3, unsigned long arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_143 _6utppm_wrapListenerBlock_ld7540(_ListenerTrampoline_143 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, id arg3, unsigned long arg4, unsigned long arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4, arg5);
  };
}

typedef void  (^_BlockingTrampoline_143)(void * waiter, void * arg0, id arg1, unsigned long arg2, id arg3, unsigned long arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_143 _6utppm_wrapBlockingBlock_ld7540(
    _BlockingTrampoline_143 block, _BlockingTrampoline_143 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2, id arg3, unsigned long arg4, unsigned long arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4, arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4, arg5);
  });
}

typedef void  (^_ProtocolTrampoline_214)(void * sel, id arg1, unsigned long arg2, id arg3, unsigned long arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_ld7540(id target, void * sel, id arg1, unsigned long arg2, id arg3, unsigned long arg4, unsigned long arg5) {
  return ((_ProtocolTrampoline_214)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_144)(void * arg0, id arg1, id arg2, MTL4CopySparseBufferMappingOperation * arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_144 _6utppm_wrapListenerBlock_r2gq11(_ListenerTrampoline_144 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, MTL4CopySparseBufferMappingOperation * arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_144)(void * waiter, void * arg0, id arg1, id arg2, MTL4CopySparseBufferMappingOperation * arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_144 _6utppm_wrapBlockingBlock_r2gq11(
    _BlockingTrampoline_144 block, _BlockingTrampoline_144 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, MTL4CopySparseBufferMappingOperation * arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_215)(void * sel, id arg1, id arg2, MTL4CopySparseBufferMappingOperation * arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_r2gq11(id target, void * sel, id arg1, id arg2, MTL4CopySparseBufferMappingOperation * arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_215)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_145)(void * arg0, id arg1, id arg2, MTL4UpdateSparseBufferMappingOperation * arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_145 _6utppm_wrapListenerBlock_113gjd5(_ListenerTrampoline_145 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, MTL4UpdateSparseBufferMappingOperation * arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_145)(void * waiter, void * arg0, id arg1, id arg2, MTL4UpdateSparseBufferMappingOperation * arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_145 _6utppm_wrapBlockingBlock_113gjd5(
    _BlockingTrampoline_145 block, _BlockingTrampoline_145 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, MTL4UpdateSparseBufferMappingOperation * arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_216)(void * sel, id arg1, id arg2, MTL4UpdateSparseBufferMappingOperation * arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_113gjd5(id target, void * sel, id arg1, id arg2, MTL4UpdateSparseBufferMappingOperation * arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_216)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_146)(void * arg0, id * arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_146 _6utppm_wrapListenerBlock_1shg59k(_ListenerTrampoline_146 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id * arg1, struct _NSRange arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_146)(void * waiter, void * arg0, id * arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_146 _6utppm_wrapBlockingBlock_1shg59k(
    _BlockingTrampoline_146 block, _BlockingTrampoline_146 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id * arg1, struct _NSRange arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_217)(void * sel, id * arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1shg59k(id target, void * sel, id * arg1, struct _NSRange arg2) {
  return ((_ProtocolTrampoline_217)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_147)(void * arg0, id arg1, struct _NSRange arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_147 _6utppm_wrapListenerBlock_si2isw(_ListenerTrampoline_147 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct _NSRange arg2, id arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  };
}

typedef void  (^_BlockingTrampoline_147)(void * waiter, void * arg0, id arg1, struct _NSRange arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_147 _6utppm_wrapBlockingBlock_si2isw(
    _BlockingTrampoline_147 block, _BlockingTrampoline_147 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct _NSRange arg2, id arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  });
}

typedef void  (^_ProtocolTrampoline_218)(void * sel, id arg1, struct _NSRange arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_si2isw(id target, void * sel, id arg1, struct _NSRange arg2, id arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_218)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_148)(void * arg0, id arg1, unsigned long arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_148 _6utppm_wrapListenerBlock_1nyrrbs(_ListenerTrampoline_148 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, BOOL arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_148)(void * waiter, void * arg0, id arg1, unsigned long arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_148 _6utppm_wrapBlockingBlock_1nyrrbs(
    _BlockingTrampoline_148 block, _BlockingTrampoline_148 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2, BOOL arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_219)(void * sel, id arg1, unsigned long arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1nyrrbs(id target, void * sel, id arg1, unsigned long arg2, BOOL arg3) {
  return ((_ProtocolTrampoline_219)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_149)(void * arg0, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_149 _6utppm_wrapListenerBlock_ve6f9k(_ListenerTrampoline_149 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, double arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_149)(void * waiter, void * arg0, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_149 _6utppm_wrapBlockingBlock_ve6f9k(
    _BlockingTrampoline_149 block, _BlockingTrampoline_149 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, double arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_220)(void * sel, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_ve6f9k(id target, void * sel, id arg1, double arg2) {
  return ((_ProtocolTrampoline_220)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_150)(void * arg0, id arg1, uint64_t arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_150 _6utppm_wrapListenerBlock_10o24io(_ListenerTrampoline_150 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, uint64_t arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_150)(void * waiter, void * arg0, id arg1, uint64_t arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_150 _6utppm_wrapBlockingBlock_10o24io(
    _BlockingTrampoline_150 block, _BlockingTrampoline_150 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, uint64_t arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_221)(void * sel, id arg1, uint64_t arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_10o24io(id target, void * sel, id arg1, uint64_t arg2) {
  return ((_ProtocolTrampoline_221)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_151)(void * arg0, id arg1, MTLStages arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_151 _6utppm_wrapListenerBlock_mxqk4t(_ListenerTrampoline_151 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, MTLStages arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_151)(void * waiter, void * arg0, id arg1, MTLStages arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_151 _6utppm_wrapBlockingBlock_mxqk4t(
    _BlockingTrampoline_151 block, _BlockingTrampoline_151 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, MTLStages arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_222)(void * sel, id arg1, MTLStages arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_mxqk4t(id target, void * sel, id arg1, MTLStages arg2) {
  return ((_ProtocolTrampoline_222)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_152)(void * arg0, id * arg1, unsigned long arg2, MTLRenderStages arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_152 _6utppm_wrapListenerBlock_1vnvqqj(_ListenerTrampoline_152 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id * arg1, unsigned long arg2, MTLRenderStages arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_152)(void * waiter, void * arg0, id * arg1, unsigned long arg2, MTLRenderStages arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_152 _6utppm_wrapBlockingBlock_1vnvqqj(
    _BlockingTrampoline_152 block, _BlockingTrampoline_152 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id * arg1, unsigned long arg2, MTLRenderStages arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_223)(void * sel, id * arg1, unsigned long arg2, MTLRenderStages arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1vnvqqj(id target, void * sel, id * arg1, unsigned long arg2, MTLRenderStages arg3) {
  return ((_ProtocolTrampoline_223)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_153)(void * arg0, id arg1, MTLResourceUsage arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_153 _6utppm_wrapListenerBlock_2ehcc9(_ListenerTrampoline_153 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, MTLResourceUsage arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_153)(void * waiter, void * arg0, id arg1, MTLResourceUsage arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_153 _6utppm_wrapBlockingBlock_2ehcc9(
    _BlockingTrampoline_153 block, _BlockingTrampoline_153 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, MTLResourceUsage arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_224)(void * sel, id arg1, MTLResourceUsage arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_2ehcc9(id target, void * sel, id arg1, MTLResourceUsage arg2) {
  return ((_ProtocolTrampoline_224)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_154)(void * arg0, id arg1, MTLResourceUsage arg2, MTLRenderStages arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_154 _6utppm_wrapListenerBlock_48hp1z(_ListenerTrampoline_154 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, MTLResourceUsage arg2, MTLRenderStages arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_154)(void * waiter, void * arg0, id arg1, MTLResourceUsage arg2, MTLRenderStages arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_154 _6utppm_wrapBlockingBlock_48hp1z(
    _BlockingTrampoline_154 block, _BlockingTrampoline_154 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, MTLResourceUsage arg2, MTLRenderStages arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_225)(void * sel, id arg1, MTLResourceUsage arg2, MTLRenderStages arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_48hp1z(id target, void * sel, id arg1, MTLResourceUsage arg2, MTLRenderStages arg3) {
  return ((_ProtocolTrampoline_225)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_155)(void * arg0, id * arg1, unsigned long arg2, MTLRenderStages arg3, MTLRenderStages arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_155 _6utppm_wrapListenerBlock_1pzwcgd(_ListenerTrampoline_155 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id * arg1, unsigned long arg2, MTLRenderStages arg3, MTLRenderStages arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_155)(void * waiter, void * arg0, id * arg1, unsigned long arg2, MTLRenderStages arg3, MTLRenderStages arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_155 _6utppm_wrapBlockingBlock_1pzwcgd(
    _BlockingTrampoline_155 block, _BlockingTrampoline_155 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id * arg1, unsigned long arg2, MTLRenderStages arg3, MTLRenderStages arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_226)(void * sel, id * arg1, unsigned long arg2, MTLRenderStages arg3, MTLRenderStages arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1pzwcgd(id target, void * sel, id * arg1, unsigned long arg2, MTLRenderStages arg3, MTLRenderStages arg4) {
  return ((_ProtocolTrampoline_226)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_156)(void * arg0, id * arg1, unsigned long arg2, MTLResourceUsage arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_156 _6utppm_wrapListenerBlock_13hogjj(_ListenerTrampoline_156 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id * arg1, unsigned long arg2, MTLResourceUsage arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_156)(void * waiter, void * arg0, id * arg1, unsigned long arg2, MTLResourceUsage arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_156 _6utppm_wrapBlockingBlock_13hogjj(
    _BlockingTrampoline_156 block, _BlockingTrampoline_156 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id * arg1, unsigned long arg2, MTLResourceUsage arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_227)(void * sel, id * arg1, unsigned long arg2, MTLResourceUsage arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_13hogjj(id target, void * sel, id * arg1, unsigned long arg2, MTLResourceUsage arg3) {
  return ((_ProtocolTrampoline_227)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_157)(void * arg0, id * arg1, unsigned long arg2, MTLResourceUsage arg3, MTLRenderStages arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_157 _6utppm_wrapListenerBlock_k165m9(_ListenerTrampoline_157 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id * arg1, unsigned long arg2, MTLResourceUsage arg3, MTLRenderStages arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_157)(void * waiter, void * arg0, id * arg1, unsigned long arg2, MTLResourceUsage arg3, MTLRenderStages arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_157 _6utppm_wrapBlockingBlock_k165m9(
    _BlockingTrampoline_157 block, _BlockingTrampoline_157 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id * arg1, unsigned long arg2, MTLResourceUsage arg3, MTLRenderStages arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_228)(void * sel, id * arg1, unsigned long arg2, MTLResourceUsage arg3, MTLRenderStages arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_k165m9(id target, void * sel, id * arg1, unsigned long arg2, MTLResourceUsage arg3, MTLRenderStages arg4) {
  return ((_ProtocolTrampoline_228)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_158)(void * arg0, id * arg1, float * arg2, float * arg3, struct _NSRange arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_158 _6utppm_wrapListenerBlock_tx2gfc(_ListenerTrampoline_158 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id * arg1, float * arg2, float * arg3, struct _NSRange arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_158)(void * waiter, void * arg0, id * arg1, float * arg2, float * arg3, struct _NSRange arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_158 _6utppm_wrapBlockingBlock_tx2gfc(
    _BlockingTrampoline_158 block, _BlockingTrampoline_158 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id * arg1, float * arg2, float * arg3, struct _NSRange arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_229)(void * sel, id * arg1, float * arg2, float * arg3, struct _NSRange arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_tx2gfc(id target, void * sel, id * arg1, float * arg2, float * arg3, struct _NSRange arg4) {
  return ((_ProtocolTrampoline_229)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_159)(void * arg0, id arg1, float arg2, float arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_159 _6utppm_wrapListenerBlock_17z3y9o(_ListenerTrampoline_159 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, float arg2, float arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_159)(void * waiter, void * arg0, id arg1, float arg2, float arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_159 _6utppm_wrapBlockingBlock_17z3y9o(
    _BlockingTrampoline_159 block, _BlockingTrampoline_159 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, float arg2, float arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_230)(void * sel, id arg1, float arg2, float arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_17z3y9o(id target, void * sel, id arg1, float arg2, float arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_230)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_160)(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5, id arg6);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_160 _6utppm_wrapListenerBlock_1cj193d(_ListenerTrampoline_160 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5, id arg6) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5), (__bridge id)(__bridge_retained void*)(arg6));
  };
}

typedef void  (^_BlockingTrampoline_160)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5, id arg6);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_160 _6utppm_wrapBlockingBlock_1cj193d(
    _BlockingTrampoline_160 block, _BlockingTrampoline_160 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5, id arg6), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5), (__bridge id)(__bridge_retained void*)(arg6));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5), (__bridge id)(__bridge_retained void*)(arg6));
  });
}

typedef void  (^_ProtocolTrampoline_231)(void * sel, id arg1, id arg2, id arg3, id arg4, id arg5, id arg6);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1cj193d(id target, void * sel, id arg1, id arg2, id arg3, id arg4, id arg5, id arg6) {
  return ((_ProtocolTrampoline_231)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef void  (^_ListenerTrampoline_161)(void * arg0, id arg1, MTLRegion arg2, unsigned long arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_161 _6utppm_wrapListenerBlock_149ux9u(_ListenerTrampoline_161 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, MTLRegion arg2, unsigned long arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_161)(void * waiter, void * arg0, id arg1, MTLRegion arg2, unsigned long arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_161 _6utppm_wrapBlockingBlock_149ux9u(
    _BlockingTrampoline_161 block, _BlockingTrampoline_161 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, MTLRegion arg2, unsigned long arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_232)(void * sel, id arg1, MTLRegion arg2, unsigned long arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_149ux9u(id target, void * sel, id arg1, MTLRegion arg2, unsigned long arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_232)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_162)(void * arg0, id arg1, MTLRegion arg2, unsigned long arg3, unsigned long arg4, BOOL arg5, id arg6, unsigned long arg7);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_162 _6utppm_wrapListenerBlock_16t0ff9(_ListenerTrampoline_162 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, MTLRegion arg2, unsigned long arg3, unsigned long arg4, BOOL arg5, id arg6, unsigned long arg7) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7);
  };
}

typedef void  (^_BlockingTrampoline_162)(void * waiter, void * arg0, id arg1, MTLRegion arg2, unsigned long arg3, unsigned long arg4, BOOL arg5, id arg6, unsigned long arg7);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_162 _6utppm_wrapBlockingBlock_16t0ff9(
    _BlockingTrampoline_162 block, _BlockingTrampoline_162 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, MTLRegion arg2, unsigned long arg3, unsigned long arg4, BOOL arg5, id arg6, unsigned long arg7), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7);
  });
}

typedef void  (^_ProtocolTrampoline_233)(void * sel, id arg1, MTLRegion arg2, unsigned long arg3, unsigned long arg4, BOOL arg5, id arg6, unsigned long arg7);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_16t0ff9(id target, void * sel, id arg1, MTLRegion arg2, unsigned long arg3, unsigned long arg4, BOOL arg5, id arg6, unsigned long arg7) {
  return ((_ProtocolTrampoline_233)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
}

typedef void  (^_ListenerTrampoline_163)(void * arg0, id arg1, MTLSparseTextureMappingMode arg2, MTLRegion arg3, unsigned long arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_163 _6utppm_wrapListenerBlock_kfbtuv(_ListenerTrampoline_163 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, MTLSparseTextureMappingMode arg2, MTLRegion arg3, unsigned long arg4, unsigned long arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5);
  };
}

typedef void  (^_BlockingTrampoline_163)(void * waiter, void * arg0, id arg1, MTLSparseTextureMappingMode arg2, MTLRegion arg3, unsigned long arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_163 _6utppm_wrapBlockingBlock_kfbtuv(
    _BlockingTrampoline_163 block, _BlockingTrampoline_163 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, MTLSparseTextureMappingMode arg2, MTLRegion arg3, unsigned long arg4, unsigned long arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5);
  });
}

typedef void  (^_ProtocolTrampoline_234)(void * sel, id arg1, MTLSparseTextureMappingMode arg2, MTLRegion arg3, unsigned long arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_kfbtuv(id target, void * sel, id arg1, MTLSparseTextureMappingMode arg2, MTLRegion arg3, unsigned long arg4, unsigned long arg5) {
  return ((_ProtocolTrampoline_234)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_164)(void * arg0, id arg1, MTLSparseTextureMappingMode arg2, MTLRegion * arg3, unsigned long * arg4, unsigned long * arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_164 _6utppm_wrapListenerBlock_1oqxone(_ListenerTrampoline_164 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, MTLSparseTextureMappingMode arg2, MTLRegion * arg3, unsigned long * arg4, unsigned long * arg5, unsigned long arg6) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, arg6);
  };
}

typedef void  (^_BlockingTrampoline_164)(void * waiter, void * arg0, id arg1, MTLSparseTextureMappingMode arg2, MTLRegion * arg3, unsigned long * arg4, unsigned long * arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_164 _6utppm_wrapBlockingBlock_1oqxone(
    _BlockingTrampoline_164 block, _BlockingTrampoline_164 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, MTLSparseTextureMappingMode arg2, MTLRegion * arg3, unsigned long * arg4, unsigned long * arg5, unsigned long arg6), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, arg6);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, arg6);
  });
}

typedef void  (^_ProtocolTrampoline_235)(void * sel, id arg1, MTLSparseTextureMappingMode arg2, MTLRegion * arg3, unsigned long * arg4, unsigned long * arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1oqxone(id target, void * sel, id arg1, MTLSparseTextureMappingMode arg2, MTLRegion * arg3, unsigned long * arg4, unsigned long * arg5, unsigned long arg6) {
  return ((_ProtocolTrampoline_235)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef void  (^_ListenerTrampoline_165)(void * arg0, id arg1, MTLSparseTextureMappingMode arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_165 _6utppm_wrapListenerBlock_1owq0hf(_ListenerTrampoline_165 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, MTLSparseTextureMappingMode arg2, id arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  };
}

typedef void  (^_BlockingTrampoline_165)(void * waiter, void * arg0, id arg1, MTLSparseTextureMappingMode arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_165 _6utppm_wrapBlockingBlock_1owq0hf(
    _BlockingTrampoline_165 block, _BlockingTrampoline_165 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, MTLSparseTextureMappingMode arg2, id arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  });
}

typedef void  (^_ProtocolTrampoline_236)(void * sel, id arg1, MTLSparseTextureMappingMode arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1owq0hf(id target, void * sel, id arg1, MTLSparseTextureMappingMode arg2, id arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_236)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_166)(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_166 _6utppm_wrapListenerBlock_7p6m9j(_ListenerTrampoline_166 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9);
  };
}

typedef void  (^_BlockingTrampoline_166)(void * waiter, void * arg0, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_166 _6utppm_wrapBlockingBlock_7p6m9j(
    _BlockingTrampoline_166 block, _BlockingTrampoline_166 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9);
  });
}

typedef void  (^_ProtocolTrampoline_237)(void * sel, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_7p6m9j(id target, void * sel, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9) {
  return ((_ProtocolTrampoline_237)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
}

typedef void  (^_ListenerTrampoline_167)(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9, MTLBlitOption arg10);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_167 _6utppm_wrapListenerBlock_1i8704m(_ListenerTrampoline_167 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9, MTLBlitOption arg10) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9, arg10);
  };
}

typedef void  (^_BlockingTrampoline_167)(void * waiter, void * arg0, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9, MTLBlitOption arg10);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_167 _6utppm_wrapBlockingBlock_1i8704m(
    _BlockingTrampoline_167 block, _BlockingTrampoline_167 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9, MTLBlitOption arg10), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9, arg10);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9, arg10);
  });
}

typedef void  (^_ProtocolTrampoline_238)(void * sel, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9, MTLBlitOption arg10);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1i8704m(id target, void * sel, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, unsigned long arg9, MTLBlitOption arg10) {
  return ((_ProtocolTrampoline_238)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
}

typedef void  (^_ListenerTrampoline_168)(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_168 _6utppm_wrapListenerBlock_1f5kuzx(_ListenerTrampoline_168 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9);
  };
}

typedef void  (^_BlockingTrampoline_168)(void * waiter, void * arg0, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_168 _6utppm_wrapBlockingBlock_1f5kuzx(
    _BlockingTrampoline_168 block, _BlockingTrampoline_168 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, (__bridge id)(__bridge_retained void*)(arg6), arg7, arg8, arg9);
  });
}

typedef void  (^_ProtocolTrampoline_239)(void * sel, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1f5kuzx(id target, void * sel, id arg1, unsigned long arg2, unsigned long arg3, MTLOrigin arg4, MTLSize arg5, id arg6, unsigned long arg7, unsigned long arg8, MTLOrigin arg9) {
  return ((_ProtocolTrampoline_239)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
}

typedef void  (^_ListenerTrampoline_169)(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, MTLSize arg4, unsigned long arg5, unsigned long arg6, MTLOrigin arg7, id arg8, unsigned long arg9);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_169 _6utppm_wrapListenerBlock_psk36x(_ListenerTrampoline_169 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, MTLSize arg4, unsigned long arg5, unsigned long arg6, MTLOrigin arg7, id arg8, unsigned long arg9) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, arg6, arg7, (__bridge id)(__bridge_retained void*)(arg8), arg9);
  };
}

typedef void  (^_BlockingTrampoline_169)(void * waiter, void * arg0, id arg1, unsigned long arg2, unsigned long arg3, MTLSize arg4, unsigned long arg5, unsigned long arg6, MTLOrigin arg7, id arg8, unsigned long arg9);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_169 _6utppm_wrapBlockingBlock_psk36x(
    _BlockingTrampoline_169 block, _BlockingTrampoline_169 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, MTLSize arg4, unsigned long arg5, unsigned long arg6, MTLOrigin arg7, id arg8, unsigned long arg9), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, arg6, arg7, (__bridge id)(__bridge_retained void*)(arg8), arg9);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5, arg6, arg7, (__bridge id)(__bridge_retained void*)(arg8), arg9);
  });
}

typedef void  (^_ProtocolTrampoline_240)(void * sel, id arg1, unsigned long arg2, unsigned long arg3, MTLSize arg4, unsigned long arg5, unsigned long arg6, MTLOrigin arg7, id arg8, unsigned long arg9);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_psk36x(id target, void * sel, id arg1, unsigned long arg2, unsigned long arg3, MTLSize arg4, unsigned long arg5, unsigned long arg6, MTLOrigin arg7, id arg8, unsigned long arg9) {
  return ((_ProtocolTrampoline_240)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
}

typedef void  (^_ListenerTrampoline_170)(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7, unsigned long arg8);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_170 _6utppm_wrapListenerBlock_1pfumo3(_ListenerTrampoline_170 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7, unsigned long arg8) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6, arg7, arg8);
  };
}

typedef void  (^_BlockingTrampoline_170)(void * waiter, void * arg0, id arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7, unsigned long arg8);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_170 _6utppm_wrapBlockingBlock_1pfumo3(
    _BlockingTrampoline_170 block, _BlockingTrampoline_170 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7, unsigned long arg8), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6, arg7, arg8);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5, arg6, arg7, arg8);
  });
}

typedef void  (^_ProtocolTrampoline_241)(void * sel, id arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7, unsigned long arg8);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1pfumo3(id target, void * sel, id arg1, unsigned long arg2, unsigned long arg3, id arg4, unsigned long arg5, unsigned long arg6, unsigned long arg7, unsigned long arg8) {
  return ((_ProtocolTrampoline_241)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
}

typedef void  (^_ListenerTrampoline_171)(void * arg0, id arg1, id arg2, MTL4UpdateSparseTextureMappingOperation * arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_171 _6utppm_wrapListenerBlock_1fsb5f2(_ListenerTrampoline_171 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, MTL4UpdateSparseTextureMappingOperation * arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_171)(void * waiter, void * arg0, id arg1, id arg2, MTL4UpdateSparseTextureMappingOperation * arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_171 _6utppm_wrapBlockingBlock_1fsb5f2(
    _BlockingTrampoline_171 block, _BlockingTrampoline_171 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, MTL4UpdateSparseTextureMappingOperation * arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_242)(void * sel, id arg1, id arg2, MTL4UpdateSparseTextureMappingOperation * arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_1fsb5f2(id target, void * sel, id arg1, id arg2, MTL4UpdateSparseTextureMappingOperation * arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_242)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_172)(void * arg0, id arg1, id arg2, MTL4CopySparseTextureMappingOperation * arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_172 _6utppm_wrapListenerBlock_vng1vu(_ListenerTrampoline_172 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, MTL4CopySparseTextureMappingOperation * arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_172)(void * waiter, void * arg0, id arg1, id arg2, MTL4CopySparseTextureMappingOperation * arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_172 _6utppm_wrapBlockingBlock_vng1vu(
    _BlockingTrampoline_172 block, _BlockingTrampoline_172 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, MTL4CopySparseTextureMappingOperation * arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_243)(void * sel, id arg1, id arg2, MTL4CopySparseTextureMappingOperation * arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _6utppm_protocolTrampoline_vng1vu(id target, void * sel, id arg1, id arg2, MTL4CopySparseTextureMappingOperation * arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_243)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_173)(id arg0, uint64_t arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_173 _6utppm_wrapListenerBlock_dzdejc(_ListenerTrampoline_173 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, uint64_t arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1);
  };
}

typedef void  (^_BlockingTrampoline_173)(void * waiter, id arg0, uint64_t arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_173 _6utppm_wrapBlockingBlock_dzdejc(
    _BlockingTrampoline_173 block, _BlockingTrampoline_173 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, uint64_t arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  });
}

typedef void  (^_ListenerTrampoline_174)(id arg0, unsigned long arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_174 _6utppm_wrapListenerBlock_1p9ui4q(_ListenerTrampoline_174 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, unsigned long arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_174)(void * waiter, id arg0, unsigned long arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_174 _6utppm_wrapBlockingBlock_1p9ui4q(
    _BlockingTrampoline_174 block, _BlockingTrampoline_174 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, unsigned long arg1, BOOL * arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef id  (^_ProtocolTrampoline_244)(void * sel, id arg1, id * arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_10s6poe(id target, void * sel, id arg1, id * arg2) {
  return ((_ProtocolTrampoline_244)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_245)(void * sel, id arg1, id arg2, id * arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_10z9f5k(id target, void * sel, id arg1, id arg2, id * arg3) {
  return ((_ProtocolTrampoline_245)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_246)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_7m0j0m(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_246)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_247)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_1ezi0a0(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_247)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_248)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_1q0i84(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_248)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_249)(void * sel, id arg1, MTL4RenderEncoderOptions arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_102ra16(id target, void * sel, id arg1, MTL4RenderEncoderOptions arg2) {
  return ((_ProtocolTrampoline_249)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_250)(void * sel, id arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_skjqxk(id target, void * sel, id arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_250)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_251)(void * sel, unsigned long arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_3nbx5e(id target, void * sel, unsigned long arg1) {
  return ((_ProtocolTrampoline_251)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_252)(void * sel, unsigned long arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_9b3h4v(id target, void * sel, unsigned long arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_252)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_253)(void * sel, unsigned long arg1, id * arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_zxdjzr(id target, void * sel, unsigned long arg1, id * arg2) {
  return ((_ProtocolTrampoline_253)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_254)(void * sel, unsigned long arg1, MTLResourceOptions arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_e344kn(id target, void * sel, unsigned long arg1, MTLResourceOptions arg2) {
  return ((_ProtocolTrampoline_254)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_255)(void * sel, unsigned long arg1, MTLResourceOptions arg2, MTLSparsePageSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_19k9lgq(id target, void * sel, unsigned long arg1, MTLResourceOptions arg2, MTLSparsePageSize arg3) {
  return ((_ProtocolTrampoline_255)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_256)(void * sel, unsigned long arg1, MTLResourceOptions arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_1n9czk0(id target, void * sel, unsigned long arg1, MTLResourceOptions arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_256)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_257)(void * sel, void * arg1, unsigned long arg2, MTLResourceOptions arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_1wsspof(id target, void * sel, void * arg1, unsigned long arg2, MTLResourceOptions arg3) {
  return ((_ProtocolTrampoline_257)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_258)(void * sel, void * arg1, unsigned long arg2, MTLResourceOptions arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_qvsazo(id target, void * sel, void * arg1, unsigned long arg2, MTLResourceOptions arg3, id arg4) {
  return ((_ProtocolTrampoline_258)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_259)(void * sel, MTLDispatchType arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_1vuldgw(id target, void * sel, MTLDispatchType arg1) {
  return ((_ProtocolTrampoline_259)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_260)(void * sel, id arg1, id arg2, id arg3, id * arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_s3ociy(id target, void * sel, id arg1, id arg2, id arg3, id * arg4) {
  return ((_ProtocolTrampoline_260)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_261)(void * sel, id arg1, MTLPipelineOption arg2, id * arg3, id * arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_s8j3g9(id target, void * sel, id arg1, MTLPipelineOption arg2, id * arg3, id * arg4) {
  return ((_ProtocolTrampoline_261)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_262)(void * sel, id arg1, MTLRenderStages arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_mo5hqp(id target, void * sel, id arg1, MTLRenderStages arg2) {
  return ((_ProtocolTrampoline_262)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_263)(void * sel, id arg1, MTLIOCompressionMethod arg2, id * arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_ttdcgo(id target, void * sel, id arg1, MTLIOCompressionMethod arg2, id * arg3) {
  return ((_ProtocolTrampoline_263)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_264)(void * sel, id arg1, unsigned long arg2, MTLResourceOptions arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_1pwmu1(id target, void * sel, id arg1, unsigned long arg2, MTLResourceOptions arg3) {
  return ((_ProtocolTrampoline_264)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_265)(void * sel, id arg1, unsigned long arg2, id * arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_1ogfjip(id target, void * sel, id arg1, unsigned long arg2, id * arg3) {
  return ((_ProtocolTrampoline_265)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_266)(void * sel, MTLPixelFormat arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_12woq8r(id target, void * sel, MTLPixelFormat arg1) {
  return ((_ProtocolTrampoline_266)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_267)(void * sel, MTLPixelFormat arg1, MTLTextureType arg2, struct _NSRange arg3, struct _NSRange arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_1aoqdpp(id target, void * sel, MTLPixelFormat arg1, MTLTextureType arg2, struct _NSRange arg3, struct _NSRange arg4) {
  return ((_ProtocolTrampoline_267)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_268)(void * sel, MTLPixelFormat arg1, MTLTextureType arg2, struct _NSRange arg3, struct _NSRange arg4, MTLTextureSwizzleChannels arg5);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_jipc5v(id target, void * sel, MTLPixelFormat arg1, MTLTextureType arg2, struct _NSRange arg3, struct _NSRange arg4, MTLTextureSwizzleChannels arg5) {
  return ((_ProtocolTrampoline_268)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef id  (^_ProtocolTrampoline_269)(void * sel, id arg1, struct __IOSurface * arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_1ynlvay(id target, void * sel, id arg1, struct __IOSurface * arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_269)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_270)(void * sel, id arg1, unsigned long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_17gec3x(id target, void * sel, id arg1, unsigned long arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_270)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef int  (^_ProtocolTrampoline_271)(void * sel, unsigned arg1);
__attribute__((visibility("default"))) __attribute__((used))
int  _6utppm_protocolTrampoline_4tbi0v(id target, void * sel, unsigned arg1) {
  return ((_ProtocolTrampoline_271)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_272)(void * sel, id arg1, id arg2 __attribute__((ns_consumed)));
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_1p0fswn(id target, void * sel, id arg1, id arg2 __attribute__((ns_consumed))) {
  return ((_ProtocolTrampoline_272)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_273)(void * sel, struct _NSZone * arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_18nsem0(id target, void * sel, struct _NSZone * arg1) {
  return ((_ProtocolTrampoline_273)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_274)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _6utppm_protocolTrampoline_wpy7aa(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_274)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}
#undef BLOCKING_BLOCK_IMPL

#pragma clang diagnostic pop
