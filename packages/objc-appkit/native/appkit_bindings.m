#include <stdint.h>
#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <AppKit/AppKit.h>

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


typedef double  (^_ProtocolTrampoline)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
double  _1wf8t1k_protocolTrampoline_5bm8w8(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef double  (^_ProtocolTrampoline_1)(void * sel, id arg1, long arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
double  _1wf8t1k_protocolTrampoline_1fuhj8e(id target, void * sel, id arg1, long arg2, long arg3) {
  return ((_ProtocolTrampoline_1)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef double  (^_ProtocolTrampoline_2)(void * sel, id arg1, long arg2, BOOL arg3, double arg4);
__attribute__((visibility("default"))) __attribute__((used))
double  _1wf8t1k_protocolTrampoline_b7h1rb(id target, void * sel, id arg1, long arg2, BOOL arg3, double arg4) {
  return ((_ProtocolTrampoline_2)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef double  (^_ProtocolTrampoline_3)(void * sel, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
double  _1wf8t1k_protocolTrampoline_mj5w82(id target, void * sel, id arg1, id arg2, long arg3) {
  return ((_ProtocolTrampoline_3)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef double  (^_ProtocolTrampoline_4)(void * sel, id arg1, unsigned long arg2, struct CGRect arg3);
__attribute__((visibility("default"))) __attribute__((used))
double  _1wf8t1k_protocolTrampoline_1csvj5s(id target, void * sel, id arg1, unsigned long arg2, struct CGRect arg3) {
  return ((_ProtocolTrampoline_4)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef double  (^_ProtocolTrampoline_5)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
double  _1wf8t1k_protocolTrampoline_1kspct0(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_5)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef double  (^_ProtocolTrampoline_6)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
double  _1wf8t1k_protocolTrampoline_lwcz9r(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_6)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef double  (^_ProtocolTrampoline_7)(void * sel, id arg1, double arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
double  _1wf8t1k_protocolTrampoline_f2ihi3(id target, void * sel, id arg1, double arg2, long arg3) {
  return ((_ProtocolTrampoline_7)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef double  (^_ProtocolTrampoline_8)(void * sel, unsigned long arg1);
__attribute__((visibility("default"))) __attribute__((used))
double  _1wf8t1k_protocolTrampoline_ae6hkl(id target, void * sel, unsigned long arg1) {
  return ((_ProtocolTrampoline_8)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGImage *  (^_ProtocolTrampoline_9)(void * sel, struct CGSize arg1, double arg2, struct CGPoint * arg3, struct CGSize * arg4);
__attribute__((visibility("default"))) __attribute__((used))
struct CGImage *  _1wf8t1k_protocolTrampoline_1p89e63(id target, void * sel, struct CGSize arg1, double arg2, struct CGPoint * arg3, struct CGSize * arg4) {
  return ((_ProtocolTrampoline_9)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef struct CGRect  (^_ProtocolTrampoline_10)(void * sel, id arg1, id arg2, id arg3, struct CGRect arg4, struct CGPoint arg5);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _1wf8t1k_protocolTrampoline_1ravc6k(id target, void * sel, id arg1, id arg2, id arg3, struct CGRect arg4, struct CGPoint arg5) {
  return ((_ProtocolTrampoline_10)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef struct CGRect  (^_ProtocolTrampoline_11)(void * sel, id arg1, struct CGRect arg2, struct CGPoint arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _1wf8t1k_protocolTrampoline_iqdvkd(id target, void * sel, id arg1, struct CGRect arg2, struct CGPoint arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_11)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef struct CGRect  (^_ProtocolTrampoline_12)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _1wf8t1k_protocolTrampoline_szn7s6(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_12)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGSize  (^_ProtocolTrampoline_13)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _1wf8t1k_protocolTrampoline_xmxmuf(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_13)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_14)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_xr62hr(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_14)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_15)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_zi5eed(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_15)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef NSAccessibilityOrientation  (^_ProtocolTrampoline_16)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSAccessibilityOrientation  _1wf8t1k_protocolTrampoline_ua0zt4(id target, void * sel) {
  return ((_ProtocolTrampoline_16)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSAccessibilityRulerMarkerType  (^_ProtocolTrampoline_17)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSAccessibilityRulerMarkerType  _1wf8t1k_protocolTrampoline_1sop3vw(id target, void * sel) {
  return ((_ProtocolTrampoline_17)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSAccessibilitySortDirection  (^_ProtocolTrampoline_18)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSAccessibilitySortDirection  _1wf8t1k_protocolTrampoline_1gh8zj5(id target, void * sel) {
  return ((_ProtocolTrampoline_18)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSAccessibilityUnits  (^_ProtocolTrampoline_19)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSAccessibilityUnits  _1wf8t1k_protocolTrampoline_1600k13(id target, void * sel) {
  return ((_ProtocolTrampoline_19)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_20)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1mbt9g9(id target, void * sel) {
  return ((_ProtocolTrampoline_20)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSApplicationPresentationOptions  (^_ProtocolTrampoline_21)(void * sel, id arg1, NSApplicationPresentationOptions arg2);
__attribute__((visibility("default"))) __attribute__((used))
NSApplicationPresentationOptions  _1wf8t1k_protocolTrampoline_o924zt(id target, void * sel, id arg1, NSApplicationPresentationOptions arg2) {
  return ((_ProtocolTrampoline_21)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef NSApplicationPrintReply  (^_ProtocolTrampoline_22)(void * sel, id arg1, id arg2, id arg3, BOOL arg4);
__attribute__((visibility("default"))) __attribute__((used))
NSApplicationPrintReply  _1wf8t1k_protocolTrampoline_1ntoid(id target, void * sel, id arg1, id arg2, id arg3, BOOL arg4) {
  return ((_ProtocolTrampoline_22)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef NSApplicationTerminateReply  (^_ProtocolTrampoline_23)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSApplicationTerminateReply  _1wf8t1k_protocolTrampoline_dl2wbd(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_23)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_24)(void * sel, id arg1, id arg2, id arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_9e3h5l(id target, void * sel, id arg1, id arg2, id arg3, long arg4) {
  return ((_ProtocolTrampoline_24)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_25)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1yw2rcr(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_25)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_26)(void * sel, id arg1, id arg2, id arg3, struct _NSRange arg4, long * arg5);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1c30j5d(id target, void * sel, id arg1, id arg2, id arg3, struct _NSRange arg4, long * arg5) {
  return ((_ProtocolTrampoline_26)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef id  (^_ProtocolTrampoline_27)(void * sel, struct _NSRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_xzy3cf(id target, void * sel, struct _NSRange arg1) {
  return ((_ProtocolTrampoline_27)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_28)(void * sel, id arg1, struct _NSRange arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_19u921t(id target, void * sel, id arg1, struct _NSRange arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_28)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_29)(void * sel, id arg1, id arg2, unsigned long arg3, uint64_t arg4, id arg5, id arg6, long * arg7);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1chy5b9(id target, void * sel, id arg1, id arg2, unsigned long arg3, uint64_t arg4, id arg5, id arg6, long * arg7) {
  return ((_ProtocolTrampoline_29)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
}

typedef id  (^_ProtocolTrampoline_30)(void * sel, id arg1, long arg2, NSTableRowActionEdge arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_9a8fyd(id target, void * sel, id arg1, long arg2, NSTableRowActionEdge arg3) {
  return ((_ProtocolTrampoline_30)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_31)(void * sel, id arg1, id arg2, id arg3, struct _NSRange arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1rp5l9d(id target, void * sel, id arg1, id arg2, id arg3, struct _NSRange arg4) {
  return ((_ProtocolTrampoline_31)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_32)(void * sel, id arg1, id arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1sfqckr(id target, void * sel, id arg1, id arg2, struct _NSRange arg3) {
  return ((_ProtocolTrampoline_32)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_33)(void * sel, id arg1, id arg2, struct _NSRange arg3, long * arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1cinhbv(id target, void * sel, id arg1, id arg2, struct _NSRange arg3, long * arg4) {
  return ((_ProtocolTrampoline_33)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_34)(void * sel, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_ggvik5(id target, void * sel, id arg1, struct _NSRange arg2) {
  return ((_ProtocolTrampoline_34)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_35)(void * sel, id arg1, struct _NSRange arg2, uint64_t arg3, id arg4, id arg5, id arg6, long arg7);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_145pe2u(id target, void * sel, id arg1, struct _NSRange arg2, uint64_t arg3, id arg4, id arg5, id arg6, long arg7) {
  return ((_ProtocolTrampoline_35)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
}

typedef id  (^_ProtocolTrampoline_36)(void * sel, id arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1mpupby(id target, void * sel, id arg1, id arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_36)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_37)(void * sel, id arg1, id arg2, long arg3, long * arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1f6rkc7(id target, void * sel, id arg1, id arg2, long arg3, long * arg4) {
  return ((_ProtocolTrampoline_37)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_38)(void * sel, struct _NSRange arg1, struct _NSRange * arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_17bmapz(id target, void * sel, struct _NSRange arg1, struct _NSRange * arg2) {
  return ((_ProtocolTrampoline_38)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_39)(void * sel, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1tgdqpb(id target, void * sel, id arg1, id arg2, long arg3) {
  return ((_ProtocolTrampoline_39)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef NSCloudKitSharingServiceOptions  (^_ProtocolTrampoline_40)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
NSCloudKitSharingServiceOptions  _1wf8t1k_protocolTrampoline_1syiric(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_40)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef NSCollectionElementCategory  (^_ProtocolTrampoline_41)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSCollectionElementCategory  _1wf8t1k_protocolTrampoline_etyamm(id target, void * sel) {
  return ((_ProtocolTrampoline_41)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSColorPanelMode  (^_ProtocolTrampoline_42)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSColorPanelMode  _1wf8t1k_protocolTrampoline_160f7hy(id target, void * sel) {
  return ((_ProtocolTrampoline_42)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSComparisonResult  (^_ProtocolTrampoline_43)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSComparisonResult  _1wf8t1k_protocolTrampoline_1xws32k(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_43)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef NSControlCharacterAction  (^_ProtocolTrampoline_44)(void * sel, id arg1, NSControlCharacterAction arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
NSControlCharacterAction  _1wf8t1k_protocolTrampoline_505ew6(id target, void * sel, id arg1, NSControlCharacterAction arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_44)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_45)(void * sel, struct objc_selector * arg1, NSCalculationError arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_738w24(id target, void * sel, struct objc_selector * arg1, NSCalculationError arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_45)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_46)(void * sel, id arg1, id arg2, BOOL arg3, unsigned long arg4, struct _NSRange * arg5);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_obu6t0(id target, void * sel, id arg1, id arg2, BOOL arg3, unsigned long arg4, struct _NSRange * arg5) {
  return ((_ProtocolTrampoline_46)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef id  (^_ProtocolTrampoline_47)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_qfyidt(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_47)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_48)(void * sel, id arg1, struct _NSRange arg2, id arg3, uint64_t * arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1wersru(id target, void * sel, id arg1, struct _NSRange arg2, id arg3, uint64_t * arg4) {
  return ((_ProtocolTrampoline_48)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef struct NSDirectionalEdgeInsets  (^_ProtocolTrampoline_49)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct NSDirectionalEdgeInsets  _1wf8t1k_protocolTrampoline_1qyypoa(id target, void * sel) {
  return ((_ProtocolTrampoline_49)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSDragOperation  (^_ProtocolTrampoline_50)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSDragOperation  _1wf8t1k_protocolTrampoline_opoy27(id target, void * sel) {
  return ((_ProtocolTrampoline_50)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSDragOperation  (^_ProtocolTrampoline_51)(void * sel, id arg1, id arg2, long * arg3, long * arg4, NSBrowserDropOperation * arg5);
__attribute__((visibility("default"))) __attribute__((used))
NSDragOperation  _1wf8t1k_protocolTrampoline_1pxm63y(id target, void * sel, id arg1, id arg2, long * arg3, long * arg4, NSBrowserDropOperation * arg5) {
  return ((_ProtocolTrampoline_51)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef NSDragOperation  (^_ProtocolTrampoline_52)(void * sel, id arg1, id arg2, id * arg3, NSCollectionViewDropOperation * arg4);
__attribute__((visibility("default"))) __attribute__((used))
NSDragOperation  _1wf8t1k_protocolTrampoline_ae1ot0(id target, void * sel, id arg1, id arg2, id * arg3, NSCollectionViewDropOperation * arg4) {
  return ((_ProtocolTrampoline_52)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef NSDragOperation  (^_ProtocolTrampoline_53)(void * sel, id arg1, id arg2, long * arg3, NSCollectionViewDropOperation * arg4);
__attribute__((visibility("default"))) __attribute__((used))
NSDragOperation  _1wf8t1k_protocolTrampoline_rkv09v(id target, void * sel, id arg1, id arg2, long * arg3, NSCollectionViewDropOperation * arg4) {
  return ((_ProtocolTrampoline_53)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef NSDragOperation  (^_ProtocolTrampoline_54)(void * sel, id arg1, NSDraggingContext arg2);
__attribute__((visibility("default"))) __attribute__((used))
NSDragOperation  _1wf8t1k_protocolTrampoline_144wi1g(id target, void * sel, id arg1, NSDraggingContext arg2) {
  return ((_ProtocolTrampoline_54)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef NSDragOperation  (^_ProtocolTrampoline_55)(void * sel, id arg1, id arg2, id arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
NSDragOperation  _1wf8t1k_protocolTrampoline_zajc1v(id target, void * sel, id arg1, id arg2, id arg3, long arg4) {
  return ((_ProtocolTrampoline_55)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef NSDragOperation  (^_ProtocolTrampoline_56)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
NSDragOperation  _1wf8t1k_protocolTrampoline_ulsrbf(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_56)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef NSDragOperation  (^_ProtocolTrampoline_57)(void * sel, id arg1, id arg2, long arg3, NSTableViewDropOperation arg4);
__attribute__((visibility("default"))) __attribute__((used))
NSDragOperation  _1wf8t1k_protocolTrampoline_1yx9laf(id target, void * sel, id arg1, id arg2, long arg3, NSTableViewDropOperation arg4) {
  return ((_ProtocolTrampoline_57)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef NSDragOperation  (^_ProtocolTrampoline_58)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSDragOperation  _1wf8t1k_protocolTrampoline_u1rw1h(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_58)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef NSDraggingFormation  (^_ProtocolTrampoline_59)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSDraggingFormation  _1wf8t1k_protocolTrampoline_1c2pgii(id target, void * sel) {
  return ((_ProtocolTrampoline_59)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct NSEdgeInsets  (^_ProtocolTrampoline_60)(void * sel, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
struct NSEdgeInsets  _1wf8t1k_protocolTrampoline_yx4fwe(id target, void * sel, id arg1, id arg2, long arg3) {
  return ((_ProtocolTrampoline_60)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef NSFontPanelModeMask  (^_ProtocolTrampoline_61)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSFontPanelModeMask  _1wf8t1k_protocolTrampoline_wlkc32(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_61)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_62)(void * sel, struct CGRect arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1a7e3u0(id target, void * sel, struct CGRect arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_62)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_63)(void * sel, struct CGRect arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_qwb72h(id target, void * sel, struct CGRect arg1, id arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_63)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_64)(void * sel, id arg1, id arg2, long arg3, id arg4, struct CGPoint * arg5);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1k3721c(id target, void * sel, id arg1, id arg2, long arg3, id arg4, struct CGPoint * arg5) {
  return ((_ProtocolTrampoline_64)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef id  (^_ProtocolTrampoline_65)(void * sel, id arg1, id arg2, id arg3, struct CGPoint * arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_e90bri(id target, void * sel, id arg1, id arg2, id arg3, struct CGPoint * arg4) {
  return ((_ProtocolTrampoline_65)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_66)(void * sel, id arg1, struct CGRect arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1vkcw9o(id target, void * sel, id arg1, struct CGRect arg2) {
  return ((_ProtocolTrampoline_66)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_67)(void * sel, id arg1, id arg2, struct CGRect * arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1mrep1k(id target, void * sel, id arg1, id arg2, struct CGRect * arg3) {
  return ((_ProtocolTrampoline_67)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef long  (^_ProtocolTrampoline_68)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
long  _1wf8t1k_protocolTrampoline_fai2e9(id target, void * sel) {
  return ((_ProtocolTrampoline_68)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef long  (^_ProtocolTrampoline_69)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
long  _1wf8t1k_protocolTrampoline_1e5b3dp(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_69)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef long  (^_ProtocolTrampoline_70)(void * sel, id arg1, long arg2, long arg3, long arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
long  _1wf8t1k_protocolTrampoline_2ufktv(id target, void * sel, id arg1, long arg2, long arg3, long arg4, id arg5) {
  return ((_ProtocolTrampoline_70)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef long  (^_ProtocolTrampoline_71)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
long  _1wf8t1k_protocolTrampoline_evw03x(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_71)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef long  (^_ProtocolTrampoline_72)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
long  _1wf8t1k_protocolTrampoline_sqbvvb(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_72)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef long  (^_ProtocolTrampoline_73)(void * sel, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
long  _1wf8t1k_protocolTrampoline_1p78ubn(id target, void * sel, long arg1) {
  return ((_ProtocolTrampoline_73)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef long  (^_ProtocolTrampoline_74)(void * sel, id arg1, id arg2, NSRuleEditorRowType arg3);
__attribute__((visibility("default"))) __attribute__((used))
long  _1wf8t1k_protocolTrampoline_93cew3(id target, void * sel, id arg1, id arg2, NSRuleEditorRowType arg3) {
  return ((_ProtocolTrampoline_74)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef long  (^_ProtocolTrampoline_75)(void * sel, id arg1, long arg2, long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
long  _1wf8t1k_protocolTrampoline_1vphh99(id target, void * sel, id arg1, long arg2, long arg3, id arg4) {
  return ((_ProtocolTrampoline_75)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef long  (^_ProtocolTrampoline_76)(void * sel, id arg1, long arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
long  _1wf8t1k_protocolTrampoline_15zjx8z(id target, void * sel, id arg1, long arg2, struct _NSRange arg3) {
  return ((_ProtocolTrampoline_76)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_77)(void * sel, id arg1, id arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1ja1ksk(id target, void * sel, id arg1, id arg2, id arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_77)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef NSPasteboardWritingOptions  (^_ProtocolTrampoline_78)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
NSPasteboardWritingOptions  _1wf8t1k_protocolTrampoline_zs9fen(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_78)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGPoint  (^_ProtocolTrampoline_79)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _1wf8t1k_protocolTrampoline_7ohnx8(id target, void * sel) {
  return ((_ProtocolTrampoline_79)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGPoint  (^_ProtocolTrampoline_80)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _1wf8t1k_protocolTrampoline_loskaj(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_80)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct _NSRange  (^_ProtocolTrampoline_81)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct _NSRange  _1wf8t1k_protocolTrampoline_1mh5vs9(id target, void * sel) {
  return ((_ProtocolTrampoline_81)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct _NSRange  (^_ProtocolTrampoline_82)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct _NSRange  _1wf8t1k_protocolTrampoline_ci9aun(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_82)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct _NSRange  (^_ProtocolTrampoline_83)(void * sel, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct _NSRange  _1wf8t1k_protocolTrampoline_8h6smj(id target, void * sel, long arg1) {
  return ((_ProtocolTrampoline_83)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct _NSRange  (^_ProtocolTrampoline_84)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct _NSRange  _1wf8t1k_protocolTrampoline_1lg7chq(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_84)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct _NSRange  (^_ProtocolTrampoline_85)(void * sel, id arg1, id arg2, id arg3, id * arg4);
__attribute__((visibility("default"))) __attribute__((used))
struct _NSRange  _1wf8t1k_protocolTrampoline_xsqx6i(id target, void * sel, id arg1, id arg2, id arg3, id * arg4) {
  return ((_ProtocolTrampoline_85)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef struct _NSRange  (^_ProtocolTrampoline_86)(void * sel, id arg1, id arg2, id arg3, long * arg4, BOOL arg5);
__attribute__((visibility("default"))) __attribute__((used))
struct _NSRange  _1wf8t1k_protocolTrampoline_1j6oadz(id target, void * sel, id arg1, id arg2, id arg3, long * arg4, BOOL arg5) {
  return ((_ProtocolTrampoline_86)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef struct _NSRange  (^_ProtocolTrampoline_87)(void * sel, id arg1, struct _NSRange arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
struct _NSRange  _1wf8t1k_protocolTrampoline_g9lmej(id target, void * sel, id arg1, struct _NSRange arg2, struct _NSRange arg3) {
  return ((_ProtocolTrampoline_87)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef struct CGRect  (^_ProtocolTrampoline_88)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _1wf8t1k_protocolTrampoline_1c3uc0w(id target, void * sel) {
  return ((_ProtocolTrampoline_88)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGRect  (^_ProtocolTrampoline_89)(void * sel, id arg1, unsigned long arg2, id arg3, struct CGRect arg4, struct CGPoint arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _1wf8t1k_protocolTrampoline_dunsuy(id target, void * sel, id arg1, unsigned long arg2, id arg3, struct CGRect arg4, struct CGPoint arg5, unsigned long arg6) {
  return ((_ProtocolTrampoline_89)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef struct CGRect  (^_ProtocolTrampoline_90)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _1wf8t1k_protocolTrampoline_bl8dec(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_90)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGRect  (^_ProtocolTrampoline_91)(void * sel, struct _NSRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _1wf8t1k_protocolTrampoline_ox7a80(id target, void * sel, struct _NSRange arg1) {
  return ((_ProtocolTrampoline_91)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGRect  (^_ProtocolTrampoline_92)(void * sel, struct _NSRange arg1, struct _NSRange * arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _1wf8t1k_protocolTrampoline_1xytnsq(id target, void * sel, struct _NSRange arg1, struct _NSRange * arg2) {
  return ((_ProtocolTrampoline_92)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGRect  (^_ProtocolTrampoline_93)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _1wf8t1k_protocolTrampoline_1c2y2tk(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_93)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGRect  (^_ProtocolTrampoline_94)(void * sel, id arg1, struct CGRect arg2, struct CGRect arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _1wf8t1k_protocolTrampoline_4xhn6i(id target, void * sel, id arg1, struct CGRect arg2, struct CGRect arg3, long arg4) {
  return ((_ProtocolTrampoline_94)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef struct CGRect  (^_ProtocolTrampoline_95)(void * sel, id arg1, struct CGRect arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _1wf8t1k_protocolTrampoline_jnr01b(id target, void * sel, id arg1, struct CGRect arg2) {
  return ((_ProtocolTrampoline_95)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGRect  (^_ProtocolTrampoline_96)(void * sel, id arg1, id arg2, struct CGRect arg3);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _1wf8t1k_protocolTrampoline_1vg0rmd(id target, void * sel, id arg1, id arg2, struct CGRect arg3) {
  return ((_ProtocolTrampoline_96)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef NSRoundingMode  (^_ProtocolTrampoline_97)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSRoundingMode  _1wf8t1k_protocolTrampoline_5cb1bj(id target, void * sel) {
  return ((_ProtocolTrampoline_97)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_98)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1xvw1tx(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_98)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_99)(void * sel, id arg1, id arg2, NSCollectionViewItemHighlightState arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_wqwmd5(id target, void * sel, id arg1, id arg2, NSCollectionViewItemHighlightState arg3) {
  return ((_ProtocolTrampoline_99)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef struct CGSize  (^_ProtocolTrampoline_100)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _1wf8t1k_protocolTrampoline_1j20mp(id target, void * sel) {
  return ((_ProtocolTrampoline_100)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGSize  (^_ProtocolTrampoline_101)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _1wf8t1k_protocolTrampoline_ckubc3(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_101)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef struct CGSize  (^_ProtocolTrampoline_102)(void * sel, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _1wf8t1k_protocolTrampoline_141imqv(id target, void * sel, id arg1, id arg2, long arg3) {
  return ((_ProtocolTrampoline_102)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef struct CGSize  (^_ProtocolTrampoline_103)(void * sel, id arg1, struct CGSize arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _1wf8t1k_protocolTrampoline_gnbb7x(id target, void * sel, id arg1, struct CGSize arg2) {
  return ((_ProtocolTrampoline_103)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGSize  (^_ProtocolTrampoline_104)(void * sel, struct CGSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _1wf8t1k_protocolTrampoline_zeon27(id target, void * sel, struct CGSize arg1) {
  return ((_ProtocolTrampoline_104)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGSize  (^_ProtocolTrampoline_105)(void * sel, id arg1, struct CGSize arg2, struct CGSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _1wf8t1k_protocolTrampoline_1hqtzbn(id target, void * sel, id arg1, struct CGSize arg2, struct CGSize arg3) {
  return ((_ProtocolTrampoline_105)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef NSSpringLoadingHighlight  (^_ProtocolTrampoline_106)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSSpringLoadingHighlight  _1wf8t1k_protocolTrampoline_d6sil9(id target, void * sel) {
  return ((_ProtocolTrampoline_106)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSSpringLoadingOptions  (^_ProtocolTrampoline_107)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSSpringLoadingOptions  _1wf8t1k_protocolTrampoline_50pxk9(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_107)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_108)(void * sel, id arg1, long arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_17vitjj(id target, void * sel, id arg1, long arg2, long arg3) {
  return ((_ProtocolTrampoline_108)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_109)(void * sel, id arg1, id arg2, struct CGRect * arg3, id arg4, id arg5, struct CGPoint arg6);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1t8fkvv(id target, void * sel, id arg1, id arg2, struct CGRect * arg3, id arg4, id arg5, struct CGPoint arg6) {
  return ((_ProtocolTrampoline_109)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef id  (^_ProtocolTrampoline_110)(void * sel, id arg1, id arg2, struct CGRect * arg3, id arg4, long arg5, struct CGPoint arg6);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1ppdj67(id target, void * sel, id arg1, id arg2, struct CGRect * arg3, id arg4, long arg5, struct CGPoint arg6) {
  return ((_ProtocolTrampoline_110)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef id  (^_ProtocolTrampoline_111)(void * sel, unsigned long arg1, struct _NSRange * arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_19qfjta(id target, void * sel, unsigned long arg1, struct _NSRange * arg2, BOOL * arg3) {
  return ((_ProtocolTrampoline_111)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_112)(void * sel, id arg1, long arg2, struct CGPoint arg3, void * arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_vja0y6(id target, void * sel, id arg1, long arg2, struct CGPoint arg3, void * arg4) {
  return ((_ProtocolTrampoline_112)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_113)(void * sel, id arg1, id arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1lm7r4t(id target, void * sel, id arg1, id arg2, BOOL arg3) {
  return ((_ProtocolTrampoline_113)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef NSTextCursorAccessoryPlacement  (^_ProtocolTrampoline_114)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSTextCursorAccessoryPlacement  _1wf8t1k_protocolTrampoline_1q0cf5a(id target, void * sel) {
  return ((_ProtocolTrampoline_114)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSTextInputTraitType  (^_ProtocolTrampoline_115)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSTextInputTraitType  _1wf8t1k_protocolTrampoline_1hvujqv(id target, void * sel) {
  return ((_ProtocolTrampoline_115)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSTextLayoutOrientation  (^_ProtocolTrampoline_116)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSTextLayoutOrientation  _1wf8t1k_protocolTrampoline_1hcgfk1(id target, void * sel) {
  return ((_ProtocolTrampoline_116)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_117)(void * sel, struct CGPoint arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1cizpv0(id target, void * sel, struct CGPoint arg1, id arg2) {
  return ((_ProtocolTrampoline_117)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_118)(void * sel, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1u4xn97(id target, void * sel, id arg1, BOOL arg2) {
  return ((_ProtocolTrampoline_118)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_119)(void * sel, NSTextSelectionGranularity arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1msw0hl(id target, void * sel, NSTextSelectionGranularity arg1, id arg2) {
  return ((_ProtocolTrampoline_119)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef NSTextSelectionNavigationLayoutOrientation  (^_ProtocolTrampoline_120)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSTextSelectionNavigationLayoutOrientation  _1wf8t1k_protocolTrampoline_1kcz7dl(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_120)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef NSTextSelectionNavigationWritingDirection  (^_ProtocolTrampoline_121)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSTextSelectionNavigationWritingDirection  _1wf8t1k_protocolTrampoline_1kewuno(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_121)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef NSTokenStyle  (^_ProtocolTrampoline_122)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
NSTokenStyle  _1wf8t1k_protocolTrampoline_1dyn294(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_122)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef unsigned long  (^_ProtocolTrampoline_123)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _1wf8t1k_protocolTrampoline_1ckyi24(id target, void * sel) {
  return ((_ProtocolTrampoline_123)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef unsigned long  (^_ProtocolTrampoline_124)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _1wf8t1k_protocolTrampoline_1xrqj4g(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_124)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef unsigned long  (^_ProtocolTrampoline_125)(void * sel, id arg1, unsigned short * arg2, NSGlyphProperty * arg3, unsigned long * arg4, id arg5, struct _NSRange arg6);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _1wf8t1k_protocolTrampoline_1njk2hu(id target, void * sel, id arg1, unsigned short * arg2, NSGlyphProperty * arg3, unsigned long * arg4, id arg5, struct _NSRange arg6) {
  return ((_ProtocolTrampoline_125)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef unsigned long  (^_ProtocolTrampoline_126)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _1wf8t1k_protocolTrampoline_r5c0tn(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_126)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_127)(void * sel, struct _NSRange arg1, struct CGRect * arg2, struct _NSRange * arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_g9rctw(id target, void * sel, struct _NSRange arg1, struct CGRect * arg2, struct _NSRange * arg3) {
  return ((_ProtocolTrampoline_127)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_128)(void * sel, id arg1, struct CGRect * arg2, NSRectEdge * arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_erz08o(id target, void * sel, id arg1, struct CGRect * arg2, NSRectEdge * arg3) {
  return ((_ProtocolTrampoline_128)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_129)(void * sel, unsigned long arg1, struct _NSRange * arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_vt1y0w(id target, void * sel, unsigned long arg1, struct _NSRange * arg2) {
  return ((_ProtocolTrampoline_129)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_130)(void * sel, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1ggpu35(id target, void * sel, BOOL arg1) {
  return ((_ProtocolTrampoline_130)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_131)(void * sel, id arg1, id arg2, NSSharingContentScope * arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_vys0t7(id target, void * sel, id arg1, id arg2, NSSharingContentScope * arg3) {
  return ((_ProtocolTrampoline_131)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef NSWritingToolsBehavior  (^_ProtocolTrampoline_132)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSWritingToolsBehavior  _1wf8t1k_protocolTrampoline_1lr8nud(id target, void * sel) {
  return ((_ProtocolTrampoline_132)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSWritingToolsResultOptions  (^_ProtocolTrampoline_133)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSWritingToolsResultOptions  _1wf8t1k_protocolTrampoline_3iswoq(id target, void * sel) {
  return ((_ProtocolTrampoline_133)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct OpaquePMPageFormat *  (^_ProtocolTrampoline_134)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct OpaquePMPageFormat *  _1wf8t1k_protocolTrampoline_1pm5t72(id target, void * sel) {
  return ((_ProtocolTrampoline_134)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct OpaquePMPrintSession *  (^_ProtocolTrampoline_135)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct OpaquePMPrintSession *  _1wf8t1k_protocolTrampoline_1ch2rph(id target, void * sel) {
  return ((_ProtocolTrampoline_135)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct OpaquePMPrintSettings *  (^_ProtocolTrampoline_136)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct OpaquePMPrintSettings *  _1wf8t1k_protocolTrampoline_1cwrrqo(id target, void * sel) {
  return ((_ProtocolTrampoline_136)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct OpaquePMPrinter *  (^_ProtocolTrampoline_137)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct OpaquePMPrinter *  _1wf8t1k_protocolTrampoline_h8xvuu(id target, void * sel) {
  return ((_ProtocolTrampoline_137)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_138)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_e3qsqz(id target, void * sel) {
  return ((_ProtocolTrampoline_138)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_139)(void * sel, id arg1, double arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_cpb8xo(id target, void * sel, id arg1, double arg2, id arg3) {
  return ((_ProtocolTrampoline_139)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_140)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_3su7tt(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_140)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_141)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_2n06mv(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_141)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_142)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_rptcvw(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_142)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_143)(void * sel, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_9k4e9l(id target, void * sel, id arg1, BOOL arg2) {
  return ((_ProtocolTrampoline_143)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_144)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_jk8du5(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_144)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_145)(void * sel, id arg1, id arg2, long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_3jk1er(id target, void * sel, id arg1, id arg2, long arg3, id arg4) {
  return ((_ProtocolTrampoline_145)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_146)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_1ae3jer(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_146)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_147)(void * sel, id arg1, long arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_oyissh(id target, void * sel, id arg1, long arg2, long arg3) {
  return ((_ProtocolTrampoline_147)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_148)(void * sel, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_zsfo0t(id target, void * sel, id arg1, id arg2, long arg3) {
  return ((_ProtocolTrampoline_148)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_149)(void * sel, id arg1, id arg2, long arg3, long arg4, NSBrowserDropOperation arg5);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_mx94ww(id target, void * sel, id arg1, id arg2, long arg3, long arg4, NSBrowserDropOperation arg5) {
  return ((_ProtocolTrampoline_149)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef BOOL  (^_ProtocolTrampoline_150)(void * sel, id arg1, id arg2, id arg3, NSCollectionViewDropOperation arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_17rgzir(id target, void * sel, id arg1, id arg2, id arg3, NSCollectionViewDropOperation arg4) {
  return ((_ProtocolTrampoline_150)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_151)(void * sel, id arg1, id arg2, long arg3, NSCollectionViewDropOperation arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_15x9ftv(id target, void * sel, id arg1, id arg2, long arg3, NSCollectionViewDropOperation arg4) {
  return ((_ProtocolTrampoline_151)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_152)(void * sel, NSColorPanelMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_1o8ee36(id target, void * sel, NSColorPanelMode arg1) {
  return ((_ProtocolTrampoline_152)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_153)(void * sel, id arg1, id arg2, struct objc_selector * arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_1c6g01w(id target, void * sel, id arg1, id arg2, struct objc_selector * arg3) {
  return ((_ProtocolTrampoline_153)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_154)(void * sel, id * arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_jp3gca(id target, void * sel, id * arg1) {
  return ((_ProtocolTrampoline_154)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_155)(void * sel, id arg1, struct CGRect arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_mdqffl(id target, void * sel, id arg1, struct CGRect arg2, id arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_155)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_156)(void * sel, id arg1, struct CGRect arg2, id arg3, unsigned long arg4, BOOL arg5);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_7vcxix(id target, void * sel, id arg1, struct CGRect arg2, id arg3, unsigned long arg4, BOOL arg5) {
  return ((_ProtocolTrampoline_156)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef BOOL  (^_ProtocolTrampoline_157)(void * sel, id arg1, struct CGRect arg2, id arg3, BOOL arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_b1wn5c(id target, void * sel, id arg1, struct CGRect arg2, id arg3, BOOL arg4) {
  return ((_ProtocolTrampoline_157)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_158)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_1em3l8z(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_158)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_159)(void * sel, id arg1, struct CGRect * arg2, struct CGRect * arg3, double * arg4, id arg5, struct _NSRange arg6);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_1p38w4s(id target, void * sel, id arg1, struct CGRect * arg2, struct CGRect * arg3, double * arg4, id arg5, struct _NSRange arg6) {
  return ((_ProtocolTrampoline_159)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef BOOL  (^_ProtocolTrampoline_160)(void * sel, id arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_16fgsa(id target, void * sel, id arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_160)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_161)(void * sel, id arg1, id arg2, id * arg3, struct objc_selector * * arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_11zjqzj(id target, void * sel, id arg1, id arg2, id * arg3, struct objc_selector * * arg4) {
  return ((_ProtocolTrampoline_161)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_162)(void * sel, id arg1, id arg2, long arg3, BOOL arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_1d4j51x(id target, void * sel, id arg1, id arg2, long arg3, BOOL arg4) {
  return ((_ProtocolTrampoline_162)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_163)(void * sel, id arg1, id arg2, id arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_1g7q2jb(id target, void * sel, id arg1, id arg2, id arg3, long arg4) {
  return ((_ProtocolTrampoline_163)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_164)(void * sel, id arg1, id arg2, long arg3, NSTableViewDropOperation arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_ml7ks3(id target, void * sel, id arg1, id arg2, long arg3, NSTableViewDropOperation arg4) {
  return ((_ProtocolTrampoline_164)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_165)(void * sel, id arg1, id arg2, NSTextContentManagerEnumerationOptions arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_r3hakm(id target, void * sel, id arg1, id arg2, NSTextContentManagerEnumerationOptions arg3) {
  return ((_ProtocolTrampoline_165)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_166)(void * sel, id arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_7ene1c(id target, void * sel, id arg1, id arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_166)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_167)(void * sel, id arg1, id arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_t3vpwz(id target, void * sel, id arg1, id arg2, BOOL arg3) {
  return ((_ProtocolTrampoline_167)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_168)(void * sel, id arg1, struct _NSRange arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_u18wpp(id target, void * sel, id arg1, struct _NSRange arg2, id arg3) {
  return ((_ProtocolTrampoline_168)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_169)(void * sel, id arg1, id arg2, unsigned long arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_1i5xgg4(id target, void * sel, id arg1, id arg2, unsigned long arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_169)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef BOOL  (^_ProtocolTrampoline_170)(void * sel, id arg1, struct objc_selector * arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_122cere(id target, void * sel, id arg1, struct objc_selector * arg2) {
  return ((_ProtocolTrampoline_170)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_171)(void * sel, unsigned long arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_15ssoz8(id target, void * sel, unsigned long arg1) {
  return ((_ProtocolTrampoline_171)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_172)(void * sel, unsigned long arg1, struct CGPoint arg2, unsigned long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_il9yo2(id target, void * sel, unsigned long arg1, struct CGPoint arg2, unsigned long arg3, id arg4) {
  return ((_ProtocolTrampoline_172)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_173)(void * sel, id arg1, id arg2, struct CGPoint arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_6f73nq(id target, void * sel, id arg1, id arg2, struct CGPoint arg3, id arg4) {
  return ((_ProtocolTrampoline_173)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_174)(void * sel, id arg1, struct CGRect arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_yubn6m(id target, void * sel, id arg1, struct CGRect arg2) {
  return ((_ProtocolTrampoline_174)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_175)(void * sel, id arg1, id arg2, id * arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_oqebfq(id target, void * sel, id arg1, id arg2, id * arg3) {
  return ((_ProtocolTrampoline_175)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_176)(void * sel, struct objc_selector * arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1wf8t1k_protocolTrampoline_w1e3k0(id target, void * sel, struct objc_selector * arg1) {
  return ((_ProtocolTrampoline_176)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef double  (^_ProtocolTrampoline_177)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
double  _1wf8t1k_protocolTrampoline_tfvuzk(id target, void * sel) {
  return ((_ProtocolTrampoline_177)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef float  (^_ProtocolTrampoline_178)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
float  _1wf8t1k_protocolTrampoline_66c10j(id target, void * sel) {
  return ((_ProtocolTrampoline_178)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef float  (^_ProtocolTrampoline_179)(void * sel, id arg1, float arg2);
__attribute__((visibility("default"))) __attribute__((used))
float  _1wf8t1k_protocolTrampoline_u45tch(id target, void * sel, id arg1, float arg2) {
  return ((_ProtocolTrampoline_179)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef short  (^_ProtocolTrampoline_180)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
short  _1wf8t1k_protocolTrampoline_p984hf(id target, void * sel) {
  return ((_ProtocolTrampoline_180)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline)(void);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _1wf8t1k_wrapListenerBlock_1pl9qdv(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void() {
    objc_retainBlock(block);
    block();
  };
}

typedef void  (^_BlockingTrampoline)(void * waiter);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _1wf8t1k_wrapBlockingBlock_1pl9qdv(
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

typedef void  (^_ListenerTrampoline_1)(double arg0, NSEventPhase arg1, BOOL arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _1wf8t1k_wrapListenerBlock_d66md0(_ListenerTrampoline_1 block) NS_RETURNS_RETAINED {
  return ^void(double arg0, NSEventPhase arg1, BOOL arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_1)(void * waiter, double arg0, NSEventPhase arg1, BOOL arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _1wf8t1k_wrapBlockingBlock_d66md0(
    _BlockingTrampoline_1 block, _BlockingTrampoline_1 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(double arg0, NSEventPhase arg1, BOOL arg2, BOOL * arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3);
  });
}

typedef void  (^_ListenerTrampoline_2)(double arg0, id arg1, BOOL arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _1wf8t1k_wrapListenerBlock_o4flre(_ListenerTrampoline_2 block) NS_RETURNS_RETAINED {
  return ^void(double arg0, id arg1, BOOL arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_2)(void * waiter, double arg0, id arg1, BOOL arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _1wf8t1k_wrapBlockingBlock_o4flre(
    _BlockingTrampoline_2 block, _BlockingTrampoline_2 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(double arg0, id arg1, BOOL arg2, BOOL * arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ListenerTrampoline_3)(id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _1wf8t1k_wrapListenerBlock_r8gdi7(_ListenerTrampoline_3 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_3)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _1wf8t1k_wrapBlockingBlock_r8gdi7(
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
_ListenerTrampoline_4 _1wf8t1k_wrapListenerBlock_xtuoz7(_ListenerTrampoline_4 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0));
  };
}

typedef void  (^_BlockingTrampoline_4)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _1wf8t1k_wrapBlockingBlock_xtuoz7(
    _BlockingTrampoline_4 block, _BlockingTrampoline_4 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0));
  });
}

typedef void  (^_ListenerTrampoline_5)(id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _1wf8t1k_wrapListenerBlock_pfv6jd(_ListenerTrampoline_5 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_5)(void * waiter, id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _1wf8t1k_wrapBlockingBlock_pfv6jd(
    _BlockingTrampoline_5 block, _BlockingTrampoline_5 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_6)(id arg0, struct CGPoint arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _1wf8t1k_wrapListenerBlock_14v8ia(_ListenerTrampoline_6 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct CGPoint arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_6)(void * waiter, id arg0, struct CGPoint arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _1wf8t1k_wrapBlockingBlock_14v8ia(
    _BlockingTrampoline_6 block, _BlockingTrampoline_6 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, struct CGPoint arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ListenerTrampoline_7)(id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _1wf8t1k_wrapListenerBlock_f167m6(_ListenerTrampoline_7 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block(objc_retainBlock(arg0));
  };
}

typedef void  (^_BlockingTrampoline_7)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _1wf8t1k_wrapBlockingBlock_f167m6(
    _BlockingTrampoline_7 block, _BlockingTrampoline_7 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0), {
    objc_retainBlock(block);
    block(nil, objc_retainBlock(arg0));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, objc_retainBlock(arg0));
  });
}

typedef void  (^_ListenerTrampoline_8)(NSBackgroundActivityResult arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _1wf8t1k_wrapListenerBlock_10ssdng(_ListenerTrampoline_8 block) NS_RETURNS_RETAINED {
  return ^void(NSBackgroundActivityResult arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_8)(void * waiter, NSBackgroundActivityResult arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _1wf8t1k_wrapBlockingBlock_10ssdng(
    _BlockingTrampoline_8 block, _BlockingTrampoline_8 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(NSBackgroundActivityResult arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_9)(id arg0, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _1wf8t1k_wrapListenerBlock_rnu2c5(_ListenerTrampoline_9 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_9)(void * waiter, id arg0, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _1wf8t1k_wrapBlockingBlock_rnu2c5(
    _BlockingTrampoline_9 block, _BlockingTrampoline_9 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ListenerTrampoline_10)(id arg0, BOOL arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _1wf8t1k_wrapListenerBlock_1uqbrux(_ListenerTrampoline_10 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_10)(void * waiter, id arg0, BOOL arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _1wf8t1k_wrapBlockingBlock_1uqbrux(
    _BlockingTrampoline_10 block, _BlockingTrampoline_10 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL arg1, BOOL * arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef void  (^_ListenerTrampoline_11)(id arg0, struct _NSRange arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _1wf8t1k_wrapListenerBlock_1a22wz(_ListenerTrampoline_11 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_11)(void * waiter, id arg0, struct _NSRange arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _1wf8t1k_wrapBlockingBlock_1a22wz(
    _BlockingTrampoline_11 block, _BlockingTrampoline_11 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, struct _NSRange arg1, BOOL * arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef void  (^_ListenerTrampoline_12)(id arg0, long arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _1wf8t1k_wrapListenerBlock_15kw6nv(_ListenerTrampoline_12 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, long arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_12)(void * waiter, id arg0, long arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _1wf8t1k_wrapBlockingBlock_15kw6nv(
    _BlockingTrampoline_12 block, _BlockingTrampoline_12 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, long arg1, BOOL * arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef void  (^_ListenerTrampoline_13)(id arg0, BOOL * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _1wf8t1k_wrapListenerBlock_t8l8el(_ListenerTrampoline_13 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL * arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1);
  };
}

typedef void  (^_BlockingTrampoline_13)(void * waiter, id arg0, BOOL * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _1wf8t1k_wrapBlockingBlock_t8l8el(
    _BlockingTrampoline_13 block, _BlockingTrampoline_13 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL * arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  });
}

typedef void  (^_ListenerTrampoline_14)(long arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _1wf8t1k_wrapListenerBlock_1kva9v1(_ListenerTrampoline_14 block) NS_RETURNS_RETAINED {
  return ^void(long arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_14)(void * waiter, long arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _1wf8t1k_wrapBlockingBlock_1kva9v1(
    _BlockingTrampoline_14 block, _BlockingTrampoline_14 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(long arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_15)(long arg0, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _1wf8t1k_wrapListenerBlock_1u5zzch(_ListenerTrampoline_15 block) NS_RETURNS_RETAINED {
  return ^void(long arg0, id arg1, id arg2, long arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_15)(void * waiter, long arg0, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _1wf8t1k_wrapBlockingBlock_1u5zzch(
    _BlockingTrampoline_15 block, _BlockingTrampoline_15 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(long arg0, id arg1, id arg2, long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ListenerTrampoline_16)(id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _1wf8t1k_wrapListenerBlock_1b3bb6a(_ListenerTrampoline_16 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(objc_retainBlock(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_16)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _1wf8t1k_wrapBlockingBlock_1b3bb6a(
    _BlockingTrampoline_16 block, _BlockingTrampoline_16 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, objc_retainBlock(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, objc_retainBlock(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ListenerTrampoline_17)(NSPageLayoutResult arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _1wf8t1k_wrapListenerBlock_g2d4k(_ListenerTrampoline_17 block) NS_RETURNS_RETAINED {
  return ^void(NSPageLayoutResult arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_17)(void * waiter, NSPageLayoutResult arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _1wf8t1k_wrapBlockingBlock_g2d4k(
    _BlockingTrampoline_17 block, _BlockingTrampoline_17 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(NSPageLayoutResult arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_18)(NSPrintPanelResult arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _1wf8t1k_wrapListenerBlock_11ginym(_ListenerTrampoline_18 block) NS_RETURNS_RETAINED {
  return ^void(NSPrintPanelResult arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_18)(void * waiter, NSPrintPanelResult arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _1wf8t1k_wrapBlockingBlock_11ginym(
    _BlockingTrampoline_18 block, _BlockingTrampoline_18 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(NSPrintPanelResult arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_19)(struct _NSRange arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_19 _1wf8t1k_wrapListenerBlock_1tv4uax(_ListenerTrampoline_19 block) NS_RETURNS_RETAINED {
  return ^void(struct _NSRange arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_19)(void * waiter, struct _NSRange arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_19 _1wf8t1k_wrapBlockingBlock_1tv4uax(
    _BlockingTrampoline_19 block, _BlockingTrampoline_19 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(struct _NSRange arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_20)(struct CGRect arg0, struct CGRect arg1, id arg2, struct _NSRange arg3, BOOL * arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_20 _1wf8t1k_wrapListenerBlock_1k4qrah(_ListenerTrampoline_20 block) NS_RETURNS_RETAINED {
  return ^void(struct CGRect arg0, struct CGRect arg1, id arg2, struct _NSRange arg3, BOOL * arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_20)(void * waiter, struct CGRect arg0, struct CGRect arg1, id arg2, struct _NSRange arg3, BOOL * arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_20 _1wf8t1k_wrapBlockingBlock_1k4qrah(
    _BlockingTrampoline_20 block, _BlockingTrampoline_20 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(struct CGRect arg0, struct CGRect arg1, id arg2, struct _NSRange arg3, BOOL * arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  });
}

typedef void  (^_ListenerTrampoline_21)(struct CGRect arg0, BOOL * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_21 _1wf8t1k_wrapListenerBlock_aoc6k0(_ListenerTrampoline_21 block) NS_RETURNS_RETAINED {
  return ^void(struct CGRect arg0, BOOL * arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_21)(void * waiter, struct CGRect arg0, BOOL * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_21 _1wf8t1k_wrapBlockingBlock_aoc6k0(
    _BlockingTrampoline_21 block, _BlockingTrampoline_21 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(struct CGRect arg0, BOOL * arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ListenerTrampoline_22)(struct CGRect arg0, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_22 _1wf8t1k_wrapListenerBlock_3juc99(_ListenerTrampoline_22 block) NS_RETURNS_RETAINED {
  return ^void(struct CGRect arg0, double arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_22)(void * waiter, struct CGRect arg0, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_22 _1wf8t1k_wrapBlockingBlock_3juc99(
    _BlockingTrampoline_22 block, _BlockingTrampoline_22 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(struct CGRect arg0, double arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ListenerTrampoline_23)(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_23 _1wf8t1k_wrapListenerBlock_lmc3p5(_ListenerTrampoline_23 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_23)(void * waiter, id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_23 _1wf8t1k_wrapBlockingBlock_lmc3p5(
    _BlockingTrampoline_23 block, _BlockingTrampoline_23 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  });
}

typedef void  (^_ListenerTrampoline_24)(id arg0, id arg1, id arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_24 _1wf8t1k_wrapListenerBlock_fo7rrt(_ListenerTrampoline_24 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_24)(void * waiter, id arg0, id arg1, id arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_24 _1wf8t1k_wrapBlockingBlock_fo7rrt(
    _BlockingTrampoline_24 block, _BlockingTrampoline_24 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, id arg2, BOOL * arg3), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ListenerTrampoline_25)(id arg0, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_25 _1wf8t1k_wrapListenerBlock_1nvl641(_ListenerTrampoline_25 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, long arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1);
  };
}

typedef void  (^_BlockingTrampoline_25)(void * waiter, id arg0, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_25 _1wf8t1k_wrapBlockingBlock_1nvl641(
    _BlockingTrampoline_25 block, _BlockingTrampoline_25 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, long arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  });
}

typedef void  (^_ListenerTrampoline_26)(id arg0, NSMatchingFlags arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_26 _1wf8t1k_wrapListenerBlock_6jvo9y(_ListenerTrampoline_26 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, NSMatchingFlags arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_26)(void * waiter, id arg0, NSMatchingFlags arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_26 _1wf8t1k_wrapBlockingBlock_6jvo9y(
    _BlockingTrampoline_26 block, _BlockingTrampoline_26 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, NSMatchingFlags arg1, BOOL * arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef void  (^_ListenerTrampoline_27)(NSURLSessionAuthChallengeDisposition arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_27 _1wf8t1k_wrapListenerBlock_n8yd09(_ListenerTrampoline_27 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionAuthChallengeDisposition arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_27)(void * waiter, NSURLSessionAuthChallengeDisposition arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_27 _1wf8t1k_wrapBlockingBlock_n8yd09(
    _BlockingTrampoline_27 block, _BlockingTrampoline_27 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(NSURLSessionAuthChallengeDisposition arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_28)(NSURLSessionDelayedRequestDisposition arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_28 _1wf8t1k_wrapListenerBlock_1otpo83(_ListenerTrampoline_28 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionDelayedRequestDisposition arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_28)(void * waiter, NSURLSessionDelayedRequestDisposition arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_28 _1wf8t1k_wrapBlockingBlock_1otpo83(
    _BlockingTrampoline_28 block, _BlockingTrampoline_28 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(NSURLSessionDelayedRequestDisposition arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_29)(NSURLSessionResponseDisposition arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_29 _1wf8t1k_wrapListenerBlock_16sve1d(_ListenerTrampoline_29 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionResponseDisposition arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_29)(void * waiter, NSURLSessionResponseDisposition arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_29 _1wf8t1k_wrapBlockingBlock_16sve1d(
    _BlockingTrampoline_29 block, _BlockingTrampoline_29 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(NSURLSessionResponseDisposition arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_30)(BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_30 _1wf8t1k_wrapListenerBlock_1s56lr9(_ListenerTrampoline_30 block) NS_RETURNS_RETAINED {
  return ^void(BOOL arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_30)(void * waiter, BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_30 _1wf8t1k_wrapBlockingBlock_1s56lr9(
    _BlockingTrampoline_30 block, _BlockingTrampoline_30 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(BOOL arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_31)(float arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_31 _1wf8t1k_wrapListenerBlock_v5hmet(_ListenerTrampoline_31 block) NS_RETURNS_RETAINED {
  return ^void(float arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_31)(void * waiter, float arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_31 _1wf8t1k_wrapBlockingBlock_v5hmet(
    _BlockingTrampoline_31 block, _BlockingTrampoline_31 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(float arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_32)(long arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_32 _1wf8t1k_wrapListenerBlock_4sp4xj(_ListenerTrampoline_32 block) NS_RETURNS_RETAINED {
  return ^void(long arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_32)(void * waiter, long arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_32 _1wf8t1k_wrapBlockingBlock_4sp4xj(
    _BlockingTrampoline_32 block, _BlockingTrampoline_32 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(long arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_33)(void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_33 _1wf8t1k_wrapListenerBlock_ovsamd(_ListenerTrampoline_33 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_33)(void * waiter, void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_33 _1wf8t1k_wrapBlockingBlock_ovsamd(
    _BlockingTrampoline_33 block, _BlockingTrampoline_33 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ProtocolTrampoline_181)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_ovsamd(id target, void * sel) {
  return ((_ProtocolTrampoline_181)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_34)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_34 _1wf8t1k_wrapListenerBlock_18v1jvf(_ListenerTrampoline_34 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_34)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_34 _1wf8t1k_wrapBlockingBlock_18v1jvf(
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

typedef void  (^_ProtocolTrampoline_182)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_18v1jvf(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_182)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_35)(void * arg0, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_35 _1wf8t1k_wrapListenerBlock_qvcerx(_ListenerTrampoline_35 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGContext * arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_35)(void * waiter, void * arg0, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_35 _1wf8t1k_wrapBlockingBlock_qvcerx(
    _BlockingTrampoline_35 block, _BlockingTrampoline_35 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGContext * arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_183)(void * sel, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_qvcerx(id target, void * sel, id arg1, struct CGContext * arg2) {
  return ((_ProtocolTrampoline_183)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_36)(void * arg0, NSAccessibilityOrientation arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_36 _1wf8t1k_wrapListenerBlock_6qimxm(_ListenerTrampoline_36 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSAccessibilityOrientation arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_36)(void * waiter, void * arg0, NSAccessibilityOrientation arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_36 _1wf8t1k_wrapBlockingBlock_6qimxm(
    _BlockingTrampoline_36 block, _BlockingTrampoline_36 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSAccessibilityOrientation arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_184)(void * sel, NSAccessibilityOrientation arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_6qimxm(id target, void * sel, NSAccessibilityOrientation arg1) {
  return ((_ProtocolTrampoline_184)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_37)(void * arg0, NSAccessibilityRulerMarkerType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_37 _1wf8t1k_wrapListenerBlock_w4u4pi(_ListenerTrampoline_37 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSAccessibilityRulerMarkerType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_37)(void * waiter, void * arg0, NSAccessibilityRulerMarkerType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_37 _1wf8t1k_wrapBlockingBlock_w4u4pi(
    _BlockingTrampoline_37 block, _BlockingTrampoline_37 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSAccessibilityRulerMarkerType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_185)(void * sel, NSAccessibilityRulerMarkerType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_w4u4pi(id target, void * sel, NSAccessibilityRulerMarkerType arg1) {
  return ((_ProtocolTrampoline_185)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_38)(void * arg0, NSAccessibilitySortDirection arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_38 _1wf8t1k_wrapListenerBlock_141m1k3(_ListenerTrampoline_38 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSAccessibilitySortDirection arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_38)(void * waiter, void * arg0, NSAccessibilitySortDirection arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_38 _1wf8t1k_wrapBlockingBlock_141m1k3(
    _BlockingTrampoline_38 block, _BlockingTrampoline_38 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSAccessibilitySortDirection arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_186)(void * sel, NSAccessibilitySortDirection arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_141m1k3(id target, void * sel, NSAccessibilitySortDirection arg1) {
  return ((_ProtocolTrampoline_186)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_39)(void * arg0, NSAccessibilityUnits arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_39 _1wf8t1k_wrapListenerBlock_12prxo1(_ListenerTrampoline_39 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSAccessibilityUnits arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_39)(void * waiter, void * arg0, NSAccessibilityUnits arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_39 _1wf8t1k_wrapBlockingBlock_12prxo1(
    _BlockingTrampoline_39 block, _BlockingTrampoline_39 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSAccessibilityUnits arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_187)(void * sel, NSAccessibilityUnits arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_12prxo1(id target, void * sel, NSAccessibilityUnits arg1) {
  return ((_ProtocolTrampoline_187)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_40)(void * arg0, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_40 _1wf8t1k_wrapListenerBlock_ayxzy9(_ListenerTrampoline_40 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct _NSRange arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_40)(void * waiter, void * arg0, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_40 _1wf8t1k_wrapBlockingBlock_ayxzy9(
    _BlockingTrampoline_40 block, _BlockingTrampoline_40 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct _NSRange arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_188)(void * sel, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_ayxzy9(id target, void * sel, id arg1, struct _NSRange arg2) {
  return ((_ProtocolTrampoline_188)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_41)(void * arg0, id arg1, float arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_41 _1wf8t1k_wrapListenerBlock_1lhuflb(_ListenerTrampoline_41 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, float arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_41)(void * waiter, void * arg0, id arg1, float arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_41 _1wf8t1k_wrapBlockingBlock_1lhuflb(
    _BlockingTrampoline_41 block, _BlockingTrampoline_41 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, float arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_189)(void * sel, id arg1, float arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1lhuflb(id target, void * sel, id arg1, float arg2) {
  return ((_ProtocolTrampoline_189)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_42)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_42 _1wf8t1k_wrapListenerBlock_fjrv01(_ListenerTrampoline_42 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_42)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_42 _1wf8t1k_wrapBlockingBlock_fjrv01(
    _BlockingTrampoline_42 block, _BlockingTrampoline_42 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_190)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_fjrv01(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_190)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_43)(void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_43 _1wf8t1k_wrapListenerBlock_1tz5yf(_ListenerTrampoline_43 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_43)(void * waiter, void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_43 _1wf8t1k_wrapBlockingBlock_1tz5yf(
    _BlockingTrampoline_43 block, _BlockingTrampoline_43 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_191)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1tz5yf(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_191)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_44)(void * arg0, id arg1, long arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_44 _1wf8t1k_wrapListenerBlock_98c27v(_ListenerTrampoline_44 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long arg2, long arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_44)(void * waiter, void * arg0, id arg1, long arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_44 _1wf8t1k_wrapBlockingBlock_98c27v(
    _BlockingTrampoline_44 block, _BlockingTrampoline_44 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long arg2, long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_192)(void * sel, id arg1, long arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_98c27v(id target, void * sel, id arg1, long arg2, long arg3) {
  return ((_ProtocolTrampoline_192)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_45)(void * arg0, id arg1, long arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_45 _1wf8t1k_wrapListenerBlock_1wo7l1b(_ListenerTrampoline_45 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_45)(void * waiter, void * arg0, id arg1, long arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_45 _1wf8t1k_wrapBlockingBlock_1wo7l1b(
    _BlockingTrampoline_45 block, _BlockingTrampoline_45 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_193)(void * sel, id arg1, long arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1wo7l1b(id target, void * sel, id arg1, long arg2, id arg3) {
  return ((_ProtocolTrampoline_193)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_46)(void * arg0, id arg1, id arg2, long arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_46 _1wf8t1k_wrapListenerBlock_1xqzua9(_ListenerTrampoline_46 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, long arg3, long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_46)(void * waiter, void * arg0, id arg1, id arg2, long arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_46 _1wf8t1k_wrapBlockingBlock_1xqzua9(
    _BlockingTrampoline_46 block, _BlockingTrampoline_46 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, long arg3, long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_194)(void * sel, id arg1, id arg2, long arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1xqzua9(id target, void * sel, id arg1, id arg2, long arg3, long arg4) {
  return ((_ProtocolTrampoline_194)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_47)(void * arg0, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_47 _1wf8t1k_wrapListenerBlock_1wp3it5(_ListenerTrampoline_47 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_47)(void * waiter, void * arg0, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_47 _1wf8t1k_wrapBlockingBlock_1wp3it5(
    _BlockingTrampoline_47 block, _BlockingTrampoline_47 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_195)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1wp3it5(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_195)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_48)(void * arg0, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_48 _1wf8t1k_wrapListenerBlock_zzthnb(_ListenerTrampoline_48 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, BOOL arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_48)(void * waiter, void * arg0, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_48 _1wf8t1k_wrapBlockingBlock_zzthnb(
    _BlockingTrampoline_48 block, _BlockingTrampoline_48 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, BOOL arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_196)(void * sel, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_zzthnb(id target, void * sel, id arg1, BOOL arg2) {
  return ((_ProtocolTrampoline_196)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_49)(void * arg0, id arg1, id arg2, struct CGPoint arg3, NSDragOperation arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_49 _1wf8t1k_wrapListenerBlock_terpf0(_ListenerTrampoline_49 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct CGPoint arg3, NSDragOperation arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_49)(void * waiter, void * arg0, id arg1, id arg2, struct CGPoint arg3, NSDragOperation arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_49 _1wf8t1k_wrapBlockingBlock_terpf0(
    _BlockingTrampoline_49 block, _BlockingTrampoline_49 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct CGPoint arg3, NSDragOperation arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_197)(void * sel, id arg1, id arg2, struct CGPoint arg3, NSDragOperation arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_terpf0(id target, void * sel, id arg1, id arg2, struct CGPoint arg3, NSDragOperation arg4) {
  return ((_ProtocolTrampoline_197)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_50)(void * arg0, id arg1, id arg2, struct CGPoint arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_50 _1wf8t1k_wrapListenerBlock_p8wmus(_ListenerTrampoline_50 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct CGPoint arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_50)(void * waiter, void * arg0, id arg1, id arg2, struct CGPoint arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_50 _1wf8t1k_wrapBlockingBlock_p8wmus(
    _BlockingTrampoline_50 block, _BlockingTrampoline_50 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct CGPoint arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_198)(void * sel, id arg1, id arg2, struct CGPoint arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_p8wmus(id target, void * sel, id arg1, id arg2, struct CGPoint arg3, id arg4) {
  return ((_ProtocolTrampoline_198)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_51)(void * arg0, id arg1, id arg2, NSCollectionViewItemHighlightState arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_51 _1wf8t1k_wrapListenerBlock_6n3nb9(_ListenerTrampoline_51 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, NSCollectionViewItemHighlightState arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_51)(void * waiter, void * arg0, id arg1, id arg2, NSCollectionViewItemHighlightState arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_51 _1wf8t1k_wrapBlockingBlock_6n3nb9(
    _BlockingTrampoline_51 block, _BlockingTrampoline_51 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, NSCollectionViewItemHighlightState arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_199)(void * sel, id arg1, id arg2, NSCollectionViewItemHighlightState arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_6n3nb9(id target, void * sel, id arg1, id arg2, NSCollectionViewItemHighlightState arg3) {
  return ((_ProtocolTrampoline_199)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_52)(void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_52 _1wf8t1k_wrapListenerBlock_8jfq1p(_ListenerTrampoline_52 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_52)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_52 _1wf8t1k_wrapBlockingBlock_8jfq1p(
    _BlockingTrampoline_52 block, _BlockingTrampoline_52 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_200)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_8jfq1p(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_200)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_53)(void * arg0, NSColorPanelMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_53 _1wf8t1k_wrapListenerBlock_jnbfgk(_ListenerTrampoline_53 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSColorPanelMode arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_53)(void * waiter, void * arg0, NSColorPanelMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_53 _1wf8t1k_wrapBlockingBlock_jnbfgk(
    _BlockingTrampoline_53 block, _BlockingTrampoline_53 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSColorPanelMode arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_201)(void * sel, NSColorPanelMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_jnbfgk(id target, void * sel, NSColorPanelMode arg1) {
  return ((_ProtocolTrampoline_201)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_54)(void * arg0, id arg1, id * arg2, double * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_54 _1wf8t1k_wrapListenerBlock_thq3a7(_ListenerTrampoline_54 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id * arg2, double * arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_54)(void * waiter, void * arg0, id arg1, id * arg2, double * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_54 _1wf8t1k_wrapBlockingBlock_thq3a7(
    _BlockingTrampoline_54 block, _BlockingTrampoline_54 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id * arg2, double * arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_202)(void * sel, id arg1, id * arg2, double * arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_thq3a7(id target, void * sel, id arg1, id * arg2, double * arg3) {
  return ((_ProtocolTrampoline_202)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_55)(void * arg0, NSDraggingFormation arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_55 _1wf8t1k_wrapListenerBlock_qh4ic4(_ListenerTrampoline_55 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSDraggingFormation arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_55)(void * waiter, void * arg0, NSDraggingFormation arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_55 _1wf8t1k_wrapBlockingBlock_qh4ic4(
    _BlockingTrampoline_55 block, _BlockingTrampoline_55 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSDraggingFormation arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_203)(void * sel, NSDraggingFormation arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_qh4ic4(id target, void * sel, NSDraggingFormation arg1) {
  return ((_ProtocolTrampoline_203)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_56)(void * arg0, NSDraggingItemEnumerationOptions arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_56 _1wf8t1k_wrapListenerBlock_133d9cm(_ListenerTrampoline_56 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSDraggingItemEnumerationOptions arg1, id arg2, id arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  };
}

typedef void  (^_BlockingTrampoline_56)(void * waiter, void * arg0, NSDraggingItemEnumerationOptions arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_56 _1wf8t1k_wrapBlockingBlock_133d9cm(
    _BlockingTrampoline_56 block, _BlockingTrampoline_56 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSDraggingItemEnumerationOptions arg1, id arg2, id arg3, id arg4, id arg5), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  });
}

typedef void  (^_ProtocolTrampoline_204)(void * sel, NSDraggingItemEnumerationOptions arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_133d9cm(id target, void * sel, NSDraggingItemEnumerationOptions arg1, id arg2, id arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_204)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_57)(void * arg0, id arg1, struct CGPoint arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_57 _1wf8t1k_wrapListenerBlock_1b63vg4(_ListenerTrampoline_57 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGPoint arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_57)(void * waiter, void * arg0, id arg1, struct CGPoint arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_57 _1wf8t1k_wrapBlockingBlock_1b63vg4(
    _BlockingTrampoline_57 block, _BlockingTrampoline_57 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGPoint arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_205)(void * sel, id arg1, struct CGPoint arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1b63vg4(id target, void * sel, id arg1, struct CGPoint arg2) {
  return ((_ProtocolTrampoline_205)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_58)(void * arg0, id arg1, struct CGPoint arg2, NSDragOperation arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_58 _1wf8t1k_wrapListenerBlock_mg31sm(_ListenerTrampoline_58 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGPoint arg2, NSDragOperation arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_58)(void * waiter, void * arg0, id arg1, struct CGPoint arg2, NSDragOperation arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_58 _1wf8t1k_wrapBlockingBlock_mg31sm(
    _BlockingTrampoline_58 block, _BlockingTrampoline_58 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGPoint arg2, NSDragOperation arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_206)(void * sel, id arg1, struct CGPoint arg2, NSDragOperation arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_mg31sm(id target, void * sel, id arg1, struct CGPoint arg2, NSDragOperation arg3) {
  return ((_ProtocolTrampoline_206)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_59)(void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_59 _1wf8t1k_wrapListenerBlock_bklti2(_ListenerTrampoline_59 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_59)(void * waiter, void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_59 _1wf8t1k_wrapBlockingBlock_bklti2(
    _BlockingTrampoline_59 block, _BlockingTrampoline_59 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_207)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_bklti2(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_207)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_60)(void * arg0, unsigned * arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_60 _1wf8t1k_wrapListenerBlock_6ifcc1(_ListenerTrampoline_60 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, unsigned * arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_60)(void * waiter, void * arg0, unsigned * arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_60 _1wf8t1k_wrapBlockingBlock_6ifcc1(
    _BlockingTrampoline_60 block, _BlockingTrampoline_60 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, unsigned * arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_208)(void * sel, unsigned * arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_6ifcc1(id target, void * sel, unsigned * arg1, unsigned long arg2, unsigned long arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_208)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_61)(void * arg0, NSHapticFeedbackPattern arg1, NSHapticFeedbackPerformanceTime arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_61 _1wf8t1k_wrapListenerBlock_gjex3c(_ListenerTrampoline_61 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSHapticFeedbackPattern arg1, NSHapticFeedbackPerformanceTime arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_61)(void * waiter, void * arg0, NSHapticFeedbackPattern arg1, NSHapticFeedbackPerformanceTime arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_61 _1wf8t1k_wrapBlockingBlock_gjex3c(
    _BlockingTrampoline_61 block, _BlockingTrampoline_61 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSHapticFeedbackPattern arg1, NSHapticFeedbackPerformanceTime arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2);
  });
}

typedef void  (^_ProtocolTrampoline_209)(void * sel, NSHapticFeedbackPattern arg1, NSHapticFeedbackPerformanceTime arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_gjex3c(id target, void * sel, NSHapticFeedbackPattern arg1, NSHapticFeedbackPerformanceTime arg2) {
  return ((_ProtocolTrampoline_209)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_62)(void * arg0, id arg1, id arg2, NSImageLoadStatus arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_62 _1wf8t1k_wrapListenerBlock_rwrcyp(_ListenerTrampoline_62 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, NSImageLoadStatus arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_62)(void * waiter, void * arg0, id arg1, id arg2, NSImageLoadStatus arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_62 _1wf8t1k_wrapBlockingBlock_rwrcyp(
    _BlockingTrampoline_62 block, _BlockingTrampoline_62 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, NSImageLoadStatus arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_210)(void * sel, id arg1, id arg2, NSImageLoadStatus arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_rwrcyp(id target, void * sel, id arg1, id arg2, NSImageLoadStatus arg3) {
  return ((_ProtocolTrampoline_210)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_63)(void * arg0, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_63 _1wf8t1k_wrapListenerBlock_e6jln7(_ListenerTrampoline_63 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, long arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_63)(void * waiter, void * arg0, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_63 _1wf8t1k_wrapBlockingBlock_e6jln7(
    _BlockingTrampoline_63 block, _BlockingTrampoline_63 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_211)(void * sel, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_e6jln7(id target, void * sel, id arg1, id arg2, long arg3) {
  return ((_ProtocolTrampoline_211)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_64)(void * arg0, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_64 _1wf8t1k_wrapListenerBlock_unr2j3(_ListenerTrampoline_64 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, long arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_64)(void * waiter, void * arg0, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_64 _1wf8t1k_wrapBlockingBlock_unr2j3(
    _BlockingTrampoline_64 block, _BlockingTrampoline_64 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, long arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_212)(void * sel, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_unr2j3(id target, void * sel, long arg1) {
  return ((_ProtocolTrampoline_212)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_65)(void * arg0, long arg1, long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_65 _1wf8t1k_wrapListenerBlock_ibwj1q(_ListenerTrampoline_65 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, long arg1, long arg2, unsigned long arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_65)(void * waiter, void * arg0, long arg1, long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_65 _1wf8t1k_wrapBlockingBlock_ibwj1q(
    _BlockingTrampoline_65 block, _BlockingTrampoline_65 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, long arg1, long arg2, unsigned long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_213)(void * sel, long arg1, long arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_ibwj1q(id target, void * sel, long arg1, long arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_213)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_66)(void * arg0, id arg1, id arg2, struct CGSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_66 _1wf8t1k_wrapListenerBlock_13mvetb(_ListenerTrampoline_66 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct CGSize arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_66)(void * waiter, void * arg0, id arg1, id arg2, struct CGSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_66 _1wf8t1k_wrapBlockingBlock_13mvetb(
    _BlockingTrampoline_66 block, _BlockingTrampoline_66 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct CGSize arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_214)(void * sel, id arg1, id arg2, struct CGSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_13mvetb(id target, void * sel, id arg1, id arg2, struct CGSize arg3) {
  return ((_ProtocolTrampoline_214)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_67)(void * arg0, id arg1, id arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_67 _1wf8t1k_wrapListenerBlock_8acz2h(_ListenerTrampoline_67 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, BOOL arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_67)(void * waiter, void * arg0, id arg1, id arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_67 _1wf8t1k_wrapBlockingBlock_8acz2h(
    _BlockingTrampoline_67 block, _BlockingTrampoline_67 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, BOOL arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_215)(void * sel, id arg1, id arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_8acz2h(id target, void * sel, id arg1, id arg2, BOOL arg3) {
  return ((_ProtocolTrampoline_215)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_68)(void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_68 _1wf8t1k_wrapListenerBlock_1bktu2(_ListenerTrampoline_68 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGPoint arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_68)(void * waiter, void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_68 _1wf8t1k_wrapBlockingBlock_1bktu2(
    _BlockingTrampoline_68 block, _BlockingTrampoline_68 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGPoint arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_216)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1bktu2(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_216)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_69)(void * arg0, struct _NSRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_69 _1wf8t1k_wrapListenerBlock_xpqfd7(_ListenerTrampoline_69 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct _NSRange arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_69)(void * waiter, void * arg0, struct _NSRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_69 _1wf8t1k_wrapBlockingBlock_xpqfd7(
    _BlockingTrampoline_69 block, _BlockingTrampoline_69 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct _NSRange arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_217)(void * sel, struct _NSRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_xpqfd7(id target, void * sel, struct _NSRange arg1) {
  return ((_ProtocolTrampoline_217)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_70)(void * arg0, struct _NSRange arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_70 _1wf8t1k_wrapListenerBlock_1f6txb5(_ListenerTrampoline_70 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct _NSRange arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_70)(void * waiter, void * arg0, struct _NSRange arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_70 _1wf8t1k_wrapBlockingBlock_1f6txb5(
    _BlockingTrampoline_70 block, _BlockingTrampoline_70 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct _NSRange arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_218)(void * sel, struct _NSRange arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1f6txb5(id target, void * sel, struct _NSRange arg1, id arg2) {
  return ((_ProtocolTrampoline_218)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_71)(void * arg0, struct CGRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_71 _1wf8t1k_wrapListenerBlock_1e49sma(_ListenerTrampoline_71 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGRect arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_71)(void * waiter, void * arg0, struct CGRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_71 _1wf8t1k_wrapBlockingBlock_1e49sma(
    _BlockingTrampoline_71 block, _BlockingTrampoline_71 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGRect arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_219)(void * sel, struct CGRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1e49sma(id target, void * sel, struct CGRect arg1) {
  return ((_ProtocolTrampoline_219)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_72)(void * arg0, struct CGRect arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_72 _1wf8t1k_wrapListenerBlock_5r0qjk(_ListenerTrampoline_72 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGRect arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_72)(void * waiter, void * arg0, struct CGRect arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_72 _1wf8t1k_wrapBlockingBlock_5r0qjk(
    _BlockingTrampoline_72 block, _BlockingTrampoline_72 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGRect arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_220)(void * sel, struct CGRect arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_5r0qjk(id target, void * sel, struct CGRect arg1, id arg2) {
  return ((_ProtocolTrampoline_220)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_73)(void * arg0, struct CGRect arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_73 _1wf8t1k_wrapListenerBlock_772a45(_ListenerTrampoline_73 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGRect arg1, id arg2, unsigned long arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_73)(void * waiter, void * arg0, struct CGRect arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_73 _1wf8t1k_wrapBlockingBlock_772a45(
    _BlockingTrampoline_73 block, _BlockingTrampoline_73 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGRect arg1, id arg2, unsigned long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_221)(void * sel, struct CGRect arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_772a45(id target, void * sel, struct CGRect arg1, id arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_221)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_74)(void * arg0, struct CGRect arg1, id arg2, unsigned long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_74 _1wf8t1k_wrapListenerBlock_1gzvlvv(_ListenerTrampoline_74 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGRect arg1, id arg2, unsigned long arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_74)(void * waiter, void * arg0, struct CGRect arg1, id arg2, unsigned long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_74 _1wf8t1k_wrapBlockingBlock_1gzvlvv(
    _BlockingTrampoline_74 block, _BlockingTrampoline_74 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGRect arg1, id arg2, unsigned long arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_222)(void * sel, struct CGRect arg1, id arg2, unsigned long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1gzvlvv(id target, void * sel, struct CGRect arg1, id arg2, unsigned long arg3, id arg4) {
  return ((_ProtocolTrampoline_222)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_75)(void * arg0, struct CGSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_75 _1wf8t1k_wrapListenerBlock_leirm3(_ListenerTrampoline_75 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGSize arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_75)(void * waiter, void * arg0, struct CGSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_75 _1wf8t1k_wrapBlockingBlock_leirm3(
    _BlockingTrampoline_75 block, _BlockingTrampoline_75 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGSize arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_223)(void * sel, struct CGSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_leirm3(id target, void * sel, struct CGSize arg1) {
  return ((_ProtocolTrampoline_223)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_76)(void * arg0, id arg1, struct _NSRange arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_76 _1wf8t1k_wrapListenerBlock_laniev(_ListenerTrampoline_76 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct _NSRange arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_76)(void * waiter, void * arg0, id arg1, struct _NSRange arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_76 _1wf8t1k_wrapBlockingBlock_laniev(
    _BlockingTrampoline_76 block, _BlockingTrampoline_76 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct _NSRange arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_224)(void * sel, id arg1, struct _NSRange arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_laniev(id target, void * sel, id arg1, struct _NSRange arg2, id arg3) {
  return ((_ProtocolTrampoline_224)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_77)(void * arg0, id arg1, unsigned long arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_77 _1wf8t1k_wrapListenerBlock_dgt0w8(_ListenerTrampoline_77 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_77)(void * waiter, void * arg0, id arg1, unsigned long arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_77 _1wf8t1k_wrapBlockingBlock_dgt0w8(
    _BlockingTrampoline_77 block, _BlockingTrampoline_77 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_225)(void * sel, id arg1, unsigned long arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_dgt0w8(id target, void * sel, id arg1, unsigned long arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_225)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_78)(void * arg0, id arg1, short arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_78 _1wf8t1k_wrapListenerBlock_g16len(_ListenerTrampoline_78 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, short arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_78)(void * waiter, void * arg0, id arg1, short arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_78 _1wf8t1k_wrapBlockingBlock_g16len(
    _BlockingTrampoline_78 block, _BlockingTrampoline_78 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, short arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_226)(void * sel, id arg1, short arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_g16len(id target, void * sel, id arg1, short arg2) {
  return ((_ProtocolTrampoline_226)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_79)(void * arg0, id arg1, unsigned long arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_79 _1wf8t1k_wrapListenerBlock_1cn988u(_ListenerTrampoline_79 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2, id arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  };
}

typedef void  (^_BlockingTrampoline_79)(void * waiter, void * arg0, id arg1, unsigned long arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_79 _1wf8t1k_wrapBlockingBlock_1cn988u(
    _BlockingTrampoline_79 block, _BlockingTrampoline_79 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2, id arg3, id arg4, id arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  });
}

typedef void  (^_ProtocolTrampoline_227)(void * sel, id arg1, unsigned long arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1cn988u(id target, void * sel, id arg1, unsigned long arg2, id arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_227)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_80)(void * arg0, id arg1, struct CGSize arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_80 _1wf8t1k_wrapListenerBlock_7llvxl(_ListenerTrampoline_80 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGSize arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_80)(void * waiter, void * arg0, id arg1, struct CGSize arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_80 _1wf8t1k_wrapBlockingBlock_7llvxl(
    _BlockingTrampoline_80 block, _BlockingTrampoline_80 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGSize arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_228)(void * sel, id arg1, struct CGSize arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_7llvxl(id target, void * sel, id arg1, struct CGSize arg2) {
  return ((_ProtocolTrampoline_228)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_81)(void * arg0, id arg1, long arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_81 _1wf8t1k_wrapListenerBlock_5gixqa(_ListenerTrampoline_81 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_81)(void * waiter, void * arg0, id arg1, long arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_81 _1wf8t1k_wrapBlockingBlock_5gixqa(
    _BlockingTrampoline_81 block, _BlockingTrampoline_81 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_229)(void * sel, id arg1, long arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_5gixqa(id target, void * sel, id arg1, long arg2, id arg3) {
  return ((_ProtocolTrampoline_229)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_82)(void * arg0, id arg1, id arg2, id arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_82 _1wf8t1k_wrapListenerBlock_1csxhgt(_ListenerTrampoline_82 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4);
  };
}

typedef void  (^_BlockingTrampoline_82)(void * waiter, void * arg0, id arg1, id arg2, id arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_82 _1wf8t1k_wrapBlockingBlock_1csxhgt(
    _BlockingTrampoline_82 block, _BlockingTrampoline_82 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4);
  });
}

typedef void  (^_ProtocolTrampoline_230)(void * sel, id arg1, id arg2, id arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1csxhgt(id target, void * sel, id arg1, id arg2, id arg3, long arg4) {
  return ((_ProtocolTrampoline_230)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_83)(void * arg0, NSTextInputTraitType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_83 _1wf8t1k_wrapListenerBlock_pu9nad(_ListenerTrampoline_83 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSTextInputTraitType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_83)(void * waiter, void * arg0, NSTextInputTraitType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_83 _1wf8t1k_wrapBlockingBlock_pu9nad(
    _BlockingTrampoline_83 block, _BlockingTrampoline_83 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSTextInputTraitType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_231)(void * sel, NSTextInputTraitType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_pu9nad(id target, void * sel, NSTextInputTraitType arg1) {
  return ((_ProtocolTrampoline_231)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_84)(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_84 _1wf8t1k_wrapListenerBlock_19w094r(_ListenerTrampoline_84 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_84)(void * waiter, void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_84 _1wf8t1k_wrapBlockingBlock_19w094r(
    _BlockingTrampoline_84 block, _BlockingTrampoline_84 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_232)(void * sel, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_19w094r(id target, void * sel, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4) {
  return ((_ProtocolTrampoline_232)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_85)(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_85 _1wf8t1k_wrapListenerBlock_1ucjyxt(_ListenerTrampoline_85 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5);
  };
}

typedef void  (^_BlockingTrampoline_85)(void * waiter, void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_85 _1wf8t1k_wrapBlockingBlock_1ucjyxt(
    _BlockingTrampoline_85 block, _BlockingTrampoline_85 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5);
  });
}

typedef void  (^_ProtocolTrampoline_233)(void * sel, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1ucjyxt(id target, void * sel, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5) {
  return ((_ProtocolTrampoline_233)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_86)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_86 _1wf8t1k_wrapListenerBlock_jk1ljc(_ListenerTrampoline_86 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  };
}

typedef void  (^_BlockingTrampoline_86)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_86 _1wf8t1k_wrapBlockingBlock_jk1ljc(
    _BlockingTrampoline_86 block, _BlockingTrampoline_86 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_234)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_jk1ljc(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_234)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_87)(void * arg0, id arg1, id arg2, struct CGRect arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_87 _1wf8t1k_wrapListenerBlock_eln3n2(_ListenerTrampoline_87 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct CGRect arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_87)(void * waiter, void * arg0, id arg1, id arg2, struct CGRect arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_87 _1wf8t1k_wrapBlockingBlock_eln3n2(
    _BlockingTrampoline_87 block, _BlockingTrampoline_87 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct CGRect arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_235)(void * sel, id arg1, id arg2, struct CGRect arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_eln3n2(id target, void * sel, id arg1, id arg2, struct CGRect arg3) {
  return ((_ProtocolTrampoline_235)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_88)(void * arg0, id arg1, id arg2, struct CGRect arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_88 _1wf8t1k_wrapListenerBlock_36y93g(_ListenerTrampoline_88 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct CGRect arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_88)(void * waiter, void * arg0, id arg1, id arg2, struct CGRect arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_88 _1wf8t1k_wrapBlockingBlock_36y93g(
    _BlockingTrampoline_88 block, _BlockingTrampoline_88 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct CGRect arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_236)(void * sel, id arg1, id arg2, struct CGRect arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_36y93g(id target, void * sel, id arg1, id arg2, struct CGRect arg3, id arg4) {
  return ((_ProtocolTrampoline_236)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_89)(void * arg0, id arg1, id arg2, struct CGRect arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_89 _1wf8t1k_wrapListenerBlock_14vjvrl(_ListenerTrampoline_89 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct CGRect arg3, id arg4, unsigned long arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5);
  };
}

typedef void  (^_BlockingTrampoline_89)(void * waiter, void * arg0, id arg1, id arg2, struct CGRect arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_89 _1wf8t1k_wrapBlockingBlock_14vjvrl(
    _BlockingTrampoline_89 block, _BlockingTrampoline_89 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct CGRect arg3, id arg4, unsigned long arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5);
  });
}

typedef void  (^_ProtocolTrampoline_237)(void * sel, id arg1, id arg2, struct CGRect arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_14vjvrl(id target, void * sel, id arg1, id arg2, struct CGRect arg3, id arg4, unsigned long arg5) {
  return ((_ProtocolTrampoline_237)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_90)(void * arg0, id arg1, id arg2, struct CGRect arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_90 _1wf8t1k_wrapListenerBlock_ebp9i3(_ListenerTrampoline_90 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct CGRect arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_90)(void * waiter, void * arg0, id arg1, id arg2, struct CGRect arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_90 _1wf8t1k_wrapBlockingBlock_ebp9i3(
    _BlockingTrampoline_90 block, _BlockingTrampoline_90 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct CGRect arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_238)(void * sel, id arg1, id arg2, struct CGRect arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_ebp9i3(id target, void * sel, id arg1, id arg2, struct CGRect arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_238)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_91)(void * arg0, unsigned long arg1, struct CGPoint arg2, unsigned long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_91 _1wf8t1k_wrapListenerBlock_1l9x3wg(_ListenerTrampoline_91 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, unsigned long arg1, struct CGPoint arg2, unsigned long arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_91)(void * waiter, void * arg0, unsigned long arg1, struct CGPoint arg2, unsigned long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_91 _1wf8t1k_wrapBlockingBlock_1l9x3wg(
    _BlockingTrampoline_91 block, _BlockingTrampoline_91 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, unsigned long arg1, struct CGPoint arg2, unsigned long arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_239)(void * sel, unsigned long arg1, struct CGPoint arg2, unsigned long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1l9x3wg(id target, void * sel, unsigned long arg1, struct CGPoint arg2, unsigned long arg3, id arg4) {
  return ((_ProtocolTrampoline_239)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_92)(void * arg0, id arg1, long arg2, long arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_92 _1wf8t1k_wrapListenerBlock_15e9dqx(_ListenerTrampoline_92 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long arg2, long arg3, long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_92)(void * waiter, void * arg0, id arg1, long arg2, long arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_92 _1wf8t1k_wrapBlockingBlock_15e9dqx(
    _BlockingTrampoline_92 block, _BlockingTrampoline_92 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long arg2, long arg3, long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_240)(void * sel, id arg1, long arg2, long arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_15e9dqx(id target, void * sel, id arg1, long arg2, long arg3, long arg4) {
  return ((_ProtocolTrampoline_240)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_93)(void * arg0, id arg1, long long arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_93 _1wf8t1k_wrapListenerBlock_9crvvv(_ListenerTrampoline_93 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long long arg2, long long arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_93)(void * waiter, void * arg0, id arg1, long long arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_93 _1wf8t1k_wrapBlockingBlock_9crvvv(
    _BlockingTrampoline_93 block, _BlockingTrampoline_93 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long long arg2, long long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_241)(void * sel, id arg1, long long arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_9crvvv(id target, void * sel, id arg1, long long arg2, long long arg3) {
  return ((_ProtocolTrampoline_241)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_94)(void * arg0, id arg1, long long arg2, long long arg3, long long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_94 _1wf8t1k_wrapListenerBlock_1qf1qkl(_ListenerTrampoline_94 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long long arg2, long long arg3, long long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_94)(void * waiter, void * arg0, id arg1, long long arg2, long long arg3, long long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_94 _1wf8t1k_wrapBlockingBlock_1qf1qkl(
    _BlockingTrampoline_94 block, _BlockingTrampoline_94 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long long arg2, long long arg3, long long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_242)(void * sel, id arg1, long long arg2, long long arg3, long long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1qf1qkl(id target, void * sel, id arg1, long long arg2, long long arg3, long long arg4) {
  return ((_ProtocolTrampoline_242)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_95)(void * arg0, id arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_95 _1wf8t1k_wrapListenerBlock_wy9lus(_ListenerTrampoline_95 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, unsigned long arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_95)(void * waiter, void * arg0, id arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_95 _1wf8t1k_wrapBlockingBlock_wy9lus(
    _BlockingTrampoline_95 block, _BlockingTrampoline_95 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, unsigned long arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_243)(void * sel, id arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_wy9lus(id target, void * sel, id arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_243)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_96)(void * arg0, id arg1, id arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_96 _1wf8t1k_wrapListenerBlock_34xzuf(_ListenerTrampoline_96 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, long long arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_96)(void * waiter, void * arg0, id arg1, id arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_96 _1wf8t1k_wrapBlockingBlock_34xzuf(
    _BlockingTrampoline_96 block, _BlockingTrampoline_96 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, long long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_244)(void * sel, id arg1, id arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_34xzuf(id target, void * sel, id arg1, id arg2, long long arg3) {
  return ((_ProtocolTrampoline_244)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_97)(void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_97 _1wf8t1k_wrapListenerBlock_1j7coyk(_ListenerTrampoline_97 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_97)(void * waiter, void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_97 _1wf8t1k_wrapBlockingBlock_1j7coyk(
    _BlockingTrampoline_97 block, _BlockingTrampoline_97 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_245)(void * sel, id arg1, id arg2, NSURLCacheStoragePolicy arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1j7coyk(id target, void * sel, id arg1, id arg2, NSURLCacheStoragePolicy arg3) {
  return ((_ProtocolTrampoline_245)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_98)(void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_98 _1wf8t1k_wrapListenerBlock_xx612k(_ListenerTrampoline_98 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  };
}

typedef void  (^_BlockingTrampoline_98)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_98 _1wf8t1k_wrapBlockingBlock_xx612k(
    _BlockingTrampoline_98 block, _BlockingTrampoline_98 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_246)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_xx612k(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_246)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_99)(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_99 _1wf8t1k_wrapListenerBlock_ly2579(_ListenerTrampoline_99 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_99)(void * waiter, void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_99 _1wf8t1k_wrapBlockingBlock_ly2579(
    _BlockingTrampoline_99 block, _BlockingTrampoline_99 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_247)(void * sel, id arg1, id arg2, int64_t arg3, int64_t arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_ly2579(id target, void * sel, id arg1, id arg2, int64_t arg3, int64_t arg4) {
  return ((_ProtocolTrampoline_247)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_100)(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_100 _1wf8t1k_wrapListenerBlock_h68abb(_ListenerTrampoline_100 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4, arg5);
  };
}

typedef void  (^_BlockingTrampoline_100)(void * waiter, void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_100 _1wf8t1k_wrapBlockingBlock_h68abb(
    _BlockingTrampoline_100 block, _BlockingTrampoline_100 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4, arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4, arg5);
  });
}

typedef void  (^_ProtocolTrampoline_248)(void * sel, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_h68abb(id target, void * sel, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5) {
  return ((_ProtocolTrampoline_248)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_101)(void * arg0, id arg1, id arg2, int64_t arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_101 _1wf8t1k_wrapListenerBlock_jyim80(_ListenerTrampoline_101 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, int64_t arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, objc_retainBlock(arg4));
  };
}

typedef void  (^_BlockingTrampoline_101)(void * waiter, void * arg0, id arg1, id arg2, int64_t arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_101 _1wf8t1k_wrapBlockingBlock_jyim80(
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

typedef void  (^_ProtocolTrampoline_249)(void * sel, id arg1, id arg2, int64_t arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_jyim80(id target, void * sel, id arg1, id arg2, int64_t arg3, id arg4) {
  return ((_ProtocolTrampoline_249)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_102)(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_102 _1wf8t1k_wrapListenerBlock_l2g8ke(_ListenerTrampoline_102 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  };
}

typedef void  (^_BlockingTrampoline_102)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_102 _1wf8t1k_wrapBlockingBlock_l2g8ke(
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

typedef void  (^_ProtocolTrampoline_250)(void * sel, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_l2g8ke(id target, void * sel, id arg1, id arg2, id arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_250)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_103)(void * arg0, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_103 _1wf8t1k_wrapListenerBlock_1lx650f(_ListenerTrampoline_103 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_103)(void * waiter, void * arg0, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_103 _1wf8t1k_wrapBlockingBlock_1lx650f(
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

typedef void  (^_ProtocolTrampoline_251)(void * sel, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1lx650f(id target, void * sel, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4) {
  return ((_ProtocolTrampoline_251)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_104)(void * arg0, id arg1, id arg2, double arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_104 _1wf8t1k_wrapListenerBlock_gxqm8e(_ListenerTrampoline_104 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, double arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_104)(void * waiter, void * arg0, id arg1, id arg2, double arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_104 _1wf8t1k_wrapBlockingBlock_gxqm8e(
    _BlockingTrampoline_104 block, _BlockingTrampoline_104 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, double arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_252)(void * sel, id arg1, id arg2, double arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_gxqm8e(id target, void * sel, id arg1, id arg2, double arg3) {
  return ((_ProtocolTrampoline_252)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_105)(void * arg0, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_105 _1wf8t1k_wrapListenerBlock_ve6f9k(_ListenerTrampoline_105 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, double arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_105)(void * waiter, void * arg0, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_105 _1wf8t1k_wrapBlockingBlock_ve6f9k(
    _BlockingTrampoline_105 block, _BlockingTrampoline_105 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, double arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_253)(void * sel, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_ve6f9k(id target, void * sel, id arg1, double arg2) {
  return ((_ProtocolTrampoline_253)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_106)(void * arg0, NSWritingToolsBehavior arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_106 _1wf8t1k_wrapListenerBlock_lm7h8j(_ListenerTrampoline_106 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSWritingToolsBehavior arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_106)(void * waiter, void * arg0, NSWritingToolsBehavior arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_106 _1wf8t1k_wrapBlockingBlock_lm7h8j(
    _BlockingTrampoline_106 block, _BlockingTrampoline_106 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSWritingToolsBehavior arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_254)(void * sel, NSWritingToolsBehavior arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_lm7h8j(id target, void * sel, NSWritingToolsBehavior arg1) {
  return ((_ProtocolTrampoline_254)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_107)(void * arg0, id arg1, struct CGPoint arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_107 _1wf8t1k_wrapListenerBlock_1jo11bz(_ListenerTrampoline_107 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGPoint arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_107)(void * waiter, void * arg0, id arg1, struct CGPoint arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_107 _1wf8t1k_wrapBlockingBlock_1jo11bz(
    _BlockingTrampoline_107 block, _BlockingTrampoline_107 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGPoint arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_255)(void * sel, id arg1, struct CGPoint arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1jo11bz(id target, void * sel, id arg1, struct CGPoint arg2, id arg3) {
  return ((_ProtocolTrampoline_255)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_108)(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4, NSWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_108 _1wf8t1k_wrapListenerBlock_1n5mqz5(_ListenerTrampoline_108 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4, NSWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), objc_retainBlock(arg7));
  };
}

typedef void  (^_BlockingTrampoline_108)(void * waiter, void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4, NSWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_108 _1wf8t1k_wrapBlockingBlock_1n5mqz5(
    _BlockingTrampoline_108 block, _BlockingTrampoline_108 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4, NSWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), objc_retainBlock(arg7));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), objc_retainBlock(arg7));
  });
}

typedef void  (^_ProtocolTrampoline_256)(void * sel, id arg1, struct _NSRange arg2, id arg3, id arg4, NSWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1n5mqz5(id target, void * sel, id arg1, struct _NSRange arg2, id arg3, id arg4, NSWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7) {
  return ((_ProtocolTrampoline_256)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
}

typedef void  (^_ListenerTrampoline_109)(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_109 _1wf8t1k_wrapListenerBlock_1oetkgs(_ListenerTrampoline_109 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  };
}

typedef void  (^_BlockingTrampoline_109)(void * waiter, void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_109 _1wf8t1k_wrapBlockingBlock_1oetkgs(
    _BlockingTrampoline_109 block, _BlockingTrampoline_109 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_257)(void * sel, id arg1, struct _NSRange arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1oetkgs(id target, void * sel, id arg1, struct _NSRange arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_257)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_110)(void * arg0, id arg1, struct CGRect arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_110 _1wf8t1k_wrapListenerBlock_1q5vgwd(_ListenerTrampoline_110 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGRect arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  };
}

typedef void  (^_BlockingTrampoline_110)(void * waiter, void * arg0, id arg1, struct CGRect arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_110 _1wf8t1k_wrapBlockingBlock_1q5vgwd(
    _BlockingTrampoline_110 block, _BlockingTrampoline_110 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGRect arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_258)(void * sel, id arg1, struct CGRect arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1q5vgwd(id target, void * sel, id arg1, struct CGRect arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_258)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_111)(void * arg0, id arg1, NSWritingToolsCoordinatorContextScope arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_111 _1wf8t1k_wrapListenerBlock_kqrjsn(_ListenerTrampoline_111 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, NSWritingToolsCoordinatorContextScope arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_111)(void * waiter, void * arg0, id arg1, NSWritingToolsCoordinatorContextScope arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_111 _1wf8t1k_wrapBlockingBlock_kqrjsn(
    _BlockingTrampoline_111 block, _BlockingTrampoline_111 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, NSWritingToolsCoordinatorContextScope arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_259)(void * sel, id arg1, NSWritingToolsCoordinatorContextScope arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_kqrjsn(id target, void * sel, id arg1, NSWritingToolsCoordinatorContextScope arg2, id arg3) {
  return ((_ProtocolTrampoline_259)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_112)(void * arg0, id arg1, NSWritingToolsCoordinatorState arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_112 _1wf8t1k_wrapListenerBlock_15rjqcd(_ListenerTrampoline_112 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, NSWritingToolsCoordinatorState arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_112)(void * waiter, void * arg0, id arg1, NSWritingToolsCoordinatorState arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_112 _1wf8t1k_wrapBlockingBlock_15rjqcd(
    _BlockingTrampoline_112 block, _BlockingTrampoline_112 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, NSWritingToolsCoordinatorState arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_260)(void * sel, id arg1, NSWritingToolsCoordinatorState arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_15rjqcd(id target, void * sel, id arg1, NSWritingToolsCoordinatorState arg2, id arg3) {
  return ((_ProtocolTrampoline_260)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_113)(void * arg0, id arg1, NSWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_113 _1wf8t1k_wrapListenerBlock_iclubh(_ListenerTrampoline_113 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, NSWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  };
}

typedef void  (^_BlockingTrampoline_113)(void * waiter, void * arg0, id arg1, NSWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_113 _1wf8t1k_wrapBlockingBlock_iclubh(
    _BlockingTrampoline_113 block, _BlockingTrampoline_113 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, NSWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  });
}

typedef void  (^_ProtocolTrampoline_261)(void * sel, id arg1, NSWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_iclubh(id target, void * sel, id arg1, NSWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_261)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_114)(void * arg0, NSWritingToolsResultOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_114 _1wf8t1k_wrapListenerBlock_8seuo(_ListenerTrampoline_114 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSWritingToolsResultOptions arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_114)(void * waiter, void * arg0, NSWritingToolsResultOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_114 _1wf8t1k_wrapBlockingBlock_8seuo(
    _BlockingTrampoline_114 block, _BlockingTrampoline_114 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSWritingToolsResultOptions arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_262)(void * sel, NSWritingToolsResultOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_8seuo(id target, void * sel, NSWritingToolsResultOptions arg1) {
  return ((_ProtocolTrampoline_262)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_115)(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_115 _1wf8t1k_wrapListenerBlock_m09tr7(_ListenerTrampoline_115 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  };
}

typedef void  (^_BlockingTrampoline_115)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_115 _1wf8t1k_wrapBlockingBlock_m09tr7(
    _BlockingTrampoline_115 block, _BlockingTrampoline_115 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  });
}

typedef void  (^_ProtocolTrampoline_263)(void * sel, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_m09tr7(id target, void * sel, id arg1, id arg2, id arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_263)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_116)(void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_116 _1wf8t1k_wrapListenerBlock_10lndml(_ListenerTrampoline_116 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_116)(void * waiter, void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_116 _1wf8t1k_wrapBlockingBlock_10lndml(
    _BlockingTrampoline_116 block, _BlockingTrampoline_116 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, BOOL arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_264)(void * sel, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_10lndml(id target, void * sel, BOOL arg1) {
  return ((_ProtocolTrampoline_264)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_117)(void * arg0, BOOL arg1, struct CGRect arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_117 _1wf8t1k_wrapListenerBlock_1lgh494(_ListenerTrampoline_117 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1, struct CGRect arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_117)(void * waiter, void * arg0, BOOL arg1, struct CGRect arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_117 _1wf8t1k_wrapBlockingBlock_1lgh494(
    _BlockingTrampoline_117 block, _BlockingTrampoline_117 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, BOOL arg1, struct CGRect arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_265)(void * sel, BOOL arg1, struct CGRect arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1lgh494(id target, void * sel, BOOL arg1, struct CGRect arg2, id arg3) {
  return ((_ProtocolTrampoline_265)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_118)(void * arg0, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_118 _1wf8t1k_wrapListenerBlock_j7ve0z(_ListenerTrampoline_118 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_118)(void * waiter, void * arg0, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_118 _1wf8t1k_wrapBlockingBlock_j7ve0z(
    _BlockingTrampoline_118 block, _BlockingTrampoline_118 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, BOOL arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_266)(void * sel, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_j7ve0z(id target, void * sel, BOOL arg1, id arg2) {
  return ((_ProtocolTrampoline_266)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_119)(void * arg0, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_119 _1wf8t1k_wrapListenerBlock_18sfmo2(_ListenerTrampoline_119 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, double arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_119)(void * waiter, void * arg0, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_119 _1wf8t1k_wrapBlockingBlock_18sfmo2(
    _BlockingTrampoline_119 block, _BlockingTrampoline_119 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, double arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_267)(void * sel, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_18sfmo2(id target, void * sel, double arg1) {
  return ((_ProtocolTrampoline_267)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_120)(void * arg0, float arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_120 _1wf8t1k_wrapListenerBlock_1fcaigd(_ListenerTrampoline_120 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, float arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_120)(void * waiter, void * arg0, float arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_120 _1wf8t1k_wrapBlockingBlock_1fcaigd(
    _BlockingTrampoline_120 block, _BlockingTrampoline_120 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, float arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_268)(void * sel, float arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1fcaigd(id target, void * sel, float arg1) {
  return ((_ProtocolTrampoline_268)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_121)(void * arg0, void * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_121 _1wf8t1k_wrapListenerBlock_1037nh9(_ListenerTrampoline_121 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, void * arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_121)(void * waiter, void * arg0, void * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_121 _1wf8t1k_wrapBlockingBlock_1037nh9(
    _BlockingTrampoline_121 block, _BlockingTrampoline_121 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, void * arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_269)(void * sel, void * arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1037nh9(id target, void * sel, void * arg1) {
  return ((_ProtocolTrampoline_269)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_122)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_122 _1wf8t1k_wrapListenerBlock_1l4hxwm(_ListenerTrampoline_122 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retainBlock(arg1));
  };
}

typedef void  (^_BlockingTrampoline_122)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_122 _1wf8t1k_wrapBlockingBlock_1l4hxwm(
    _BlockingTrampoline_122 block, _BlockingTrampoline_122 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, objc_retainBlock(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, objc_retainBlock(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_270)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1l4hxwm(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_270)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_123)(void * arg0, id arg1, NSStringEnumerationOptions arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_123 _1wf8t1k_wrapListenerBlock_7dzmi7(_ListenerTrampoline_123 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, NSStringEnumerationOptions arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_123)(void * waiter, void * arg0, id arg1, NSStringEnumerationOptions arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_123 _1wf8t1k_wrapBlockingBlock_7dzmi7(
    _BlockingTrampoline_123 block, _BlockingTrampoline_123 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, NSStringEnumerationOptions arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_271)(void * sel, id arg1, NSStringEnumerationOptions arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_7dzmi7(id target, void * sel, id arg1, NSStringEnumerationOptions arg2, id arg3) {
  return ((_ProtocolTrampoline_271)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_124)(void * arg0, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_124 _1wf8t1k_wrapListenerBlock_18jmq2k(_ListenerTrampoline_124 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, BOOL arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_124)(void * waiter, void * arg0, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_124 _1wf8t1k_wrapBlockingBlock_18jmq2k(
    _BlockingTrampoline_124 block, _BlockingTrampoline_124 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, BOOL arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_272)(void * sel, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_18jmq2k(id target, void * sel, id arg1, BOOL arg2, id arg3) {
  return ((_ProtocolTrampoline_272)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_125)(void * arg0, id arg1, struct _NSRange arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_125 _1wf8t1k_wrapListenerBlock_drgxon(_ListenerTrampoline_125 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct _NSRange arg2, struct _NSRange arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_125)(void * waiter, void * arg0, id arg1, struct _NSRange arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_125 _1wf8t1k_wrapBlockingBlock_drgxon(
    _BlockingTrampoline_125 block, _BlockingTrampoline_125 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct _NSRange arg2, struct _NSRange arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_273)(void * sel, id arg1, struct _NSRange arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_drgxon(id target, void * sel, id arg1, struct _NSRange arg2, struct _NSRange arg3) {
  return ((_ProtocolTrampoline_273)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_126)(void * arg0, id arg1, struct objc_selector * arg2, void * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_126 _1wf8t1k_wrapListenerBlock_1teny3c(_ListenerTrampoline_126 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct objc_selector * arg2, void * arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_126)(void * waiter, void * arg0, id arg1, struct objc_selector * arg2, void * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_126 _1wf8t1k_wrapBlockingBlock_1teny3c(
    _BlockingTrampoline_126 block, _BlockingTrampoline_126 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct objc_selector * arg2, void * arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_274)(void * sel, id arg1, struct objc_selector * arg2, void * arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_1teny3c(id target, void * sel, id arg1, struct objc_selector * arg2, void * arg3) {
  return ((_ProtocolTrampoline_274)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_127)(void * arg0, struct objc_selector * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_127 _1wf8t1k_wrapListenerBlock_be1lg6(_ListenerTrampoline_127 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct objc_selector * arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_127)(void * waiter, void * arg0, struct objc_selector * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_127 _1wf8t1k_wrapBlockingBlock_be1lg6(
    _BlockingTrampoline_127 block, _BlockingTrampoline_127 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct objc_selector * arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_275)(void * sel, struct objc_selector * arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_be1lg6(id target, void * sel, struct objc_selector * arg1) {
  return ((_ProtocolTrampoline_275)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_128)(void * arg0, struct objc_selector * arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_128 _1wf8t1k_wrapListenerBlock_dpfojo(_ListenerTrampoline_128 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct objc_selector * arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_128)(void * waiter, void * arg0, struct objc_selector * arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_128 _1wf8t1k_wrapBlockingBlock_dpfojo(
    _BlockingTrampoline_128 block, _BlockingTrampoline_128 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct objc_selector * arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_276)(void * sel, struct objc_selector * arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1wf8t1k_protocolTrampoline_dpfojo(id target, void * sel, struct objc_selector * arg1, id arg2) {
  return ((_ProtocolTrampoline_276)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_129)(id arg0, unsigned long arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_129 _1wf8t1k_wrapListenerBlock_1p9ui4q(_ListenerTrampoline_129 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, unsigned long arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_129)(void * waiter, id arg0, unsigned long arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_129 _1wf8t1k_wrapBlockingBlock_1p9ui4q(
    _BlockingTrampoline_129 block, _BlockingTrampoline_129 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, unsigned long arg1, BOOL * arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef id  (^_ProtocolTrampoline_277)(void * sel, id arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_skjqxk(id target, void * sel, id arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_277)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_278)(void * sel, id arg1, NSTextContentManagerEnumerationOptions arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1dxsa0d(id target, void * sel, id arg1, NSTextContentManagerEnumerationOptions arg2, id arg3) {
  return ((_ProtocolTrampoline_278)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_279)(void * sel, unsigned long arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_sov0i8(id target, void * sel, unsigned long arg1, id arg2) {
  return ((_ProtocolTrampoline_279)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_280)(void * sel, id arg1, long arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1dewx97(id target, void * sel, id arg1, long arg2, id arg3) {
  return ((_ProtocolTrampoline_280)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_281)(void * sel, long arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_wrzr3t(id target, void * sel, long arg1, long arg2) {
  return ((_ProtocolTrampoline_281)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_282)(void * sel, id arg1, id arg2 __attribute__((ns_consumed)));
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_1p0fswn(id target, void * sel, id arg1, id arg2 __attribute__((ns_consumed))) {
  return ((_ProtocolTrampoline_282)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_283)(void * sel, id arg1, long arg2, id arg3, NSRuleEditorRowType arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_meja6l(id target, void * sel, id arg1, long arg2, id arg3, NSRuleEditorRowType arg4) {
  return ((_ProtocolTrampoline_283)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_284)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _1wf8t1k_protocolTrampoline_wpy7aa(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_284)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct objc_selector *  (^_ProtocolTrampoline_285)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct objc_selector *  _1wf8t1k_protocolTrampoline_ixproo(id target, void * sel) {
  return ((_ProtocolTrampoline_285)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct ppd_file_s *  (^_ProtocolTrampoline_286)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct ppd_file_s *  _1wf8t1k_protocolTrampoline_10vn635(id target, void * sel) {
  return ((_ProtocolTrampoline_286)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}
#undef BLOCKING_BLOCK_IMPL

#pragma clang diagnostic pop
