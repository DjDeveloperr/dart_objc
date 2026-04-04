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


typedef struct CGAffineTransform  (^_ProtocolTrampoline)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGAffineTransform  _ctgyal_protocolTrampoline_1mbheo7(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGRect  (^_ProtocolTrampoline_1)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _ctgyal_protocolTrampoline_1c3uc0w(id target, void * sel) {
  return ((_ProtocolTrampoline_1)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGRect  (^_ProtocolTrampoline_2)(void * sel, struct CGRect arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _ctgyal_protocolTrampoline_1k2xa69(id target, void * sel, struct CGRect arg1) {
  return ((_ProtocolTrampoline_2)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGRect  (^_ProtocolTrampoline_3)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _ctgyal_protocolTrampoline_bl8dec(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_3)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGRect  (^_ProtocolTrampoline_4)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _ctgyal_protocolTrampoline_szn7s6(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_4)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_5)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
id  _ctgyal_protocolTrampoline_1mbt9g9(id target, void * sel) {
  return ((_ProtocolTrampoline_5)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_6)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _ctgyal_protocolTrampoline_xr62hr(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_6)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_7)(void * sel, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _ctgyal_protocolTrampoline_ggvik5(id target, void * sel, id arg1, struct _NSRange arg2) {
  return ((_ProtocolTrampoline_7)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_8)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _ctgyal_protocolTrampoline_zi5eed(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_8)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_9)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _ctgyal_protocolTrampoline_1yw2rcr(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_9)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef NSComparisonResult  (^_ProtocolTrampoline_10)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
NSComparisonResult  _ctgyal_protocolTrampoline_1dp38tu(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_10)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef NSComparisonResult  (^_ProtocolTrampoline_11)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
NSComparisonResult  _ctgyal_protocolTrampoline_1939q40(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_11)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_12)(void * sel, id arg1, UITextStorageDirection arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _ctgyal_protocolTrampoline_1raep0i(id target, void * sel, id arg1, UITextStorageDirection arg2) {
  return ((_ProtocolTrampoline_12)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef unsigned long  (^_ProtocolTrampoline_13)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _ctgyal_protocolTrampoline_1ckyi24(id target, void * sel) {
  return ((_ProtocolTrampoline_13)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef long  (^_ProtocolTrampoline_14)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
long  _ctgyal_protocolTrampoline_evw03x(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_14)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef NSWritingDirection  (^_ProtocolTrampoline_15)(void * sel, id arg1, UITextStorageDirection arg2);
__attribute__((visibility("default"))) __attribute__((used))
NSWritingDirection  _ctgyal_protocolTrampoline_3fkmba(id target, void * sel, id arg1, UITextStorageDirection arg2) {
  return ((_ProtocolTrampoline_15)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UIKeyboardAppearance  (^_ProtocolTrampoline_16)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIKeyboardAppearance  _ctgyal_protocolTrampoline_ht8968(id target, void * sel) {
  return ((_ProtocolTrampoline_16)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIKeyboardType  (^_ProtocolTrampoline_17)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIKeyboardType  _ctgyal_protocolTrampoline_na2jiy(id target, void * sel) {
  return ((_ProtocolTrampoline_17)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_18)(void * sel, id arg1, struct _NSRange arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _ctgyal_protocolTrampoline_166zki3(id target, void * sel, id arg1, struct _NSRange arg2, id arg3) {
  return ((_ProtocolTrampoline_18)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef UIReturnKeyType  (^_ProtocolTrampoline_19)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIReturnKeyType  _ctgyal_protocolTrampoline_lj3zeo(id target, void * sel) {
  return ((_ProtocolTrampoline_19)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITextAutocapitalizationType  (^_ProtocolTrampoline_20)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextAutocapitalizationType  _ctgyal_protocolTrampoline_1xv2mzh(id target, void * sel) {
  return ((_ProtocolTrampoline_20)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITextAutocorrectionType  (^_ProtocolTrampoline_21)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextAutocorrectionType  _ctgyal_protocolTrampoline_1d3flt5(id target, void * sel) {
  return ((_ProtocolTrampoline_21)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITextDragOptions  (^_ProtocolTrampoline_22)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextDragOptions  _ctgyal_protocolTrampoline_6l01qw(id target, void * sel) {
  return ((_ProtocolTrampoline_22)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITextDropEditability  (^_ProtocolTrampoline_23)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
UITextDropEditability  _ctgyal_protocolTrampoline_1vvj0wr(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_23)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UITextInlinePredictionType  (^_ProtocolTrampoline_24)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextInlinePredictionType  _ctgyal_protocolTrampoline_1byt4vk(id target, void * sel) {
  return ((_ProtocolTrampoline_24)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITextMathExpressionCompletionType  (^_ProtocolTrampoline_25)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextMathExpressionCompletionType  _ctgyal_protocolTrampoline_nc807a(id target, void * sel) {
  return ((_ProtocolTrampoline_25)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_26)(void * sel, struct CGSize arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _ctgyal_protocolTrampoline_1hb9fc7(id target, void * sel, struct CGSize arg1) {
  return ((_ProtocolTrampoline_26)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_27)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _ctgyal_protocolTrampoline_jwxea6(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_27)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_28)(void * sel, struct CGPoint arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _ctgyal_protocolTrampoline_1cizpv0(id target, void * sel, struct CGPoint arg1, id arg2) {
  return ((_ProtocolTrampoline_28)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_29)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _ctgyal_protocolTrampoline_1xvw1tx(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_29)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_30)(void * sel, id arg1, UITextGranularity arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _ctgyal_protocolTrampoline_17ilkfe(id target, void * sel, id arg1, UITextGranularity arg2, long arg3) {
  return ((_ProtocolTrampoline_30)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_31)(void * sel, id arg1, UITextLayoutDirection arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _ctgyal_protocolTrampoline_1n2o6o3(id target, void * sel, id arg1, UITextLayoutDirection arg2, long arg3) {
  return ((_ProtocolTrampoline_31)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_32)(void * sel, id arg1, UITextLayoutDirection arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _ctgyal_protocolTrampoline_k9m9y9(id target, void * sel, id arg1, UITextLayoutDirection arg2) {
  return ((_ProtocolTrampoline_32)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef UITextSmartDashesType  (^_ProtocolTrampoline_33)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextSmartDashesType  _ctgyal_protocolTrampoline_17kij6f(id target, void * sel) {
  return ((_ProtocolTrampoline_33)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITextSmartInsertDeleteType  (^_ProtocolTrampoline_34)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextSmartInsertDeleteType  _ctgyal_protocolTrampoline_1e0d9d5(id target, void * sel) {
  return ((_ProtocolTrampoline_34)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITextSmartQuotesType  (^_ProtocolTrampoline_35)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextSmartQuotesType  _ctgyal_protocolTrampoline_1v1m8o4(id target, void * sel) {
  return ((_ProtocolTrampoline_35)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITextSpellCheckingType  (^_ProtocolTrampoline_36)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextSpellCheckingType  _ctgyal_protocolTrampoline_1o7csqa(id target, void * sel) {
  return ((_ProtocolTrampoline_36)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UITextStorageDirection  (^_ProtocolTrampoline_37)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UITextStorageDirection  _ctgyal_protocolTrampoline_159vyjm(id target, void * sel) {
  return ((_ProtocolTrampoline_37)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIWritingToolsBehavior  (^_ProtocolTrampoline_38)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIWritingToolsBehavior  _ctgyal_protocolTrampoline_10qz50q(id target, void * sel) {
  return ((_ProtocolTrampoline_38)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIWritingToolsResultOptions  (^_ProtocolTrampoline_39)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIWritingToolsResultOptions  _ctgyal_protocolTrampoline_ezd7fj(id target, void * sel) {
  return ((_ProtocolTrampoline_39)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_40)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ctgyal_protocolTrampoline_e3qsqz(id target, void * sel) {
  return ((_ProtocolTrampoline_40)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_41)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ctgyal_protocolTrampoline_3su7tt(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_41)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_42)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ctgyal_protocolTrampoline_jk8du5(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_42)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_43)(void * sel, id arg1, struct _NSRange arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ctgyal_protocolTrampoline_u18wpp(id target, void * sel, id arg1, struct _NSRange arg2, id arg3) {
  return ((_ProtocolTrampoline_43)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_44)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ctgyal_protocolTrampoline_2n06mv(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_44)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_45)(void * sel, id arg1, struct CGPoint arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ctgyal_protocolTrampoline_g0ff12(id target, void * sel, id arg1, struct CGPoint arg2) {
  return ((_ProtocolTrampoline_45)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_46)(void * sel, id arg1, UITextGranularity arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ctgyal_protocolTrampoline_szbl4c(id target, void * sel, id arg1, UITextGranularity arg2, long arg3) {
  return ((_ProtocolTrampoline_46)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_47)(void * sel, id arg1, id arg2, struct _NSRange arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ctgyal_protocolTrampoline_132e89p(id target, void * sel, id arg1, id arg2, struct _NSRange arg3) {
  return ((_ProtocolTrampoline_47)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_48)(void * sel, id arg1, id arg2, struct _NSRange arg3, UITextItemInteraction arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _ctgyal_protocolTrampoline_11bdmat(id target, void * sel, id arg1, id arg2, struct _NSRange arg3, UITextItemInteraction arg4) {
  return ((_ProtocolTrampoline_48)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline)(void);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _ctgyal_wrapListenerBlock_1pl9qdv(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void() {
    objc_retainBlock(block);
    block();
  };
}

typedef void  (^_BlockingTrampoline)(void * waiter);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _ctgyal_wrapBlockingBlock_1pl9qdv(
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

typedef void  (^_ListenerTrampoline_1)(void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _ctgyal_wrapListenerBlock_ovsamd(_ListenerTrampoline_1 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_1)(void * waiter, void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _ctgyal_wrapBlockingBlock_ovsamd(
    _BlockingTrampoline_1 block, _BlockingTrampoline_1 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ProtocolTrampoline_49)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_ovsamd(id target, void * sel) {
  return ((_ProtocolTrampoline_49)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_2)(void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _ctgyal_wrapListenerBlock_1bktu2(_ListenerTrampoline_2 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, struct CGPoint arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_2)(void * waiter, void * arg0, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _ctgyal_wrapBlockingBlock_1bktu2(
    _BlockingTrampoline_2 block, _BlockingTrampoline_2 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, struct CGPoint arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_50)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_1bktu2(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_50)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_3)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _ctgyal_wrapListenerBlock_fjrv01(_ListenerTrampoline_3 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_3)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _ctgyal_wrapBlockingBlock_fjrv01(
    _BlockingTrampoline_3 block, _BlockingTrampoline_3 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_51)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_fjrv01(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_51)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_4)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _ctgyal_wrapListenerBlock_18v1jvf(_ListenerTrampoline_4 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_4)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _ctgyal_wrapBlockingBlock_18v1jvf(
    _BlockingTrampoline_4 block, _BlockingTrampoline_4 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_52)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_18v1jvf(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_52)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_5)(void * arg0, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _ctgyal_wrapListenerBlock_ayxzy9(_ListenerTrampoline_5 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct _NSRange arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_5)(void * waiter, void * arg0, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _ctgyal_wrapBlockingBlock_ayxzy9(
    _BlockingTrampoline_5 block, _BlockingTrampoline_5 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct _NSRange arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_53)(void * sel, id arg1, struct _NSRange arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_ayxzy9(id target, void * sel, id arg1, struct _NSRange arg2) {
  return ((_ProtocolTrampoline_53)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_6)(void * arg0, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _ctgyal_wrapListenerBlock_unr2j3(_ListenerTrampoline_6 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, long arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_6)(void * waiter, void * arg0, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _ctgyal_wrapBlockingBlock_unr2j3(
    _BlockingTrampoline_6 block, _BlockingTrampoline_6 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, long arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_54)(void * sel, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_unr2j3(id target, void * sel, long arg1) {
  return ((_ProtocolTrampoline_54)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_7)(void * arg0, id arg1, id arg2, UITextAlternativeStyle arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _ctgyal_wrapListenerBlock_xt280e(_ListenerTrampoline_7 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, UITextAlternativeStyle arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_7)(void * waiter, void * arg0, id arg1, id arg2, UITextAlternativeStyle arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _ctgyal_wrapBlockingBlock_xt280e(
    _BlockingTrampoline_7 block, _BlockingTrampoline_7 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, UITextAlternativeStyle arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_55)(void * sel, id arg1, id arg2, UITextAlternativeStyle arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_xt280e(id target, void * sel, id arg1, id arg2, UITextAlternativeStyle arg3) {
  return ((_ProtocolTrampoline_55)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_8)(void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _ctgyal_wrapListenerBlock_1tz5yf(_ListenerTrampoline_8 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_8)(void * waiter, void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _ctgyal_wrapBlockingBlock_1tz5yf(
    _BlockingTrampoline_8 block, _BlockingTrampoline_8 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_56)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_1tz5yf(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_56)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_9)(void * arg0, NSWritingDirection arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _ctgyal_wrapListenerBlock_elgbmd(_ListenerTrampoline_9 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, NSWritingDirection arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_9)(void * waiter, void * arg0, NSWritingDirection arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _ctgyal_wrapBlockingBlock_elgbmd(
    _BlockingTrampoline_9 block, _BlockingTrampoline_9 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, NSWritingDirection arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1, (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_57)(void * sel, NSWritingDirection arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_elgbmd(id target, void * sel, NSWritingDirection arg1, id arg2) {
  return ((_ProtocolTrampoline_57)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_10)(void * arg0, UIKeyboardAppearance arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _ctgyal_wrapListenerBlock_ygwzfa(_ListenerTrampoline_10 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIKeyboardAppearance arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_10)(void * waiter, void * arg0, UIKeyboardAppearance arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _ctgyal_wrapBlockingBlock_ygwzfa(
    _BlockingTrampoline_10 block, _BlockingTrampoline_10 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIKeyboardAppearance arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_58)(void * sel, UIKeyboardAppearance arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_ygwzfa(id target, void * sel, UIKeyboardAppearance arg1) {
  return ((_ProtocolTrampoline_58)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_11)(void * arg0, UIKeyboardType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _ctgyal_wrapListenerBlock_65vlqw(_ListenerTrampoline_11 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIKeyboardType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_11)(void * waiter, void * arg0, UIKeyboardType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _ctgyal_wrapBlockingBlock_65vlqw(
    _BlockingTrampoline_11 block, _BlockingTrampoline_11 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIKeyboardType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_59)(void * sel, UIKeyboardType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_65vlqw(id target, void * sel, UIKeyboardType arg1) {
  return ((_ProtocolTrampoline_59)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_12)(void * arg0, UIReturnKeyType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _ctgyal_wrapListenerBlock_16k97um(_ListenerTrampoline_12 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIReturnKeyType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_12)(void * waiter, void * arg0, UIReturnKeyType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _ctgyal_wrapBlockingBlock_16k97um(
    _BlockingTrampoline_12 block, _BlockingTrampoline_12 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIReturnKeyType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_60)(void * sel, UIReturnKeyType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_16k97um(id target, void * sel, UIReturnKeyType arg1) {
  return ((_ProtocolTrampoline_60)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_13)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _ctgyal_wrapListenerBlock_1l4hxwm(_ListenerTrampoline_13 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retainBlock(arg1));
  };
}

typedef void  (^_BlockingTrampoline_13)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _ctgyal_wrapBlockingBlock_1l4hxwm(
    _BlockingTrampoline_13 block, _BlockingTrampoline_13 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, objc_retainBlock(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, objc_retainBlock(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_61)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_1l4hxwm(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_61)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_14)(void * arg0, UITextAutocapitalizationType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _ctgyal_wrapListenerBlock_1j3gd57(_ListenerTrampoline_14 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextAutocapitalizationType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_14)(void * waiter, void * arg0, UITextAutocapitalizationType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _ctgyal_wrapBlockingBlock_1j3gd57(
    _BlockingTrampoline_14 block, _BlockingTrampoline_14 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextAutocapitalizationType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_62)(void * sel, UITextAutocapitalizationType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_1j3gd57(id target, void * sel, UITextAutocapitalizationType arg1) {
  return ((_ProtocolTrampoline_62)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_15)(void * arg0, UITextAutocorrectionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _ctgyal_wrapListenerBlock_mqcqqj(_ListenerTrampoline_15 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextAutocorrectionType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_15)(void * waiter, void * arg0, UITextAutocorrectionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _ctgyal_wrapBlockingBlock_mqcqqj(
    _BlockingTrampoline_15 block, _BlockingTrampoline_15 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextAutocorrectionType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_63)(void * sel, UITextAutocorrectionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_mqcqqj(id target, void * sel, UITextAutocorrectionType arg1) {
  return ((_ProtocolTrampoline_63)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_16)(void * arg0, UITextDragOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _ctgyal_wrapListenerBlock_1gonnvy(_ListenerTrampoline_16 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextDragOptions arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_16)(void * waiter, void * arg0, UITextDragOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _ctgyal_wrapBlockingBlock_1gonnvy(
    _BlockingTrampoline_16 block, _BlockingTrampoline_16 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextDragOptions arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_64)(void * sel, UITextDragOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_1gonnvy(id target, void * sel, UITextDragOptions arg1) {
  return ((_ProtocolTrampoline_64)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_17)(void * arg0, id arg1, UITextFieldDidEndEditingReason arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _ctgyal_wrapListenerBlock_18wmx9i(_ListenerTrampoline_17 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UITextFieldDidEndEditingReason arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_17)(void * waiter, void * arg0, id arg1, UITextFieldDidEndEditingReason arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _ctgyal_wrapBlockingBlock_18wmx9i(
    _BlockingTrampoline_17 block, _BlockingTrampoline_17 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UITextFieldDidEndEditingReason arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_65)(void * sel, id arg1, UITextFieldDidEndEditingReason arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_18wmx9i(id target, void * sel, id arg1, UITextFieldDidEndEditingReason arg2) {
  return ((_ProtocolTrampoline_65)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_18)(void * arg0, UITextInlinePredictionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _ctgyal_wrapListenerBlock_17cibua(_ListenerTrampoline_18 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextInlinePredictionType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_18)(void * waiter, void * arg0, UITextInlinePredictionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _ctgyal_wrapBlockingBlock_17cibua(
    _BlockingTrampoline_18 block, _BlockingTrampoline_18 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextInlinePredictionType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_66)(void * sel, UITextInlinePredictionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_17cibua(id target, void * sel, UITextInlinePredictionType arg1) {
  return ((_ProtocolTrampoline_66)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_19)(void * arg0, UITextMathExpressionCompletionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_19 _ctgyal_wrapListenerBlock_1142ncg(_ListenerTrampoline_19 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextMathExpressionCompletionType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_19)(void * waiter, void * arg0, UITextMathExpressionCompletionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_19 _ctgyal_wrapBlockingBlock_1142ncg(
    _BlockingTrampoline_19 block, _BlockingTrampoline_19 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextMathExpressionCompletionType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_67)(void * sel, UITextMathExpressionCompletionType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_1142ncg(id target, void * sel, UITextMathExpressionCompletionType arg1) {
  return ((_ProtocolTrampoline_67)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_20)(void * arg0, id arg1, id arg2, UITextSearchFoundTextStyle arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_20 _ctgyal_wrapListenerBlock_x8ytla(_ListenerTrampoline_20 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, UITextSearchFoundTextStyle arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_20)(void * waiter, void * arg0, id arg1, id arg2, UITextSearchFoundTextStyle arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_20 _ctgyal_wrapBlockingBlock_x8ytla(
    _BlockingTrampoline_20 block, _BlockingTrampoline_20 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, UITextSearchFoundTextStyle arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_68)(void * sel, id arg1, id arg2, UITextSearchFoundTextStyle arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_x8ytla(id target, void * sel, id arg1, id arg2, UITextSearchFoundTextStyle arg3) {
  return ((_ProtocolTrampoline_68)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_21)(void * arg0, UITextSmartDashesType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_21 _ctgyal_wrapListenerBlock_1jo5fi9(_ListenerTrampoline_21 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextSmartDashesType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_21)(void * waiter, void * arg0, UITextSmartDashesType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_21 _ctgyal_wrapBlockingBlock_1jo5fi9(
    _BlockingTrampoline_21 block, _BlockingTrampoline_21 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextSmartDashesType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_69)(void * sel, UITextSmartDashesType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_1jo5fi9(id target, void * sel, UITextSmartDashesType arg1) {
  return ((_ProtocolTrampoline_69)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_22)(void * arg0, UITextSmartInsertDeleteType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_22 _ctgyal_wrapListenerBlock_lk25kr(_ListenerTrampoline_22 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextSmartInsertDeleteType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_22)(void * waiter, void * arg0, UITextSmartInsertDeleteType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_22 _ctgyal_wrapBlockingBlock_lk25kr(
    _BlockingTrampoline_22 block, _BlockingTrampoline_22 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextSmartInsertDeleteType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_70)(void * sel, UITextSmartInsertDeleteType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_lk25kr(id target, void * sel, UITextSmartInsertDeleteType arg1) {
  return ((_ProtocolTrampoline_70)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_23)(void * arg0, UITextSmartQuotesType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_23 _ctgyal_wrapListenerBlock_1wgfcbu(_ListenerTrampoline_23 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextSmartQuotesType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_23)(void * waiter, void * arg0, UITextSmartQuotesType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_23 _ctgyal_wrapBlockingBlock_1wgfcbu(
    _BlockingTrampoline_23 block, _BlockingTrampoline_23 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextSmartQuotesType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_71)(void * sel, UITextSmartQuotesType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_1wgfcbu(id target, void * sel, UITextSmartQuotesType arg1) {
  return ((_ProtocolTrampoline_71)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_24)(void * arg0, UITextSpellCheckingType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_24 _ctgyal_wrapListenerBlock_87wnoc(_ListenerTrampoline_24 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextSpellCheckingType arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_24)(void * waiter, void * arg0, UITextSpellCheckingType arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_24 _ctgyal_wrapBlockingBlock_87wnoc(
    _BlockingTrampoline_24 block, _BlockingTrampoline_24 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextSpellCheckingType arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_72)(void * sel, UITextSpellCheckingType arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_87wnoc(id target, void * sel, UITextSpellCheckingType arg1) {
  return ((_ProtocolTrampoline_72)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_25)(void * arg0, UITextStorageDirection arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_25 _ctgyal_wrapListenerBlock_1hk7a7s(_ListenerTrampoline_25 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UITextStorageDirection arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_25)(void * waiter, void * arg0, UITextStorageDirection arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_25 _ctgyal_wrapBlockingBlock_1hk7a7s(
    _BlockingTrampoline_25 block, _BlockingTrampoline_25 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UITextStorageDirection arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_73)(void * sel, UITextStorageDirection arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_1hk7a7s(id target, void * sel, UITextStorageDirection arg1) {
  return ((_ProtocolTrampoline_73)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_26)(void * arg0, id arg1, id arg2, UIDropOperation arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_26 _ctgyal_wrapListenerBlock_zrfj47(_ListenerTrampoline_26 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, UIDropOperation arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_26)(void * waiter, void * arg0, id arg1, id arg2, UIDropOperation arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_26 _ctgyal_wrapBlockingBlock_zrfj47(
    _BlockingTrampoline_26 block, _BlockingTrampoline_26 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, UIDropOperation arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_74)(void * sel, id arg1, id arg2, UIDropOperation arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_zrfj47(id target, void * sel, id arg1, id arg2, UIDropOperation arg3) {
  return ((_ProtocolTrampoline_74)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_27)(void * arg0, UIWritingToolsBehavior arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_27 _ctgyal_wrapListenerBlock_16m0vek(_ListenerTrampoline_27 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIWritingToolsBehavior arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_27)(void * waiter, void * arg0, UIWritingToolsBehavior arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_27 _ctgyal_wrapBlockingBlock_16m0vek(
    _BlockingTrampoline_27 block, _BlockingTrampoline_27 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIWritingToolsBehavior arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_75)(void * sel, UIWritingToolsBehavior arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_16m0vek(id target, void * sel, UIWritingToolsBehavior arg1) {
  return ((_ProtocolTrampoline_75)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_28)(void * arg0, UIWritingToolsResultOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_28 _ctgyal_wrapListenerBlock_1ceqvf1(_ListenerTrampoline_28 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIWritingToolsResultOptions arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_28)(void * waiter, void * arg0, UIWritingToolsResultOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_28 _ctgyal_wrapBlockingBlock_1ceqvf1(
    _BlockingTrampoline_28 block, _BlockingTrampoline_28 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIWritingToolsResultOptions arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_76)(void * sel, UIWritingToolsResultOptions arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_1ceqvf1(id target, void * sel, UIWritingToolsResultOptions arg1) {
  return ((_ProtocolTrampoline_76)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_29)(void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_29 _ctgyal_wrapListenerBlock_10lndml(_ListenerTrampoline_29 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_29)(void * waiter, void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_29 _ctgyal_wrapBlockingBlock_10lndml(
    _BlockingTrampoline_29 block, _BlockingTrampoline_29 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, BOOL arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_77)(void * sel, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_10lndml(id target, void * sel, BOOL arg1) {
  return ((_ProtocolTrampoline_77)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_30)(void * arg0, unsigned long arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_30 _ctgyal_wrapListenerBlock_zuf90e(_ListenerTrampoline_30 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, unsigned long arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_30)(void * waiter, void * arg0, unsigned long arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_30 _ctgyal_wrapBlockingBlock_zuf90e(
    _BlockingTrampoline_30 block, _BlockingTrampoline_30 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, unsigned long arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_78)(void * sel, unsigned long arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_zuf90e(id target, void * sel, unsigned long arg1) {
  return ((_ProtocolTrampoline_78)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_31)(void * arg0, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_31 _ctgyal_wrapListenerBlock_zzthnb(_ListenerTrampoline_31 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, BOOL arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_31)(void * waiter, void * arg0, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_31 _ctgyal_wrapBlockingBlock_zzthnb(
    _BlockingTrampoline_31 block, _BlockingTrampoline_31 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, BOOL arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_79)(void * sel, id arg1, BOOL arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _ctgyal_protocolTrampoline_zzthnb(id target, void * sel, id arg1, BOOL arg2) {
  return ((_ProtocolTrampoline_79)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}
#undef BLOCKING_BLOCK_IMPL

#pragma clang diagnostic pop
