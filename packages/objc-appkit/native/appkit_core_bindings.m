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


typedef double  (^_ProtocolTrampoline)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
double  _ushtfa_protocolTrampoline_lwcz9r(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef double  (^_ProtocolTrampoline_1)(void * sel, unsigned long arg1);
__attribute__((visibility("default"))) __attribute__((used))
double  _ushtfa_protocolTrampoline_ae6hkl(id target, void * sel, unsigned long arg1) {
  return ((_ProtocolTrampoline_1)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGRect  (^_ProtocolTrampoline_2)(void * sel, id arg1, id arg2, id arg3, struct CGRect arg4, struct CGPoint arg5);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _ushtfa_protocolTrampoline_1ravc6k(id target, void * sel, id arg1, id arg2, id arg3, struct CGRect arg4, struct CGPoint arg5) {
  return ((_ProtocolTrampoline_2)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef struct CGRect  (^_ProtocolTrampoline_3)(void * sel, id arg1, struct CGRect arg2, struct CGPoint arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _ushtfa_protocolTrampoline_iqdvkd(id target, void * sel, id arg1, struct CGRect arg2, struct CGPoint arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_3)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef struct CGRect  (^_ProtocolTrampoline_4)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _ushtfa_protocolTrampoline_szn7s6(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_4)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef NSApplicationPresentationOptions  (^_ProtocolTrampoline_5)(void * sel, id arg1, NSApplicationPresentationOptions arg2);
__attribute__((visibility("default"))) __attribute__((used))
NSApplicationPresentationOptions  _ushtfa_protocolTrampoline_o924zt(id target, void * sel, id arg1, NSApplicationPresentationOptions arg2) {
  return ((_ProtocolTrampoline_5)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef NSApplicationPrintReply  (^_ProtocolTrampoline_6)(void * sel, id arg1, id arg2, id arg3, BOOL arg4);
__attribute__((visibility("default"))) __attribute__((used))
NSApplicationPrintReply  _ushtfa_protocolTrampoline_1ntoid(id target, void * sel, id arg1, id arg2, id arg3, BOOL arg4) {
  return ((_ProtocolTrampoline_6)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef NSApplicationTerminateReply  (^_ProtocolTrampoline_7)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSApplicationTerminateReply  _ushtfa_protocolTrampoline_dl2wbd(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_7)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_8)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_1mbt9g9(id target, void * sel) {
  return ((_ProtocolTrampoline_8)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_9)(void * sel, id arg1, id arg2, id arg3, struct _NSRange arg4, long * arg5);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_1c30j5d(id target, void * sel, id arg1, id arg2, id arg3, struct _NSRange arg4, long * arg5) {
  return ((_ProtocolTrampoline_9)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef id  (^_ProtocolTrampoline_10)(void * sel, struct _NSRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_xzy3cf(id target, void * sel, struct _NSRange arg1) {
  return ((_ProtocolTrampoline_10)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_11)(void * sel, id arg1, id arg2, id arg3, struct _NSRange arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_1rp5l9d(id target, void * sel, id arg1, id arg2, id arg3, struct _NSRange arg4) {
  return ((_ProtocolTrampoline_11)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_12)(void * sel, id arg1, id arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_1sfqckr(id target, void * sel, id arg1, id arg2, struct _NSRange arg3) {
  return ((_ProtocolTrampoline_12)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_13)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_zi5eed(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_13)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_14)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_1yw2rcr(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_14)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_15)(void * sel, id arg1, id arg2, struct _NSRange arg3, long * arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_1cinhbv(id target, void * sel, id arg1, id arg2, struct _NSRange arg3, long * arg4) {
  return ((_ProtocolTrampoline_15)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_16)(void * sel, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_ggvik5(id target, void * sel, id arg1, struct _NSRange arg2) {
  return ((_ProtocolTrampoline_16)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_17)(void * sel, id arg1, struct _NSRange arg2, uint64_t arg3, id arg4, id arg5, id arg6, long arg7);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_145pe2u(id target, void * sel, id arg1, struct _NSRange arg2, uint64_t arg3, id arg4, id arg5, id arg6, long arg7) {
  return ((_ProtocolTrampoline_17)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
}

typedef id  (^_ProtocolTrampoline_18)(void * sel, id arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_1mpupby(id target, void * sel, id arg1, id arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_18)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_19)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_xr62hr(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_19)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_20)(void * sel, struct _NSRange arg1, struct _NSRange * arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_17bmapz(id target, void * sel, struct _NSRange arg1, struct _NSRange * arg2) {
  return ((_ProtocolTrampoline_20)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef NSColorPanelMode  (^_ProtocolTrampoline_21)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSColorPanelMode  _ushtfa_protocolTrampoline_160f7hy(id target, void * sel) {
  return ((_ProtocolTrampoline_21)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSComparisonResult  (^_ProtocolTrampoline_22)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSComparisonResult  _ushtfa_protocolTrampoline_1xws32k(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_22)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_23)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_qfyidt(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_23)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_24)(void * sel, id arg1, struct _NSRange arg2, id arg3, uint64_t * arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_1wersru(id target, void * sel, id arg1, struct _NSRange arg2, id arg3, uint64_t * arg4) {
  return ((_ProtocolTrampoline_24)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef NSFontPanelModeMask  (^_ProtocolTrampoline_25)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSFontPanelModeMask  _ushtfa_protocolTrampoline_wlkc32(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_25)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_26)(void * sel, struct CGRect arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_1a7e3u0(id target, void * sel, struct CGRect arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_26)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_27)(void * sel, struct CGRect arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_qwb72h(id target, void * sel, struct CGRect arg1, id arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_27)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef long  (^_ProtocolTrampoline_28)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
long  _ushtfa_protocolTrampoline_fai2e9(id target, void * sel) {
  return ((_ProtocolTrampoline_28)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef long  (^_ProtocolTrampoline_29)(void * sel, id arg1, long arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
long  _ushtfa_protocolTrampoline_15zjx8z(id target, void * sel, id arg1, long arg2, struct _NSRange arg3) {
  return ((_ProtocolTrampoline_29)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef long  (^_ProtocolTrampoline_30)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
long  _ushtfa_protocolTrampoline_evw03x(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_30)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_31)(void * sel, id arg1, id arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_1ja1ksk(id target, void * sel, id arg1, id arg2, id arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_31)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef struct CGPoint  (^_ProtocolTrampoline_32)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _ushtfa_protocolTrampoline_7ohnx8(id target, void * sel) {
  return ((_ProtocolTrampoline_32)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct _NSRange  (^_ProtocolTrampoline_33)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct _NSRange  _ushtfa_protocolTrampoline_1mh5vs9(id target, void * sel) {
  return ((_ProtocolTrampoline_33)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct _NSRange  (^_ProtocolTrampoline_34)(void * sel, id arg1, struct _NSRange arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
struct _NSRange  _ushtfa_protocolTrampoline_g9lmej(id target, void * sel, id arg1, struct _NSRange arg2, struct _NSRange arg3) {
  return ((_ProtocolTrampoline_34)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef struct CGRect  (^_ProtocolTrampoline_35)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _ushtfa_protocolTrampoline_1c3uc0w(id target, void * sel) {
  return ((_ProtocolTrampoline_35)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGRect  (^_ProtocolTrampoline_36)(void * sel, struct _NSRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _ushtfa_protocolTrampoline_ox7a80(id target, void * sel, struct _NSRange arg1) {
  return ((_ProtocolTrampoline_36)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGRect  (^_ProtocolTrampoline_37)(void * sel, struct _NSRange arg1, struct _NSRange * arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _ushtfa_protocolTrampoline_1xytnsq(id target, void * sel, struct _NSRange arg1, struct _NSRange * arg2) {
  return ((_ProtocolTrampoline_37)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGRect  (^_ProtocolTrampoline_38)(void * sel, id arg1, struct CGRect arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _ushtfa_protocolTrampoline_jnr01b(id target, void * sel, id arg1, struct CGRect arg2) {
  return ((_ProtocolTrampoline_38)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGRect  (^_ProtocolTrampoline_39)(void * sel, id arg1, id arg2, struct CGRect arg3);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _ushtfa_protocolTrampoline_1vg0rmd(id target, void * sel, id arg1, id arg2, struct CGRect arg3) {
  return ((_ProtocolTrampoline_39)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef struct CGSize  (^_ProtocolTrampoline_40)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _ushtfa_protocolTrampoline_1j20mp(id target, void * sel) {
  return ((_ProtocolTrampoline_40)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGSize  (^_ProtocolTrampoline_41)(void * sel, id arg1, struct CGSize arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _ushtfa_protocolTrampoline_gnbb7x(id target, void * sel, id arg1, struct CGSize arg2) {
  return ((_ProtocolTrampoline_41)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGSize  (^_ProtocolTrampoline_42)(void * sel, id arg1, struct CGSize arg2, struct CGSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _ushtfa_protocolTrampoline_1hqtzbn(id target, void * sel, id arg1, struct CGSize arg2, struct CGSize arg3) {
  return ((_ProtocolTrampoline_42)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_43)(void * sel, unsigned long arg1, struct _NSRange * arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_19qfjta(id target, void * sel, unsigned long arg1, struct _NSRange * arg2, BOOL * arg3) {
  return ((_ProtocolTrampoline_43)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_44)(void * sel, id arg1, long arg2, struct CGPoint arg3, void * arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_vja0y6(id target, void * sel, id arg1, long arg2, struct CGPoint arg3, void * arg4) {
  return ((_ProtocolTrampoline_44)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef NSTextCursorAccessoryPlacement  (^_ProtocolTrampoline_45)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSTextCursorAccessoryPlacement  _ushtfa_protocolTrampoline_1q0cf5a(id target, void * sel) {
  return ((_ProtocolTrampoline_45)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSTextInputTraitType  (^_ProtocolTrampoline_46)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSTextInputTraitType  _ushtfa_protocolTrampoline_1hvujqv(id target, void * sel) {
  return ((_ProtocolTrampoline_46)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSTextLayoutOrientation  (^_ProtocolTrampoline_47)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSTextLayoutOrientation  _ushtfa_protocolTrampoline_1hcgfk1(id target, void * sel) {
  return ((_ProtocolTrampoline_47)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_48)(void * sel, struct CGPoint arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_1cizpv0(id target, void * sel, struct CGPoint arg1, id arg2) {
  return ((_ProtocolTrampoline_48)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_49)(void * sel, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_1u4xn97(id target, void * sel, id arg1, BOOL arg2) {
  return ((_ProtocolTrampoline_49)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_50)(void * sel, NSTextSelectionGranularity arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_1msw0hl(id target, void * sel, NSTextSelectionGranularity arg1, id arg2) {
  return ((_ProtocolTrampoline_50)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef NSTextSelectionNavigationLayoutOrientation  (^_ProtocolTrampoline_51)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSTextSelectionNavigationLayoutOrientation  _ushtfa_protocolTrampoline_1kcz7dl(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_51)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef NSTextSelectionNavigationWritingDirection  (^_ProtocolTrampoline_52)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSTextSelectionNavigationWritingDirection  _ushtfa_protocolTrampoline_1kewuno(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_52)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef unsigned long  (^_ProtocolTrampoline_53)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _ushtfa_protocolTrampoline_1ckyi24(id target, void * sel) {
  return ((_ProtocolTrampoline_53)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef unsigned long  (^_ProtocolTrampoline_54)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _ushtfa_protocolTrampoline_r5c0tn(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_54)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_55)(void * sel, struct _NSRange arg1, struct CGRect * arg2, struct _NSRange * arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_g9rctw(id target, void * sel, struct _NSRange arg1, struct CGRect * arg2, struct _NSRange * arg3) {
  return ((_ProtocolTrampoline_55)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_56)(void * sel, unsigned long arg1, struct _NSRange * arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_vt1y0w(id target, void * sel, unsigned long arg1, struct _NSRange * arg2) {
  return ((_ProtocolTrampoline_56)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_57)(void * sel, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_1ggpu35(id target, void * sel, BOOL arg1) {
  return ((_ProtocolTrampoline_57)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef NSWritingToolsBehavior  (^_ProtocolTrampoline_58)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSWritingToolsBehavior  _ushtfa_protocolTrampoline_1lr8nud(id target, void * sel) {
  return ((_ProtocolTrampoline_58)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSWritingToolsResultOptions  (^_ProtocolTrampoline_59)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSWritingToolsResultOptions  _ushtfa_protocolTrampoline_3iswoq(id target, void * sel) {
  return ((_ProtocolTrampoline_59)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_60)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_e3qsqz(id target, void * sel) {
  return ((_ProtocolTrampoline_60)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_61)(void * sel, id arg1, double arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_cpb8xo(id target, void * sel, id arg1, double arg2, id arg3) {
  return ((_ProtocolTrampoline_61)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_62)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_3su7tt(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_62)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_63)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_2n06mv(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_63)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_64)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_rptcvw(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_64)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_65)(void * sel, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_9k4e9l(id target, void * sel, id arg1, BOOL arg2) {
  return ((_ProtocolTrampoline_65)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_66)(void * sel, NSColorPanelMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_1o8ee36(id target, void * sel, NSColorPanelMode arg1) {
  return ((_ProtocolTrampoline_66)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_67)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_jk8du5(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_67)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_68)(void * sel, id arg1, id arg2, struct objc_selector * arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_1c6g01w(id target, void * sel, id arg1, id arg2, struct objc_selector * arg3) {
  return ((_ProtocolTrampoline_68)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_69)(void * sel, id * arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_jp3gca(id target, void * sel, id * arg1) {
  return ((_ProtocolTrampoline_69)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_70)(void * sel, id arg1, struct CGRect arg2, id arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_mdqffl(id target, void * sel, id arg1, struct CGRect arg2, id arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_70)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_71)(void * sel, id arg1, struct CGRect arg2, id arg3, unsigned long arg4, BOOL arg5);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_7vcxix(id target, void * sel, id arg1, struct CGRect arg2, id arg3, unsigned long arg4, BOOL arg5) {
  return ((_ProtocolTrampoline_71)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef BOOL  (^_ProtocolTrampoline_72)(void * sel, id arg1, struct CGRect arg2, id arg3, BOOL arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_b1wn5c(id target, void * sel, id arg1, struct CGRect arg2, id arg3, BOOL arg4) {
  return ((_ProtocolTrampoline_72)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_73)(void * sel, id arg1, id arg2, NSTextContentManagerEnumerationOptions arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_r3hakm(id target, void * sel, id arg1, id arg2, NSTextContentManagerEnumerationOptions arg3) {
  return ((_ProtocolTrampoline_73)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_74)(void * sel, id arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_7ene1c(id target, void * sel, id arg1, id arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_74)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_75)(void * sel, id arg1, id arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_t3vpwz(id target, void * sel, id arg1, id arg2, BOOL arg3) {
  return ((_ProtocolTrampoline_75)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_76)(void * sel, id arg1, struct _NSRange arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_u18wpp(id target, void * sel, id arg1, struct _NSRange arg2, id arg3) {
  return ((_ProtocolTrampoline_76)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_77)(void * sel, id arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_16fgsa(id target, void * sel, id arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_77)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_78)(void * sel, id arg1, id arg2, unsigned long arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_1i5xgg4(id target, void * sel, id arg1, id arg2, unsigned long arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_78)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef BOOL  (^_ProtocolTrampoline_79)(void * sel, id arg1, struct objc_selector * arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_122cere(id target, void * sel, id arg1, struct objc_selector * arg2) {
  return ((_ProtocolTrampoline_79)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_80)(void * sel, unsigned long arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_15ssoz8(id target, void * sel, unsigned long arg1) {
  return ((_ProtocolTrampoline_80)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_81)(void * sel, id arg1, id arg2, struct CGPoint arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_6f73nq(id target, void * sel, id arg1, id arg2, struct CGPoint arg3, id arg4) {
  return ((_ProtocolTrampoline_81)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_82)(void * sel, id arg1, struct CGRect arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ushtfa_protocolTrampoline_yubn6m(id target, void * sel, id arg1, struct CGRect arg2) {
  return ((_ProtocolTrampoline_82)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline)(void);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _ushtfa_wrapListenerBlock_1pl9qdv(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void() {
    objc_retainBlock(block);
    block();
  };
}

typedef void  (^_BlockingTrampoline)(void * waiter);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _ushtfa_wrapBlockingBlock_1pl9qdv(
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

typedef void  (^_ListenerTrampoline_1)(double arg0, id arg1, BOOL arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _ushtfa_wrapListenerBlock_o4flre(_ListenerTrampoline_1 block) NS_RETURNS_RETAINED {
  return ^void(double arg0, id arg1, BOOL arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_1)(void * waiter, double arg0, id arg1, BOOL arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _ushtfa_wrapBlockingBlock_o4flre(
    _BlockingTrampoline_1 block, _BlockingTrampoline_1 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(double arg0, id arg1, BOOL arg2, BOOL * arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ListenerTrampoline_2)(id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _ushtfa_wrapListenerBlock_xtuoz7(_ListenerTrampoline_2 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0));
  };
}

typedef void  (^_BlockingTrampoline_2)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _ushtfa_wrapBlockingBlock_xtuoz7(
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

typedef void  (^_ListenerTrampoline_3)(id arg0, id arg1, id arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _ushtfa_wrapListenerBlock_fo7rrt(_ListenerTrampoline_3 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_3)(void * waiter, id arg0, id arg1, id arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _ushtfa_wrapBlockingBlock_fo7rrt(
    _BlockingTrampoline_3 block, _BlockingTrampoline_3 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, id arg2, BOOL * arg3), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ListenerTrampoline_4)(id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _ushtfa_wrapListenerBlock_pfv6jd(_ListenerTrampoline_4 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_4)(void * waiter, id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _ushtfa_wrapBlockingBlock_pfv6jd(
    _BlockingTrampoline_4 block, _BlockingTrampoline_4 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_5)(id arg0, BOOL * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _ushtfa_wrapListenerBlock_t8l8el(_ListenerTrampoline_5 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL * arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1);
  };
}

typedef void  (^_BlockingTrampoline_5)(void * waiter, id arg0, BOOL * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _ushtfa_wrapBlockingBlock_t8l8el(
    _BlockingTrampoline_5 block, _BlockingTrampoline_5 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL * arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  });
}

typedef void  (^_ListenerTrampoline_6)(long arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _ushtfa_wrapListenerBlock_4sp4xj(_ListenerTrampoline_6 block) NS_RETURNS_RETAINED {
  return ^void(long arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_6)(void * waiter, long arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _ushtfa_wrapBlockingBlock_4sp4xj(
    _BlockingTrampoline_6 block, _BlockingTrampoline_6 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(long arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_7)(void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _ushtfa_wrapListenerBlock_ovsamd(_ListenerTrampoline_7 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_7)(void * waiter, void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _ushtfa_wrapBlockingBlock_ovsamd(
    _BlockingTrampoline_7 block, _BlockingTrampoline_7 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ProtocolTrampoline_83)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_ovsamd(id target, void * sel) {
  return ((_ProtocolTrampoline_83)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_8)(void * arg0, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _ushtfa_wrapListenerBlock_ayxzy9(_ListenerTrampoline_8 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct _NSRange arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_8)(void * waiter, void * arg0, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _ushtfa_wrapBlockingBlock_ayxzy9(
    _BlockingTrampoline_8 block, _BlockingTrampoline_8 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct _NSRange arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_84)(void * sel, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_ayxzy9(id target, void * sel, id arg1, struct _NSRange arg2) {
  return ((_ProtocolTrampoline_84)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_9)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _ushtfa_wrapListenerBlock_fjrv01(_ListenerTrampoline_9 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_9)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _ushtfa_wrapBlockingBlock_fjrv01(
    _BlockingTrampoline_9 block, _BlockingTrampoline_9 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_85)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_fjrv01(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_85)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_10)(void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _ushtfa_wrapListenerBlock_1tz5yf(_ListenerTrampoline_10 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_10)(void * waiter, void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _ushtfa_wrapBlockingBlock_1tz5yf(
    _BlockingTrampoline_10 block, _BlockingTrampoline_10 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_86)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_1tz5yf(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_86)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_11)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _ushtfa_wrapListenerBlock_18v1jvf(_ListenerTrampoline_11 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_11)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _ushtfa_wrapBlockingBlock_18v1jvf(
    _BlockingTrampoline_11 block, _BlockingTrampoline_11 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_87)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_18v1jvf(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_87)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_12)(void * arg0, NSColorPanelMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _ushtfa_wrapListenerBlock_jnbfgk(_ListenerTrampoline_12 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSColorPanelMode arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_12)(void * waiter, void * arg0, NSColorPanelMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _ushtfa_wrapBlockingBlock_jnbfgk(
    _BlockingTrampoline_12 block, _BlockingTrampoline_12 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSColorPanelMode arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_88)(void * sel, NSColorPanelMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_jnbfgk(id target, void * sel, NSColorPanelMode arg1) {
  return ((_ProtocolTrampoline_88)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_13)(void * arg0, struct _NSRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _ushtfa_wrapListenerBlock_xpqfd7(_ListenerTrampoline_13 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct _NSRange arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_13)(void * waiter, void * arg0, struct _NSRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _ushtfa_wrapBlockingBlock_xpqfd7(
    _BlockingTrampoline_13 block, _BlockingTrampoline_13 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct _NSRange arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_89)(void * sel, struct _NSRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_xpqfd7(id target, void * sel, struct _NSRange arg1) {
  return ((_ProtocolTrampoline_89)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_14)(void * arg0, struct _NSRange arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _ushtfa_wrapListenerBlock_1f6txb5(_ListenerTrampoline_14 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct _NSRange arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_14)(void * waiter, void * arg0, struct _NSRange arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _ushtfa_wrapBlockingBlock_1f6txb5(
    _BlockingTrampoline_14 block, _BlockingTrampoline_14 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct _NSRange arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_90)(void * sel, struct _NSRange arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_1f6txb5(id target, void * sel, struct _NSRange arg1, id arg2) {
  return ((_ProtocolTrampoline_90)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_15)(void * arg0, struct CGRect arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _ushtfa_wrapListenerBlock_5r0qjk(_ListenerTrampoline_15 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGRect arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_15)(void * waiter, void * arg0, struct CGRect arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _ushtfa_wrapBlockingBlock_5r0qjk(
    _BlockingTrampoline_15 block, _BlockingTrampoline_15 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGRect arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_91)(void * sel, struct CGRect arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_5r0qjk(id target, void * sel, struct CGRect arg1, id arg2) {
  return ((_ProtocolTrampoline_91)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_16)(void * arg0, struct CGRect arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _ushtfa_wrapListenerBlock_772a45(_ListenerTrampoline_16 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGRect arg1, id arg2, unsigned long arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_16)(void * waiter, void * arg0, struct CGRect arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _ushtfa_wrapBlockingBlock_772a45(
    _BlockingTrampoline_16 block, _BlockingTrampoline_16 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGRect arg1, id arg2, unsigned long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_92)(void * sel, struct CGRect arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_772a45(id target, void * sel, struct CGRect arg1, id arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_92)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_17)(void * arg0, struct CGRect arg1, id arg2, unsigned long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _ushtfa_wrapListenerBlock_1gzvlvv(_ListenerTrampoline_17 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGRect arg1, id arg2, unsigned long arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_17)(void * waiter, void * arg0, struct CGRect arg1, id arg2, unsigned long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _ushtfa_wrapBlockingBlock_1gzvlvv(
    _BlockingTrampoline_17 block, _BlockingTrampoline_17 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGRect arg1, id arg2, unsigned long arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_93)(void * sel, struct CGRect arg1, id arg2, unsigned long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_1gzvlvv(id target, void * sel, struct CGRect arg1, id arg2, unsigned long arg3, id arg4) {
  return ((_ProtocolTrampoline_93)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_18)(void * arg0, struct CGSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _ushtfa_wrapListenerBlock_leirm3(_ListenerTrampoline_18 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGSize arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_18)(void * waiter, void * arg0, struct CGSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _ushtfa_wrapBlockingBlock_leirm3(
    _BlockingTrampoline_18 block, _BlockingTrampoline_18 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGSize arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_94)(void * sel, struct CGSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_leirm3(id target, void * sel, struct CGSize arg1) {
  return ((_ProtocolTrampoline_94)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_19)(void * arg0, NSTextInputTraitType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_19 _ushtfa_wrapListenerBlock_pu9nad(_ListenerTrampoline_19 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSTextInputTraitType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_19)(void * waiter, void * arg0, NSTextInputTraitType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_19 _ushtfa_wrapBlockingBlock_pu9nad(
    _BlockingTrampoline_19 block, _BlockingTrampoline_19 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSTextInputTraitType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_95)(void * sel, NSTextInputTraitType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_pu9nad(id target, void * sel, NSTextInputTraitType arg1) {
  return ((_ProtocolTrampoline_95)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_20)(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_20 _ushtfa_wrapListenerBlock_19w094r(_ListenerTrampoline_20 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_20)(void * waiter, void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_20 _ushtfa_wrapBlockingBlock_19w094r(
    _BlockingTrampoline_20 block, _BlockingTrampoline_20 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_96)(void * sel, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_19w094r(id target, void * sel, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4) {
  return ((_ProtocolTrampoline_96)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_21)(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_21 _ushtfa_wrapListenerBlock_1ucjyxt(_ListenerTrampoline_21 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5);
  };
}

typedef void  (^_BlockingTrampoline_21)(void * waiter, void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_21 _ushtfa_wrapBlockingBlock_1ucjyxt(
    _BlockingTrampoline_21 block, _BlockingTrampoline_21 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5);
  });
}

typedef void  (^_ProtocolTrampoline_97)(void * sel, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_1ucjyxt(id target, void * sel, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5) {
  return ((_ProtocolTrampoline_97)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_22)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_22 _ushtfa_wrapListenerBlock_jk1ljc(_ListenerTrampoline_22 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  };
}

typedef void  (^_BlockingTrampoline_22)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_22 _ushtfa_wrapBlockingBlock_jk1ljc(
    _BlockingTrampoline_22 block, _BlockingTrampoline_22 listenerBlock,
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
void  _ushtfa_protocolTrampoline_jk1ljc(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_98)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_23)(void * arg0, id arg1, id arg2, struct CGRect arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_23 _ushtfa_wrapListenerBlock_eln3n2(_ListenerTrampoline_23 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct CGRect arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_23)(void * waiter, void * arg0, id arg1, id arg2, struct CGRect arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_23 _ushtfa_wrapBlockingBlock_eln3n2(
    _BlockingTrampoline_23 block, _BlockingTrampoline_23 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct CGRect arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_99)(void * sel, id arg1, id arg2, struct CGRect arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_eln3n2(id target, void * sel, id arg1, id arg2, struct CGRect arg3) {
  return ((_ProtocolTrampoline_99)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_24)(void * arg0, id arg1, id arg2, struct CGRect arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_24 _ushtfa_wrapListenerBlock_36y93g(_ListenerTrampoline_24 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct CGRect arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_24)(void * waiter, void * arg0, id arg1, id arg2, struct CGRect arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_24 _ushtfa_wrapBlockingBlock_36y93g(
    _BlockingTrampoline_24 block, _BlockingTrampoline_24 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct CGRect arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_100)(void * sel, id arg1, id arg2, struct CGRect arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_36y93g(id target, void * sel, id arg1, id arg2, struct CGRect arg3, id arg4) {
  return ((_ProtocolTrampoline_100)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_25)(void * arg0, id arg1, id arg2, struct CGRect arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_25 _ushtfa_wrapListenerBlock_14vjvrl(_ListenerTrampoline_25 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct CGRect arg3, id arg4, unsigned long arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5);
  };
}

typedef void  (^_BlockingTrampoline_25)(void * waiter, void * arg0, id arg1, id arg2, struct CGRect arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_25 _ushtfa_wrapBlockingBlock_14vjvrl(
    _BlockingTrampoline_25 block, _BlockingTrampoline_25 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct CGRect arg3, id arg4, unsigned long arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4), arg5);
  });
}

typedef void  (^_ProtocolTrampoline_101)(void * sel, id arg1, id arg2, struct CGRect arg3, id arg4, unsigned long arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_14vjvrl(id target, void * sel, id arg1, id arg2, struct CGRect arg3, id arg4, unsigned long arg5) {
  return ((_ProtocolTrampoline_101)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_26)(void * arg0, id arg1, id arg2, struct CGRect arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_26 _ushtfa_wrapListenerBlock_ebp9i3(_ListenerTrampoline_26 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct CGRect arg3, unsigned long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_26)(void * waiter, void * arg0, id arg1, id arg2, struct CGRect arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_26 _ushtfa_wrapBlockingBlock_ebp9i3(
    _BlockingTrampoline_26 block, _BlockingTrampoline_26 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct CGRect arg3, unsigned long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_102)(void * sel, id arg1, id arg2, struct CGRect arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_ebp9i3(id target, void * sel, id arg1, id arg2, struct CGRect arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_102)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_27)(void * arg0, id arg1, id arg2, double arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_27 _ushtfa_wrapListenerBlock_gxqm8e(_ListenerTrampoline_27 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, double arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_27)(void * waiter, void * arg0, id arg1, id arg2, double arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_27 _ushtfa_wrapBlockingBlock_gxqm8e(
    _BlockingTrampoline_27 block, _BlockingTrampoline_27 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, double arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_103)(void * sel, id arg1, id arg2, double arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_gxqm8e(id target, void * sel, id arg1, id arg2, double arg3) {
  return ((_ProtocolTrampoline_103)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_28)(void * arg0, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_28 _ushtfa_wrapListenerBlock_ve6f9k(_ListenerTrampoline_28 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, double arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_28)(void * waiter, void * arg0, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_28 _ushtfa_wrapBlockingBlock_ve6f9k(
    _BlockingTrampoline_28 block, _BlockingTrampoline_28 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, double arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_104)(void * sel, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_ve6f9k(id target, void * sel, id arg1, double arg2) {
  return ((_ProtocolTrampoline_104)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_29)(void * arg0, NSWritingToolsBehavior arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_29 _ushtfa_wrapListenerBlock_lm7h8j(_ListenerTrampoline_29 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSWritingToolsBehavior arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_29)(void * waiter, void * arg0, NSWritingToolsBehavior arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_29 _ushtfa_wrapBlockingBlock_lm7h8j(
    _BlockingTrampoline_29 block, _BlockingTrampoline_29 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSWritingToolsBehavior arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_105)(void * sel, NSWritingToolsBehavior arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_lm7h8j(id target, void * sel, NSWritingToolsBehavior arg1) {
  return ((_ProtocolTrampoline_105)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_30)(void * arg0, NSWritingToolsResultOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_30 _ushtfa_wrapListenerBlock_8seuo(_ListenerTrampoline_30 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSWritingToolsResultOptions arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_30)(void * waiter, void * arg0, NSWritingToolsResultOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_30 _ushtfa_wrapBlockingBlock_8seuo(
    _BlockingTrampoline_30 block, _BlockingTrampoline_30 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSWritingToolsResultOptions arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_106)(void * sel, NSWritingToolsResultOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_8seuo(id target, void * sel, NSWritingToolsResultOptions arg1) {
  return ((_ProtocolTrampoline_106)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_31)(void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_31 _ushtfa_wrapListenerBlock_10lndml(_ListenerTrampoline_31 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_31)(void * waiter, void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_31 _ushtfa_wrapBlockingBlock_10lndml(
    _BlockingTrampoline_31 block, _BlockingTrampoline_31 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, BOOL arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_107)(void * sel, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_10lndml(id target, void * sel, BOOL arg1) {
  return ((_ProtocolTrampoline_107)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_32)(void * arg0, BOOL arg1, struct CGRect arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_32 _ushtfa_wrapListenerBlock_1lgh494(_ListenerTrampoline_32 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1, struct CGRect arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_32)(void * waiter, void * arg0, BOOL arg1, struct CGRect arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_32 _ushtfa_wrapBlockingBlock_1lgh494(
    _BlockingTrampoline_32 block, _BlockingTrampoline_32 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, BOOL arg1, struct CGRect arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, arg2, (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_108)(void * sel, BOOL arg1, struct CGRect arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_1lgh494(id target, void * sel, BOOL arg1, struct CGRect arg2, id arg3) {
  return ((_ProtocolTrampoline_108)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_33)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_33 _ushtfa_wrapListenerBlock_1l4hxwm(_ListenerTrampoline_33 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retainBlock(arg1));
  };
}

typedef void  (^_BlockingTrampoline_33)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_33 _ushtfa_wrapBlockingBlock_1l4hxwm(
    _BlockingTrampoline_33 block, _BlockingTrampoline_33 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, objc_retainBlock(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, objc_retainBlock(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_109)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_1l4hxwm(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_109)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_34)(void * arg0, id arg1, NSStringEnumerationOptions arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_34 _ushtfa_wrapListenerBlock_7dzmi7(_ListenerTrampoline_34 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, NSStringEnumerationOptions arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_34)(void * waiter, void * arg0, id arg1, NSStringEnumerationOptions arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_34 _ushtfa_wrapBlockingBlock_7dzmi7(
    _BlockingTrampoline_34 block, _BlockingTrampoline_34 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, NSStringEnumerationOptions arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_110)(void * sel, id arg1, NSStringEnumerationOptions arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_7dzmi7(id target, void * sel, id arg1, NSStringEnumerationOptions arg2, id arg3) {
  return ((_ProtocolTrampoline_110)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_35)(void * arg0, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_35 _ushtfa_wrapListenerBlock_18jmq2k(_ListenerTrampoline_35 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, BOOL arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_35)(void * waiter, void * arg0, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_35 _ushtfa_wrapBlockingBlock_18jmq2k(
    _BlockingTrampoline_35 block, _BlockingTrampoline_35 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, BOOL arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_111)(void * sel, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_18jmq2k(id target, void * sel, id arg1, BOOL arg2, id arg3) {
  return ((_ProtocolTrampoline_111)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_36)(void * arg0, id arg1, struct _NSRange arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_36 _ushtfa_wrapListenerBlock_drgxon(_ListenerTrampoline_36 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct _NSRange arg2, struct _NSRange arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_36)(void * waiter, void * arg0, id arg1, struct _NSRange arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_36 _ushtfa_wrapBlockingBlock_drgxon(
    _BlockingTrampoline_36 block, _BlockingTrampoline_36 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct _NSRange arg2, struct _NSRange arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_112)(void * sel, id arg1, struct _NSRange arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_drgxon(id target, void * sel, id arg1, struct _NSRange arg2, struct _NSRange arg3) {
  return ((_ProtocolTrampoline_112)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_37)(void * arg0, id arg1, struct objc_selector * arg2, void * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_37 _ushtfa_wrapListenerBlock_1teny3c(_ListenerTrampoline_37 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct objc_selector * arg2, void * arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_37)(void * waiter, void * arg0, id arg1, struct objc_selector * arg2, void * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_37 _ushtfa_wrapBlockingBlock_1teny3c(
    _BlockingTrampoline_37 block, _BlockingTrampoline_37 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct objc_selector * arg2, void * arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_113)(void * sel, id arg1, struct objc_selector * arg2, void * arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_1teny3c(id target, void * sel, id arg1, struct objc_selector * arg2, void * arg3) {
  return ((_ProtocolTrampoline_113)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_38)(void * arg0, struct objc_selector * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_38 _ushtfa_wrapListenerBlock_be1lg6(_ListenerTrampoline_38 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct objc_selector * arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_38)(void * waiter, void * arg0, struct objc_selector * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_38 _ushtfa_wrapBlockingBlock_be1lg6(
    _BlockingTrampoline_38 block, _BlockingTrampoline_38 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct objc_selector * arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_114)(void * sel, struct objc_selector * arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ushtfa_protocolTrampoline_be1lg6(id target, void * sel, struct objc_selector * arg1) {
  return ((_ProtocolTrampoline_114)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_115)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_1xvw1tx(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_115)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_116)(void * sel, id arg1, NSTextContentManagerEnumerationOptions arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_1dxsa0d(id target, void * sel, id arg1, NSTextContentManagerEnumerationOptions arg2, id arg3) {
  return ((_ProtocolTrampoline_116)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_117)(void * sel, unsigned long arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _ushtfa_protocolTrampoline_sov0i8(id target, void * sel, unsigned long arg1, id arg2) {
  return ((_ProtocolTrampoline_117)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}
#undef BLOCKING_BLOCK_IMPL

#pragma clang diagnostic pop
