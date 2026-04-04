#include <stdint.h>
#import <Foundation/Foundation.h>
#import <objc/message.h>
#import <UIKit/UIKit.h>

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


typedef id  (^_ProtocolTrampoline)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_1mbt9g9(id target, void * sel) {
  return ((_ProtocolTrampoline)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CATransform3D  (^_ProtocolTrampoline_1)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CATransform3D  _1653r2v_protocolTrampoline_11izgv5(id target, void * sel) {
  return ((_ProtocolTrampoline_1)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGAffineTransform  (^_ProtocolTrampoline_2)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGAffineTransform  _1653r2v_protocolTrampoline_8o6he9(id target, void * sel) {
  return ((_ProtocolTrampoline_2)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef double  (^_ProtocolTrampoline_3)(void * sel, id arg1, unsigned long arg2, struct CGRect arg3);
__attribute__((visibility("default"))) __attribute__((used))
double  _1653r2v_protocolTrampoline_1csvj5s(id target, void * sel, id arg1, unsigned long arg2, struct CGRect arg3) {
  return ((_ProtocolTrampoline_3)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef double  (^_ProtocolTrampoline_4)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
double  _1653r2v_protocolTrampoline_1x666sm(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_4)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGImage *  (^_ProtocolTrampoline_5)(void * sel, struct CGSize arg1, double arg2, struct CGPoint * arg3, struct CGSize * arg4);
__attribute__((visibility("default"))) __attribute__((used))
struct CGImage *  _1653r2v_protocolTrampoline_1p89e63(id target, void * sel, struct CGSize arg1, double arg2, struct CGPoint * arg3, struct CGSize * arg4) {
  return ((_ProtocolTrampoline_5)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef struct CGPoint  (^_ProtocolTrampoline_6)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _1653r2v_protocolTrampoline_7ohnx8(id target, void * sel) {
  return ((_ProtocolTrampoline_6)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGPoint  (^_ProtocolTrampoline_7)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _1653r2v_protocolTrampoline_1hsw88y(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_7)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGRect  (^_ProtocolTrampoline_8)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _1653r2v_protocolTrampoline_1c3uc0w(id target, void * sel) {
  return ((_ProtocolTrampoline_8)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGRect  (^_ProtocolTrampoline_9)(void * sel, id arg1, id arg2, id arg3, struct CGRect arg4, struct CGPoint arg5);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _1653r2v_protocolTrampoline_1ravc6k(id target, void * sel, id arg1, id arg2, id arg3, struct CGRect arg4, struct CGPoint arg5) {
  return ((_ProtocolTrampoline_9)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef struct CGRect  (^_ProtocolTrampoline_10)(void * sel, id arg1, unsigned long arg2, id arg3, struct CGRect arg4, struct CGPoint arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _1653r2v_protocolTrampoline_dunsuy(id target, void * sel, id arg1, unsigned long arg2, id arg3, struct CGRect arg4, struct CGPoint arg5, unsigned long arg6) {
  return ((_ProtocolTrampoline_10)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef struct CGRect  (^_ProtocolTrampoline_11)(void * sel, id arg1, struct CGRect arg2, struct CGPoint arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _1653r2v_protocolTrampoline_iqdvkd(id target, void * sel, id arg1, struct CGRect arg2, struct CGPoint arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_11)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef struct CGRect  (^_ProtocolTrampoline_12)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _1653r2v_protocolTrampoline_szn7s6(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_12)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGSize  (^_ProtocolTrampoline_13)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _1653r2v_protocolTrampoline_1j20mp(id target, void * sel) {
  return ((_ProtocolTrampoline_13)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGSize  (^_ProtocolTrampoline_14)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _1653r2v_protocolTrampoline_xmxmuf(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_14)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_15)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_xr62hr(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_15)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef int  (^_ProtocolTrampoline_16)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
int  _1653r2v_protocolTrampoline_1l0nlq(id target, void * sel) {
  return ((_ProtocolTrampoline_16)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct __CVBuffer *  (^_ProtocolTrampoline_17)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct __CVBuffer *  _1653r2v_protocolTrampoline_vfhx8p(id target, void * sel) {
  return ((_ProtocolTrampoline_17)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct __IOSurface *  (^_ProtocolTrampoline_18)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct __IOSurface *  _1653r2v_protocolTrampoline_tg5r79(id target, void * sel) {
  return ((_ProtocolTrampoline_18)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_19)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_zi5eed(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_19)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef NSComparisonResult  (^_ProtocolTrampoline_20)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSComparisonResult  _1653r2v_protocolTrampoline_1xws32k(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_20)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef NSControlCharacterAction  (^_ProtocolTrampoline_21)(void * sel, id arg1, NSControlCharacterAction arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
NSControlCharacterAction  _1653r2v_protocolTrampoline_505ew6(id target, void * sel, id arg1, NSControlCharacterAction arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_21)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_22)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_1yw2rcr(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_22)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_23)(void * sel, struct objc_selector * arg1, NSCalculationError arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_738w24(id target, void * sel, struct objc_selector * arg1, NSCalculationError arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_23)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_24)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_qfyidt(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_24)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef struct NSDirectionalEdgeInsets  (^_ProtocolTrampoline_25)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct NSDirectionalEdgeInsets  _1653r2v_protocolTrampoline_1qyypoa(id target, void * sel) {
  return ((_ProtocolTrampoline_25)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSFileProviderContentPolicy  (^_ProtocolTrampoline_26)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSFileProviderContentPolicy  _1653r2v_protocolTrampoline_vvhs3w(id target, void * sel) {
  return ((_ProtocolTrampoline_26)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSFileProviderFileSystemFlags  (^_ProtocolTrampoline_27)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSFileProviderFileSystemFlags  _1653r2v_protocolTrampoline_d7559n(id target, void * sel) {
  return ((_ProtocolTrampoline_27)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSFileProviderItemCapabilities  (^_ProtocolTrampoline_28)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSFileProviderItemCapabilities  _1653r2v_protocolTrampoline_jw04t4(id target, void * sel) {
  return ((_ProtocolTrampoline_28)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct NSFileProviderTypeAndCreator  (^_ProtocolTrampoline_29)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct NSFileProviderTypeAndCreator  _1653r2v_protocolTrampoline_f76iul(id target, void * sel) {
  return ((_ProtocolTrampoline_29)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef long  (^_ProtocolTrampoline_30)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
long  _1653r2v_protocolTrampoline_fai2e9(id target, void * sel) {
  return ((_ProtocolTrampoline_30)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef long  (^_ProtocolTrampoline_31)(void * sel, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
long  _1653r2v_protocolTrampoline_1p78ubn(id target, void * sel, long arg1) {
  return ((_ProtocolTrampoline_31)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef long  (^_ProtocolTrampoline_32)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
long  _1653r2v_protocolTrampoline_sqbvvb(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_32)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef long  (^_ProtocolTrampoline_33)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
long  _1653r2v_protocolTrampoline_evw03x(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_33)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef NSRoundingMode  (^_ProtocolTrampoline_34)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSRoundingMode  _1653r2v_protocolTrampoline_5cb1bj(id target, void * sel) {
  return ((_ProtocolTrampoline_34)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSTextLayoutOrientation  (^_ProtocolTrampoline_35)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSTextLayoutOrientation  _1653r2v_protocolTrampoline_1hcgfk1(id target, void * sel) {
  return ((_ProtocolTrampoline_35)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_36)(void * sel, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_ggvik5(id target, void * sel, id arg1, struct _NSRange arg2) {
  return ((_ProtocolTrampoline_36)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_37)(void * sel, struct CGPoint arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_1cizpv0(id target, void * sel, struct CGPoint arg1, id arg2) {
  return ((_ProtocolTrampoline_37)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_38)(void * sel, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_1u4xn97(id target, void * sel, id arg1, BOOL arg2) {
  return ((_ProtocolTrampoline_38)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_39)(void * sel, NSTextSelectionGranularity arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_1msw0hl(id target, void * sel, NSTextSelectionGranularity arg1, id arg2) {
  return ((_ProtocolTrampoline_39)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef NSTextSelectionNavigationLayoutOrientation  (^_ProtocolTrampoline_40)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSTextSelectionNavigationLayoutOrientation  _1653r2v_protocolTrampoline_1kcz7dl(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_40)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef NSTextSelectionNavigationWritingDirection  (^_ProtocolTrampoline_41)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSTextSelectionNavigationWritingDirection  _1653r2v_protocolTrampoline_1kewuno(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_41)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef unsigned long  (^_ProtocolTrampoline_42)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _1653r2v_protocolTrampoline_1ckyi24(id target, void * sel) {
  return ((_ProtocolTrampoline_42)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef unsigned long  (^_ProtocolTrampoline_43)(void * sel, id arg1, unsigned short * arg2, NSGlyphProperty * arg3, unsigned long * arg4, id arg5, struct _NSRange arg6);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _1653r2v_protocolTrampoline_1njk2hu(id target, void * sel, id arg1, unsigned short * arg2, NSGlyphProperty * arg3, unsigned long * arg4, id arg5, struct _NSRange arg6) {
  return ((_ProtocolTrampoline_43)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef struct UIEdgeInsets  (^_ProtocolTrampoline_44)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct UIEdgeInsets  _1653r2v_protocolTrampoline_1rtilx3(id target, void * sel) {
  return ((_ProtocolTrampoline_44)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_45)(void * sel, struct CGRect arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_1a7e3u0(id target, void * sel, struct CGRect arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_45)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_46)(void * sel, struct CGRect arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_qwb72h(id target, void * sel, struct CGRect arg1, id arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_46)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef unsigned long  (^_ProtocolTrampoline_47)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _1653r2v_protocolTrampoline_18rn8gi(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_47)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef UILetterformAwareSizingRule  (^_ProtocolTrampoline_48)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UILetterformAwareSizingRule  _1653r2v_protocolTrampoline_o2xzcr(id target, void * sel) {
  return ((_ProtocolTrampoline_48)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIPageViewControllerSpineLocation  (^_ProtocolTrampoline_49)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
UIPageViewControllerSpineLocation  _1653r2v_protocolTrampoline_1o377kd(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_49)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UISpringLoadedInteractionEffectState  (^_ProtocolTrampoline_50)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UISpringLoadedInteractionEffectState  _1653r2v_protocolTrampoline_7dyt8b(id target, void * sel) {
  return ((_ProtocolTrampoline_50)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_51)(void * sel, id arg1, struct CGPoint arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_uah4a0(id target, void * sel, id arg1, struct CGPoint arg2) {
  return ((_ProtocolTrampoline_51)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_52)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_1xvw1tx(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_52)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef uint64_t  (^_ProtocolTrampoline_53)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
uint64_t  _1653r2v_protocolTrampoline_k3xjiw(id target, void * sel) {
  return ((_ProtocolTrampoline_53)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_54)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1653r2v_protocolTrampoline_e3qsqz(id target, void * sel) {
  return ((_ProtocolTrampoline_54)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_55)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1653r2v_protocolTrampoline_jk8du5(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_55)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_56)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1653r2v_protocolTrampoline_1em3l8z(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_56)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_57)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1653r2v_protocolTrampoline_2n06mv(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_57)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_58)(void * sel, id arg1, struct CGRect * arg2, struct CGRect * arg3, double * arg4, id arg5, struct _NSRange arg6);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1653r2v_protocolTrampoline_1p38w4s(id target, void * sel, id arg1, struct CGRect * arg2, struct CGRect * arg3, double * arg4, id arg5, struct _NSRange arg6) {
  return ((_ProtocolTrampoline_58)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef BOOL  (^_ProtocolTrampoline_59)(void * sel, id arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1653r2v_protocolTrampoline_16fgsa(id target, void * sel, id arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_59)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_60)(void * sel, id arg1, id arg2, NSTextContentManagerEnumerationOptions arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1653r2v_protocolTrampoline_r3hakm(id target, void * sel, id arg1, id arg2, NSTextContentManagerEnumerationOptions arg3) {
  return ((_ProtocolTrampoline_60)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_61)(void * sel, id arg1, id arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1653r2v_protocolTrampoline_t3vpwz(id target, void * sel, id arg1, id arg2, BOOL arg3) {
  return ((_ProtocolTrampoline_61)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_62)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1653r2v_protocolTrampoline_3su7tt(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_62)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_63)(void * sel, id arg1, id arg2, UIWebViewNavigationType arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _1653r2v_protocolTrampoline_162dnig(id target, void * sel, id arg1, id arg2, UIWebViewNavigationType arg3) {
  return ((_ProtocolTrampoline_63)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef double  (^_ProtocolTrampoline_64)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
double  _1653r2v_protocolTrampoline_tfvuzk(id target, void * sel) {
  return ((_ProtocolTrampoline_64)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef float  (^_ProtocolTrampoline_65)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
float  _1653r2v_protocolTrampoline_66c10j(id target, void * sel) {
  return ((_ProtocolTrampoline_65)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef short  (^_ProtocolTrampoline_66)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
short  _1653r2v_protocolTrampoline_p984hf(id target, void * sel) {
  return ((_ProtocolTrampoline_66)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef size_t  (^_ProtocolTrampoline_67)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
size_t  _1653r2v_protocolTrampoline_150qdkd(id target, void * sel) {
  return ((_ProtocolTrampoline_67)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline)(void);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _1653r2v_wrapListenerBlock_1pl9qdv(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void() {
    objc_retainBlock(block);
    block();
  };
}

typedef void  (^_BlockingTrampoline)(void * waiter);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _1653r2v_wrapBlockingBlock_1pl9qdv(
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

typedef void  (^_ListenerTrampoline_1)(id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _1653r2v_wrapListenerBlock_xtuoz7(_ListenerTrampoline_1 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0));
  };
}

typedef void  (^_BlockingTrampoline_1)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _1653r2v_wrapBlockingBlock_xtuoz7(
    _BlockingTrampoline_1 block, _BlockingTrampoline_1 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0));
  });
}

typedef void  (^_ListenerTrampoline_2)(double arg0, id arg1, BOOL arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _1653r2v_wrapListenerBlock_o4flre(_ListenerTrampoline_2 block) NS_RETURNS_RETAINED {
  return ^void(double arg0, id arg1, BOOL arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_2)(void * waiter, double arg0, id arg1, BOOL arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _1653r2v_wrapBlockingBlock_o4flre(
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

typedef void  (^_ListenerTrampoline_3)(struct CGRect arg0, struct CGRect arg1, id arg2, struct _NSRange arg3, BOOL * arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _1653r2v_wrapListenerBlock_1k4qrah(_ListenerTrampoline_3 block) NS_RETURNS_RETAINED {
  return ^void(struct CGRect arg0, struct CGRect arg1, id arg2, struct _NSRange arg3, BOOL * arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_3)(void * waiter, struct CGRect arg0, struct CGRect arg1, id arg2, struct _NSRange arg3, BOOL * arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _1653r2v_wrapBlockingBlock_1k4qrah(
    _BlockingTrampoline_3 block, _BlockingTrampoline_3 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(struct CGRect arg0, struct CGRect arg1, id arg2, struct _NSRange arg3, BOOL * arg4), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  });
}

typedef void  (^_ListenerTrampoline_4)(struct CGRect arg0, BOOL * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _1653r2v_wrapListenerBlock_aoc6k0(_ListenerTrampoline_4 block) NS_RETURNS_RETAINED {
  return ^void(struct CGRect arg0, BOOL * arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_4)(void * waiter, struct CGRect arg0, BOOL * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _1653r2v_wrapBlockingBlock_aoc6k0(
    _BlockingTrampoline_4 block, _BlockingTrampoline_4 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(struct CGRect arg0, BOOL * arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ListenerTrampoline_5)(id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _1653r2v_wrapListenerBlock_r8gdi7(_ListenerTrampoline_5 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_5)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _1653r2v_wrapBlockingBlock_r8gdi7(
    _BlockingTrampoline_5 block, _BlockingTrampoline_5 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ListenerTrampoline_6)(id arg0, struct CGPoint arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _1653r2v_wrapListenerBlock_14v8ia(_ListenerTrampoline_6 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct CGPoint arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_6)(void * waiter, id arg0, struct CGPoint arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _1653r2v_wrapBlockingBlock_14v8ia(
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

typedef void  (^_ListenerTrampoline_7)(id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _1653r2v_wrapListenerBlock_pfv6jd(_ListenerTrampoline_7 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_7)(void * waiter, id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _1653r2v_wrapBlockingBlock_pfv6jd(
    _BlockingTrampoline_7 block, _BlockingTrampoline_7 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_8)(id arg0, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _1653r2v_wrapListenerBlock_rnu2c5(_ListenerTrampoline_8 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_8)(void * waiter, id arg0, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _1653r2v_wrapBlockingBlock_rnu2c5(
    _BlockingTrampoline_8 block, _BlockingTrampoline_8 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ListenerTrampoline_9)(id arg0, BOOL arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _1653r2v_wrapListenerBlock_1uqbrux(_ListenerTrampoline_9 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_9)(void * waiter, id arg0, BOOL arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _1653r2v_wrapBlockingBlock_1uqbrux(
    _BlockingTrampoline_9 block, _BlockingTrampoline_9 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL arg1, BOOL * arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef void  (^_ListenerTrampoline_10)(id arg0, struct _NSRange arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _1653r2v_wrapListenerBlock_1a22wz(_ListenerTrampoline_10 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_10)(void * waiter, id arg0, struct _NSRange arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _1653r2v_wrapBlockingBlock_1a22wz(
    _BlockingTrampoline_10 block, _BlockingTrampoline_10 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, struct _NSRange arg1, BOOL * arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef void  (^_ListenerTrampoline_11)(id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _1653r2v_wrapListenerBlock_1b3bb6a(_ListenerTrampoline_11 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(objc_retainBlock(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_11)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _1653r2v_wrapBlockingBlock_1b3bb6a(
    _BlockingTrampoline_11 block, _BlockingTrampoline_11 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, objc_retainBlock(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, objc_retainBlock(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ListenerTrampoline_12)(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _1653r2v_wrapListenerBlock_lmc3p5(_ListenerTrampoline_12 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_12)(void * waiter, id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _1653r2v_wrapBlockingBlock_lmc3p5(
    _BlockingTrampoline_12 block, _BlockingTrampoline_12 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  });
}

typedef void  (^_ListenerTrampoline_13)(id arg0, id arg1, id arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _1653r2v_wrapListenerBlock_fo7rrt(_ListenerTrampoline_13 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_13)(void * waiter, id arg0, id arg1, id arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _1653r2v_wrapBlockingBlock_fo7rrt(
    _BlockingTrampoline_13 block, _BlockingTrampoline_13 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, id arg2, BOOL * arg3), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ListenerTrampoline_14)(id arg0, NSMatchingFlags arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _1653r2v_wrapListenerBlock_6jvo9y(_ListenerTrampoline_14 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, NSMatchingFlags arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_14)(void * waiter, id arg0, NSMatchingFlags arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _1653r2v_wrapBlockingBlock_6jvo9y(
    _BlockingTrampoline_14 block, _BlockingTrampoline_14 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, NSMatchingFlags arg1, BOOL * arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef void  (^_ListenerTrampoline_15)(NSURLSessionAuthChallengeDisposition arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _1653r2v_wrapListenerBlock_n8yd09(_ListenerTrampoline_15 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionAuthChallengeDisposition arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_15)(void * waiter, NSURLSessionAuthChallengeDisposition arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _1653r2v_wrapBlockingBlock_n8yd09(
    _BlockingTrampoline_15 block, _BlockingTrampoline_15 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(NSURLSessionAuthChallengeDisposition arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_16)(NSURLSessionDelayedRequestDisposition arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _1653r2v_wrapListenerBlock_1otpo83(_ListenerTrampoline_16 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionDelayedRequestDisposition arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_16)(void * waiter, NSURLSessionDelayedRequestDisposition arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _1653r2v_wrapBlockingBlock_1otpo83(
    _BlockingTrampoline_16 block, _BlockingTrampoline_16 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(NSURLSessionDelayedRequestDisposition arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_17)(NSURLSessionResponseDisposition arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _1653r2v_wrapListenerBlock_16sve1d(_ListenerTrampoline_17 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionResponseDisposition arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_17)(void * waiter, NSURLSessionResponseDisposition arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _1653r2v_wrapBlockingBlock_16sve1d(
    _BlockingTrampoline_17 block, _BlockingTrampoline_17 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(NSURLSessionResponseDisposition arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_18)(id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _1653r2v_wrapListenerBlock_o762yo(_ListenerTrampoline_18 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), objc_retainBlock(arg1));
  };
}

typedef void  (^_BlockingTrampoline_18)(void * waiter, id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _1653r2v_wrapBlockingBlock_o762yo(
    _BlockingTrampoline_18 block, _BlockingTrampoline_18 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), objc_retainBlock(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), objc_retainBlock(arg1));
  });
}

typedef void  (^_ListenerTrampoline_19)(id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_19 _1653r2v_wrapListenerBlock_18qun1e(_ListenerTrampoline_19 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  };
}

typedef void  (^_BlockingTrampoline_19)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_19 _1653r2v_wrapBlockingBlock_18qun1e(
    _BlockingTrampoline_19 block, _BlockingTrampoline_19 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  });
}

typedef void  (^_ListenerTrampoline_20)(BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_20 _1653r2v_wrapListenerBlock_1s56lr9(_ListenerTrampoline_20 block) NS_RETURNS_RETAINED {
  return ^void(BOOL arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_20)(void * waiter, BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_20 _1653r2v_wrapBlockingBlock_1s56lr9(
    _BlockingTrampoline_20 block, _BlockingTrampoline_20 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(BOOL arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_21)(void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_21 _1653r2v_wrapListenerBlock_ovsamd(_ListenerTrampoline_21 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_21)(void * waiter, void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_21 _1653r2v_wrapBlockingBlock_ovsamd(
    _BlockingTrampoline_21 block, _BlockingTrampoline_21 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ProtocolTrampoline_68)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_ovsamd(id target, void * sel) {
  return ((_ProtocolTrampoline_68)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_22)(id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_22 _1653r2v_wrapListenerBlock_f167m6(_ListenerTrampoline_22 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block(objc_retainBlock(arg0));
  };
}

typedef void  (^_BlockingTrampoline_22)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_22 _1653r2v_wrapBlockingBlock_f167m6(
    _BlockingTrampoline_22 block, _BlockingTrampoline_22 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0), {
    objc_retainBlock(block);
    block(nil, objc_retainBlock(arg0));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, objc_retainBlock(arg0));
  });
}

typedef void *  (^_ProtocolTrampoline_69)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
void *  _1653r2v_protocolTrampoline_3fl8pv(id target, void * sel) {
  return ((_ProtocolTrampoline_69)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_23)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_23 _1653r2v_wrapListenerBlock_18v1jvf(_ListenerTrampoline_23 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_23)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_23 _1653r2v_wrapBlockingBlock_18v1jvf(
    _BlockingTrampoline_23 block, _BlockingTrampoline_23 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_70)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_18v1jvf(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_70)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_24)(void * arg0, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_24 _1653r2v_wrapListenerBlock_zzthnb(_ListenerTrampoline_24 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, BOOL arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_24)(void * waiter, void * arg0, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_24 _1653r2v_wrapBlockingBlock_zzthnb(
    _BlockingTrampoline_24 block, _BlockingTrampoline_24 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, BOOL arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_71)(void * sel, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_zzthnb(id target, void * sel, id arg1, BOOL arg2) {
  return ((_ProtocolTrampoline_71)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_25)(void * arg0, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_25 _1653r2v_wrapListenerBlock_qvcerx(_ListenerTrampoline_25 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGContext * arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_25)(void * waiter, void * arg0, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_25 _1653r2v_wrapBlockingBlock_qvcerx(
    _BlockingTrampoline_25 block, _BlockingTrampoline_25 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGContext * arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_72)(void * sel, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_qvcerx(id target, void * sel, id arg1, struct CGContext * arg2) {
  return ((_ProtocolTrampoline_72)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_26)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_26 _1653r2v_wrapListenerBlock_fjrv01(_ListenerTrampoline_26 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_26)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_26 _1653r2v_wrapBlockingBlock_fjrv01(
    _BlockingTrampoline_26 block, _BlockingTrampoline_26 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_73)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_fjrv01(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_73)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_27)(void * arg0, struct CATransform3D arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_27 _1653r2v_wrapListenerBlock_12flqkv(_ListenerTrampoline_27 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CATransform3D arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_27)(void * waiter, void * arg0, struct CATransform3D arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_27 _1653r2v_wrapBlockingBlock_12flqkv(
    _BlockingTrampoline_27 block, _BlockingTrampoline_27 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CATransform3D arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_74)(void * sel, struct CATransform3D arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_12flqkv(id target, void * sel, struct CATransform3D arg1) {
  return ((_ProtocolTrampoline_74)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_28)(void * arg0, struct CGAffineTransform arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_28 _1653r2v_wrapListenerBlock_1lznlw3(_ListenerTrampoline_28 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGAffineTransform arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_28)(void * waiter, void * arg0, struct CGAffineTransform arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_28 _1653r2v_wrapBlockingBlock_1lznlw3(
    _BlockingTrampoline_28 block, _BlockingTrampoline_28 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGAffineTransform arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_75)(void * sel, struct CGAffineTransform arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_1lznlw3(id target, void * sel, struct CGAffineTransform arg1) {
  return ((_ProtocolTrampoline_75)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_29)(void * arg0, double arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_29 _1653r2v_wrapListenerBlock_1g6ud1c(_ListenerTrampoline_29 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, double arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_29)(void * waiter, void * arg0, double arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_29 _1653r2v_wrapBlockingBlock_1g6ud1c(
    _BlockingTrampoline_29 block, _BlockingTrampoline_29 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, double arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_76)(void * sel, double arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_1g6ud1c(id target, void * sel, double arg1, id arg2) {
  return ((_ProtocolTrampoline_76)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_30)(void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_30 _1653r2v_wrapListenerBlock_1bktu2(_ListenerTrampoline_30 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGPoint arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_30)(void * waiter, void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_30 _1653r2v_wrapBlockingBlock_1bktu2(
    _BlockingTrampoline_30 block, _BlockingTrampoline_30 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGPoint arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_77)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_1bktu2(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_77)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_31)(void * arg0, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_31 _1653r2v_wrapListenerBlock_unr2j3(_ListenerTrampoline_31 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, long arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_31)(void * waiter, void * arg0, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_31 _1653r2v_wrapBlockingBlock_unr2j3(
    _BlockingTrampoline_31 block, _BlockingTrampoline_31 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, long arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_78)(void * sel, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_unr2j3(id target, void * sel, long arg1) {
  return ((_ProtocolTrampoline_78)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_32)(void * arg0, long arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_32 _1653r2v_wrapListenerBlock_1453bv9(_ListenerTrampoline_32 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, long arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_32)(void * waiter, void * arg0, long arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_32 _1653r2v_wrapBlockingBlock_1453bv9(
    _BlockingTrampoline_32 block, _BlockingTrampoline_32 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, long arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_79)(void * sel, long arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_1453bv9(id target, void * sel, long arg1, id arg2) {
  return ((_ProtocolTrampoline_79)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_33)(void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_33 _1653r2v_wrapListenerBlock_1tz5yf(_ListenerTrampoline_33 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_33)(void * waiter, void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_33 _1653r2v_wrapBlockingBlock_1tz5yf(
    _BlockingTrampoline_33 block, _BlockingTrampoline_33 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_80)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_1tz5yf(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_80)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_34)(void * arg0, id arg1, id arg2, struct CGSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_34 _1653r2v_wrapListenerBlock_13mvetb(_ListenerTrampoline_34 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct CGSize arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_34)(void * waiter, void * arg0, id arg1, id arg2, struct CGSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_34 _1653r2v_wrapBlockingBlock_13mvetb(
    _BlockingTrampoline_34 block, _BlockingTrampoline_34 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct CGSize arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_81)(void * sel, id arg1, id arg2, struct CGSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_13mvetb(id target, void * sel, id arg1, id arg2, struct CGSize arg3) {
  return ((_ProtocolTrampoline_81)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_35)(void * arg0, id arg1, id arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_35 _1653r2v_wrapListenerBlock_8acz2h(_ListenerTrampoline_35 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, BOOL arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_35)(void * waiter, void * arg0, id arg1, id arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_35 _1653r2v_wrapBlockingBlock_8acz2h(
    _BlockingTrampoline_35 block, _BlockingTrampoline_35 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, BOOL arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_82)(void * sel, id arg1, id arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_8acz2h(id target, void * sel, id arg1, id arg2, BOOL arg3) {
  return ((_ProtocolTrampoline_82)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_36)(void * arg0, id arg1, UIGuidedAccessRestrictionState arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_36 _1653r2v_wrapListenerBlock_vrkvde(_ListenerTrampoline_36 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UIGuidedAccessRestrictionState arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_36)(void * waiter, void * arg0, id arg1, UIGuidedAccessRestrictionState arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_36 _1653r2v_wrapBlockingBlock_vrkvde(
    _BlockingTrampoline_36 block, _BlockingTrampoline_36 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UIGuidedAccessRestrictionState arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_83)(void * sel, id arg1, UIGuidedAccessRestrictionState arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_vrkvde(id target, void * sel, id arg1, UIGuidedAccessRestrictionState arg2) {
  return ((_ProtocolTrampoline_83)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_37)(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_37 _1653r2v_wrapListenerBlock_19w094r(_ListenerTrampoline_37 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_37)(void * waiter, void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_37 _1653r2v_wrapBlockingBlock_19w094r(
    _BlockingTrampoline_37 block, _BlockingTrampoline_37 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_84)(void * sel, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_19w094r(id target, void * sel, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4) {
  return ((_ProtocolTrampoline_84)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_38)(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_38 _1653r2v_wrapListenerBlock_1ucjyxt(_ListenerTrampoline_38 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5);
  };
}

typedef void  (^_BlockingTrampoline_38)(void * waiter, void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_38 _1653r2v_wrapBlockingBlock_1ucjyxt(
    _BlockingTrampoline_38 block, _BlockingTrampoline_38 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5);
  });
}

typedef void  (^_ProtocolTrampoline_85)(void * sel, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_1ucjyxt(id target, void * sel, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5) {
  return ((_ProtocolTrampoline_85)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_39)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_39 _1653r2v_wrapListenerBlock_jk1ljc(_ListenerTrampoline_39 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  };
}

typedef void  (^_BlockingTrampoline_39)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_39 _1653r2v_wrapBlockingBlock_jk1ljc(
    _BlockingTrampoline_39 block, _BlockingTrampoline_39 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_86)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_jk1ljc(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_86)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_40)(void * arg0, id arg1, long arg2, long arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_40 _1653r2v_wrapListenerBlock_15e9dqx(_ListenerTrampoline_40 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long arg2, long arg3, long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_40)(void * waiter, void * arg0, id arg1, long arg2, long arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_40 _1653r2v_wrapBlockingBlock_15e9dqx(
    _BlockingTrampoline_40 block, _BlockingTrampoline_40 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long arg2, long arg3, long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_87)(void * sel, id arg1, long arg2, long arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_15e9dqx(id target, void * sel, id arg1, long arg2, long arg3, long arg4) {
  return ((_ProtocolTrampoline_87)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_41)(void * arg0, id arg1, long long arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_41 _1653r2v_wrapListenerBlock_9crvvv(_ListenerTrampoline_41 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long long arg2, long long arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_41)(void * waiter, void * arg0, id arg1, long long arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_41 _1653r2v_wrapBlockingBlock_9crvvv(
    _BlockingTrampoline_41 block, _BlockingTrampoline_41 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long long arg2, long long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_88)(void * sel, id arg1, long long arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_9crvvv(id target, void * sel, id arg1, long long arg2, long long arg3) {
  return ((_ProtocolTrampoline_88)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_42)(void * arg0, id arg1, long long arg2, long long arg3, long long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_42 _1653r2v_wrapListenerBlock_1qf1qkl(_ListenerTrampoline_42 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long long arg2, long long arg3, long long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_42)(void * waiter, void * arg0, id arg1, long long arg2, long long arg3, long long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_42 _1653r2v_wrapBlockingBlock_1qf1qkl(
    _BlockingTrampoline_42 block, _BlockingTrampoline_42 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long long arg2, long long arg3, long long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_89)(void * sel, id arg1, long long arg2, long long arg3, long long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_1qf1qkl(id target, void * sel, id arg1, long long arg2, long long arg3, long long arg4) {
  return ((_ProtocolTrampoline_89)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_43)(void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_43 _1653r2v_wrapListenerBlock_1j7coyk(_ListenerTrampoline_43 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_43)(void * waiter, void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_43 _1653r2v_wrapBlockingBlock_1j7coyk(
    _BlockingTrampoline_43 block, _BlockingTrampoline_43 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_90)(void * sel, id arg1, id arg2, NSURLCacheStoragePolicy arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_1j7coyk(id target, void * sel, id arg1, id arg2, NSURLCacheStoragePolicy arg3) {
  return ((_ProtocolTrampoline_90)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_44)(void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_44 _1653r2v_wrapListenerBlock_bklti2(_ListenerTrampoline_44 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_44)(void * waiter, void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_44 _1653r2v_wrapBlockingBlock_bklti2(
    _BlockingTrampoline_44 block, _BlockingTrampoline_44 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_91)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_bklti2(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_91)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_45)(void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_45 _1653r2v_wrapListenerBlock_xx612k(_ListenerTrampoline_45 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  };
}

typedef void  (^_BlockingTrampoline_45)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_45 _1653r2v_wrapBlockingBlock_xx612k(
    _BlockingTrampoline_45 block, _BlockingTrampoline_45 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_92)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_xx612k(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_92)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_46)(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_46 _1653r2v_wrapListenerBlock_ly2579(_ListenerTrampoline_46 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_46)(void * waiter, void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_46 _1653r2v_wrapBlockingBlock_ly2579(
    _BlockingTrampoline_46 block, _BlockingTrampoline_46 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_93)(void * sel, id arg1, id arg2, int64_t arg3, int64_t arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_ly2579(id target, void * sel, id arg1, id arg2, int64_t arg3, int64_t arg4) {
  return ((_ProtocolTrampoline_93)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_47)(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_47 _1653r2v_wrapListenerBlock_h68abb(_ListenerTrampoline_47 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4, arg5);
  };
}

typedef void  (^_BlockingTrampoline_47)(void * waiter, void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_47 _1653r2v_wrapBlockingBlock_h68abb(
    _BlockingTrampoline_47 block, _BlockingTrampoline_47 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4, arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4, arg5);
  });
}

typedef void  (^_ProtocolTrampoline_94)(void * sel, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_h68abb(id target, void * sel, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5) {
  return ((_ProtocolTrampoline_94)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_48)(void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_48 _1653r2v_wrapListenerBlock_8jfq1p(_ListenerTrampoline_48 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_48)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_48 _1653r2v_wrapBlockingBlock_8jfq1p(
    _BlockingTrampoline_48 block, _BlockingTrampoline_48 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_95)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_8jfq1p(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_95)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_49)(void * arg0, id arg1, id arg2, int64_t arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_49 _1653r2v_wrapListenerBlock_jyim80(_ListenerTrampoline_49 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, int64_t arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, objc_retainBlock(arg4));
  };
}

typedef void  (^_BlockingTrampoline_49)(void * waiter, void * arg0, id arg1, id arg2, int64_t arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_49 _1653r2v_wrapBlockingBlock_jyim80(
    _BlockingTrampoline_49 block, _BlockingTrampoline_49 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, int64_t arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, objc_retainBlock(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, objc_retainBlock(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_96)(void * sel, id arg1, id arg2, int64_t arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_jyim80(id target, void * sel, id arg1, id arg2, int64_t arg3, id arg4) {
  return ((_ProtocolTrampoline_96)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_50)(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_50 _1653r2v_wrapListenerBlock_l2g8ke(_ListenerTrampoline_50 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  };
}

typedef void  (^_BlockingTrampoline_50)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_50 _1653r2v_wrapBlockingBlock_l2g8ke(
    _BlockingTrampoline_50 block, _BlockingTrampoline_50 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  });
}

typedef void  (^_ProtocolTrampoline_97)(void * sel, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_l2g8ke(id target, void * sel, id arg1, id arg2, id arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_97)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_51)(void * arg0, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_51 _1653r2v_wrapListenerBlock_1lx650f(_ListenerTrampoline_51 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_51)(void * waiter, void * arg0, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_51 _1653r2v_wrapBlockingBlock_1lx650f(
    _BlockingTrampoline_51 block, _BlockingTrampoline_51 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_98)(void * sel, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_1lx650f(id target, void * sel, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4) {
  return ((_ProtocolTrampoline_98)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_52)(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_52 _1653r2v_wrapListenerBlock_m09tr7(_ListenerTrampoline_52 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  };
}

typedef void  (^_BlockingTrampoline_52)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_52 _1653r2v_wrapBlockingBlock_m09tr7(
    _BlockingTrampoline_52 block, _BlockingTrampoline_52 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  });
}

typedef void  (^_ProtocolTrampoline_99)(void * sel, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_m09tr7(id target, void * sel, id arg1, id arg2, id arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_99)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_53)(void * arg0, id arg1, id arg2, id arg3, struct CGPoint arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_53 _1653r2v_wrapListenerBlock_13vf580(_ListenerTrampoline_53 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, struct CGPoint arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4);
  };
}

typedef void  (^_BlockingTrampoline_53)(void * waiter, void * arg0, id arg1, id arg2, id arg3, struct CGPoint arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_53 _1653r2v_wrapBlockingBlock_13vf580(
    _BlockingTrampoline_53 block, _BlockingTrampoline_53 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, struct CGPoint arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4);
  });
}

typedef void  (^_ProtocolTrampoline_100)(void * sel, id arg1, id arg2, id arg3, struct CGPoint arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_13vf580(id target, void * sel, id arg1, id arg2, id arg3, struct CGPoint arg4) {
  return ((_ProtocolTrampoline_100)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_54)(void * arg0, id arg1, id arg2, struct CGPoint arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_54 _1653r2v_wrapListenerBlock_4w8ame(_ListenerTrampoline_54 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct CGPoint arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_54)(void * waiter, void * arg0, id arg1, id arg2, struct CGPoint arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_54 _1653r2v_wrapBlockingBlock_4w8ame(
    _BlockingTrampoline_54 block, _BlockingTrampoline_54 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct CGPoint arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_101)(void * sel, id arg1, id arg2, struct CGPoint arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_4w8ame(id target, void * sel, id arg1, id arg2, struct CGPoint arg3) {
  return ((_ProtocolTrampoline_101)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_55)(void * arg0, UILetterformAwareSizingRule arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_55 _1653r2v_wrapListenerBlock_1k3rxc1(_ListenerTrampoline_55 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UILetterformAwareSizingRule arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_55)(void * waiter, void * arg0, UILetterformAwareSizingRule arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_55 _1653r2v_wrapBlockingBlock_1k3rxc1(
    _BlockingTrampoline_55 block, _BlockingTrampoline_55 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UILetterformAwareSizingRule arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_102)(void * sel, UILetterformAwareSizingRule arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_1k3rxc1(id target, void * sel, UILetterformAwareSizingRule arg1) {
  return ((_ProtocolTrampoline_102)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_56)(void * arg0, id arg1, BOOL arg2, id arg3, BOOL arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_56 _1653r2v_wrapListenerBlock_hcu3ph(_ListenerTrampoline_56 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, BOOL arg2, id arg3, BOOL arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  };
}

typedef void  (^_BlockingTrampoline_56)(void * waiter, void * arg0, id arg1, BOOL arg2, id arg3, BOOL arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_56 _1653r2v_wrapBlockingBlock_hcu3ph(
    _BlockingTrampoline_56 block, _BlockingTrampoline_56 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, BOOL arg2, id arg3, BOOL arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  });
}

typedef void  (^_ProtocolTrampoline_103)(void * sel, id arg1, BOOL arg2, id arg3, BOOL arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_hcu3ph(id target, void * sel, id arg1, BOOL arg2, id arg3, BOOL arg4) {
  return ((_ProtocolTrampoline_103)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_57)(void * arg0, id arg1, long arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_57 _1653r2v_wrapListenerBlock_1wo7l1b(_ListenerTrampoline_57 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_57)(void * waiter, void * arg0, id arg1, long arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_57 _1653r2v_wrapBlockingBlock_1wo7l1b(
    _BlockingTrampoline_57 block, _BlockingTrampoline_57 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_104)(void * sel, id arg1, long arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_1wo7l1b(id target, void * sel, id arg1, long arg2, id arg3) {
  return ((_ProtocolTrampoline_104)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_58)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_58 _1653r2v_wrapListenerBlock_1l4hxwm(_ListenerTrampoline_58 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retainBlock(arg1));
  };
}

typedef void  (^_BlockingTrampoline_58)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_58 _1653r2v_wrapBlockingBlock_1l4hxwm(
    _BlockingTrampoline_58 block, _BlockingTrampoline_58 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, objc_retainBlock(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, objc_retainBlock(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_105)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_1l4hxwm(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_105)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_59)(void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_59 _1653r2v_wrapListenerBlock_10lndml(_ListenerTrampoline_59 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_59)(void * waiter, void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_59 _1653r2v_wrapBlockingBlock_10lndml(
    _BlockingTrampoline_59 block, _BlockingTrampoline_59 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, BOOL arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_106)(void * sel, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_10lndml(id target, void * sel, BOOL arg1) {
  return ((_ProtocolTrampoline_106)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_60)(void * arg0, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_60 _1653r2v_wrapListenerBlock_18sfmo2(_ListenerTrampoline_60 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, double arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_60)(void * waiter, void * arg0, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_60 _1653r2v_wrapBlockingBlock_18sfmo2(
    _BlockingTrampoline_60 block, _BlockingTrampoline_60 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, double arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_107)(void * sel, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_18sfmo2(id target, void * sel, double arg1) {
  return ((_ProtocolTrampoline_107)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_61)(void * arg0, float arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_61 _1653r2v_wrapListenerBlock_1fcaigd(_ListenerTrampoline_61 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, float arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_61)(void * waiter, void * arg0, float arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_61 _1653r2v_wrapBlockingBlock_1fcaigd(
    _BlockingTrampoline_61 block, _BlockingTrampoline_61 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, float arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_108)(void * sel, float arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_1fcaigd(id target, void * sel, float arg1) {
  return ((_ProtocolTrampoline_108)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_62)(void * arg0, void * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_62 _1653r2v_wrapListenerBlock_1037nh9(_ListenerTrampoline_62 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, void * arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_62)(void * waiter, void * arg0, void * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_62 _1653r2v_wrapBlockingBlock_1037nh9(
    _BlockingTrampoline_62 block, _BlockingTrampoline_62 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, void * arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_109)(void * sel, void * arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _1653r2v_protocolTrampoline_1037nh9(id target, void * sel, void * arg1) {
  return ((_ProtocolTrampoline_109)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_63)(void * arg0, id arg1, NSStringEnumerationOptions arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_63 _1653r2v_wrapListenerBlock_7dzmi7(_ListenerTrampoline_63 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, NSStringEnumerationOptions arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_63)(void * waiter, void * arg0, id arg1, NSStringEnumerationOptions arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_63 _1653r2v_wrapBlockingBlock_7dzmi7(
    _BlockingTrampoline_63 block, _BlockingTrampoline_63 listenerBlock,
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
void  _1653r2v_protocolTrampoline_7dzmi7(id target, void * sel, id arg1, NSStringEnumerationOptions arg2, id arg3) {
  return ((_ProtocolTrampoline_110)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_64)(void * arg0, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_64 _1653r2v_wrapListenerBlock_18jmq2k(_ListenerTrampoline_64 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, BOOL arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_64)(void * waiter, void * arg0, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_64 _1653r2v_wrapBlockingBlock_18jmq2k(
    _BlockingTrampoline_64 block, _BlockingTrampoline_64 listenerBlock,
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
void  _1653r2v_protocolTrampoline_18jmq2k(id target, void * sel, id arg1, BOOL arg2, id arg3) {
  return ((_ProtocolTrampoline_111)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_65)(id arg0, BOOL * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_65 _1653r2v_wrapListenerBlock_t8l8el(_ListenerTrampoline_65 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL * arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1);
  };
}

typedef void  (^_BlockingTrampoline_65)(void * waiter, id arg0, BOOL * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_65 _1653r2v_wrapBlockingBlock_t8l8el(
    _BlockingTrampoline_65 block, _BlockingTrampoline_65 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL * arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  });
}

typedef void  (^_ListenerTrampoline_66)(id arg0, unsigned long arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_66 _1653r2v_wrapListenerBlock_1p9ui4q(_ListenerTrampoline_66 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, unsigned long arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_66)(void * waiter, id arg0, unsigned long arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_66 _1653r2v_wrapBlockingBlock_1p9ui4q(
    _BlockingTrampoline_66 block, _BlockingTrampoline_66 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, unsigned long arg1, BOOL * arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef id  (^_ProtocolTrampoline_112)(void * sel, id arg1, NSTextContentManagerEnumerationOptions arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_1dxsa0d(id target, void * sel, id arg1, NSTextContentManagerEnumerationOptions arg2, id arg3) {
  return ((_ProtocolTrampoline_112)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_113)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_1zubem(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_113)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_114)(void * sel, id arg1, id arg2 __attribute__((ns_consumed)));
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_1p0fswn(id target, void * sel, id arg1, id arg2 __attribute__((ns_consumed))) {
  return ((_ProtocolTrampoline_114)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_115)(void * sel, struct _NSZone * arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_18nsem0(id target, void * sel, struct _NSZone * arg1) {
  return ((_ProtocolTrampoline_115)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_116)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _1653r2v_protocolTrampoline_wpy7aa(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_116)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}
#undef BLOCKING_BLOCK_IMPL

#pragma clang diagnostic pop
