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


typedef struct CGAffineTransform  (^_ProtocolTrampoline)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGAffineTransform  _138hsv5_protocolTrampoline_8o6he9(id target, void * sel) {
  return ((_ProtocolTrampoline)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef double  (^_ProtocolTrampoline_1)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
double  _138hsv5_protocolTrampoline_1x666sm(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_1)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGPoint  (^_ProtocolTrampoline_2)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _138hsv5_protocolTrampoline_7ohnx8(id target, void * sel) {
  return ((_ProtocolTrampoline_2)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGPoint  (^_ProtocolTrampoline_3)(void * sel, struct CGPoint arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _138hsv5_protocolTrampoline_17ipln5(id target, void * sel, struct CGPoint arg1, id arg2) {
  return ((_ProtocolTrampoline_3)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGRect  (^_ProtocolTrampoline_4)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _138hsv5_protocolTrampoline_1c3uc0w(id target, void * sel) {
  return ((_ProtocolTrampoline_4)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGRect  (^_ProtocolTrampoline_5)(void * sel, struct CGRect arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _138hsv5_protocolTrampoline_1sh7l9z(id target, void * sel, struct CGRect arg1, id arg2) {
  return ((_ProtocolTrampoline_5)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGRect  (^_ProtocolTrampoline_6)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _138hsv5_protocolTrampoline_szn7s6(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_6)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGSize  (^_ProtocolTrampoline_7)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _138hsv5_protocolTrampoline_1j20mp(id target, void * sel) {
  return ((_ProtocolTrampoline_7)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGSize  (^_ProtocolTrampoline_8)(void * sel, id arg1, struct CGSize arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _138hsv5_protocolTrampoline_gnbb7x(id target, void * sel, id arg1, struct CGSize arg2) {
  return ((_ProtocolTrampoline_8)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_9)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
id  _138hsv5_protocolTrampoline_1mbt9g9(id target, void * sel) {
  return ((_ProtocolTrampoline_9)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_10)(void * sel, struct CGRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _138hsv5_protocolTrampoline_12thpau(id target, void * sel, struct CGRect arg1) {
  return ((_ProtocolTrampoline_10)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_11)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _138hsv5_protocolTrampoline_xr62hr(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_11)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef long  (^_ProtocolTrampoline_12)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
long  _138hsv5_protocolTrampoline_sqbvvb(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_12)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef UIAccessibilityContrast  (^_ProtocolTrampoline_13)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIAccessibilityContrast  _138hsv5_protocolTrampoline_1y291i1(id target, void * sel) {
  return ((_ProtocolTrampoline_13)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIDisplayGamut  (^_ProtocolTrampoline_14)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIDisplayGamut  _138hsv5_protocolTrampoline_rbevjh(id target, void * sel) {
  return ((_ProtocolTrampoline_14)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef long  (^_ProtocolTrampoline_15)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
long  _138hsv5_protocolTrampoline_fai2e9(id target, void * sel) {
  return ((_ProtocolTrampoline_15)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIFocusItemDeferralMode  (^_ProtocolTrampoline_16)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIFocusItemDeferralMode  _138hsv5_protocolTrampoline_1qeotwu(id target, void * sel) {
  return ((_ProtocolTrampoline_16)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIForceTouchCapability  (^_ProtocolTrampoline_17)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIForceTouchCapability  _138hsv5_protocolTrampoline_1v6iqyx(id target, void * sel) {
  return ((_ProtocolTrampoline_17)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIImageDynamicRange  (^_ProtocolTrampoline_18)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIImageDynamicRange  _138hsv5_protocolTrampoline_s20jvy(id target, void * sel) {
  return ((_ProtocolTrampoline_18)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIInterfaceOrientationMask  (^_ProtocolTrampoline_19)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
UIInterfaceOrientationMask  _138hsv5_protocolTrampoline_197itbk(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_19)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UILegibilityWeight  (^_ProtocolTrampoline_20)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UILegibilityWeight  _138hsv5_protocolTrampoline_nppfkr(id target, void * sel) {
  return ((_ProtocolTrampoline_20)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIListEnvironment  (^_ProtocolTrampoline_21)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIListEnvironment  _138hsv5_protocolTrampoline_ytxobw(id target, void * sel) {
  return ((_ProtocolTrampoline_21)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIModalPresentationStyle  (^_ProtocolTrampoline_22)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIModalPresentationStyle  _138hsv5_protocolTrampoline_1p9y19b(id target, void * sel) {
  return ((_ProtocolTrampoline_22)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIModalTransitionStyle  (^_ProtocolTrampoline_23)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIModalTransitionStyle  _138hsv5_protocolTrampoline_o3nor4(id target, void * sel) {
  return ((_ProtocolTrampoline_23)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UINSToolbarItemPresentationSize  (^_ProtocolTrampoline_24)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UINSToolbarItemPresentationSize  _138hsv5_protocolTrampoline_ky0mvb(id target, void * sel) {
  return ((_ProtocolTrampoline_24)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_25)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _138hsv5_protocolTrampoline_1yw2rcr(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_25)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef UIRectEdge  (^_ProtocolTrampoline_26)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIRectEdge  _138hsv5_protocolTrampoline_115ahz8(id target, void * sel) {
  return ((_ProtocolTrampoline_26)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UISceneCaptureState  (^_ProtocolTrampoline_27)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UISceneCaptureState  _138hsv5_protocolTrampoline_dxga5i(id target, void * sel) {
  return ((_ProtocolTrampoline_27)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_28)(void * sel, NSDirectionalRectEdge arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _138hsv5_protocolTrampoline_rjw3wx(id target, void * sel, NSDirectionalRectEdge arg1) {
  return ((_ProtocolTrampoline_28)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef UISplitViewControllerLayoutEnvironment  (^_ProtocolTrampoline_29)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UISplitViewControllerLayoutEnvironment  _138hsv5_protocolTrampoline_rye8dh(id target, void * sel) {
  return ((_ProtocolTrampoline_29)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIStatusBarAnimation  (^_ProtocolTrampoline_30)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIStatusBarAnimation  _138hsv5_protocolTrampoline_dqvytk(id target, void * sel) {
  return ((_ProtocolTrampoline_30)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIStatusBarStyle  (^_ProtocolTrampoline_31)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIStatusBarStyle  _138hsv5_protocolTrampoline_1khrvfx(id target, void * sel) {
  return ((_ProtocolTrampoline_31)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITabAccessoryEnvironment  (^_ProtocolTrampoline_32)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITabAccessoryEnvironment  _138hsv5_protocolTrampoline_1vzw3vb(id target, void * sel) {
  return ((_ProtocolTrampoline_32)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITimingCurveType  (^_ProtocolTrampoline_33)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITimingCurveType  _138hsv5_protocolTrampoline_1b0thcs(id target, void * sel) {
  return ((_ProtocolTrampoline_33)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITraitEnvironmentLayoutDirection  (^_ProtocolTrampoline_34)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITraitEnvironmentLayoutDirection  _138hsv5_protocolTrampoline_xq5tn3(id target, void * sel) {
  return ((_ProtocolTrampoline_34)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIUserInterfaceActiveAppearance  (^_ProtocolTrampoline_35)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIUserInterfaceActiveAppearance  _138hsv5_protocolTrampoline_1r4hjnp(id target, void * sel) {
  return ((_ProtocolTrampoline_35)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIUserInterfaceIdiom  (^_ProtocolTrampoline_36)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIUserInterfaceIdiom  _138hsv5_protocolTrampoline_105ez3b(id target, void * sel) {
  return ((_ProtocolTrampoline_36)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIUserInterfaceLevel  (^_ProtocolTrampoline_37)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIUserInterfaceLevel  _138hsv5_protocolTrampoline_1eol91l(id target, void * sel) {
  return ((_ProtocolTrampoline_37)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIUserInterfaceSizeClass  (^_ProtocolTrampoline_38)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIUserInterfaceSizeClass  _138hsv5_protocolTrampoline_dat8c2(id target, void * sel) {
  return ((_ProtocolTrampoline_38)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIUserInterfaceStyle  (^_ProtocolTrampoline_39)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIUserInterfaceStyle  _138hsv5_protocolTrampoline_z9dozg(id target, void * sel) {
  return ((_ProtocolTrampoline_39)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIViewAnimatingState  (^_ProtocolTrampoline_40)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIViewAnimatingState  _138hsv5_protocolTrampoline_19bak41(id target, void * sel) {
  return ((_ProtocolTrampoline_40)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIViewAnimationCurve  (^_ProtocolTrampoline_41)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIViewAnimationCurve  _138hsv5_protocolTrampoline_1q1046l(id target, void * sel) {
  return ((_ProtocolTrampoline_41)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_42)(void * sel, id arg1, struct CGPoint arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _138hsv5_protocolTrampoline_uah4a0(id target, void * sel, id arg1, struct CGPoint arg2) {
  return ((_ProtocolTrampoline_42)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_43)(void * sel, struct objc_selector * arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _138hsv5_protocolTrampoline_c7gk2u(id target, void * sel, struct objc_selector * arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_43)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_44)(void * sel, struct objc_selector * arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _138hsv5_protocolTrampoline_1mllhpc(id target, void * sel, struct objc_selector * arg1, id arg2) {
  return ((_ProtocolTrampoline_44)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_45)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _138hsv5_protocolTrampoline_e3qsqz(id target, void * sel) {
  return ((_ProtocolTrampoline_45)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_46)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _138hsv5_protocolTrampoline_2n06mv(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_46)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_47)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _138hsv5_protocolTrampoline_3su7tt(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_47)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_48)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _138hsv5_protocolTrampoline_jk8du5(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_48)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_49)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _138hsv5_protocolTrampoline_1em3l8z(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_49)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_50)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _138hsv5_protocolTrampoline_rptcvw(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_50)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_51)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _138hsv5_protocolTrampoline_1ja9agx(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_51)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_52)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _138hsv5_protocolTrampoline_jogy9n(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_52)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_53)(void * sel, struct objc_selector * arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _138hsv5_protocolTrampoline_1yvmq2c(id target, void * sel, struct objc_selector * arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_53)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef double  (^_ProtocolTrampoline_54)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
double  _138hsv5_protocolTrampoline_tfvuzk(id target, void * sel) {
  return ((_ProtocolTrampoline_54)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline)(void);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _138hsv5_wrapListenerBlock_1pl9qdv(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void() {
    objc_retainBlock(block);
    block();
  };
}

typedef void  (^_BlockingTrampoline)(void * waiter);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _138hsv5_wrapBlockingBlock_1pl9qdv(
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
_ListenerTrampoline_1 _138hsv5_wrapListenerBlock_xtuoz7(_ListenerTrampoline_1 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0));
  };
}

typedef void  (^_BlockingTrampoline_1)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _138hsv5_wrapBlockingBlock_xtuoz7(
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

typedef void  (^_ListenerTrampoline_2)(id arg0, long arg1, struct CGRect arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _138hsv5_wrapListenerBlock_11l3kq6(_ListenerTrampoline_2 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, long arg1, struct CGRect arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_2)(void * waiter, id arg0, long arg1, struct CGRect arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _138hsv5_wrapBlockingBlock_11l3kq6(
    _BlockingTrampoline_2 block, _BlockingTrampoline_2 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, long arg1, struct CGRect arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef void  (^_ListenerTrampoline_3)(UIBackgroundFetchResult arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _138hsv5_wrapListenerBlock_l6dgk2(_ListenerTrampoline_3 block) NS_RETURNS_RETAINED {
  return ^void(UIBackgroundFetchResult arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_3)(void * waiter, UIBackgroundFetchResult arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _138hsv5_wrapBlockingBlock_l6dgk2(
    _BlockingTrampoline_3 block, _BlockingTrampoline_3 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(UIBackgroundFetchResult arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_4)(UIViewAnimatingPosition arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _138hsv5_wrapListenerBlock_cgf7tp(_ListenerTrampoline_4 block) NS_RETURNS_RETAINED {
  return ^void(UIViewAnimatingPosition arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_4)(void * waiter, UIViewAnimatingPosition arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _138hsv5_wrapBlockingBlock_cgf7tp(
    _BlockingTrampoline_4 block, _BlockingTrampoline_4 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(UIViewAnimatingPosition arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_5)(BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _138hsv5_wrapListenerBlock_1s56lr9(_ListenerTrampoline_5 block) NS_RETURNS_RETAINED {
  return ^void(BOOL arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_5)(void * waiter, BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _138hsv5_wrapBlockingBlock_1s56lr9(
    _BlockingTrampoline_5 block, _BlockingTrampoline_5 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(BOOL arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_6)(void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _138hsv5_wrapListenerBlock_ovsamd(_ListenerTrampoline_6 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_6)(void * waiter, void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _138hsv5_wrapBlockingBlock_ovsamd(
    _BlockingTrampoline_6 block, _BlockingTrampoline_6 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ProtocolTrampoline_55)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_ovsamd(id target, void * sel) {
  return ((_ProtocolTrampoline_55)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_7)(void * arg0, double arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _138hsv5_wrapListenerBlock_1g6ud1c(_ListenerTrampoline_7 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, double arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_7)(void * waiter, void * arg0, double arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _138hsv5_wrapBlockingBlock_1g6ud1c(
    _BlockingTrampoline_7 block, _BlockingTrampoline_7 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, double arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_56)(void * sel, double arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1g6ud1c(id target, void * sel, double arg1, id arg2) {
  return ((_ProtocolTrampoline_56)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_8)(void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _138hsv5_wrapListenerBlock_1bktu2(_ListenerTrampoline_8 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGPoint arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_8)(void * waiter, void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _138hsv5_wrapBlockingBlock_1bktu2(
    _BlockingTrampoline_8 block, _BlockingTrampoline_8 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGPoint arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_57)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1bktu2(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_57)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_9)(void * arg0, struct CGRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _138hsv5_wrapListenerBlock_1e49sma(_ListenerTrampoline_9 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGRect arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_9)(void * waiter, void * arg0, struct CGRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _138hsv5_wrapBlockingBlock_1e49sma(
    _BlockingTrampoline_9 block, _BlockingTrampoline_9 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGRect arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_58)(void * sel, struct CGRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1e49sma(id target, void * sel, struct CGRect arg1) {
  return ((_ProtocolTrampoline_58)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_10)(void * arg0, struct CGSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _138hsv5_wrapListenerBlock_leirm3(_ListenerTrampoline_10 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGSize arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_10)(void * waiter, void * arg0, struct CGSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _138hsv5_wrapBlockingBlock_leirm3(
    _BlockingTrampoline_10 block, _BlockingTrampoline_10 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGSize arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_59)(void * sel, struct CGSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_leirm3(id target, void * sel, struct CGSize arg1) {
  return ((_ProtocolTrampoline_59)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_11)(void * arg0, struct CGSize arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _138hsv5_wrapListenerBlock_1rn6eap(_ListenerTrampoline_11 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGSize arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_11)(void * waiter, void * arg0, struct CGSize arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _138hsv5_wrapBlockingBlock_1rn6eap(
    _BlockingTrampoline_11 block, _BlockingTrampoline_11 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGSize arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_60)(void * sel, struct CGSize arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1rn6eap(id target, void * sel, struct CGSize arg1, id arg2) {
  return ((_ProtocolTrampoline_60)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_12)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _138hsv5_wrapListenerBlock_18v1jvf(_ListenerTrampoline_12 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_12)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _138hsv5_wrapBlockingBlock_18v1jvf(
    _BlockingTrampoline_12 block, _BlockingTrampoline_12 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_61)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_18v1jvf(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_61)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_13)(void * arg0, long arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _138hsv5_wrapListenerBlock_1453bv9(_ListenerTrampoline_13 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, long arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_13)(void * waiter, void * arg0, long arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _138hsv5_wrapBlockingBlock_1453bv9(
    _BlockingTrampoline_13 block, _BlockingTrampoline_13 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, long arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_62)(void * sel, long arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1453bv9(id target, void * sel, long arg1, id arg2) {
  return ((_ProtocolTrampoline_62)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_14)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _138hsv5_wrapListenerBlock_fjrv01(_ListenerTrampoline_14 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_14)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _138hsv5_wrapBlockingBlock_fjrv01(
    _BlockingTrampoline_14 block, _BlockingTrampoline_14 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_63)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_fjrv01(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_63)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_15)(void * arg0, UIAccessibilityContrast arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _138hsv5_wrapListenerBlock_wpry4n(_ListenerTrampoline_15 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIAccessibilityContrast arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_15)(void * waiter, void * arg0, UIAccessibilityContrast arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _138hsv5_wrapBlockingBlock_wpry4n(
    _BlockingTrampoline_15 block, _BlockingTrampoline_15 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIAccessibilityContrast arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_64)(void * sel, UIAccessibilityContrast arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_wpry4n(id target, void * sel, UIAccessibilityContrast arg1) {
  return ((_ProtocolTrampoline_64)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_16)(void * arg0, id arg1, struct CGRect arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _138hsv5_wrapListenerBlock_ustzvs(_ListenerTrampoline_16 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGRect arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_16)(void * waiter, void * arg0, id arg1, struct CGRect arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _138hsv5_wrapBlockingBlock_ustzvs(
    _BlockingTrampoline_16 block, _BlockingTrampoline_16 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGRect arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_65)(void * sel, id arg1, struct CGRect arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_ustzvs(id target, void * sel, id arg1, struct CGRect arg2) {
  return ((_ProtocolTrampoline_65)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_17)(void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _138hsv5_wrapListenerBlock_bklti2(_ListenerTrampoline_17 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_17)(void * waiter, void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _138hsv5_wrapBlockingBlock_bklti2(
    _BlockingTrampoline_17 block, _BlockingTrampoline_17 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_66)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_bklti2(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_66)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_18)(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _138hsv5_wrapListenerBlock_l2g8ke(_ListenerTrampoline_18 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  };
}

typedef void  (^_BlockingTrampoline_18)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _138hsv5_wrapBlockingBlock_l2g8ke(
    _BlockingTrampoline_18 block, _BlockingTrampoline_18 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  });
}

typedef void  (^_ProtocolTrampoline_67)(void * sel, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_l2g8ke(id target, void * sel, id arg1, id arg2, id arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_67)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_19)(void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_19 _138hsv5_wrapListenerBlock_xx612k(_ListenerTrampoline_19 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  };
}

typedef void  (^_BlockingTrampoline_19)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_19 _138hsv5_wrapBlockingBlock_xx612k(
    _BlockingTrampoline_19 block, _BlockingTrampoline_19 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_68)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_xx612k(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_68)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_20)(void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_20 _138hsv5_wrapListenerBlock_1tz5yf(_ListenerTrampoline_20 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_20)(void * waiter, void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_20 _138hsv5_wrapBlockingBlock_1tz5yf(
    _BlockingTrampoline_20 block, _BlockingTrampoline_20 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_69)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1tz5yf(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_69)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_21)(void * arg0, id arg1, UIInterfaceOrientation arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_21 _138hsv5_wrapListenerBlock_1dzhcvo(_ListenerTrampoline_21 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UIInterfaceOrientation arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_21)(void * waiter, void * arg0, id arg1, UIInterfaceOrientation arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_21 _138hsv5_wrapBlockingBlock_1dzhcvo(
    _BlockingTrampoline_21 block, _BlockingTrampoline_21 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UIInterfaceOrientation arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_70)(void * sel, id arg1, UIInterfaceOrientation arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1dzhcvo(id target, void * sel, id arg1, UIInterfaceOrientation arg2) {
  return ((_ProtocolTrampoline_70)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_22)(void * arg0, id arg1, UIInterfaceOrientation arg2, double arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_22 _138hsv5_wrapListenerBlock_z8eyrz(_ListenerTrampoline_22 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UIInterfaceOrientation arg2, double arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_22)(void * waiter, void * arg0, id arg1, UIInterfaceOrientation arg2, double arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_22 _138hsv5_wrapBlockingBlock_z8eyrz(
    _BlockingTrampoline_22 block, _BlockingTrampoline_22 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UIInterfaceOrientation arg2, double arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_71)(void * sel, id arg1, UIInterfaceOrientation arg2, double arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_z8eyrz(id target, void * sel, id arg1, UIInterfaceOrientation arg2, double arg3) {
  return ((_ProtocolTrampoline_71)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_23)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_23 _138hsv5_wrapListenerBlock_jk1ljc(_ListenerTrampoline_23 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  };
}

typedef void  (^_BlockingTrampoline_23)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_23 _138hsv5_wrapBlockingBlock_jk1ljc(
    _BlockingTrampoline_23 block, _BlockingTrampoline_23 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_72)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_jk1ljc(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_72)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_24)(void * arg0, UIDisplayGamut arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_24 _138hsv5_wrapListenerBlock_k3o9k7(_ListenerTrampoline_24 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIDisplayGamut arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_24)(void * waiter, void * arg0, UIDisplayGamut arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_24 _138hsv5_wrapBlockingBlock_k3o9k7(
    _BlockingTrampoline_24 block, _BlockingTrampoline_24 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIDisplayGamut arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_73)(void * sel, UIDisplayGamut arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_k3o9k7(id target, void * sel, UIDisplayGamut arg1) {
  return ((_ProtocolTrampoline_73)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_25)(void * arg0, UIForceTouchCapability arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_25 _138hsv5_wrapListenerBlock_1ifv5ez(_ListenerTrampoline_25 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIForceTouchCapability arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_25)(void * waiter, void * arg0, UIForceTouchCapability arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_25 _138hsv5_wrapBlockingBlock_1ifv5ez(
    _BlockingTrampoline_25 block, _BlockingTrampoline_25 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIForceTouchCapability arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_74)(void * sel, UIForceTouchCapability arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1ifv5ez(id target, void * sel, UIForceTouchCapability arg1) {
  return ((_ProtocolTrampoline_74)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_26)(void * arg0, UIImageDynamicRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_26 _138hsv5_wrapListenerBlock_6h2ktc(_ListenerTrampoline_26 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIImageDynamicRange arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_26)(void * waiter, void * arg0, UIImageDynamicRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_26 _138hsv5_wrapBlockingBlock_6h2ktc(
    _BlockingTrampoline_26 block, _BlockingTrampoline_26 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIImageDynamicRange arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_75)(void * sel, UIImageDynamicRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_6h2ktc(id target, void * sel, UIImageDynamicRange arg1) {
  return ((_ProtocolTrampoline_75)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_27)(void * arg0, UILegibilityWeight arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_27 _138hsv5_wrapListenerBlock_f6bqwx(_ListenerTrampoline_27 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UILegibilityWeight arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_27)(void * waiter, void * arg0, UILegibilityWeight arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_27 _138hsv5_wrapBlockingBlock_f6bqwx(
    _BlockingTrampoline_27 block, _BlockingTrampoline_27 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UILegibilityWeight arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_76)(void * sel, UILegibilityWeight arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_f6bqwx(id target, void * sel, UILegibilityWeight arg1) {
  return ((_ProtocolTrampoline_76)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_28)(void * arg0, UIListEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_28 _138hsv5_wrapListenerBlock_6nmvtq(_ListenerTrampoline_28 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIListEnvironment arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_28)(void * waiter, void * arg0, UIListEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_28 _138hsv5_wrapBlockingBlock_6nmvtq(
    _BlockingTrampoline_28 block, _BlockingTrampoline_28 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIListEnvironment arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_77)(void * sel, UIListEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_6nmvtq(id target, void * sel, UIListEnvironment arg1) {
  return ((_ProtocolTrampoline_77)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_29)(void * arg0, UIModalPresentationStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_29 _138hsv5_wrapListenerBlock_1t4edop(_ListenerTrampoline_29 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIModalPresentationStyle arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_29)(void * waiter, void * arg0, UIModalPresentationStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_29 _138hsv5_wrapBlockingBlock_1t4edop(
    _BlockingTrampoline_29 block, _BlockingTrampoline_29 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIModalPresentationStyle arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_78)(void * sel, UIModalPresentationStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1t4edop(id target, void * sel, UIModalPresentationStyle arg1) {
  return ((_ProtocolTrampoline_78)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_30)(void * arg0, UIModalTransitionStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_30 _138hsv5_wrapListenerBlock_1oclfry(_ListenerTrampoline_30 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIModalTransitionStyle arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_30)(void * waiter, void * arg0, UIModalTransitionStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_30 _138hsv5_wrapBlockingBlock_1oclfry(
    _BlockingTrampoline_30 block, _BlockingTrampoline_30 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIModalTransitionStyle arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_79)(void * sel, UIModalTransitionStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1oclfry(id target, void * sel, UIModalTransitionStyle arg1) {
  return ((_ProtocolTrampoline_79)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_31)(void * arg0, UINSToolbarItemPresentationSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_31 _138hsv5_wrapListenerBlock_1j3snqt(_ListenerTrampoline_31 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UINSToolbarItemPresentationSize arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_31)(void * waiter, void * arg0, UINSToolbarItemPresentationSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_31 _138hsv5_wrapBlockingBlock_1j3snqt(
    _BlockingTrampoline_31 block, _BlockingTrampoline_31 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UINSToolbarItemPresentationSize arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_80)(void * sel, UINSToolbarItemPresentationSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1j3snqt(id target, void * sel, UINSToolbarItemPresentationSize arg1) {
  return ((_ProtocolTrampoline_80)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_32)(void * arg0, UIRectEdge arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_32 _138hsv5_wrapListenerBlock_1866l6q(_ListenerTrampoline_32 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIRectEdge arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_32)(void * waiter, void * arg0, UIRectEdge arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_32 _138hsv5_wrapBlockingBlock_1866l6q(
    _BlockingTrampoline_32 block, _BlockingTrampoline_32 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIRectEdge arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_81)(void * sel, UIRectEdge arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1866l6q(id target, void * sel, UIRectEdge arg1) {
  return ((_ProtocolTrampoline_81)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_33)(void * arg0, UISceneCaptureState arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_33 _138hsv5_wrapListenerBlock_g764c0(_ListenerTrampoline_33 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UISceneCaptureState arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_33)(void * waiter, void * arg0, UISceneCaptureState arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_33 _138hsv5_wrapBlockingBlock_g764c0(
    _BlockingTrampoline_33 block, _BlockingTrampoline_33 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UISceneCaptureState arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_82)(void * sel, UISceneCaptureState arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_g764c0(id target, void * sel, UISceneCaptureState arg1) {
  return ((_ProtocolTrampoline_82)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_34)(void * arg0, id arg1, NSDirectionalRectEdge arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_34 _138hsv5_wrapListenerBlock_119a3ez(_ListenerTrampoline_34 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, NSDirectionalRectEdge arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_34)(void * waiter, void * arg0, id arg1, NSDirectionalRectEdge arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_34 _138hsv5_wrapBlockingBlock_119a3ez(
    _BlockingTrampoline_34 block, _BlockingTrampoline_34 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, NSDirectionalRectEdge arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_83)(void * sel, id arg1, NSDirectionalRectEdge arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_119a3ez(id target, void * sel, id arg1, NSDirectionalRectEdge arg2) {
  return ((_ProtocolTrampoline_83)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_35)(void * arg0, UISplitViewControllerLayoutEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_35 _138hsv5_wrapListenerBlock_17x4a9j(_ListenerTrampoline_35 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UISplitViewControllerLayoutEnvironment arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_35)(void * waiter, void * arg0, UISplitViewControllerLayoutEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_35 _138hsv5_wrapBlockingBlock_17x4a9j(
    _BlockingTrampoline_35 block, _BlockingTrampoline_35 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UISplitViewControllerLayoutEnvironment arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_84)(void * sel, UISplitViewControllerLayoutEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_17x4a9j(id target, void * sel, UISplitViewControllerLayoutEnvironment arg1) {
  return ((_ProtocolTrampoline_84)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_36)(void * arg0, UITabAccessoryEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_36 _138hsv5_wrapListenerBlock_w40jp9(_ListenerTrampoline_36 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITabAccessoryEnvironment arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_36)(void * waiter, void * arg0, UITabAccessoryEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_36 _138hsv5_wrapBlockingBlock_w40jp9(
    _BlockingTrampoline_36 block, _BlockingTrampoline_36 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITabAccessoryEnvironment arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_85)(void * sel, UITabAccessoryEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_w40jp9(id target, void * sel, UITabAccessoryEnvironment arg1) {
  return ((_ProtocolTrampoline_85)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_37)(void * arg0, UITraitEnvironmentLayoutDirection arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_37 _138hsv5_wrapListenerBlock_1nlyfpt(_ListenerTrampoline_37 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITraitEnvironmentLayoutDirection arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_37)(void * waiter, void * arg0, UITraitEnvironmentLayoutDirection arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_37 _138hsv5_wrapBlockingBlock_1nlyfpt(
    _BlockingTrampoline_37 block, _BlockingTrampoline_37 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITraitEnvironmentLayoutDirection arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_86)(void * sel, UITraitEnvironmentLayoutDirection arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1nlyfpt(id target, void * sel, UITraitEnvironmentLayoutDirection arg1) {
  return ((_ProtocolTrampoline_86)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_38)(void * arg0, UIUserInterfaceActiveAppearance arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_38 _138hsv5_wrapListenerBlock_c30qzr(_ListenerTrampoline_38 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIUserInterfaceActiveAppearance arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_38)(void * waiter, void * arg0, UIUserInterfaceActiveAppearance arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_38 _138hsv5_wrapBlockingBlock_c30qzr(
    _BlockingTrampoline_38 block, _BlockingTrampoline_38 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIUserInterfaceActiveAppearance arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_87)(void * sel, UIUserInterfaceActiveAppearance arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_c30qzr(id target, void * sel, UIUserInterfaceActiveAppearance arg1) {
  return ((_ProtocolTrampoline_87)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_39)(void * arg0, UIUserInterfaceIdiom arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_39 _138hsv5_wrapListenerBlock_i9yv41(_ListenerTrampoline_39 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIUserInterfaceIdiom arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_39)(void * waiter, void * arg0, UIUserInterfaceIdiom arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_39 _138hsv5_wrapBlockingBlock_i9yv41(
    _BlockingTrampoline_39 block, _BlockingTrampoline_39 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIUserInterfaceIdiom arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_88)(void * sel, UIUserInterfaceIdiom arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_i9yv41(id target, void * sel, UIUserInterfaceIdiom arg1) {
  return ((_ProtocolTrampoline_88)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_40)(void * arg0, UIUserInterfaceLevel arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_40 _138hsv5_wrapListenerBlock_1f63hfj(_ListenerTrampoline_40 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIUserInterfaceLevel arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_40)(void * waiter, void * arg0, UIUserInterfaceLevel arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_40 _138hsv5_wrapBlockingBlock_1f63hfj(
    _BlockingTrampoline_40 block, _BlockingTrampoline_40 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIUserInterfaceLevel arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_89)(void * sel, UIUserInterfaceLevel arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1f63hfj(id target, void * sel, UIUserInterfaceLevel arg1) {
  return ((_ProtocolTrampoline_89)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_41)(void * arg0, UIUserInterfaceSizeClass arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_41 _138hsv5_wrapListenerBlock_1ehkefo(_ListenerTrampoline_41 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIUserInterfaceSizeClass arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_41)(void * waiter, void * arg0, UIUserInterfaceSizeClass arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_41 _138hsv5_wrapBlockingBlock_1ehkefo(
    _BlockingTrampoline_41 block, _BlockingTrampoline_41 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIUserInterfaceSizeClass arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_90)(void * sel, UIUserInterfaceSizeClass arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1ehkefo(id target, void * sel, UIUserInterfaceSizeClass arg1) {
  return ((_ProtocolTrampoline_90)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_42)(void * arg0, UIUserInterfaceStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_42 _138hsv5_wrapListenerBlock_rfcn96(_ListenerTrampoline_42 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIUserInterfaceStyle arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_42)(void * waiter, void * arg0, UIUserInterfaceStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_42 _138hsv5_wrapBlockingBlock_rfcn96(
    _BlockingTrampoline_42 block, _BlockingTrampoline_42 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIUserInterfaceStyle arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_91)(void * sel, UIUserInterfaceStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_rfcn96(id target, void * sel, UIUserInterfaceStyle arg1) {
  return ((_ProtocolTrampoline_91)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_43)(void * arg0, UIViewAnimatingPosition arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_43 _138hsv5_wrapListenerBlock_1o8zrhx(_ListenerTrampoline_43 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIViewAnimatingPosition arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_43)(void * waiter, void * arg0, UIViewAnimatingPosition arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_43 _138hsv5_wrapBlockingBlock_1o8zrhx(
    _BlockingTrampoline_43 block, _BlockingTrampoline_43 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIViewAnimatingPosition arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_92)(void * sel, UIViewAnimatingPosition arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1o8zrhx(id target, void * sel, UIViewAnimatingPosition arg1) {
  return ((_ProtocolTrampoline_92)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_44)(void * arg0, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_44 _138hsv5_wrapListenerBlock_zzthnb(_ListenerTrampoline_44 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, BOOL arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_44)(void * waiter, void * arg0, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_44 _138hsv5_wrapBlockingBlock_zzthnb(
    _BlockingTrampoline_44 block, _BlockingTrampoline_44 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, BOOL arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_93)(void * sel, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_zzthnb(id target, void * sel, id arg1, BOOL arg2) {
  return ((_ProtocolTrampoline_93)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_45)(void * arg0, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_45 _138hsv5_wrapListenerBlock_18jmq2k(_ListenerTrampoline_45 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, BOOL arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_45)(void * waiter, void * arg0, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_45 _138hsv5_wrapBlockingBlock_18jmq2k(
    _BlockingTrampoline_45 block, _BlockingTrampoline_45 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, BOOL arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_94)(void * sel, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_18jmq2k(id target, void * sel, id arg1, BOOL arg2, id arg3) {
  return ((_ProtocolTrampoline_94)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_46)(void * arg0, id arg1, id arg2, UIInterfaceOrientation arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_46 _138hsv5_wrapListenerBlock_ynx60k(_ListenerTrampoline_46 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, UIInterfaceOrientation arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_46)(void * waiter, void * arg0, id arg1, id arg2, UIInterfaceOrientation arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_46 _138hsv5_wrapBlockingBlock_ynx60k(
    _BlockingTrampoline_46 block, _BlockingTrampoline_46 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, UIInterfaceOrientation arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_95)(void * sel, id arg1, id arg2, UIInterfaceOrientation arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_ynx60k(id target, void * sel, id arg1, id arg2, UIInterfaceOrientation arg3, id arg4) {
  return ((_ProtocolTrampoline_95)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_47)(void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_47 _138hsv5_wrapListenerBlock_10lndml(_ListenerTrampoline_47 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_47)(void * waiter, void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_47 _138hsv5_wrapBlockingBlock_10lndml(
    _BlockingTrampoline_47 block, _BlockingTrampoline_47 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, BOOL arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_96)(void * sel, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_10lndml(id target, void * sel, BOOL arg1) {
  return ((_ProtocolTrampoline_96)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_48)(void * arg0, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_48 _138hsv5_wrapListenerBlock_ftecxq(_ListenerTrampoline_48 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, objc_retainBlock(arg2));
  };
}

typedef void  (^_BlockingTrampoline_48)(void * waiter, void * arg0, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_48 _138hsv5_wrapBlockingBlock_ftecxq(
    _BlockingTrampoline_48 block, _BlockingTrampoline_48 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, BOOL arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, objc_retainBlock(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, objc_retainBlock(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_97)(void * sel, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_ftecxq(id target, void * sel, BOOL arg1, id arg2) {
  return ((_ProtocolTrampoline_97)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_49)(void * arg0, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_49 _138hsv5_wrapListenerBlock_18sfmo2(_ListenerTrampoline_49 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, double arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_49)(void * waiter, void * arg0, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_49 _138hsv5_wrapBlockingBlock_18sfmo2(
    _BlockingTrampoline_49 block, _BlockingTrampoline_49 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, double arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_98)(void * sel, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_18sfmo2(id target, void * sel, double arg1) {
  return ((_ProtocolTrampoline_98)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_50)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_50 _138hsv5_wrapListenerBlock_1l4hxwm(_ListenerTrampoline_50 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retainBlock(arg1));
  };
}

typedef void  (^_BlockingTrampoline_50)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_50 _138hsv5_wrapBlockingBlock_1l4hxwm(
    _BlockingTrampoline_50 block, _BlockingTrampoline_50 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, objc_retainBlock(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, objc_retainBlock(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_99)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1l4hxwm(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_99)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_51)(void * arg0, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_51 _138hsv5_wrapListenerBlock_1bbqgd5(_ListenerTrampoline_51 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, double arg2) {
    objc_retainBlock(block);
    block(arg0, objc_retainBlock(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_51)(void * waiter, void * arg0, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_51 _138hsv5_wrapBlockingBlock_1bbqgd5(
    _BlockingTrampoline_51 block, _BlockingTrampoline_51 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, double arg2), {
    objc_retainBlock(block);
    block(nil, arg0, objc_retainBlock(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, objc_retainBlock(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_100)(void * sel, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_1bbqgd5(id target, void * sel, id arg1, double arg2) {
  return ((_ProtocolTrampoline_100)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_52)(void * arg0, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_52 _138hsv5_wrapListenerBlock_ve6f9k(_ListenerTrampoline_52 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, double arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_52)(void * waiter, void * arg0, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_52 _138hsv5_wrapBlockingBlock_ve6f9k(
    _BlockingTrampoline_52 block, _BlockingTrampoline_52 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, double arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_101)(void * sel, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _138hsv5_protocolTrampoline_ve6f9k(id target, void * sel, id arg1, double arg2) {
  return ((_ProtocolTrampoline_101)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_53)(id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_53 _138hsv5_wrapListenerBlock_pfv6jd(_ListenerTrampoline_53 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_53)(void * waiter, id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_53 _138hsv5_wrapBlockingBlock_pfv6jd(
    _BlockingTrampoline_53 block, _BlockingTrampoline_53 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef id  (^_ProtocolTrampoline_102)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _138hsv5_protocolTrampoline_1q0i84(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_102)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_103)(void * sel, id arg1, id arg2, struct objc_selector * arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _138hsv5_protocolTrampoline_g285me(id target, void * sel, id arg1, id arg2, struct objc_selector * arg3) {
  return ((_ProtocolTrampoline_103)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_104)(void * sel, id arg1, struct objc_selector * arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _138hsv5_protocolTrampoline_wyrm70(id target, void * sel, id arg1, struct objc_selector * arg2) {
  return ((_ProtocolTrampoline_104)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_105)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _138hsv5_protocolTrampoline_zi5eed(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_105)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_106)(void * sel, struct _NSZone * arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _138hsv5_protocolTrampoline_18nsem0(id target, void * sel, struct _NSZone * arg1) {
  return ((_ProtocolTrampoline_106)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}
#undef BLOCKING_BLOCK_IMPL

#pragma clang diagnostic pop
