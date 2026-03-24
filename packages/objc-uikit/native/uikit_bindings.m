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
id  _tdboth_protocolTrampoline_1mbt9g9(id target, void * sel) {
  return ((_ProtocolTrampoline)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CATransform3D  (^_ProtocolTrampoline_1)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CATransform3D  _tdboth_protocolTrampoline_11izgv5(id target, void * sel) {
  return ((_ProtocolTrampoline_1)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGAffineTransform  (^_ProtocolTrampoline_2)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGAffineTransform  _tdboth_protocolTrampoline_8o6he9(id target, void * sel) {
  return ((_ProtocolTrampoline_2)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGAffineTransform  (^_ProtocolTrampoline_3)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGAffineTransform  _tdboth_protocolTrampoline_1mbheo7(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_3)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef double  (^_ProtocolTrampoline_4)(void * sel, id arg1, unsigned long arg2, struct CGRect arg3);
__attribute__((visibility("default"))) __attribute__((used))
double  _tdboth_protocolTrampoline_1csvj5s(id target, void * sel, id arg1, unsigned long arg2, struct CGRect arg3) {
  return ((_ProtocolTrampoline_4)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef double  (^_ProtocolTrampoline_5)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
double  _tdboth_protocolTrampoline_1x666sm(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_5)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef double  (^_ProtocolTrampoline_6)(void * sel, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
double  _tdboth_protocolTrampoline_mj5w82(id target, void * sel, id arg1, id arg2, long arg3) {
  return ((_ProtocolTrampoline_6)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef double  (^_ProtocolTrampoline_7)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
double  _tdboth_protocolTrampoline_5bm8w8(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_7)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef double  (^_ProtocolTrampoline_8)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
double  _tdboth_protocolTrampoline_1kspct0(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_8)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGImage *  (^_ProtocolTrampoline_9)(void * sel, struct CGSize arg1, double arg2, struct CGPoint * arg3, struct CGSize * arg4);
__attribute__((visibility("default"))) __attribute__((used))
struct CGImage *  _tdboth_protocolTrampoline_1p89e63(id target, void * sel, struct CGSize arg1, double arg2, struct CGPoint * arg3, struct CGSize * arg4) {
  return ((_ProtocolTrampoline_9)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef struct CGPoint  (^_ProtocolTrampoline_10)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _tdboth_protocolTrampoline_7ohnx8(id target, void * sel) {
  return ((_ProtocolTrampoline_10)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGPoint  (^_ProtocolTrampoline_11)(void * sel, struct CGPoint arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _tdboth_protocolTrampoline_17ipln5(id target, void * sel, struct CGPoint arg1, id arg2) {
  return ((_ProtocolTrampoline_11)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGPoint  (^_ProtocolTrampoline_12)(void * sel, id arg1, struct CGPoint arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _tdboth_protocolTrampoline_pftu99(id target, void * sel, id arg1, struct CGPoint arg2) {
  return ((_ProtocolTrampoline_12)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGPoint  (^_ProtocolTrampoline_13)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _tdboth_protocolTrampoline_1hsw88y(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_13)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGRect  (^_ProtocolTrampoline_14)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _tdboth_protocolTrampoline_1c3uc0w(id target, void * sel) {
  return ((_ProtocolTrampoline_14)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGRect  (^_ProtocolTrampoline_15)(void * sel, struct CGRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _tdboth_protocolTrampoline_1k2xa69(id target, void * sel, struct CGRect arg1) {
  return ((_ProtocolTrampoline_15)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGRect  (^_ProtocolTrampoline_16)(void * sel, struct CGRect arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _tdboth_protocolTrampoline_1sh7l9z(id target, void * sel, struct CGRect arg1, id arg2) {
  return ((_ProtocolTrampoline_16)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGRect  (^_ProtocolTrampoline_17)(void * sel, id arg1, id arg2, id arg3, struct CGRect arg4, struct CGPoint arg5);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _tdboth_protocolTrampoline_1ravc6k(id target, void * sel, id arg1, id arg2, id arg3, struct CGRect arg4, struct CGPoint arg5) {
  return ((_ProtocolTrampoline_17)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef struct CGRect  (^_ProtocolTrampoline_18)(void * sel, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _tdboth_protocolTrampoline_1xyboba(id target, void * sel, long arg1) {
  return ((_ProtocolTrampoline_18)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGRect  (^_ProtocolTrampoline_19)(void * sel, id arg1, unsigned long arg2, id arg3, struct CGRect arg4, struct CGPoint arg5, unsigned long arg6);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _tdboth_protocolTrampoline_dunsuy(id target, void * sel, id arg1, unsigned long arg2, id arg3, struct CGRect arg4, struct CGPoint arg5, unsigned long arg6) {
  return ((_ProtocolTrampoline_19)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef struct CGRect  (^_ProtocolTrampoline_20)(void * sel, id arg1, struct CGRect arg2, struct CGPoint arg3, unsigned long arg4);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _tdboth_protocolTrampoline_iqdvkd(id target, void * sel, id arg1, struct CGRect arg2, struct CGPoint arg3, unsigned long arg4) {
  return ((_ProtocolTrampoline_20)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef struct CGRect  (^_ProtocolTrampoline_21)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _tdboth_protocolTrampoline_szn7s6(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_21)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGRect  (^_ProtocolTrampoline_22)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _tdboth_protocolTrampoline_bl8dec(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_22)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGSize  (^_ProtocolTrampoline_23)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _tdboth_protocolTrampoline_1j20mp(id target, void * sel) {
  return ((_ProtocolTrampoline_23)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGSize  (^_ProtocolTrampoline_24)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _tdboth_protocolTrampoline_xmxmuf(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_24)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGSize  (^_ProtocolTrampoline_25)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _tdboth_protocolTrampoline_ckubc3(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_25)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef struct CGSize  (^_ProtocolTrampoline_26)(void * sel, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _tdboth_protocolTrampoline_141imqv(id target, void * sel, id arg1, id arg2, long arg3) {
  return ((_ProtocolTrampoline_26)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef struct CGSize  (^_ProtocolTrampoline_27)(void * sel, id arg1, struct CGSize arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _tdboth_protocolTrampoline_gnbb7x(id target, void * sel, id arg1, struct CGSize arg2) {
  return ((_ProtocolTrampoline_27)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_28)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_xr62hr(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_28)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef int  (^_ProtocolTrampoline_29)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
int  _tdboth_protocolTrampoline_1l0nlq(id target, void * sel) {
  return ((_ProtocolTrampoline_29)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct __CVBuffer *  (^_ProtocolTrampoline_30)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct __CVBuffer *  _tdboth_protocolTrampoline_vfhx8p(id target, void * sel) {
  return ((_ProtocolTrampoline_30)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct __IOSurface *  (^_ProtocolTrampoline_31)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct __IOSurface *  _tdboth_protocolTrampoline_tg5r79(id target, void * sel) {
  return ((_ProtocolTrampoline_31)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_32)(void * sel, struct CGRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_12thpau(id target, void * sel, struct CGRect arg1) {
  return ((_ProtocolTrampoline_32)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_33)(void * sel, unsigned long arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_3nbx5e(id target, void * sel, unsigned long arg1) {
  return ((_ProtocolTrampoline_33)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_34)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_1yw2rcr(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_34)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_35)(void * sel, id arg1, id arg2, id arg3, struct CGPoint arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_8oua50(id target, void * sel, id arg1, id arg2, id arg3, struct CGPoint arg4) {
  return ((_ProtocolTrampoline_35)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_36)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_zi5eed(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_36)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_37)(void * sel, id arg1, id arg2, struct CGPoint arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_11umze2(id target, void * sel, id arg1, id arg2, struct CGPoint arg3) {
  return ((_ProtocolTrampoline_37)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_38)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_1xvw1tx(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_38)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_39)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_qfyidt(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_39)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_40)(void * sel, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_ggvik5(id target, void * sel, id arg1, struct _NSRange arg2) {
  return ((_ProtocolTrampoline_40)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_41)(void * sel, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_ldbu1n(id target, void * sel, long arg1) {
  return ((_ProtocolTrampoline_41)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_42)(void * sel, id arg1, long arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_17vitjj(id target, void * sel, id arg1, long arg2, long arg3) {
  return ((_ProtocolTrampoline_42)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef NSComparisonResult  (^_ProtocolTrampoline_43)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
NSComparisonResult  _tdboth_protocolTrampoline_1dp38tu(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_43)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef NSComparisonResult  (^_ProtocolTrampoline_44)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
NSComparisonResult  _tdboth_protocolTrampoline_1939q40(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_44)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef NSComparisonResult  (^_ProtocolTrampoline_45)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSComparisonResult  _tdboth_protocolTrampoline_1xws32k(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_45)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef NSControlCharacterAction  (^_ProtocolTrampoline_46)(void * sel, id arg1, NSControlCharacterAction arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
NSControlCharacterAction  _tdboth_protocolTrampoline_505ew6(id target, void * sel, id arg1, NSControlCharacterAction arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_46)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_47)(void * sel, struct objc_selector * arg1, NSCalculationError arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_738w24(id target, void * sel, struct objc_selector * arg1, NSCalculationError arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_47)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_48)(void * sel, id arg1, UITextStorageDirection arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_1raep0i(id target, void * sel, id arg1, UITextStorageDirection arg2) {
  return ((_ProtocolTrampoline_48)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct NSDirectionalEdgeInsets  (^_ProtocolTrampoline_49)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct NSDirectionalEdgeInsets  _tdboth_protocolTrampoline_1qyypoa(id target, void * sel) {
  return ((_ProtocolTrampoline_49)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSDirectionalRectEdge  (^_ProtocolTrampoline_50)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSDirectionalRectEdge  _tdboth_protocolTrampoline_1dpzpu7(id target, void * sel) {
  return ((_ProtocolTrampoline_50)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSFileProviderContentPolicy  (^_ProtocolTrampoline_51)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSFileProviderContentPolicy  _tdboth_protocolTrampoline_vvhs3w(id target, void * sel) {
  return ((_ProtocolTrampoline_51)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSFileProviderFileSystemFlags  (^_ProtocolTrampoline_52)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSFileProviderFileSystemFlags  _tdboth_protocolTrampoline_d7559n(id target, void * sel) {
  return ((_ProtocolTrampoline_52)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSFileProviderItemCapabilities  (^_ProtocolTrampoline_53)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSFileProviderItemCapabilities  _tdboth_protocolTrampoline_jw04t4(id target, void * sel) {
  return ((_ProtocolTrampoline_53)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct NSFileProviderTypeAndCreator  (^_ProtocolTrampoline_54)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct NSFileProviderTypeAndCreator  _tdboth_protocolTrampoline_f76iul(id target, void * sel) {
  return ((_ProtocolTrampoline_54)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_55)(void * sel, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_1tgdqpb(id target, void * sel, id arg1, id arg2, long arg3) {
  return ((_ProtocolTrampoline_55)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef long  (^_ProtocolTrampoline_56)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
long  _tdboth_protocolTrampoline_1aeg7rq(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_56)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef long  (^_ProtocolTrampoline_57)(void * sel, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
long  _tdboth_protocolTrampoline_1p78ubn(id target, void * sel, long arg1) {
  return ((_ProtocolTrampoline_57)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef long  (^_ProtocolTrampoline_58)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
long  _tdboth_protocolTrampoline_sqbvvb(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_58)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef long  (^_ProtocolTrampoline_59)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
long  _tdboth_protocolTrampoline_1e5b3dp(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_59)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef long  (^_ProtocolTrampoline_60)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
long  _tdboth_protocolTrampoline_evw03x(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_60)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef long  (^_ProtocolTrampoline_61)(void * sel, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
long  _tdboth_protocolTrampoline_12jo9nb(id target, void * sel, id arg1, id arg2, long arg3) {
  return ((_ProtocolTrampoline_61)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_62)(void * sel, long arg1, id arg2, struct CGSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_1x2cudb(id target, void * sel, long arg1, id arg2, struct CGSize arg3) {
  return ((_ProtocolTrampoline_62)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_63)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_1q0i84(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_63)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct _NSRange  (^_ProtocolTrampoline_64)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct _NSRange  _tdboth_protocolTrampoline_1mh5vs9(id target, void * sel) {
  return ((_ProtocolTrampoline_64)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef NSRoundingMode  (^_ProtocolTrampoline_65)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSRoundingMode  _tdboth_protocolTrampoline_5cb1bj(id target, void * sel) {
  return ((_ProtocolTrampoline_65)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_66)(void * sel, id arg1, id arg2, struct _NSRange * arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_166s821(id target, void * sel, id arg1, id arg2, struct _NSRange * arg3) {
  return ((_ProtocolTrampoline_66)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef NSTextLayoutOrientation  (^_ProtocolTrampoline_67)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
NSTextLayoutOrientation  _tdboth_protocolTrampoline_1hcgfk1(id target, void * sel) {
  return ((_ProtocolTrampoline_67)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_68)(void * sel, struct CGPoint arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_1cizpv0(id target, void * sel, struct CGPoint arg1, id arg2) {
  return ((_ProtocolTrampoline_68)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_69)(void * sel, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_1u4xn97(id target, void * sel, id arg1, BOOL arg2) {
  return ((_ProtocolTrampoline_69)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_70)(void * sel, NSTextSelectionGranularity arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_1msw0hl(id target, void * sel, NSTextSelectionGranularity arg1, id arg2) {
  return ((_ProtocolTrampoline_70)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef NSTextSelectionNavigationLayoutOrientation  (^_ProtocolTrampoline_71)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSTextSelectionNavigationLayoutOrientation  _tdboth_protocolTrampoline_1kcz7dl(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_71)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef NSTextSelectionNavigationWritingDirection  (^_ProtocolTrampoline_72)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
NSTextSelectionNavigationWritingDirection  _tdboth_protocolTrampoline_1kewuno(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_72)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef unsigned long  (^_ProtocolTrampoline_73)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _tdboth_protocolTrampoline_1ckyi24(id target, void * sel) {
  return ((_ProtocolTrampoline_73)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef unsigned long  (^_ProtocolTrampoline_74)(void * sel, id arg1, unsigned short * arg2, NSGlyphProperty * arg3, unsigned long * arg4, id arg5, struct _NSRange arg6);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _tdboth_protocolTrampoline_1njk2hu(id target, void * sel, id arg1, unsigned short * arg2, NSGlyphProperty * arg3, unsigned long * arg4, id arg5, struct _NSRange arg6) {
  return ((_ProtocolTrampoline_74)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef NSWritingDirection  (^_ProtocolTrampoline_75)(void * sel, id arg1, UITextStorageDirection arg2);
__attribute__((visibility("default"))) __attribute__((used))
NSWritingDirection  _tdboth_protocolTrampoline_3fkmba(id target, void * sel, id arg1, UITextStorageDirection arg2) {
  return ((_ProtocolTrampoline_75)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UIAccessibilityContrast  (^_ProtocolTrampoline_76)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIAccessibilityContrast  _tdboth_protocolTrampoline_1y291i1(id target, void * sel) {
  return ((_ProtocolTrampoline_76)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIBarPosition  (^_ProtocolTrampoline_77)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIBarPosition  _tdboth_protocolTrampoline_qartj1(id target, void * sel) {
  return ((_ProtocolTrampoline_77)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIBarPosition  (^_ProtocolTrampoline_78)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
UIBarPosition  _tdboth_protocolTrampoline_1aqbt4z(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_78)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef UICollectionElementCategory  (^_ProtocolTrampoline_79)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UICollectionElementCategory  _tdboth_protocolTrampoline_tzdamv(id target, void * sel) {
  return ((_ProtocolTrampoline_79)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_80)(void * sel, struct objc_selector * arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_1mllhpc(id target, void * sel, struct objc_selector * arg1, id arg2) {
  return ((_ProtocolTrampoline_80)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_81)(void * sel, id arg1, struct CGPoint arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_uah4a0(id target, void * sel, id arg1, struct CGPoint arg2) {
  return ((_ProtocolTrampoline_81)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UIContextMenuInteractionCommitStyle  (^_ProtocolTrampoline_82)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIContextMenuInteractionCommitStyle  _tdboth_protocolTrampoline_14zx8fx(id target, void * sel) {
  return ((_ProtocolTrampoline_82)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIDisplayGamut  (^_ProtocolTrampoline_83)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIDisplayGamut  _tdboth_protocolTrampoline_rbevjh(id target, void * sel) {
  return ((_ProtocolTrampoline_83)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIDropOperation  (^_ProtocolTrampoline_84)(void * sel, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
UIDropOperation  _tdboth_protocolTrampoline_3ho217(id target, void * sel, id arg1, id arg2, id arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_84)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef UIDropOperation  (^_ProtocolTrampoline_85)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
UIDropOperation  _tdboth_protocolTrampoline_u40h2n(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_85)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef UIDropSessionProgressIndicatorStyle  (^_ProtocolTrampoline_86)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIDropSessionProgressIndicatorStyle  _tdboth_protocolTrampoline_1etxt4l(id target, void * sel) {
  return ((_ProtocolTrampoline_86)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIDynamicItemCollisionBoundsType  (^_ProtocolTrampoline_87)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIDynamicItemCollisionBoundsType  _tdboth_protocolTrampoline_ku69ws(id target, void * sel) {
  return ((_ProtocolTrampoline_87)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct UIEdgeInsets  (^_ProtocolTrampoline_88)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct UIEdgeInsets  _tdboth_protocolTrampoline_1rtilx3(id target, void * sel) {
  return ((_ProtocolTrampoline_88)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct UIEdgeInsets  (^_ProtocolTrampoline_89)(void * sel, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
struct UIEdgeInsets  _tdboth_protocolTrampoline_spyj1t(id target, void * sel, id arg1, id arg2, long arg3) {
  return ((_ProtocolTrampoline_89)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef UIFocusItemDeferralMode  (^_ProtocolTrampoline_90)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIFocusItemDeferralMode  _tdboth_protocolTrampoline_1qeotwu(id target, void * sel) {
  return ((_ProtocolTrampoline_90)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIForceTouchCapability  (^_ProtocolTrampoline_91)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIForceTouchCapability  _tdboth_protocolTrampoline_1v6iqyx(id target, void * sel) {
  return ((_ProtocolTrampoline_91)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIImageDynamicRange  (^_ProtocolTrampoline_92)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIImageDynamicRange  _tdboth_protocolTrampoline_s20jvy(id target, void * sel) {
  return ((_ProtocolTrampoline_92)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_93)(void * sel, struct CGRect arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_1a7e3u0(id target, void * sel, struct CGRect arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_93)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_94)(void * sel, struct CGRect arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_qwb72h(id target, void * sel, struct CGRect arg1, id arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_94)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_95)(void * sel, id arg1, id arg2, struct CGSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_18mw7aj(id target, void * sel, id arg1, id arg2, struct CGSize arg3) {
  return ((_ProtocolTrampoline_95)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef UIInterfaceOrientationMask  (^_ProtocolTrampoline_96)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
UIInterfaceOrientationMask  _tdboth_protocolTrampoline_197itbk(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_96)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UIInterfaceOrientationMask  (^_ProtocolTrampoline_97)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
UIInterfaceOrientationMask  _tdboth_protocolTrampoline_l5rsi(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_97)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef UIInterfaceOrientation  (^_ProtocolTrampoline_98)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
UIInterfaceOrientation  _tdboth_protocolTrampoline_1ahzoma(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_98)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef UIKeyboardAppearance  (^_ProtocolTrampoline_99)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIKeyboardAppearance  _tdboth_protocolTrampoline_ht8968(id target, void * sel) {
  return ((_ProtocolTrampoline_99)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIKeyboardType  (^_ProtocolTrampoline_100)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIKeyboardType  _tdboth_protocolTrampoline_na2jiy(id target, void * sel) {
  return ((_ProtocolTrampoline_100)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UILegibilityWeight  (^_ProtocolTrampoline_101)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UILegibilityWeight  _tdboth_protocolTrampoline_nppfkr(id target, void * sel) {
  return ((_ProtocolTrampoline_101)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UILetterformAwareSizingRule  (^_ProtocolTrampoline_102)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UILetterformAwareSizingRule  _tdboth_protocolTrampoline_o2xzcr(id target, void * sel) {
  return ((_ProtocolTrampoline_102)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIListEnvironment  (^_ProtocolTrampoline_103)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIListEnvironment  _tdboth_protocolTrampoline_ytxobw(id target, void * sel) {
  return ((_ProtocolTrampoline_103)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIMenuElementAttributes  (^_ProtocolTrampoline_104)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIMenuElementAttributes  _tdboth_protocolTrampoline_1tmn9mr(id target, void * sel) {
  return ((_ProtocolTrampoline_104)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIMenuElementRepeatBehavior  (^_ProtocolTrampoline_105)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIMenuElementRepeatBehavior  _tdboth_protocolTrampoline_1ctlj1n(id target, void * sel) {
  return ((_ProtocolTrampoline_105)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIMenuElementState  (^_ProtocolTrampoline_106)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIMenuElementState  _tdboth_protocolTrampoline_gvl1rz(id target, void * sel) {
  return ((_ProtocolTrampoline_106)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_107)(void * sel, id arg1, struct _NSRange arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_166zki3(id target, void * sel, id arg1, struct _NSRange arg2, id arg3) {
  return ((_ProtocolTrampoline_107)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef UIModalPresentationStyle  (^_ProtocolTrampoline_108)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIModalPresentationStyle  _tdboth_protocolTrampoline_1p9y19b(id target, void * sel) {
  return ((_ProtocolTrampoline_108)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIModalPresentationStyle  (^_ProtocolTrampoline_109)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
UIModalPresentationStyle  _tdboth_protocolTrampoline_dqanvp(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_109)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef UIModalPresentationStyle  (^_ProtocolTrampoline_110)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
UIModalPresentationStyle  _tdboth_protocolTrampoline_1b495tn(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_110)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UIModalTransitionStyle  (^_ProtocolTrampoline_111)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIModalTransitionStyle  _tdboth_protocolTrampoline_o3nor4(id target, void * sel) {
  return ((_ProtocolTrampoline_111)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UINSToolbarItemPresentationSize  (^_ProtocolTrampoline_112)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UINSToolbarItemPresentationSize  _tdboth_protocolTrampoline_ky0mvb(id target, void * sel) {
  return ((_ProtocolTrampoline_112)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UINavigationBarNSToolbarSection  (^_ProtocolTrampoline_113)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
UINavigationBarNSToolbarSection  _tdboth_protocolTrampoline_1d0ihm3(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_113)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef UIPageViewControllerSpineLocation  (^_ProtocolTrampoline_114)(void * sel, id arg1, UIInterfaceOrientation arg2);
__attribute__((visibility("default"))) __attribute__((used))
UIPageViewControllerSpineLocation  _tdboth_protocolTrampoline_wstwps(id target, void * sel, id arg1, UIInterfaceOrientation arg2) {
  return ((_ProtocolTrampoline_114)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UIPrinterCutterBehavior  (^_ProtocolTrampoline_115)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
UIPrinterCutterBehavior  _tdboth_protocolTrampoline_123jp2s(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_115)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UIRectEdge  (^_ProtocolTrampoline_116)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIRectEdge  _tdboth_protocolTrampoline_115ahz8(id target, void * sel) {
  return ((_ProtocolTrampoline_116)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIReturnKeyType  (^_ProtocolTrampoline_117)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIReturnKeyType  _tdboth_protocolTrampoline_lj3zeo(id target, void * sel) {
  return ((_ProtocolTrampoline_117)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UISceneCaptureState  (^_ProtocolTrampoline_118)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UISceneCaptureState  _tdboth_protocolTrampoline_dxga5i(id target, void * sel) {
  return ((_ProtocolTrampoline_118)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_119)(void * sel, NSDirectionalRectEdge arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_rjw3wx(id target, void * sel, NSDirectionalRectEdge arg1) {
  return ((_ProtocolTrampoline_119)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef UISplitViewControllerColumn  (^_ProtocolTrampoline_120)(void * sel, id arg1, UISplitViewControllerColumn arg2);
__attribute__((visibility("default"))) __attribute__((used))
UISplitViewControllerColumn  _tdboth_protocolTrampoline_15hh5db(id target, void * sel, id arg1, UISplitViewControllerColumn arg2) {
  return ((_ProtocolTrampoline_120)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UISplitViewControllerDisplayMode  (^_ProtocolTrampoline_121)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
UISplitViewControllerDisplayMode  _tdboth_protocolTrampoline_1d86oqd(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_121)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef UISplitViewControllerDisplayMode  (^_ProtocolTrampoline_122)(void * sel, id arg1, UISplitViewControllerDisplayMode arg2);
__attribute__((visibility("default"))) __attribute__((used))
UISplitViewControllerDisplayMode  _tdboth_protocolTrampoline_abu9b5(id target, void * sel, id arg1, UISplitViewControllerDisplayMode arg2) {
  return ((_ProtocolTrampoline_122)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UISplitViewControllerLayoutEnvironment  (^_ProtocolTrampoline_123)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UISplitViewControllerLayoutEnvironment  _tdboth_protocolTrampoline_rye8dh(id target, void * sel) {
  return ((_ProtocolTrampoline_123)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UISpringLoadedInteractionEffectState  (^_ProtocolTrampoline_124)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UISpringLoadedInteractionEffectState  _tdboth_protocolTrampoline_7dyt8b(id target, void * sel) {
  return ((_ProtocolTrampoline_124)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIStatusBarAnimation  (^_ProtocolTrampoline_125)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIStatusBarAnimation  _tdboth_protocolTrampoline_dqvytk(id target, void * sel) {
  return ((_ProtocolTrampoline_125)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIStatusBarStyle  (^_ProtocolTrampoline_126)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIStatusBarStyle  _tdboth_protocolTrampoline_1khrvfx(id target, void * sel) {
  return ((_ProtocolTrampoline_126)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITabAccessoryEnvironment  (^_ProtocolTrampoline_127)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITabAccessoryEnvironment  _tdboth_protocolTrampoline_1vzw3vb(id target, void * sel) {
  return ((_ProtocolTrampoline_127)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITableViewCellAccessoryType  (^_ProtocolTrampoline_128)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
UITableViewCellAccessoryType  _tdboth_protocolTrampoline_99g1re(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_128)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UITableViewCellEditingStyle  (^_ProtocolTrampoline_129)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
UITableViewCellEditingStyle  _tdboth_protocolTrampoline_xo1673(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_129)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UITextAutocapitalizationType  (^_ProtocolTrampoline_130)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextAutocapitalizationType  _tdboth_protocolTrampoline_1xv2mzh(id target, void * sel) {
  return ((_ProtocolTrampoline_130)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITextAutocorrectionType  (^_ProtocolTrampoline_131)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextAutocorrectionType  _tdboth_protocolTrampoline_1d3flt5(id target, void * sel) {
  return ((_ProtocolTrampoline_131)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITextDragOptions  (^_ProtocolTrampoline_132)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextDragOptions  _tdboth_protocolTrampoline_6l01qw(id target, void * sel) {
  return ((_ProtocolTrampoline_132)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITextDropEditability  (^_ProtocolTrampoline_133)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
UITextDropEditability  _tdboth_protocolTrampoline_1vvj0wr(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_133)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UITextInlinePredictionType  (^_ProtocolTrampoline_134)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextInlinePredictionType  _tdboth_protocolTrampoline_1byt4vk(id target, void * sel) {
  return ((_ProtocolTrampoline_134)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITextMathExpressionCompletionType  (^_ProtocolTrampoline_135)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextMathExpressionCompletionType  _tdboth_protocolTrampoline_nc807a(id target, void * sel) {
  return ((_ProtocolTrampoline_135)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_136)(void * sel, struct CGSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_1hb9fc7(id target, void * sel, struct CGSize arg1) {
  return ((_ProtocolTrampoline_136)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_137)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_jwxea6(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_137)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_138)(void * sel, id arg1, UITextGranularity arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_17ilkfe(id target, void * sel, id arg1, UITextGranularity arg2, long arg3) {
  return ((_ProtocolTrampoline_138)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_139)(void * sel, id arg1, UITextLayoutDirection arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_1n2o6o3(id target, void * sel, id arg1, UITextLayoutDirection arg2, long arg3) {
  return ((_ProtocolTrampoline_139)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_140)(void * sel, id arg1, UITextLayoutDirection arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_k9m9y9(id target, void * sel, id arg1, UITextLayoutDirection arg2) {
  return ((_ProtocolTrampoline_140)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UITextSmartDashesType  (^_ProtocolTrampoline_141)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextSmartDashesType  _tdboth_protocolTrampoline_17kij6f(id target, void * sel) {
  return ((_ProtocolTrampoline_141)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITextSmartInsertDeleteType  (^_ProtocolTrampoline_142)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextSmartInsertDeleteType  _tdboth_protocolTrampoline_1e0d9d5(id target, void * sel) {
  return ((_ProtocolTrampoline_142)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITextSmartQuotesType  (^_ProtocolTrampoline_143)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextSmartQuotesType  _tdboth_protocolTrampoline_1v1m8o4(id target, void * sel) {
  return ((_ProtocolTrampoline_143)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITextSpellCheckingType  (^_ProtocolTrampoline_144)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextSpellCheckingType  _tdboth_protocolTrampoline_1o7csqa(id target, void * sel) {
  return ((_ProtocolTrampoline_144)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITextStorageDirection  (^_ProtocolTrampoline_145)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextStorageDirection  _tdboth_protocolTrampoline_159vyjm(id target, void * sel) {
  return ((_ProtocolTrampoline_145)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITimingCurveType  (^_ProtocolTrampoline_146)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITimingCurveType  _tdboth_protocolTrampoline_1b0thcs(id target, void * sel) {
  return ((_ProtocolTrampoline_146)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITraitEnvironmentLayoutDirection  (^_ProtocolTrampoline_147)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITraitEnvironmentLayoutDirection  _tdboth_protocolTrampoline_xq5tn3(id target, void * sel) {
  return ((_ProtocolTrampoline_147)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIUserInterfaceActiveAppearance  (^_ProtocolTrampoline_148)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIUserInterfaceActiveAppearance  _tdboth_protocolTrampoline_1r4hjnp(id target, void * sel) {
  return ((_ProtocolTrampoline_148)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIUserInterfaceIdiom  (^_ProtocolTrampoline_149)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIUserInterfaceIdiom  _tdboth_protocolTrampoline_105ez3b(id target, void * sel) {
  return ((_ProtocolTrampoline_149)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIUserInterfaceLevel  (^_ProtocolTrampoline_150)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIUserInterfaceLevel  _tdboth_protocolTrampoline_1eol91l(id target, void * sel) {
  return ((_ProtocolTrampoline_150)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIUserInterfaceSizeClass  (^_ProtocolTrampoline_151)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIUserInterfaceSizeClass  _tdboth_protocolTrampoline_dat8c2(id target, void * sel) {
  return ((_ProtocolTrampoline_151)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIUserInterfaceStyle  (^_ProtocolTrampoline_152)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIUserInterfaceStyle  _tdboth_protocolTrampoline_z9dozg(id target, void * sel) {
  return ((_ProtocolTrampoline_152)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIViewAnimatingState  (^_ProtocolTrampoline_153)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIViewAnimatingState  _tdboth_protocolTrampoline_19bak41(id target, void * sel) {
  return ((_ProtocolTrampoline_153)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIViewAnimationCurve  (^_ProtocolTrampoline_154)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIViewAnimationCurve  _tdboth_protocolTrampoline_1q1046l(id target, void * sel) {
  return ((_ProtocolTrampoline_154)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_155)(void * sel, id arg1, UIModalPresentationStyle arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_11z5u7z(id target, void * sel, id arg1, UIModalPresentationStyle arg2) {
  return ((_ProtocolTrampoline_155)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_156)(void * sel, struct objc_selector * arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_c7gk2u(id target, void * sel, struct objc_selector * arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_156)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_157)(void * sel, id arg1, long arg2, long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_16qxnpx(id target, void * sel, id arg1, long arg2, long arg3, id arg4) {
  return ((_ProtocolTrampoline_157)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef UIWritingToolsBehavior  (^_ProtocolTrampoline_158)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIWritingToolsBehavior  _tdboth_protocolTrampoline_10qz50q(id target, void * sel) {
  return ((_ProtocolTrampoline_158)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIWritingToolsResultOptions  (^_ProtocolTrampoline_159)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIWritingToolsResultOptions  _tdboth_protocolTrampoline_ezd7fj(id target, void * sel) {
  return ((_ProtocolTrampoline_159)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef uint64_t  (^_ProtocolTrampoline_160)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
uint64_t  _tdboth_protocolTrampoline_k3xjiw(id target, void * sel) {
  return ((_ProtocolTrampoline_160)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_161)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_e3qsqz(id target, void * sel) {
  return ((_ProtocolTrampoline_161)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_162)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_3su7tt(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_162)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_163)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_jk8du5(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_163)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_164)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_1em3l8z(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_164)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_165)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_2n06mv(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_165)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_166)(void * sel, id arg1, struct CGRect * arg2, struct CGRect * arg3, double * arg4, id arg5, struct _NSRange arg6);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_1p38w4s(id target, void * sel, id arg1, struct CGRect * arg2, struct CGRect * arg3, double * arg4, id arg5, struct _NSRange arg6) {
  return ((_ProtocolTrampoline_166)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6);
}

typedef BOOL  (^_ProtocolTrampoline_167)(void * sel, id arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_16fgsa(id target, void * sel, id arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_167)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_168)(void * sel, id arg1, id arg2, NSTextContentManagerEnumerationOptions arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_r3hakm(id target, void * sel, id arg1, id arg2, NSTextContentManagerEnumerationOptions arg3) {
  return ((_ProtocolTrampoline_168)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_169)(void * sel, id arg1, id arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_t3vpwz(id target, void * sel, id arg1, id arg2, BOOL arg3) {
  return ((_ProtocolTrampoline_169)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_170)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_rptcvw(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_170)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_171)(void * sel, id arg1, struct objc_selector * arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_1yp3wri(id target, void * sel, id arg1, struct objc_selector * arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_171)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_172)(void * sel, id arg1, struct objc_selector * arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_122cere(id target, void * sel, id arg1, struct objc_selector * arg2) {
  return ((_ProtocolTrampoline_172)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_173)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_1ae3jer(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_173)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_174)(void * sel, id arg1, struct CGPoint arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_g0ff12(id target, void * sel, id arg1, struct CGPoint arg2) {
  return ((_ProtocolTrampoline_174)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_175)(void * sel, id arg1, struct _NSRange arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_u18wpp(id target, void * sel, id arg1, struct _NSRange arg2, id arg3) {
  return ((_ProtocolTrampoline_175)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_176)(void * sel, id arg1, id arg2, UIInterfaceOrientation arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_crkhyo(id target, void * sel, id arg1, id arg2, UIInterfaceOrientation arg3) {
  return ((_ProtocolTrampoline_176)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_177)(void * sel, id arg1, UITextGranularity arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_szbl4c(id target, void * sel, id arg1, UITextGranularity arg2, long arg3) {
  return ((_ProtocolTrampoline_177)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_178)(void * sel, id arg1, id arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_132e89p(id target, void * sel, id arg1, id arg2, struct _NSRange arg3) {
  return ((_ProtocolTrampoline_178)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_179)(void * sel, id arg1, id arg2, struct _NSRange arg3, UITextItemInteraction arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_11bdmat(id target, void * sel, id arg1, id arg2, struct _NSRange arg3, UITextItemInteraction arg4) {
  return ((_ProtocolTrampoline_179)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_180)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_1ja9agx(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_180)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_181)(void * sel, id arg1, id arg2, UIWebViewNavigationType arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_162dnig(id target, void * sel, id arg1, id arg2, UIWebViewNavigationType arg3) {
  return ((_ProtocolTrampoline_181)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_182)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_23kxg8(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_182)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_183)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_jogy9n(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_183)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_184)(void * sel, struct objc_selector * arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _tdboth_protocolTrampoline_1yvmq2c(id target, void * sel, struct objc_selector * arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_184)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef double  (^_ProtocolTrampoline_185)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
double  _tdboth_protocolTrampoline_tfvuzk(id target, void * sel) {
  return ((_ProtocolTrampoline_185)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef float  (^_ProtocolTrampoline_186)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
float  _tdboth_protocolTrampoline_66c10j(id target, void * sel) {
  return ((_ProtocolTrampoline_186)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef float  (^_ProtocolTrampoline_187)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
float  _tdboth_protocolTrampoline_1o407rf(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_187)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef long  (^_ProtocolTrampoline_188)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
long  _tdboth_protocolTrampoline_fai2e9(id target, void * sel) {
  return ((_ProtocolTrampoline_188)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef short  (^_ProtocolTrampoline_189)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
short  _tdboth_protocolTrampoline_p984hf(id target, void * sel) {
  return ((_ProtocolTrampoline_189)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef size_t  (^_ProtocolTrampoline_190)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
size_t  _tdboth_protocolTrampoline_150qdkd(id target, void * sel) {
  return ((_ProtocolTrampoline_190)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline)(void);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _tdboth_wrapListenerBlock_1pl9qdv(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void() {
    objc_retainBlock(block);
    block();
  };
}

typedef void  (^_BlockingTrampoline)(void * waiter);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _tdboth_wrapBlockingBlock_1pl9qdv(
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
_ListenerTrampoline_1 _tdboth_wrapListenerBlock_xtuoz7(_ListenerTrampoline_1 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0));
  };
}

typedef void  (^_BlockingTrampoline_1)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _tdboth_wrapBlockingBlock_xtuoz7(
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
_ListenerTrampoline_2 _tdboth_wrapListenerBlock_o4flre(_ListenerTrampoline_2 block) NS_RETURNS_RETAINED {
  return ^void(double arg0, id arg1, BOOL arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_2)(void * waiter, double arg0, id arg1, BOOL arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _tdboth_wrapBlockingBlock_o4flre(
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
_ListenerTrampoline_3 _tdboth_wrapListenerBlock_1k4qrah(_ListenerTrampoline_3 block) NS_RETURNS_RETAINED {
  return ^void(struct CGRect arg0, struct CGRect arg1, id arg2, struct _NSRange arg3, BOOL * arg4) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_3)(void * waiter, struct CGRect arg0, struct CGRect arg1, id arg2, struct _NSRange arg3, BOOL * arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _tdboth_wrapBlockingBlock_1k4qrah(
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
_ListenerTrampoline_4 _tdboth_wrapListenerBlock_aoc6k0(_ListenerTrampoline_4 block) NS_RETURNS_RETAINED {
  return ^void(struct CGRect arg0, BOOL * arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_4)(void * waiter, struct CGRect arg0, BOOL * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _tdboth_wrapBlockingBlock_aoc6k0(
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
_ListenerTrampoline_5 _tdboth_wrapListenerBlock_r8gdi7(_ListenerTrampoline_5 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_5)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _tdboth_wrapBlockingBlock_r8gdi7(
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
_ListenerTrampoline_6 _tdboth_wrapListenerBlock_14v8ia(_ListenerTrampoline_6 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct CGPoint arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_6)(void * waiter, id arg0, struct CGPoint arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _tdboth_wrapBlockingBlock_14v8ia(
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
_ListenerTrampoline_7 _tdboth_wrapListenerBlock_pfv6jd(_ListenerTrampoline_7 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_7)(void * waiter, id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _tdboth_wrapBlockingBlock_pfv6jd(
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

typedef void  (^_ListenerTrampoline_8)(id arg0, long arg1, struct CGRect arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _tdboth_wrapListenerBlock_11l3kq6(_ListenerTrampoline_8 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, long arg1, struct CGRect arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_8)(void * waiter, id arg0, long arg1, struct CGRect arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _tdboth_wrapBlockingBlock_11l3kq6(
    _BlockingTrampoline_8 block, _BlockingTrampoline_8 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, long arg1, struct CGRect arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef void  (^_ListenerTrampoline_9)(id arg0, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _tdboth_wrapListenerBlock_rnu2c5(_ListenerTrampoline_9 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_9)(void * waiter, id arg0, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _tdboth_wrapBlockingBlock_rnu2c5(
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
_ListenerTrampoline_10 _tdboth_wrapListenerBlock_1uqbrux(_ListenerTrampoline_10 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_10)(void * waiter, id arg0, BOOL arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _tdboth_wrapBlockingBlock_1uqbrux(
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
_ListenerTrampoline_11 _tdboth_wrapListenerBlock_1a22wz(_ListenerTrampoline_11 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_11)(void * waiter, id arg0, struct _NSRange arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _tdboth_wrapBlockingBlock_1a22wz(
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

typedef void  (^_ListenerTrampoline_12)(id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _tdboth_wrapListenerBlock_1b3bb6a(_ListenerTrampoline_12 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(objc_retainBlock(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_12)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _tdboth_wrapBlockingBlock_1b3bb6a(
    _BlockingTrampoline_12 block, _BlockingTrampoline_12 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, objc_retainBlock(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, objc_retainBlock(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ListenerTrampoline_13)(struct _NSRange arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _tdboth_wrapListenerBlock_1tv4uax(_ListenerTrampoline_13 block) NS_RETURNS_RETAINED {
  return ^void(struct _NSRange arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_13)(void * waiter, struct _NSRange arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _tdboth_wrapBlockingBlock_1tv4uax(
    _BlockingTrampoline_13 block, _BlockingTrampoline_13 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(struct _NSRange arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_14)(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _tdboth_wrapListenerBlock_lmc3p5(_ListenerTrampoline_14 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_14)(void * waiter, id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _tdboth_wrapBlockingBlock_lmc3p5(
    _BlockingTrampoline_14 block, _BlockingTrampoline_14 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, struct _NSRange arg1, struct _NSRange arg2, BOOL * arg3), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2, arg3);
  });
}

typedef void  (^_ListenerTrampoline_15)(id arg0, id arg1, id arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _tdboth_wrapListenerBlock_fo7rrt(_ListenerTrampoline_15 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2, BOOL * arg3) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_15)(void * waiter, id arg0, id arg1, id arg2, BOOL * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _tdboth_wrapBlockingBlock_fo7rrt(
    _BlockingTrampoline_15 block, _BlockingTrampoline_15 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, id arg2, BOOL * arg3), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ListenerTrampoline_16)(id arg0, NSMatchingFlags arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _tdboth_wrapListenerBlock_6jvo9y(_ListenerTrampoline_16 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, NSMatchingFlags arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_16)(void * waiter, id arg0, NSMatchingFlags arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _tdboth_wrapBlockingBlock_6jvo9y(
    _BlockingTrampoline_16 block, _BlockingTrampoline_16 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, NSMatchingFlags arg1, BOOL * arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef void  (^_ListenerTrampoline_17)(NSURLSessionAuthChallengeDisposition arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _tdboth_wrapListenerBlock_n8yd09(_ListenerTrampoline_17 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionAuthChallengeDisposition arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_17)(void * waiter, NSURLSessionAuthChallengeDisposition arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _tdboth_wrapBlockingBlock_n8yd09(
    _BlockingTrampoline_17 block, _BlockingTrampoline_17 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(NSURLSessionAuthChallengeDisposition arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_18)(NSURLSessionDelayedRequestDisposition arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _tdboth_wrapListenerBlock_1otpo83(_ListenerTrampoline_18 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionDelayedRequestDisposition arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_18)(void * waiter, NSURLSessionDelayedRequestDisposition arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _tdboth_wrapBlockingBlock_1otpo83(
    _BlockingTrampoline_18 block, _BlockingTrampoline_18 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(NSURLSessionDelayedRequestDisposition arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_19)(NSURLSessionResponseDisposition arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_19 _tdboth_wrapListenerBlock_16sve1d(_ListenerTrampoline_19 block) NS_RETURNS_RETAINED {
  return ^void(NSURLSessionResponseDisposition arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_19)(void * waiter, NSURLSessionResponseDisposition arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_19 _tdboth_wrapBlockingBlock_16sve1d(
    _BlockingTrampoline_19 block, _BlockingTrampoline_19 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(NSURLSessionResponseDisposition arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_20)(id arg0, UIDocumentBrowserImportMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_20 _tdboth_wrapListenerBlock_1jff4hs(_ListenerTrampoline_20 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, UIDocumentBrowserImportMode arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1);
  };
}

typedef void  (^_BlockingTrampoline_20)(void * waiter, id arg0, UIDocumentBrowserImportMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_20 _tdboth_wrapBlockingBlock_1jff4hs(
    _BlockingTrampoline_20 block, _BlockingTrampoline_20 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, UIDocumentBrowserImportMode arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  });
}

typedef void  (^_ListenerTrampoline_21)(id arg0, id arg1, struct objc_selector * arg2, UIControlEvents arg3, BOOL * arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_21 _tdboth_wrapListenerBlock_1cxqo1i(_ListenerTrampoline_21 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, struct objc_selector * arg2, UIControlEvents arg3, BOOL * arg4) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_21)(void * waiter, id arg0, id arg1, struct objc_selector * arg2, UIControlEvents arg3, BOOL * arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_21 _tdboth_wrapBlockingBlock_1cxqo1i(
    _BlockingTrampoline_21 block, _BlockingTrampoline_21 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, struct objc_selector * arg2, UIControlEvents arg3, BOOL * arg4), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ListenerTrampoline_22)(id arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_22 _tdboth_wrapListenerBlock_6p7ndb(_ListenerTrampoline_22 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1);
  };
}

typedef void  (^_BlockingTrampoline_22)(void * waiter, id arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_22 _tdboth_wrapBlockingBlock_6p7ndb(
    _BlockingTrampoline_22 block, _BlockingTrampoline_22 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  });
}

typedef void  (^_ListenerTrampoline_23)(id arg0, BOOL arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_23 _tdboth_wrapListenerBlock_13x5jor(_ListenerTrampoline_23 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_23)(void * waiter, id arg0, BOOL arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_23 _tdboth_wrapBlockingBlock_13x5jor(
    _BlockingTrampoline_23 block, _BlockingTrampoline_23 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ListenerTrampoline_24)(UIBackgroundFetchResult arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_24 _tdboth_wrapListenerBlock_l6dgk2(_ListenerTrampoline_24 block) NS_RETURNS_RETAINED {
  return ^void(UIBackgroundFetchResult arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_24)(void * waiter, UIBackgroundFetchResult arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_24 _tdboth_wrapBlockingBlock_l6dgk2(
    _BlockingTrampoline_24 block, _BlockingTrampoline_24 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(UIBackgroundFetchResult arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_25)(id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_25 _tdboth_wrapListenerBlock_o762yo(_ListenerTrampoline_25 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), objc_retainBlock(arg1));
  };
}

typedef void  (^_BlockingTrampoline_25)(void * waiter, id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_25 _tdboth_wrapBlockingBlock_o762yo(
    _BlockingTrampoline_25 block, _BlockingTrampoline_25 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), objc_retainBlock(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), objc_retainBlock(arg1));
  });
}

typedef void  (^_ListenerTrampoline_26)(id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_26 _tdboth_wrapListenerBlock_18qun1e(_ListenerTrampoline_26 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  };
}

typedef void  (^_BlockingTrampoline_26)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_26 _tdboth_wrapBlockingBlock_18qun1e(
    _BlockingTrampoline_26 block, _BlockingTrampoline_26 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  });
}

typedef void  (^_ListenerTrampoline_27)(UIViewAnimatingPosition arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_27 _tdboth_wrapListenerBlock_cgf7tp(_ListenerTrampoline_27 block) NS_RETURNS_RETAINED {
  return ^void(UIViewAnimatingPosition arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_27)(void * waiter, UIViewAnimatingPosition arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_27 _tdboth_wrapBlockingBlock_cgf7tp(
    _BlockingTrampoline_27 block, _BlockingTrampoline_27 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(UIViewAnimatingPosition arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_28)(BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_28 _tdboth_wrapListenerBlock_1s56lr9(_ListenerTrampoline_28 block) NS_RETURNS_RETAINED {
  return ^void(BOOL arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_28)(void * waiter, BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_28 _tdboth_wrapBlockingBlock_1s56lr9(
    _BlockingTrampoline_28 block, _BlockingTrampoline_28 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(BOOL arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_29)(BOOL arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_29 _tdboth_wrapListenerBlock_14iqu8t(_ListenerTrampoline_29 block) NS_RETURNS_RETAINED {
  return ^void(BOOL arg0, BOOL arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_29)(void * waiter, BOOL arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_29 _tdboth_wrapBlockingBlock_14iqu8t(
    _BlockingTrampoline_29 block, _BlockingTrampoline_29 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(BOOL arg0, BOOL arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ListenerTrampoline_30)(float arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_30 _tdboth_wrapListenerBlock_v5hmet(_ListenerTrampoline_30 block) NS_RETURNS_RETAINED {
  return ^void(float arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_30)(void * waiter, float arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_30 _tdboth_wrapBlockingBlock_v5hmet(
    _BlockingTrampoline_30 block, _BlockingTrampoline_30 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(float arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_31)(void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_31 _tdboth_wrapListenerBlock_ovsamd(_ListenerTrampoline_31 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_31)(void * waiter, void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_31 _tdboth_wrapBlockingBlock_ovsamd(
    _BlockingTrampoline_31 block, _BlockingTrampoline_31 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ProtocolTrampoline_191)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_ovsamd(id target, void * sel) {
  return ((_ProtocolTrampoline_191)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_32)(id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_32 _tdboth_wrapListenerBlock_f167m6(_ListenerTrampoline_32 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block(objc_retainBlock(arg0));
  };
}

typedef void  (^_BlockingTrampoline_32)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_32 _tdboth_wrapBlockingBlock_f167m6(
    _BlockingTrampoline_32 block, _BlockingTrampoline_32 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0), {
    objc_retainBlock(block);
    block(nil, objc_retainBlock(arg0));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, objc_retainBlock(arg0));
  });
}

typedef void *  (^_ProtocolTrampoline_192)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
void *  _tdboth_protocolTrampoline_3fl8pv(id target, void * sel) {
  return ((_ProtocolTrampoline_192)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_33)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_33 _tdboth_wrapListenerBlock_18v1jvf(_ListenerTrampoline_33 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_33)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_33 _tdboth_wrapBlockingBlock_18v1jvf(
    _BlockingTrampoline_33 block, _BlockingTrampoline_33 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_193)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_18v1jvf(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_193)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_34)(void * arg0, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_34 _tdboth_wrapListenerBlock_zzthnb(_ListenerTrampoline_34 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, BOOL arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_34)(void * waiter, void * arg0, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_34 _tdboth_wrapBlockingBlock_zzthnb(
    _BlockingTrampoline_34 block, _BlockingTrampoline_34 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, BOOL arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_194)(void * sel, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_zzthnb(id target, void * sel, id arg1, BOOL arg2) {
  return ((_ProtocolTrampoline_194)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_35)(void * arg0, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_35 _tdboth_wrapListenerBlock_qvcerx(_ListenerTrampoline_35 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGContext * arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_35)(void * waiter, void * arg0, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_35 _tdboth_wrapBlockingBlock_qvcerx(
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

typedef void  (^_ProtocolTrampoline_195)(void * sel, id arg1, struct CGContext * arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_qvcerx(id target, void * sel, id arg1, struct CGContext * arg2) {
  return ((_ProtocolTrampoline_195)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_36)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_36 _tdboth_wrapListenerBlock_fjrv01(_ListenerTrampoline_36 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_36)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_36 _tdboth_wrapBlockingBlock_fjrv01(
    _BlockingTrampoline_36 block, _BlockingTrampoline_36 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_196)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_fjrv01(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_196)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_37)(void * arg0, struct CATransform3D arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_37 _tdboth_wrapListenerBlock_12flqkv(_ListenerTrampoline_37 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CATransform3D arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_37)(void * waiter, void * arg0, struct CATransform3D arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_37 _tdboth_wrapBlockingBlock_12flqkv(
    _BlockingTrampoline_37 block, _BlockingTrampoline_37 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CATransform3D arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_197)(void * sel, struct CATransform3D arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_12flqkv(id target, void * sel, struct CATransform3D arg1) {
  return ((_ProtocolTrampoline_197)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_38)(void * arg0, struct CGAffineTransform arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_38 _tdboth_wrapListenerBlock_1lznlw3(_ListenerTrampoline_38 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGAffineTransform arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_38)(void * waiter, void * arg0, struct CGAffineTransform arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_38 _tdboth_wrapBlockingBlock_1lznlw3(
    _BlockingTrampoline_38 block, _BlockingTrampoline_38 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGAffineTransform arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_198)(void * sel, struct CGAffineTransform arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1lznlw3(id target, void * sel, struct CGAffineTransform arg1) {
  return ((_ProtocolTrampoline_198)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_39)(void * arg0, double arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_39 _tdboth_wrapListenerBlock_1g6ud1c(_ListenerTrampoline_39 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, double arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_39)(void * waiter, void * arg0, double arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_39 _tdboth_wrapBlockingBlock_1g6ud1c(
    _BlockingTrampoline_39 block, _BlockingTrampoline_39 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, double arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_199)(void * sel, double arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1g6ud1c(id target, void * sel, double arg1, id arg2) {
  return ((_ProtocolTrampoline_199)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_40)(void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_40 _tdboth_wrapListenerBlock_1bktu2(_ListenerTrampoline_40 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGPoint arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_40)(void * waiter, void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_40 _tdboth_wrapBlockingBlock_1bktu2(
    _BlockingTrampoline_40 block, _BlockingTrampoline_40 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGPoint arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_200)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1bktu2(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_200)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_41)(void * arg0, struct CGRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_41 _tdboth_wrapListenerBlock_1e49sma(_ListenerTrampoline_41 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGRect arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_41)(void * waiter, void * arg0, struct CGRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_41 _tdboth_wrapBlockingBlock_1e49sma(
    _BlockingTrampoline_41 block, _BlockingTrampoline_41 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGRect arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_201)(void * sel, struct CGRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1e49sma(id target, void * sel, struct CGRect arg1) {
  return ((_ProtocolTrampoline_201)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_42)(void * arg0, struct CGSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_42 _tdboth_wrapListenerBlock_leirm3(_ListenerTrampoline_42 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGSize arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_42)(void * waiter, void * arg0, struct CGSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_42 _tdboth_wrapBlockingBlock_leirm3(
    _BlockingTrampoline_42 block, _BlockingTrampoline_42 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGSize arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_202)(void * sel, struct CGSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_leirm3(id target, void * sel, struct CGSize arg1) {
  return ((_ProtocolTrampoline_202)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_43)(void * arg0, struct CGSize arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_43 _tdboth_wrapListenerBlock_1rn6eap(_ListenerTrampoline_43 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGSize arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_43)(void * waiter, void * arg0, struct CGSize arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_43 _tdboth_wrapBlockingBlock_1rn6eap(
    _BlockingTrampoline_43 block, _BlockingTrampoline_43 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGSize arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_203)(void * sel, struct CGSize arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1rn6eap(id target, void * sel, struct CGSize arg1, id arg2) {
  return ((_ProtocolTrampoline_203)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_44)(void * arg0, id arg1, struct objc_selector * arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_44 _tdboth_wrapListenerBlock_3khjw6(_ListenerTrampoline_44 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct objc_selector * arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_44)(void * waiter, void * arg0, id arg1, struct objc_selector * arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_44 _tdboth_wrapBlockingBlock_3khjw6(
    _BlockingTrampoline_44 block, _BlockingTrampoline_44 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct objc_selector * arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_204)(void * sel, id arg1, struct objc_selector * arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_3khjw6(id target, void * sel, id arg1, struct objc_selector * arg2, id arg3) {
  return ((_ProtocolTrampoline_204)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_45)(void * arg0, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_45 _tdboth_wrapListenerBlock_ayxzy9(_ListenerTrampoline_45 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct _NSRange arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_45)(void * waiter, void * arg0, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_45 _tdboth_wrapBlockingBlock_ayxzy9(
    _BlockingTrampoline_45 block, _BlockingTrampoline_45 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct _NSRange arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_205)(void * sel, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_ayxzy9(id target, void * sel, id arg1, struct _NSRange arg2) {
  return ((_ProtocolTrampoline_205)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_46)(void * arg0, NSDirectionalRectEdge arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_46 _tdboth_wrapListenerBlock_wmxylx(_ListenerTrampoline_46 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSDirectionalRectEdge arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_46)(void * waiter, void * arg0, NSDirectionalRectEdge arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_46 _tdboth_wrapBlockingBlock_wmxylx(
    _BlockingTrampoline_46 block, _BlockingTrampoline_46 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSDirectionalRectEdge arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_206)(void * sel, NSDirectionalRectEdge arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_wmxylx(id target, void * sel, NSDirectionalRectEdge arg1) {
  return ((_ProtocolTrampoline_206)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_47)(void * arg0, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_47 _tdboth_wrapListenerBlock_unr2j3(_ListenerTrampoline_47 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, long arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_47)(void * waiter, void * arg0, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_47 _tdboth_wrapBlockingBlock_unr2j3(
    _BlockingTrampoline_47 block, _BlockingTrampoline_47 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, long arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_207)(void * sel, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_unr2j3(id target, void * sel, long arg1) {
  return ((_ProtocolTrampoline_207)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_48)(void * arg0, long arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_48 _tdboth_wrapListenerBlock_1453bv9(_ListenerTrampoline_48 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, long arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_48)(void * waiter, void * arg0, long arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_48 _tdboth_wrapBlockingBlock_1453bv9(
    _BlockingTrampoline_48 block, _BlockingTrampoline_48 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, long arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_208)(void * sel, long arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1453bv9(id target, void * sel, long arg1, id arg2) {
  return ((_ProtocolTrampoline_208)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_49)(void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_49 _tdboth_wrapListenerBlock_1tz5yf(_ListenerTrampoline_49 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_49)(void * waiter, void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_49 _tdboth_wrapBlockingBlock_1tz5yf(
    _BlockingTrampoline_49 block, _BlockingTrampoline_49 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_209)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1tz5yf(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_209)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_50)(void * arg0, id arg1, id arg2, struct CGSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_50 _tdboth_wrapListenerBlock_13mvetb(_ListenerTrampoline_50 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct CGSize arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_50)(void * waiter, void * arg0, id arg1, id arg2, struct CGSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_50 _tdboth_wrapBlockingBlock_13mvetb(
    _BlockingTrampoline_50 block, _BlockingTrampoline_50 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct CGSize arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_210)(void * sel, id arg1, id arg2, struct CGSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_13mvetb(id target, void * sel, id arg1, id arg2, struct CGSize arg3) {
  return ((_ProtocolTrampoline_210)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_51)(void * arg0, id arg1, id arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_51 _tdboth_wrapListenerBlock_8acz2h(_ListenerTrampoline_51 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, BOOL arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_51)(void * waiter, void * arg0, id arg1, id arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_51 _tdboth_wrapBlockingBlock_8acz2h(
    _BlockingTrampoline_51 block, _BlockingTrampoline_51 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, BOOL arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_211)(void * sel, id arg1, id arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_8acz2h(id target, void * sel, id arg1, id arg2, BOOL arg3) {
  return ((_ProtocolTrampoline_211)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_52)(void * arg0, id arg1, id arg2, UITextAlternativeStyle arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_52 _tdboth_wrapListenerBlock_xt280e(_ListenerTrampoline_52 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, UITextAlternativeStyle arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_52)(void * waiter, void * arg0, id arg1, id arg2, UITextAlternativeStyle arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_52 _tdboth_wrapBlockingBlock_xt280e(
    _BlockingTrampoline_52 block, _BlockingTrampoline_52 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, UITextAlternativeStyle arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_212)(void * sel, id arg1, id arg2, UITextAlternativeStyle arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_xt280e(id target, void * sel, id arg1, id arg2, UITextAlternativeStyle arg3) {
  return ((_ProtocolTrampoline_212)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_53)(void * arg0, id arg1, UIGuidedAccessRestrictionState arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_53 _tdboth_wrapListenerBlock_vrkvde(_ListenerTrampoline_53 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UIGuidedAccessRestrictionState arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_53)(void * waiter, void * arg0, id arg1, UIGuidedAccessRestrictionState arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_53 _tdboth_wrapBlockingBlock_vrkvde(
    _BlockingTrampoline_53 block, _BlockingTrampoline_53 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UIGuidedAccessRestrictionState arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_213)(void * sel, id arg1, UIGuidedAccessRestrictionState arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_vrkvde(id target, void * sel, id arg1, UIGuidedAccessRestrictionState arg2) {
  return ((_ProtocolTrampoline_213)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_54)(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_54 _tdboth_wrapListenerBlock_19w094r(_ListenerTrampoline_54 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_54)(void * waiter, void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_54 _tdboth_wrapBlockingBlock_19w094r(
    _BlockingTrampoline_54 block, _BlockingTrampoline_54 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_214)(void * sel, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_19w094r(id target, void * sel, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4) {
  return ((_ProtocolTrampoline_214)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_55)(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_55 _tdboth_wrapListenerBlock_1ucjyxt(_ListenerTrampoline_55 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5);
  };
}

typedef void  (^_BlockingTrampoline_55)(void * waiter, void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_55 _tdboth_wrapBlockingBlock_1ucjyxt(
    _BlockingTrampoline_55 block, _BlockingTrampoline_55 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4, arg5);
  });
}

typedef void  (^_ProtocolTrampoline_215)(void * sel, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1ucjyxt(id target, void * sel, id arg1, NSTextStorageEditActions arg2, struct _NSRange arg3, long arg4, struct _NSRange arg5) {
  return ((_ProtocolTrampoline_215)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_56)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_56 _tdboth_wrapListenerBlock_jk1ljc(_ListenerTrampoline_56 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  };
}

typedef void  (^_BlockingTrampoline_56)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_56 _tdboth_wrapBlockingBlock_jk1ljc(
    _BlockingTrampoline_56 block, _BlockingTrampoline_56 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_216)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_jk1ljc(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_216)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_57)(void * arg0, id arg1, long arg2, long arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_57 _tdboth_wrapListenerBlock_15e9dqx(_ListenerTrampoline_57 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long arg2, long arg3, long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_57)(void * waiter, void * arg0, id arg1, long arg2, long arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_57 _tdboth_wrapBlockingBlock_15e9dqx(
    _BlockingTrampoline_57 block, _BlockingTrampoline_57 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long arg2, long arg3, long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_217)(void * sel, id arg1, long arg2, long arg3, long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_15e9dqx(id target, void * sel, id arg1, long arg2, long arg3, long arg4) {
  return ((_ProtocolTrampoline_217)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_58)(void * arg0, id arg1, long long arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_58 _tdboth_wrapListenerBlock_9crvvv(_ListenerTrampoline_58 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long long arg2, long long arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_58)(void * waiter, void * arg0, id arg1, long long arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_58 _tdboth_wrapBlockingBlock_9crvvv(
    _BlockingTrampoline_58 block, _BlockingTrampoline_58 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long long arg2, long long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_218)(void * sel, id arg1, long long arg2, long long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_9crvvv(id target, void * sel, id arg1, long long arg2, long long arg3) {
  return ((_ProtocolTrampoline_218)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_59)(void * arg0, id arg1, long long arg2, long long arg3, long long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_59 _tdboth_wrapListenerBlock_1qf1qkl(_ListenerTrampoline_59 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long long arg2, long long arg3, long long arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_59)(void * waiter, void * arg0, id arg1, long long arg2, long long arg3, long long arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_59 _tdboth_wrapBlockingBlock_1qf1qkl(
    _BlockingTrampoline_59 block, _BlockingTrampoline_59 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long long arg2, long long arg3, long long arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_219)(void * sel, id arg1, long long arg2, long long arg3, long long arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1qf1qkl(id target, void * sel, id arg1, long long arg2, long long arg3, long long arg4) {
  return ((_ProtocolTrampoline_219)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_60)(void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_60 _tdboth_wrapListenerBlock_1j7coyk(_ListenerTrampoline_60 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_60)(void * waiter, void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_60 _tdboth_wrapBlockingBlock_1j7coyk(
    _BlockingTrampoline_60 block, _BlockingTrampoline_60 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, NSURLCacheStoragePolicy arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_220)(void * sel, id arg1, id arg2, NSURLCacheStoragePolicy arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1j7coyk(id target, void * sel, id arg1, id arg2, NSURLCacheStoragePolicy arg3) {
  return ((_ProtocolTrampoline_220)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_61)(void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_61 _tdboth_wrapListenerBlock_bklti2(_ListenerTrampoline_61 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_61)(void * waiter, void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_61 _tdboth_wrapBlockingBlock_bklti2(
    _BlockingTrampoline_61 block, _BlockingTrampoline_61 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_221)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_bklti2(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_221)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_62)(void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_62 _tdboth_wrapListenerBlock_xx612k(_ListenerTrampoline_62 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  };
}

typedef void  (^_BlockingTrampoline_62)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_62 _tdboth_wrapBlockingBlock_xx612k(
    _BlockingTrampoline_62 block, _BlockingTrampoline_62 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_222)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_xx612k(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_222)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_63)(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_63 _tdboth_wrapListenerBlock_ly2579(_ListenerTrampoline_63 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_63)(void * waiter, void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_63 _tdboth_wrapBlockingBlock_ly2579(
    _BlockingTrampoline_63 block, _BlockingTrampoline_63 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4);
  });
}

typedef void  (^_ProtocolTrampoline_223)(void * sel, id arg1, id arg2, int64_t arg3, int64_t arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_ly2579(id target, void * sel, id arg1, id arg2, int64_t arg3, int64_t arg4) {
  return ((_ProtocolTrampoline_223)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_64)(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_64 _tdboth_wrapListenerBlock_h68abb(_ListenerTrampoline_64 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4, arg5);
  };
}

typedef void  (^_BlockingTrampoline_64)(void * waiter, void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_64 _tdboth_wrapBlockingBlock_h68abb(
    _BlockingTrampoline_64 block, _BlockingTrampoline_64 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4, arg5);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, arg4, arg5);
  });
}

typedef void  (^_ProtocolTrampoline_224)(void * sel, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_h68abb(id target, void * sel, id arg1, id arg2, int64_t arg3, int64_t arg4, int64_t arg5) {
  return ((_ProtocolTrampoline_224)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_65)(void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_65 _tdboth_wrapListenerBlock_8jfq1p(_ListenerTrampoline_65 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_65)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_65 _tdboth_wrapBlockingBlock_8jfq1p(
    _BlockingTrampoline_65 block, _BlockingTrampoline_65 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_225)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_8jfq1p(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_225)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_66)(void * arg0, id arg1, id arg2, int64_t arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_66 _tdboth_wrapListenerBlock_jyim80(_ListenerTrampoline_66 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, int64_t arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, objc_retainBlock(arg4));
  };
}

typedef void  (^_BlockingTrampoline_66)(void * waiter, void * arg0, id arg1, id arg2, int64_t arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_66 _tdboth_wrapBlockingBlock_jyim80(
    _BlockingTrampoline_66 block, _BlockingTrampoline_66 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, int64_t arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, objc_retainBlock(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, objc_retainBlock(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_226)(void * sel, id arg1, id arg2, int64_t arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_jyim80(id target, void * sel, id arg1, id arg2, int64_t arg3, id arg4) {
  return ((_ProtocolTrampoline_226)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_67)(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_67 _tdboth_wrapListenerBlock_l2g8ke(_ListenerTrampoline_67 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  };
}

typedef void  (^_BlockingTrampoline_67)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_67 _tdboth_wrapBlockingBlock_l2g8ke(
    _BlockingTrampoline_67 block, _BlockingTrampoline_67 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  });
}

typedef void  (^_ProtocolTrampoline_227)(void * sel, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_l2g8ke(id target, void * sel, id arg1, id arg2, id arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_227)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_68)(void * arg0, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_68 _tdboth_wrapListenerBlock_1lx650f(_ListenerTrampoline_68 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_68)(void * waiter, void * arg0, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_68 _tdboth_wrapBlockingBlock_1lx650f(
    _BlockingTrampoline_68 block, _BlockingTrampoline_68 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_228)(void * sel, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1lx650f(id target, void * sel, id arg1, id arg2, NSURLSessionWebSocketCloseCode arg3, id arg4) {
  return ((_ProtocolTrampoline_228)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_69)(void * arg0, NSWritingDirection arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_69 _tdboth_wrapListenerBlock_elgbmd(_ListenerTrampoline_69 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSWritingDirection arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_69)(void * waiter, void * arg0, NSWritingDirection arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_69 _tdboth_wrapBlockingBlock_elgbmd(
    _BlockingTrampoline_69 block, _BlockingTrampoline_69 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSWritingDirection arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_229)(void * sel, NSWritingDirection arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_elgbmd(id target, void * sel, NSWritingDirection arg1, id arg2) {
  return ((_ProtocolTrampoline_229)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_70)(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_70 _tdboth_wrapListenerBlock_m09tr7(_ListenerTrampoline_70 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  };
}

typedef void  (^_BlockingTrampoline_70)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_70 _tdboth_wrapBlockingBlock_m09tr7(
    _BlockingTrampoline_70 block, _BlockingTrampoline_70 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4, id arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), (__bridge id)(__bridge_retained void*)(arg5));
  });
}

typedef void  (^_ProtocolTrampoline_230)(void * sel, id arg1, id arg2, id arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_m09tr7(id target, void * sel, id arg1, id arg2, id arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_230)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_71)(void * arg0, UIAccessibilityContrast arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_71 _tdboth_wrapListenerBlock_wpry4n(_ListenerTrampoline_71 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIAccessibilityContrast arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_71)(void * waiter, void * arg0, UIAccessibilityContrast arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_71 _tdboth_wrapBlockingBlock_wpry4n(
    _BlockingTrampoline_71 block, _BlockingTrampoline_71 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIAccessibilityContrast arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_231)(void * sel, UIAccessibilityContrast arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_wpry4n(id target, void * sel, UIAccessibilityContrast arg1) {
  return ((_ProtocolTrampoline_231)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_72)(void * arg0, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_72 _tdboth_wrapListenerBlock_1wp3it5(_ListenerTrampoline_72 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_72)(void * waiter, void * arg0, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_72 _tdboth_wrapBlockingBlock_1wp3it5(
    _BlockingTrampoline_72 block, _BlockingTrampoline_72 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_232)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1wp3it5(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_232)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_73)(void * arg0, id arg1, struct CGRect arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_73 _tdboth_wrapListenerBlock_ustzvs(_ListenerTrampoline_73 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGRect arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_73)(void * waiter, void * arg0, id arg1, struct CGRect arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_73 _tdboth_wrapBlockingBlock_ustzvs(
    _BlockingTrampoline_73 block, _BlockingTrampoline_73 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGRect arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_233)(void * sel, id arg1, struct CGRect arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_ustzvs(id target, void * sel, id arg1, struct CGRect arg2) {
  return ((_ProtocolTrampoline_233)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_74)(void * arg0, id arg1, UIInterfaceOrientation arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_74 _tdboth_wrapListenerBlock_1dzhcvo(_ListenerTrampoline_74 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UIInterfaceOrientation arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_74)(void * waiter, void * arg0, id arg1, UIInterfaceOrientation arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_74 _tdboth_wrapBlockingBlock_1dzhcvo(
    _BlockingTrampoline_74 block, _BlockingTrampoline_74 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UIInterfaceOrientation arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_234)(void * sel, id arg1, UIInterfaceOrientation arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1dzhcvo(id target, void * sel, id arg1, UIInterfaceOrientation arg2) {
  return ((_ProtocolTrampoline_234)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_75)(void * arg0, id arg1, UIInterfaceOrientation arg2, double arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_75 _tdboth_wrapListenerBlock_z8eyrz(_ListenerTrampoline_75 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UIInterfaceOrientation arg2, double arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_75)(void * waiter, void * arg0, id arg1, UIInterfaceOrientation arg2, double arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_75 _tdboth_wrapBlockingBlock_z8eyrz(
    _BlockingTrampoline_75 block, _BlockingTrampoline_75 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UIInterfaceOrientation arg2, double arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_235)(void * sel, id arg1, UIInterfaceOrientation arg2, double arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_z8eyrz(id target, void * sel, id arg1, UIInterfaceOrientation arg2, double arg3) {
  return ((_ProtocolTrampoline_235)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_76)(void * arg0, id arg1, struct objc_selector * arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_76 _tdboth_wrapListenerBlock_zthvms(_ListenerTrampoline_76 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct objc_selector * arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_76)(void * waiter, void * arg0, id arg1, struct objc_selector * arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_76 _tdboth_wrapBlockingBlock_zthvms(
    _BlockingTrampoline_76 block, _BlockingTrampoline_76 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct objc_selector * arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_236)(void * sel, id arg1, struct objc_selector * arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_zthvms(id target, void * sel, id arg1, struct objc_selector * arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_236)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_77)(void * arg0, id arg1, id arg2, id arg3, struct CGPoint arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_77 _tdboth_wrapListenerBlock_13vf580(_ListenerTrampoline_77 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, struct CGPoint arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4);
  };
}

typedef void  (^_BlockingTrampoline_77)(void * waiter, void * arg0, id arg1, id arg2, id arg3, struct CGPoint arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_77 _tdboth_wrapBlockingBlock_13vf580(
    _BlockingTrampoline_77 block, _BlockingTrampoline_77 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, struct CGPoint arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), arg4);
  });
}

typedef void  (^_ProtocolTrampoline_237)(void * sel, id arg1, id arg2, id arg3, struct CGPoint arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_13vf580(id target, void * sel, id arg1, id arg2, id arg3, struct CGPoint arg4) {
  return ((_ProtocolTrampoline_237)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_78)(void * arg0, UIContextMenuInteractionCommitStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_78 _tdboth_wrapListenerBlock_9yu383(_ListenerTrampoline_78 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIContextMenuInteractionCommitStyle arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_78)(void * waiter, void * arg0, UIContextMenuInteractionCommitStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_78 _tdboth_wrapBlockingBlock_9yu383(
    _BlockingTrampoline_78 block, _BlockingTrampoline_78 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIContextMenuInteractionCommitStyle arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_238)(void * sel, UIContextMenuInteractionCommitStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_9yu383(id target, void * sel, UIContextMenuInteractionCommitStyle arg1) {
  return ((_ProtocolTrampoline_238)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_79)(void * arg0, UIDisplayGamut arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_79 _tdboth_wrapListenerBlock_k3o9k7(_ListenerTrampoline_79 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIDisplayGamut arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_79)(void * waiter, void * arg0, UIDisplayGamut arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_79 _tdboth_wrapBlockingBlock_k3o9k7(
    _BlockingTrampoline_79 block, _BlockingTrampoline_79 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIDisplayGamut arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_239)(void * sel, UIDisplayGamut arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_k3o9k7(id target, void * sel, UIDisplayGamut arg1) {
  return ((_ProtocolTrampoline_239)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_80)(void * arg0, id arg1, id arg2, UIDropOperation arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_80 _tdboth_wrapListenerBlock_zrfj47(_ListenerTrampoline_80 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, UIDropOperation arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_80)(void * waiter, void * arg0, id arg1, id arg2, UIDropOperation arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_80 _tdboth_wrapBlockingBlock_zrfj47(
    _BlockingTrampoline_80 block, _BlockingTrampoline_80 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, UIDropOperation arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_240)(void * sel, id arg1, id arg2, UIDropOperation arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_zrfj47(id target, void * sel, id arg1, id arg2, UIDropOperation arg3) {
  return ((_ProtocolTrampoline_240)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_81)(void * arg0, UIDropSessionProgressIndicatorStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_81 _tdboth_wrapListenerBlock_b53a8b(_ListenerTrampoline_81 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIDropSessionProgressIndicatorStyle arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_81)(void * waiter, void * arg0, UIDropSessionProgressIndicatorStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_81 _tdboth_wrapBlockingBlock_b53a8b(
    _BlockingTrampoline_81 block, _BlockingTrampoline_81 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIDropSessionProgressIndicatorStyle arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_241)(void * sel, UIDropSessionProgressIndicatorStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_b53a8b(id target, void * sel, UIDropSessionProgressIndicatorStyle arg1) {
  return ((_ProtocolTrampoline_241)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_82)(void * arg0, UIForceTouchCapability arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_82 _tdboth_wrapListenerBlock_1ifv5ez(_ListenerTrampoline_82 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIForceTouchCapability arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_82)(void * waiter, void * arg0, UIForceTouchCapability arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_82 _tdboth_wrapBlockingBlock_1ifv5ez(
    _BlockingTrampoline_82 block, _BlockingTrampoline_82 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIForceTouchCapability arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_242)(void * sel, UIForceTouchCapability arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1ifv5ez(id target, void * sel, UIForceTouchCapability arg1) {
  return ((_ProtocolTrampoline_242)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_83)(void * arg0, UIImageDynamicRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_83 _tdboth_wrapListenerBlock_6h2ktc(_ListenerTrampoline_83 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIImageDynamicRange arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_83)(void * waiter, void * arg0, UIImageDynamicRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_83 _tdboth_wrapBlockingBlock_6h2ktc(
    _BlockingTrampoline_83 block, _BlockingTrampoline_83 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIImageDynamicRange arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_243)(void * sel, UIImageDynamicRange arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_6h2ktc(id target, void * sel, UIImageDynamicRange arg1) {
  return ((_ProtocolTrampoline_243)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_84)(void * arg0, id arg1, struct CGRect arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_84 _tdboth_wrapListenerBlock_1u7ntgr(_ListenerTrampoline_84 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGRect arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_84)(void * waiter, void * arg0, id arg1, struct CGRect arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_84 _tdboth_wrapBlockingBlock_1u7ntgr(
    _BlockingTrampoline_84 block, _BlockingTrampoline_84 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGRect arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_244)(void * sel, id arg1, struct CGRect arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1u7ntgr(id target, void * sel, id arg1, struct CGRect arg2, id arg3) {
  return ((_ProtocolTrampoline_244)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_85)(void * arg0, id arg1, id arg2, struct CGPoint arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_85 _tdboth_wrapListenerBlock_y4drw5(_ListenerTrampoline_85 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct CGPoint arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, objc_retainBlock(arg4));
  };
}

typedef void  (^_BlockingTrampoline_85)(void * waiter, void * arg0, id arg1, id arg2, struct CGPoint arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_85 _tdboth_wrapBlockingBlock_y4drw5(
    _BlockingTrampoline_85 block, _BlockingTrampoline_85 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct CGPoint arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, objc_retainBlock(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, objc_retainBlock(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_245)(void * sel, id arg1, id arg2, struct CGPoint arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_y4drw5(id target, void * sel, id arg1, id arg2, struct CGPoint arg3, id arg4) {
  return ((_ProtocolTrampoline_245)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_86)(void * arg0, UIKeyboardAppearance arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_86 _tdboth_wrapListenerBlock_ygwzfa(_ListenerTrampoline_86 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIKeyboardAppearance arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_86)(void * waiter, void * arg0, UIKeyboardAppearance arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_86 _tdboth_wrapBlockingBlock_ygwzfa(
    _BlockingTrampoline_86 block, _BlockingTrampoline_86 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIKeyboardAppearance arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_246)(void * sel, UIKeyboardAppearance arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_ygwzfa(id target, void * sel, UIKeyboardAppearance arg1) {
  return ((_ProtocolTrampoline_246)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_87)(void * arg0, UIKeyboardType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_87 _tdboth_wrapListenerBlock_65vlqw(_ListenerTrampoline_87 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIKeyboardType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_87)(void * waiter, void * arg0, UIKeyboardType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_87 _tdboth_wrapBlockingBlock_65vlqw(
    _BlockingTrampoline_87 block, _BlockingTrampoline_87 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIKeyboardType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_247)(void * sel, UIKeyboardType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_65vlqw(id target, void * sel, UIKeyboardType arg1) {
  return ((_ProtocolTrampoline_247)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_88)(void * arg0, id arg1, id arg2, struct CGPoint arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_88 _tdboth_wrapListenerBlock_4w8ame(_ListenerTrampoline_88 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct CGPoint arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_88)(void * waiter, void * arg0, id arg1, id arg2, struct CGPoint arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_88 _tdboth_wrapBlockingBlock_4w8ame(
    _BlockingTrampoline_88 block, _BlockingTrampoline_88 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct CGPoint arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_248)(void * sel, id arg1, id arg2, struct CGPoint arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_4w8ame(id target, void * sel, id arg1, id arg2, struct CGPoint arg3) {
  return ((_ProtocolTrampoline_248)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_89)(void * arg0, UILegibilityWeight arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_89 _tdboth_wrapListenerBlock_f6bqwx(_ListenerTrampoline_89 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UILegibilityWeight arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_89)(void * waiter, void * arg0, UILegibilityWeight arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_89 _tdboth_wrapBlockingBlock_f6bqwx(
    _BlockingTrampoline_89 block, _BlockingTrampoline_89 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UILegibilityWeight arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_249)(void * sel, UILegibilityWeight arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_f6bqwx(id target, void * sel, UILegibilityWeight arg1) {
  return ((_ProtocolTrampoline_249)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_90)(void * arg0, UILetterformAwareSizingRule arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_90 _tdboth_wrapListenerBlock_1k3rxc1(_ListenerTrampoline_90 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UILetterformAwareSizingRule arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_90)(void * waiter, void * arg0, UILetterformAwareSizingRule arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_90 _tdboth_wrapBlockingBlock_1k3rxc1(
    _BlockingTrampoline_90 block, _BlockingTrampoline_90 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UILetterformAwareSizingRule arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_250)(void * sel, UILetterformAwareSizingRule arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1k3rxc1(id target, void * sel, UILetterformAwareSizingRule arg1) {
  return ((_ProtocolTrampoline_250)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_91)(void * arg0, UIListEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_91 _tdboth_wrapListenerBlock_6nmvtq(_ListenerTrampoline_91 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIListEnvironment arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_91)(void * waiter, void * arg0, UIListEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_91 _tdboth_wrapBlockingBlock_6nmvtq(
    _BlockingTrampoline_91 block, _BlockingTrampoline_91 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIListEnvironment arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_251)(void * sel, UIListEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_6nmvtq(id target, void * sel, UIListEnvironment arg1) {
  return ((_ProtocolTrampoline_251)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_92)(void * arg0, UIMenuElementAttributes arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_92 _tdboth_wrapListenerBlock_1lmpkp(_ListenerTrampoline_92 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIMenuElementAttributes arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_92)(void * waiter, void * arg0, UIMenuElementAttributes arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_92 _tdboth_wrapBlockingBlock_1lmpkp(
    _BlockingTrampoline_92 block, _BlockingTrampoline_92 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIMenuElementAttributes arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_252)(void * sel, UIMenuElementAttributes arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1lmpkp(id target, void * sel, UIMenuElementAttributes arg1) {
  return ((_ProtocolTrampoline_252)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_93)(void * arg0, UIMenuElementRepeatBehavior arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_93 _tdboth_wrapListenerBlock_1wqrf61(_ListenerTrampoline_93 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIMenuElementRepeatBehavior arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_93)(void * waiter, void * arg0, UIMenuElementRepeatBehavior arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_93 _tdboth_wrapBlockingBlock_1wqrf61(
    _BlockingTrampoline_93 block, _BlockingTrampoline_93 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIMenuElementRepeatBehavior arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_253)(void * sel, UIMenuElementRepeatBehavior arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1wqrf61(id target, void * sel, UIMenuElementRepeatBehavior arg1) {
  return ((_ProtocolTrampoline_253)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_94)(void * arg0, UIMenuElementState arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_94 _tdboth_wrapListenerBlock_1mm4s9d(_ListenerTrampoline_94 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIMenuElementState arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_94)(void * waiter, void * arg0, UIMenuElementState arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_94 _tdboth_wrapBlockingBlock_1mm4s9d(
    _BlockingTrampoline_94 block, _BlockingTrampoline_94 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIMenuElementState arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_254)(void * sel, UIMenuElementState arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1mm4s9d(id target, void * sel, UIMenuElementState arg1) {
  return ((_ProtocolTrampoline_254)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_95)(void * arg0, UIModalPresentationStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_95 _tdboth_wrapListenerBlock_1t4edop(_ListenerTrampoline_95 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIModalPresentationStyle arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_95)(void * waiter, void * arg0, UIModalPresentationStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_95 _tdboth_wrapBlockingBlock_1t4edop(
    _BlockingTrampoline_95 block, _BlockingTrampoline_95 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIModalPresentationStyle arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_255)(void * sel, UIModalPresentationStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1t4edop(id target, void * sel, UIModalPresentationStyle arg1) {
  return ((_ProtocolTrampoline_255)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_96)(void * arg0, UIModalTransitionStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_96 _tdboth_wrapListenerBlock_1oclfry(_ListenerTrampoline_96 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIModalTransitionStyle arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_96)(void * waiter, void * arg0, UIModalTransitionStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_96 _tdboth_wrapBlockingBlock_1oclfry(
    _BlockingTrampoline_96 block, _BlockingTrampoline_96 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIModalTransitionStyle arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_256)(void * sel, UIModalTransitionStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1oclfry(id target, void * sel, UIModalTransitionStyle arg1) {
  return ((_ProtocolTrampoline_256)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_97)(void * arg0, UINSToolbarItemPresentationSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_97 _tdboth_wrapListenerBlock_1j3snqt(_ListenerTrampoline_97 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UINSToolbarItemPresentationSize arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_97)(void * waiter, void * arg0, UINSToolbarItemPresentationSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_97 _tdboth_wrapBlockingBlock_1j3snqt(
    _BlockingTrampoline_97 block, _BlockingTrampoline_97 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UINSToolbarItemPresentationSize arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_257)(void * sel, UINSToolbarItemPresentationSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1j3snqt(id target, void * sel, UINSToolbarItemPresentationSize arg1) {
  return ((_ProtocolTrampoline_257)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_98)(void * arg0, id arg1, BOOL arg2, id arg3, BOOL arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_98 _tdboth_wrapListenerBlock_hcu3ph(_ListenerTrampoline_98 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, BOOL arg2, id arg3, BOOL arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  };
}

typedef void  (^_BlockingTrampoline_98)(void * waiter, void * arg0, id arg1, BOOL arg2, id arg3, BOOL arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_98 _tdboth_wrapBlockingBlock_hcu3ph(
    _BlockingTrampoline_98 block, _BlockingTrampoline_98 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, BOOL arg2, id arg3, BOOL arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), arg4);
  });
}

typedef void  (^_ProtocolTrampoline_258)(void * sel, id arg1, BOOL arg2, id arg3, BOOL arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_hcu3ph(id target, void * sel, id arg1, BOOL arg2, id arg3, BOOL arg4) {
  return ((_ProtocolTrampoline_258)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_99)(void * arg0, id arg1, long arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_99 _tdboth_wrapListenerBlock_98c27v(_ListenerTrampoline_99 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long arg2, long arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_99)(void * waiter, void * arg0, id arg1, long arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_99 _tdboth_wrapBlockingBlock_98c27v(
    _BlockingTrampoline_99 block, _BlockingTrampoline_99 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long arg2, long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_259)(void * sel, id arg1, long arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_98c27v(id target, void * sel, id arg1, long arg2, long arg3) {
  return ((_ProtocolTrampoline_259)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_100)(void * arg0, id arg1, struct CGRect * arg2, id * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_100 _tdboth_wrapListenerBlock_g5ysnr(_ListenerTrampoline_100 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGRect * arg2, id * arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_100)(void * waiter, void * arg0, id arg1, struct CGRect * arg2, id * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_100 _tdboth_wrapBlockingBlock_g5ysnr(
    _BlockingTrampoline_100 block, _BlockingTrampoline_100 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGRect * arg2, id * arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_260)(void * sel, id arg1, struct CGRect * arg2, id * arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_g5ysnr(id target, void * sel, id arg1, struct CGRect * arg2, id * arg3) {
  return ((_ProtocolTrampoline_260)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_101)(void * arg0, id arg1, UIModalPresentationStyle arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_101 _tdboth_wrapListenerBlock_tcf25t(_ListenerTrampoline_101 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UIModalPresentationStyle arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_101)(void * waiter, void * arg0, id arg1, UIModalPresentationStyle arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_101 _tdboth_wrapBlockingBlock_tcf25t(
    _BlockingTrampoline_101 block, _BlockingTrampoline_101 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UIModalPresentationStyle arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_261)(void * sel, id arg1, UIModalPresentationStyle arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_tcf25t(id target, void * sel, id arg1, UIModalPresentationStyle arg2, id arg3) {
  return ((_ProtocolTrampoline_261)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_102)(void * arg0, id arg1, double arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_102 _tdboth_wrapListenerBlock_phul3w(_ListenerTrampoline_102 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, double arg2, BOOL arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_102)(void * waiter, void * arg0, id arg1, double arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_102 _tdboth_wrapBlockingBlock_phul3w(
    _BlockingTrampoline_102 block, _BlockingTrampoline_102 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, double arg2, BOOL arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_262)(void * sel, id arg1, double arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_phul3w(id target, void * sel, id arg1, double arg2, BOOL arg3) {
  return ((_ProtocolTrampoline_262)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_103)(void * arg0, UIRectEdge arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_103 _tdboth_wrapListenerBlock_1866l6q(_ListenerTrampoline_103 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIRectEdge arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_103)(void * waiter, void * arg0, UIRectEdge arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_103 _tdboth_wrapBlockingBlock_1866l6q(
    _BlockingTrampoline_103 block, _BlockingTrampoline_103 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIRectEdge arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_263)(void * sel, UIRectEdge arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1866l6q(id target, void * sel, UIRectEdge arg1) {
  return ((_ProtocolTrampoline_263)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_104)(void * arg0, UIReturnKeyType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_104 _tdboth_wrapListenerBlock_16k97um(_ListenerTrampoline_104 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIReturnKeyType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_104)(void * waiter, void * arg0, UIReturnKeyType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_104 _tdboth_wrapBlockingBlock_16k97um(
    _BlockingTrampoline_104 block, _BlockingTrampoline_104 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIReturnKeyType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_264)(void * sel, UIReturnKeyType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_16k97um(id target, void * sel, UIReturnKeyType arg1) {
  return ((_ProtocolTrampoline_264)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_105)(void * arg0, UISceneCaptureState arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_105 _tdboth_wrapListenerBlock_g764c0(_ListenerTrampoline_105 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UISceneCaptureState arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_105)(void * waiter, void * arg0, UISceneCaptureState arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_105 _tdboth_wrapBlockingBlock_g764c0(
    _BlockingTrampoline_105 block, _BlockingTrampoline_105 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UISceneCaptureState arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_265)(void * sel, UISceneCaptureState arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_g764c0(id target, void * sel, UISceneCaptureState arg1) {
  return ((_ProtocolTrampoline_265)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_106)(void * arg0, id arg1, struct CGPoint arg2, struct CGPoint * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_106 _tdboth_wrapListenerBlock_1y0a88x(_ListenerTrampoline_106 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGPoint arg2, struct CGPoint * arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_106)(void * waiter, void * arg0, id arg1, struct CGPoint arg2, struct CGPoint * arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_106 _tdboth_wrapBlockingBlock_1y0a88x(
    _BlockingTrampoline_106 block, _BlockingTrampoline_106 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGPoint arg2, struct CGPoint * arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_266)(void * sel, id arg1, struct CGPoint arg2, struct CGPoint * arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1y0a88x(id target, void * sel, id arg1, struct CGPoint arg2, struct CGPoint * arg3) {
  return ((_ProtocolTrampoline_266)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_107)(void * arg0, id arg1, NSDirectionalRectEdge arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_107 _tdboth_wrapListenerBlock_119a3ez(_ListenerTrampoline_107 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, NSDirectionalRectEdge arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_107)(void * waiter, void * arg0, id arg1, NSDirectionalRectEdge arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_107 _tdboth_wrapBlockingBlock_119a3ez(
    _BlockingTrampoline_107 block, _BlockingTrampoline_107 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, NSDirectionalRectEdge arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_267)(void * sel, id arg1, NSDirectionalRectEdge arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_119a3ez(id target, void * sel, id arg1, NSDirectionalRectEdge arg2) {
  return ((_ProtocolTrampoline_267)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_108)(void * arg0, id arg1, id arg2, double arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_108 _tdboth_wrapListenerBlock_gxqm8e(_ListenerTrampoline_108 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, double arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_108)(void * waiter, void * arg0, id arg1, id arg2, double arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_108 _tdboth_wrapBlockingBlock_gxqm8e(
    _BlockingTrampoline_108 block, _BlockingTrampoline_108 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, double arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_268)(void * sel, id arg1, id arg2, double arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_gxqm8e(id target, void * sel, id arg1, id arg2, double arg3) {
  return ((_ProtocolTrampoline_268)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_109)(void * arg0, id arg1, UINavigationItemSearchBarPlacement arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_109 _tdboth_wrapListenerBlock_wu5tg2(_ListenerTrampoline_109 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UINavigationItemSearchBarPlacement arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_109)(void * waiter, void * arg0, id arg1, UINavigationItemSearchBarPlacement arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_109 _tdboth_wrapBlockingBlock_wu5tg2(
    _BlockingTrampoline_109 block, _BlockingTrampoline_109 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UINavigationItemSearchBarPlacement arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_269)(void * sel, id arg1, UINavigationItemSearchBarPlacement arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_wu5tg2(id target, void * sel, id arg1, UINavigationItemSearchBarPlacement arg2) {
  return ((_ProtocolTrampoline_269)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_110)(void * arg0, UISplitViewControllerLayoutEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_110 _tdboth_wrapListenerBlock_17x4a9j(_ListenerTrampoline_110 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UISplitViewControllerLayoutEnvironment arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_110)(void * waiter, void * arg0, UISplitViewControllerLayoutEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_110 _tdboth_wrapBlockingBlock_17x4a9j(
    _BlockingTrampoline_110 block, _BlockingTrampoline_110 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UISplitViewControllerLayoutEnvironment arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_270)(void * sel, UISplitViewControllerLayoutEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_17x4a9j(id target, void * sel, UISplitViewControllerLayoutEnvironment arg1) {
  return ((_ProtocolTrampoline_270)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_111)(void * arg0, id arg1, UISplitViewControllerColumn arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_111 _tdboth_wrapListenerBlock_hv980a(_ListenerTrampoline_111 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UISplitViewControllerColumn arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_111)(void * waiter, void * arg0, id arg1, UISplitViewControllerColumn arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_111 _tdboth_wrapBlockingBlock_hv980a(
    _BlockingTrampoline_111 block, _BlockingTrampoline_111 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UISplitViewControllerColumn arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_271)(void * sel, id arg1, UISplitViewControllerColumn arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_hv980a(id target, void * sel, id arg1, UISplitViewControllerColumn arg2) {
  return ((_ProtocolTrampoline_271)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_112)(void * arg0, id arg1, UISplitViewControllerDisplayMode arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_112 _tdboth_wrapListenerBlock_1iqnsiz(_ListenerTrampoline_112 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UISplitViewControllerDisplayMode arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_112)(void * waiter, void * arg0, id arg1, UISplitViewControllerDisplayMode arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_112 _tdboth_wrapBlockingBlock_1iqnsiz(
    _BlockingTrampoline_112 block, _BlockingTrampoline_112 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UISplitViewControllerDisplayMode arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_272)(void * sel, id arg1, UISplitViewControllerDisplayMode arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1iqnsiz(id target, void * sel, id arg1, UISplitViewControllerDisplayMode arg2) {
  return ((_ProtocolTrampoline_272)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_113)(void * arg0, UITabAccessoryEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_113 _tdboth_wrapListenerBlock_w40jp9(_ListenerTrampoline_113 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITabAccessoryEnvironment arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_113)(void * waiter, void * arg0, UITabAccessoryEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_113 _tdboth_wrapBlockingBlock_w40jp9(
    _BlockingTrampoline_113 block, _BlockingTrampoline_113 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITabAccessoryEnvironment arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_273)(void * sel, UITabAccessoryEnvironment arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_w40jp9(id target, void * sel, UITabAccessoryEnvironment arg1) {
  return ((_ProtocolTrampoline_273)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_114)(void * arg0, id arg1, UITableViewCellEditingStyle arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_114 _tdboth_wrapListenerBlock_1qqt3t1(_ListenerTrampoline_114 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UITableViewCellEditingStyle arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_114)(void * waiter, void * arg0, id arg1, UITableViewCellEditingStyle arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_114 _tdboth_wrapBlockingBlock_1qqt3t1(
    _BlockingTrampoline_114 block, _BlockingTrampoline_114 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UITableViewCellEditingStyle arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_274)(void * sel, id arg1, UITableViewCellEditingStyle arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1qqt3t1(id target, void * sel, id arg1, UITableViewCellEditingStyle arg2, id arg3) {
  return ((_ProtocolTrampoline_274)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_115)(void * arg0, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_115 _tdboth_wrapListenerBlock_e6jln7(_ListenerTrampoline_115 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, long arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_115)(void * waiter, void * arg0, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_115 _tdboth_wrapBlockingBlock_e6jln7(
    _BlockingTrampoline_115 block, _BlockingTrampoline_115 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_275)(void * sel, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_e6jln7(id target, void * sel, id arg1, id arg2, long arg3) {
  return ((_ProtocolTrampoline_275)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_116)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_116 _tdboth_wrapListenerBlock_1l4hxwm(_ListenerTrampoline_116 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retainBlock(arg1));
  };
}

typedef void  (^_BlockingTrampoline_116)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_116 _tdboth_wrapBlockingBlock_1l4hxwm(
    _BlockingTrampoline_116 block, _BlockingTrampoline_116 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, objc_retainBlock(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, objc_retainBlock(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_276)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1l4hxwm(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_276)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_117)(void * arg0, UITextAutocapitalizationType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_117 _tdboth_wrapListenerBlock_1j3gd57(_ListenerTrampoline_117 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextAutocapitalizationType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_117)(void * waiter, void * arg0, UITextAutocapitalizationType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_117 _tdboth_wrapBlockingBlock_1j3gd57(
    _BlockingTrampoline_117 block, _BlockingTrampoline_117 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextAutocapitalizationType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_277)(void * sel, UITextAutocapitalizationType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1j3gd57(id target, void * sel, UITextAutocapitalizationType arg1) {
  return ((_ProtocolTrampoline_277)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_118)(void * arg0, UITextAutocorrectionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_118 _tdboth_wrapListenerBlock_mqcqqj(_ListenerTrampoline_118 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextAutocorrectionType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_118)(void * waiter, void * arg0, UITextAutocorrectionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_118 _tdboth_wrapBlockingBlock_mqcqqj(
    _BlockingTrampoline_118 block, _BlockingTrampoline_118 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextAutocorrectionType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_278)(void * sel, UITextAutocorrectionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_mqcqqj(id target, void * sel, UITextAutocorrectionType arg1) {
  return ((_ProtocolTrampoline_278)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_119)(void * arg0, UITextDragOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_119 _tdboth_wrapListenerBlock_1gonnvy(_ListenerTrampoline_119 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextDragOptions arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_119)(void * waiter, void * arg0, UITextDragOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_119 _tdboth_wrapBlockingBlock_1gonnvy(
    _BlockingTrampoline_119 block, _BlockingTrampoline_119 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextDragOptions arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_279)(void * sel, UITextDragOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1gonnvy(id target, void * sel, UITextDragOptions arg1) {
  return ((_ProtocolTrampoline_279)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_120)(void * arg0, id arg1, UITextFieldDidEndEditingReason arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_120 _tdboth_wrapListenerBlock_18wmx9i(_ListenerTrampoline_120 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UITextFieldDidEndEditingReason arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_120)(void * waiter, void * arg0, id arg1, UITextFieldDidEndEditingReason arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_120 _tdboth_wrapBlockingBlock_18wmx9i(
    _BlockingTrampoline_120 block, _BlockingTrampoline_120 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UITextFieldDidEndEditingReason arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_280)(void * sel, id arg1, UITextFieldDidEndEditingReason arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_18wmx9i(id target, void * sel, id arg1, UITextFieldDidEndEditingReason arg2) {
  return ((_ProtocolTrampoline_280)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_121)(void * arg0, UITextInlinePredictionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_121 _tdboth_wrapListenerBlock_17cibua(_ListenerTrampoline_121 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextInlinePredictionType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_121)(void * waiter, void * arg0, UITextInlinePredictionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_121 _tdboth_wrapBlockingBlock_17cibua(
    _BlockingTrampoline_121 block, _BlockingTrampoline_121 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextInlinePredictionType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_281)(void * sel, UITextInlinePredictionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_17cibua(id target, void * sel, UITextInlinePredictionType arg1) {
  return ((_ProtocolTrampoline_281)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_122)(void * arg0, UITextMathExpressionCompletionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_122 _tdboth_wrapListenerBlock_1142ncg(_ListenerTrampoline_122 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextMathExpressionCompletionType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_122)(void * waiter, void * arg0, UITextMathExpressionCompletionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_122 _tdboth_wrapBlockingBlock_1142ncg(
    _BlockingTrampoline_122 block, _BlockingTrampoline_122 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextMathExpressionCompletionType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_282)(void * sel, UITextMathExpressionCompletionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1142ncg(id target, void * sel, UITextMathExpressionCompletionType arg1) {
  return ((_ProtocolTrampoline_282)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_123)(void * arg0, id arg1, id arg2, UITextSearchFoundTextStyle arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_123 _tdboth_wrapListenerBlock_x8ytla(_ListenerTrampoline_123 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, UITextSearchFoundTextStyle arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_123)(void * waiter, void * arg0, id arg1, id arg2, UITextSearchFoundTextStyle arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_123 _tdboth_wrapBlockingBlock_x8ytla(
    _BlockingTrampoline_123 block, _BlockingTrampoline_123 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, UITextSearchFoundTextStyle arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_283)(void * sel, id arg1, id arg2, UITextSearchFoundTextStyle arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_x8ytla(id target, void * sel, id arg1, id arg2, UITextSearchFoundTextStyle arg3) {
  return ((_ProtocolTrampoline_283)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_124)(void * arg0, UITextSmartDashesType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_124 _tdboth_wrapListenerBlock_1jo5fi9(_ListenerTrampoline_124 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextSmartDashesType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_124)(void * waiter, void * arg0, UITextSmartDashesType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_124 _tdboth_wrapBlockingBlock_1jo5fi9(
    _BlockingTrampoline_124 block, _BlockingTrampoline_124 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextSmartDashesType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_284)(void * sel, UITextSmartDashesType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1jo5fi9(id target, void * sel, UITextSmartDashesType arg1) {
  return ((_ProtocolTrampoline_284)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_125)(void * arg0, UITextSmartInsertDeleteType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_125 _tdboth_wrapListenerBlock_lk25kr(_ListenerTrampoline_125 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextSmartInsertDeleteType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_125)(void * waiter, void * arg0, UITextSmartInsertDeleteType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_125 _tdboth_wrapBlockingBlock_lk25kr(
    _BlockingTrampoline_125 block, _BlockingTrampoline_125 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextSmartInsertDeleteType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_285)(void * sel, UITextSmartInsertDeleteType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_lk25kr(id target, void * sel, UITextSmartInsertDeleteType arg1) {
  return ((_ProtocolTrampoline_285)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_126)(void * arg0, UITextSmartQuotesType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_126 _tdboth_wrapListenerBlock_1wgfcbu(_ListenerTrampoline_126 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextSmartQuotesType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_126)(void * waiter, void * arg0, UITextSmartQuotesType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_126 _tdboth_wrapBlockingBlock_1wgfcbu(
    _BlockingTrampoline_126 block, _BlockingTrampoline_126 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextSmartQuotesType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_286)(void * sel, UITextSmartQuotesType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1wgfcbu(id target, void * sel, UITextSmartQuotesType arg1) {
  return ((_ProtocolTrampoline_286)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_127)(void * arg0, UITextSpellCheckingType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_127 _tdboth_wrapListenerBlock_87wnoc(_ListenerTrampoline_127 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextSpellCheckingType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_127)(void * waiter, void * arg0, UITextSpellCheckingType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_127 _tdboth_wrapBlockingBlock_87wnoc(
    _BlockingTrampoline_127 block, _BlockingTrampoline_127 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextSpellCheckingType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_287)(void * sel, UITextSpellCheckingType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_87wnoc(id target, void * sel, UITextSpellCheckingType arg1) {
  return ((_ProtocolTrampoline_287)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_128)(void * arg0, UITextStorageDirection arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_128 _tdboth_wrapListenerBlock_1hk7a7s(_ListenerTrampoline_128 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextStorageDirection arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_128)(void * waiter, void * arg0, UITextStorageDirection arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_128 _tdboth_wrapBlockingBlock_1hk7a7s(
    _BlockingTrampoline_128 block, _BlockingTrampoline_128 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextStorageDirection arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_288)(void * sel, UITextStorageDirection arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1hk7a7s(id target, void * sel, UITextStorageDirection arg1) {
  return ((_ProtocolTrampoline_288)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_129)(void * arg0, UITraitEnvironmentLayoutDirection arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_129 _tdboth_wrapListenerBlock_1nlyfpt(_ListenerTrampoline_129 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITraitEnvironmentLayoutDirection arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_129)(void * waiter, void * arg0, UITraitEnvironmentLayoutDirection arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_129 _tdboth_wrapBlockingBlock_1nlyfpt(
    _BlockingTrampoline_129 block, _BlockingTrampoline_129 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITraitEnvironmentLayoutDirection arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_289)(void * sel, UITraitEnvironmentLayoutDirection arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1nlyfpt(id target, void * sel, UITraitEnvironmentLayoutDirection arg1) {
  return ((_ProtocolTrampoline_289)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_130)(void * arg0, UIUserInterfaceActiveAppearance arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_130 _tdboth_wrapListenerBlock_c30qzr(_ListenerTrampoline_130 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIUserInterfaceActiveAppearance arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_130)(void * waiter, void * arg0, UIUserInterfaceActiveAppearance arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_130 _tdboth_wrapBlockingBlock_c30qzr(
    _BlockingTrampoline_130 block, _BlockingTrampoline_130 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIUserInterfaceActiveAppearance arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_290)(void * sel, UIUserInterfaceActiveAppearance arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_c30qzr(id target, void * sel, UIUserInterfaceActiveAppearance arg1) {
  return ((_ProtocolTrampoline_290)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_131)(void * arg0, UIUserInterfaceIdiom arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_131 _tdboth_wrapListenerBlock_i9yv41(_ListenerTrampoline_131 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIUserInterfaceIdiom arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_131)(void * waiter, void * arg0, UIUserInterfaceIdiom arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_131 _tdboth_wrapBlockingBlock_i9yv41(
    _BlockingTrampoline_131 block, _BlockingTrampoline_131 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIUserInterfaceIdiom arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_291)(void * sel, UIUserInterfaceIdiom arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_i9yv41(id target, void * sel, UIUserInterfaceIdiom arg1) {
  return ((_ProtocolTrampoline_291)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_132)(void * arg0, UIUserInterfaceLevel arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_132 _tdboth_wrapListenerBlock_1f63hfj(_ListenerTrampoline_132 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIUserInterfaceLevel arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_132)(void * waiter, void * arg0, UIUserInterfaceLevel arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_132 _tdboth_wrapBlockingBlock_1f63hfj(
    _BlockingTrampoline_132 block, _BlockingTrampoline_132 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIUserInterfaceLevel arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_292)(void * sel, UIUserInterfaceLevel arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1f63hfj(id target, void * sel, UIUserInterfaceLevel arg1) {
  return ((_ProtocolTrampoline_292)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_133)(void * arg0, UIUserInterfaceSizeClass arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_133 _tdboth_wrapListenerBlock_1ehkefo(_ListenerTrampoline_133 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIUserInterfaceSizeClass arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_133)(void * waiter, void * arg0, UIUserInterfaceSizeClass arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_133 _tdboth_wrapBlockingBlock_1ehkefo(
    _BlockingTrampoline_133 block, _BlockingTrampoline_133 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIUserInterfaceSizeClass arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_293)(void * sel, UIUserInterfaceSizeClass arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1ehkefo(id target, void * sel, UIUserInterfaceSizeClass arg1) {
  return ((_ProtocolTrampoline_293)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_134)(void * arg0, UIUserInterfaceStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_134 _tdboth_wrapListenerBlock_rfcn96(_ListenerTrampoline_134 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIUserInterfaceStyle arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_134)(void * waiter, void * arg0, UIUserInterfaceStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_134 _tdboth_wrapBlockingBlock_rfcn96(
    _BlockingTrampoline_134 block, _BlockingTrampoline_134 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIUserInterfaceStyle arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_294)(void * sel, UIUserInterfaceStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_rfcn96(id target, void * sel, UIUserInterfaceStyle arg1) {
  return ((_ProtocolTrampoline_294)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_135)(void * arg0, UIViewAnimatingPosition arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_135 _tdboth_wrapListenerBlock_1o8zrhx(_ListenerTrampoline_135 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIViewAnimatingPosition arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_135)(void * waiter, void * arg0, UIViewAnimatingPosition arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_135 _tdboth_wrapBlockingBlock_1o8zrhx(
    _BlockingTrampoline_135 block, _BlockingTrampoline_135 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIViewAnimatingPosition arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_295)(void * sel, UIViewAnimatingPosition arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1o8zrhx(id target, void * sel, UIViewAnimatingPosition arg1) {
  return ((_ProtocolTrampoline_295)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_136)(void * arg0, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_136 _tdboth_wrapListenerBlock_18jmq2k(_ListenerTrampoline_136 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, BOOL arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_136)(void * waiter, void * arg0, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_136 _tdboth_wrapBlockingBlock_18jmq2k(
    _BlockingTrampoline_136 block, _BlockingTrampoline_136 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, BOOL arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_296)(void * sel, id arg1, BOOL arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_18jmq2k(id target, void * sel, id arg1, BOOL arg2, id arg3) {
  return ((_ProtocolTrampoline_296)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_137)(void * arg0, id arg1, id arg2, UIInterfaceOrientation arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_137 _tdboth_wrapListenerBlock_ynx60k(_ListenerTrampoline_137 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, UIInterfaceOrientation arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_137)(void * waiter, void * arg0, id arg1, id arg2, UIInterfaceOrientation arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_137 _tdboth_wrapBlockingBlock_ynx60k(
    _BlockingTrampoline_137 block, _BlockingTrampoline_137 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, UIInterfaceOrientation arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_297)(void * sel, id arg1, id arg2, UIInterfaceOrientation arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_ynx60k(id target, void * sel, id arg1, id arg2, UIInterfaceOrientation arg3, id arg4) {
  return ((_ProtocolTrampoline_297)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_138)(void * arg0, UIWritingToolsBehavior arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_138 _tdboth_wrapListenerBlock_16m0vek(_ListenerTrampoline_138 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIWritingToolsBehavior arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_138)(void * waiter, void * arg0, UIWritingToolsBehavior arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_138 _tdboth_wrapBlockingBlock_16m0vek(
    _BlockingTrampoline_138 block, _BlockingTrampoline_138 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIWritingToolsBehavior arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_298)(void * sel, UIWritingToolsBehavior arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_16m0vek(id target, void * sel, UIWritingToolsBehavior arg1) {
  return ((_ProtocolTrampoline_298)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_139)(void * arg0, id arg1, struct CGPoint arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_139 _tdboth_wrapListenerBlock_1jo11bz(_ListenerTrampoline_139 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGPoint arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_139)(void * waiter, void * arg0, id arg1, struct CGPoint arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_139 _tdboth_wrapBlockingBlock_1jo11bz(
    _BlockingTrampoline_139 block, _BlockingTrampoline_139 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGPoint arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_299)(void * sel, id arg1, struct CGPoint arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1jo11bz(id target, void * sel, id arg1, struct CGPoint arg2, id arg3) {
  return ((_ProtocolTrampoline_299)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_140)(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4, UIWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_140 _tdboth_wrapListenerBlock_1mifnam(_ListenerTrampoline_140 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4, UIWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), objc_retainBlock(arg7));
  };
}

typedef void  (^_BlockingTrampoline_140)(void * waiter, void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4, UIWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_140 _tdboth_wrapBlockingBlock_1mifnam(
    _BlockingTrampoline_140 block, _BlockingTrampoline_140 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4, UIWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), objc_retainBlock(arg7));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), objc_retainBlock(arg7));
  });
}

typedef void  (^_ProtocolTrampoline_300)(void * sel, id arg1, struct _NSRange arg2, id arg3, id arg4, UIWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1mifnam(id target, void * sel, id arg1, struct _NSRange arg2, id arg3, id arg4, UIWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7) {
  return ((_ProtocolTrampoline_300)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
}

typedef void  (^_ListenerTrampoline_141)(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_141 _tdboth_wrapListenerBlock_1oetkgs(_ListenerTrampoline_141 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  };
}

typedef void  (^_BlockingTrampoline_141)(void * waiter, void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_141 _tdboth_wrapBlockingBlock_1oetkgs(
    _BlockingTrampoline_141 block, _BlockingTrampoline_141 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_301)(void * sel, id arg1, struct _NSRange arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1oetkgs(id target, void * sel, id arg1, struct _NSRange arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_301)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_142)(void * arg0, id arg1, UIWritingToolsCoordinatorContextScope arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_142 _tdboth_wrapListenerBlock_1ls7i4u(_ListenerTrampoline_142 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UIWritingToolsCoordinatorContextScope arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_142)(void * waiter, void * arg0, id arg1, UIWritingToolsCoordinatorContextScope arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_142 _tdboth_wrapBlockingBlock_1ls7i4u(
    _BlockingTrampoline_142 block, _BlockingTrampoline_142 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UIWritingToolsCoordinatorContextScope arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_302)(void * sel, id arg1, UIWritingToolsCoordinatorContextScope arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1ls7i4u(id target, void * sel, id arg1, UIWritingToolsCoordinatorContextScope arg2, id arg3) {
  return ((_ProtocolTrampoline_302)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_143)(void * arg0, id arg1, UIWritingToolsCoordinatorState arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_143 _tdboth_wrapListenerBlock_112fwzu(_ListenerTrampoline_143 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UIWritingToolsCoordinatorState arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_143)(void * waiter, void * arg0, id arg1, UIWritingToolsCoordinatorState arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_143 _tdboth_wrapBlockingBlock_112fwzu(
    _BlockingTrampoline_143 block, _BlockingTrampoline_143 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UIWritingToolsCoordinatorState arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_303)(void * sel, id arg1, UIWritingToolsCoordinatorState arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_112fwzu(id target, void * sel, id arg1, UIWritingToolsCoordinatorState arg2, id arg3) {
  return ((_ProtocolTrampoline_303)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_144)(void * arg0, id arg1, UIWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_144 _tdboth_wrapListenerBlock_1q671ww(_ListenerTrampoline_144 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UIWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  };
}

typedef void  (^_BlockingTrampoline_144)(void * waiter, void * arg0, id arg1, UIWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_144 _tdboth_wrapBlockingBlock_1q671ww(
    _BlockingTrampoline_144 block, _BlockingTrampoline_144 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UIWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  });
}

typedef void  (^_ProtocolTrampoline_304)(void * sel, id arg1, UIWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1q671ww(id target, void * sel, id arg1, UIWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_304)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_145)(void * arg0, UIWritingToolsResultOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_145 _tdboth_wrapListenerBlock_1ceqvf1(_ListenerTrampoline_145 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIWritingToolsResultOptions arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_145)(void * waiter, void * arg0, UIWritingToolsResultOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_145 _tdboth_wrapBlockingBlock_1ceqvf1(
    _BlockingTrampoline_145 block, _BlockingTrampoline_145 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIWritingToolsResultOptions arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_305)(void * sel, UIWritingToolsResultOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1ceqvf1(id target, void * sel, UIWritingToolsResultOptions arg1) {
  return ((_ProtocolTrampoline_305)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_146)(void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_146 _tdboth_wrapListenerBlock_10lndml(_ListenerTrampoline_146 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_146)(void * waiter, void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_146 _tdboth_wrapBlockingBlock_10lndml(
    _BlockingTrampoline_146 block, _BlockingTrampoline_146 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, BOOL arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_306)(void * sel, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_10lndml(id target, void * sel, BOOL arg1) {
  return ((_ProtocolTrampoline_306)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_147)(void * arg0, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_147 _tdboth_wrapListenerBlock_ftecxq(_ListenerTrampoline_147 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, objc_retainBlock(arg2));
  };
}

typedef void  (^_BlockingTrampoline_147)(void * waiter, void * arg0, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_147 _tdboth_wrapBlockingBlock_ftecxq(
    _BlockingTrampoline_147 block, _BlockingTrampoline_147 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, BOOL arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, objc_retainBlock(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, objc_retainBlock(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_307)(void * sel, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_ftecxq(id target, void * sel, BOOL arg1, id arg2) {
  return ((_ProtocolTrampoline_307)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_148)(void * arg0, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_148 _tdboth_wrapListenerBlock_18sfmo2(_ListenerTrampoline_148 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, double arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_148)(void * waiter, void * arg0, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_148 _tdboth_wrapBlockingBlock_18sfmo2(
    _BlockingTrampoline_148 block, _BlockingTrampoline_148 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, double arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_308)(void * sel, double arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_18sfmo2(id target, void * sel, double arg1) {
  return ((_ProtocolTrampoline_308)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_149)(void * arg0, float arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_149 _tdboth_wrapListenerBlock_1fcaigd(_ListenerTrampoline_149 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, float arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_149)(void * waiter, void * arg0, float arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_149 _tdboth_wrapBlockingBlock_1fcaigd(
    _BlockingTrampoline_149 block, _BlockingTrampoline_149 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, float arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_309)(void * sel, float arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1fcaigd(id target, void * sel, float arg1) {
  return ((_ProtocolTrampoline_309)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_150)(void * arg0, void * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_150 _tdboth_wrapListenerBlock_1037nh9(_ListenerTrampoline_150 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, void * arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_150)(void * waiter, void * arg0, void * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_150 _tdboth_wrapBlockingBlock_1037nh9(
    _BlockingTrampoline_150 block, _BlockingTrampoline_150 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, void * arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_310)(void * sel, void * arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1037nh9(id target, void * sel, void * arg1) {
  return ((_ProtocolTrampoline_310)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_151)(void * arg0, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_151 _tdboth_wrapListenerBlock_1bbqgd5(_ListenerTrampoline_151 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, double arg2) {
    objc_retainBlock(block);
    block(arg0, objc_retainBlock(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_151)(void * waiter, void * arg0, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_151 _tdboth_wrapBlockingBlock_1bbqgd5(
    _BlockingTrampoline_151 block, _BlockingTrampoline_151 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, double arg2), {
    objc_retainBlock(block);
    block(nil, arg0, objc_retainBlock(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, objc_retainBlock(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_311)(void * sel, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_1bbqgd5(id target, void * sel, id arg1, double arg2) {
  return ((_ProtocolTrampoline_311)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_152)(void * arg0, id arg1, NSStringEnumerationOptions arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_152 _tdboth_wrapListenerBlock_7dzmi7(_ListenerTrampoline_152 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, NSStringEnumerationOptions arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_152)(void * waiter, void * arg0, id arg1, NSStringEnumerationOptions arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_152 _tdboth_wrapBlockingBlock_7dzmi7(
    _BlockingTrampoline_152 block, _BlockingTrampoline_152 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, NSStringEnumerationOptions arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_312)(void * sel, id arg1, NSStringEnumerationOptions arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_7dzmi7(id target, void * sel, id arg1, NSStringEnumerationOptions arg2, id arg3) {
  return ((_ProtocolTrampoline_312)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_153)(void * arg0, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_153 _tdboth_wrapListenerBlock_ve6f9k(_ListenerTrampoline_153 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, double arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_153)(void * waiter, void * arg0, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_153 _tdboth_wrapBlockingBlock_ve6f9k(
    _BlockingTrampoline_153 block, _BlockingTrampoline_153 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, double arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_313)(void * sel, id arg1, double arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_ve6f9k(id target, void * sel, id arg1, double arg2) {
  return ((_ProtocolTrampoline_313)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_154)(void * arg0, struct objc_selector * arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_154 _tdboth_wrapListenerBlock_dpfojo(_ListenerTrampoline_154 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct objc_selector * arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_154)(void * waiter, void * arg0, struct objc_selector * arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_154 _tdboth_wrapBlockingBlock_dpfojo(
    _BlockingTrampoline_154 block, _BlockingTrampoline_154 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct objc_selector * arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_314)(void * sel, struct objc_selector * arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_dpfojo(id target, void * sel, struct objc_selector * arg1, id arg2) {
  return ((_ProtocolTrampoline_314)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_155)(void * arg0, struct objc_selector * arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_155 _tdboth_wrapListenerBlock_incuey(_ListenerTrampoline_155 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct objc_selector * arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_155)(void * waiter, void * arg0, struct objc_selector * arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_155 _tdboth_wrapBlockingBlock_incuey(
    _BlockingTrampoline_155 block, _BlockingTrampoline_155 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct objc_selector * arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_315)(void * sel, struct objc_selector * arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _tdboth_protocolTrampoline_incuey(id target, void * sel, struct objc_selector * arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_315)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_156)(id arg0, BOOL * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_156 _tdboth_wrapListenerBlock_t8l8el(_ListenerTrampoline_156 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL * arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1);
  };
}

typedef void  (^_BlockingTrampoline_156)(void * waiter, id arg0, BOOL * arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_156 _tdboth_wrapBlockingBlock_t8l8el(
    _BlockingTrampoline_156 block, _BlockingTrampoline_156 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL * arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  });
}

typedef void  (^_ListenerTrampoline_157)(id arg0, unsigned long arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_157 _tdboth_wrapListenerBlock_1p9ui4q(_ListenerTrampoline_157 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, unsigned long arg1, BOOL * arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_157)(void * waiter, id arg0, unsigned long arg1, BOOL * arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_157 _tdboth_wrapBlockingBlock_1p9ui4q(
    _BlockingTrampoline_157 block, _BlockingTrampoline_157 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, unsigned long arg1, BOOL * arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef id  (^_ProtocolTrampoline_316)(void * sel, id arg1, NSTextContentManagerEnumerationOptions arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_1dxsa0d(id target, void * sel, id arg1, NSTextContentManagerEnumerationOptions arg2, id arg3) {
  return ((_ProtocolTrampoline_316)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_317)(void * sel, unsigned long arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_9b3h4v(id target, void * sel, unsigned long arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_317)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_318)(void * sel, id arg1, id arg2, struct CGRect arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_1l4smki(id target, void * sel, id arg1, id arg2, struct CGRect arg3) {
  return ((_ProtocolTrampoline_318)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_319)(void * sel, id arg1, id arg2, struct objc_selector * arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_g285me(id target, void * sel, id arg1, id arg2, struct objc_selector * arg3) {
  return ((_ProtocolTrampoline_319)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_320)(void * sel, id arg1, struct objc_selector * arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_wyrm70(id target, void * sel, id arg1, struct objc_selector * arg2) {
  return ((_ProtocolTrampoline_320)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_321)(void * sel, id arg1, UINavigationControllerOperation arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_1cbct6m(id target, void * sel, id arg1, UINavigationControllerOperation arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_321)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_322)(void * sel, long arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_rb7anl(id target, void * sel, long arg1, id arg2) {
  return ((_ProtocolTrampoline_322)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_323)(void * sel, id arg1, id arg2 __attribute__((ns_consumed)));
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_1p0fswn(id target, void * sel, id arg1, id arg2 __attribute__((ns_consumed))) {
  return ((_ProtocolTrampoline_323)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_324)(void * sel, struct _NSZone * arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_18nsem0(id target, void * sel, struct _NSZone * arg1) {
  return ((_ProtocolTrampoline_324)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_325)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _tdboth_protocolTrampoline_wpy7aa(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_325)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}
#undef BLOCKING_BLOCK_IMPL

#pragma clang diagnostic pop
