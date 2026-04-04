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


typedef double  (^_ProtocolTrampoline)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
double  _886end_protocolTrampoline_1kspct0(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGPoint  (^_ProtocolTrampoline_1)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _886end_protocolTrampoline_1hsw88y(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_1)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGRect  (^_ProtocolTrampoline_2)(void * sel, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _886end_protocolTrampoline_1xyboba(id target, void * sel, long arg1) {
  return ((_ProtocolTrampoline_2)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGRect  (^_ProtocolTrampoline_3)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _886end_protocolTrampoline_szn7s6(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_3)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef struct CGRect  (^_ProtocolTrampoline_4)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGRect  _886end_protocolTrampoline_bl8dec(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_4)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_5)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _886end_protocolTrampoline_xr62hr(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_5)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_6)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
id  _886end_protocolTrampoline_1mbt9g9(id target, void * sel) {
  return ((_ProtocolTrampoline_6)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_7)(void * sel, unsigned long arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _886end_protocolTrampoline_3nbx5e(id target, void * sel, unsigned long arg1) {
  return ((_ProtocolTrampoline_7)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_8)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _886end_protocolTrampoline_zi5eed(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_8)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_9)(void * sel, id arg1, id arg2, struct CGPoint arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _886end_protocolTrampoline_11umze2(id target, void * sel, id arg1, id arg2, struct CGPoint arg3) {
  return ((_ProtocolTrampoline_9)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_10)(void * sel, long arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _886end_protocolTrampoline_ldbu1n(id target, void * sel, long arg1) {
  return ((_ProtocolTrampoline_10)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef long  (^_ProtocolTrampoline_11)(void * sel, struct CGPoint arg1);
__attribute__((visibility("default"))) __attribute__((used))
long  _886end_protocolTrampoline_1aeg7rq(id target, void * sel, struct CGPoint arg1) {
  return ((_ProtocolTrampoline_11)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_12)(void * sel, long arg1, id arg2, struct CGSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _886end_protocolTrampoline_1x2cudb(id target, void * sel, long arg1, id arg2, struct CGSize arg3) {
  return ((_ProtocolTrampoline_12)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_13)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _886end_protocolTrampoline_1q0i84(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_13)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct _NSRange  (^_ProtocolTrampoline_14)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct _NSRange  _886end_protocolTrampoline_1mh5vs9(id target, void * sel) {
  return ((_ProtocolTrampoline_14)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef unsigned long  (^_ProtocolTrampoline_15)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
unsigned long  _886end_protocolTrampoline_1ckyi24(id target, void * sel) {
  return ((_ProtocolTrampoline_15)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef UIDropSessionProgressIndicatorStyle  (^_ProtocolTrampoline_16)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
UIDropSessionProgressIndicatorStyle  _886end_protocolTrampoline_1etxt4l(id target, void * sel) {
  return ((_ProtocolTrampoline_16)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_17)(void * sel, id arg1, id arg2, struct CGSize arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _886end_protocolTrampoline_18mw7aj(id target, void * sel, id arg1, id arg2, struct CGSize arg3) {
  return ((_ProtocolTrampoline_17)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_18)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _886end_protocolTrampoline_1yw2rcr(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_18)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef UIPrinterCutterBehavior  (^_ProtocolTrampoline_19)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
UIPrinterCutterBehavior  _886end_protocolTrampoline_123jp2s(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_19)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_20)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _886end_protocolTrampoline_e3qsqz(id target, void * sel) {
  return ((_ProtocolTrampoline_20)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_21)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _886end_protocolTrampoline_3su7tt(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_21)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef BOOL  (^_ProtocolTrampoline_22)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _886end_protocolTrampoline_2n06mv(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_22)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_23)(void * sel, id arg1, struct objc_selector * arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _886end_protocolTrampoline_122cere(id target, void * sel, id arg1, struct objc_selector * arg2) {
  return ((_ProtocolTrampoline_23)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_24)(void * sel, id arg1, struct CGPoint arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _886end_protocolTrampoline_g0ff12(id target, void * sel, id arg1, struct CGPoint arg2) {
  return ((_ProtocolTrampoline_24)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline)(void);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _886end_wrapListenerBlock_1pl9qdv(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void() {
    objc_retainBlock(block);
    block();
  };
}

typedef void  (^_BlockingTrampoline)(void * waiter);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _886end_wrapBlockingBlock_1pl9qdv(
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
_ListenerTrampoline_1 _886end_wrapListenerBlock_xtuoz7(_ListenerTrampoline_1 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0));
  };
}

typedef void  (^_BlockingTrampoline_1)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _886end_wrapBlockingBlock_xtuoz7(
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

typedef void  (^_ListenerTrampoline_2)(id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _886end_wrapListenerBlock_pfv6jd(_ListenerTrampoline_2 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_2)(void * waiter, id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _886end_wrapBlockingBlock_pfv6jd(
    _BlockingTrampoline_2 block, _BlockingTrampoline_2 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_3)(id arg0, long arg1, struct CGRect arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _886end_wrapListenerBlock_11l3kq6(_ListenerTrampoline_3 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, long arg1, struct CGRect arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  };
}

typedef void  (^_BlockingTrampoline_3)(void * waiter, id arg0, long arg1, struct CGRect arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _886end_wrapBlockingBlock_11l3kq6(
    _BlockingTrampoline_3 block, _BlockingTrampoline_3 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, long arg1, struct CGRect arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, arg2);
  });
}

typedef void  (^_ListenerTrampoline_4)(struct _NSRange arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _886end_wrapListenerBlock_1tv4uax(_ListenerTrampoline_4 block) NS_RETURNS_RETAINED {
  return ^void(struct _NSRange arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_4)(void * waiter, struct _NSRange arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _886end_wrapBlockingBlock_1tv4uax(
    _BlockingTrampoline_4 block, _BlockingTrampoline_4 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(struct _NSRange arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_5)(id arg0, UIDocumentBrowserImportMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _886end_wrapListenerBlock_1jff4hs(_ListenerTrampoline_5 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, UIDocumentBrowserImportMode arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1);
  };
}

typedef void  (^_BlockingTrampoline_5)(void * waiter, id arg0, UIDocumentBrowserImportMode arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _886end_wrapBlockingBlock_1jff4hs(
    _BlockingTrampoline_5 block, _BlockingTrampoline_5 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, UIDocumentBrowserImportMode arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  });
}

typedef void  (^_ListenerTrampoline_6)(id arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _886end_wrapListenerBlock_6p7ndb(_ListenerTrampoline_6 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1);
  };
}

typedef void  (^_BlockingTrampoline_6)(void * waiter, id arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _886end_wrapBlockingBlock_6p7ndb(
    _BlockingTrampoline_6 block, _BlockingTrampoline_6 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1);
  });
}

typedef void  (^_ListenerTrampoline_7)(id arg0, BOOL arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _886end_wrapListenerBlock_13x5jor(_ListenerTrampoline_7 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_7)(void * waiter, id arg0, BOOL arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _886end_wrapBlockingBlock_13x5jor(
    _BlockingTrampoline_7 block, _BlockingTrampoline_7 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, BOOL arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ListenerTrampoline_8)(id arg0, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _886end_wrapListenerBlock_rnu2c5(_ListenerTrampoline_8 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, BOOL arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), arg1, (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_8)(void * waiter, id arg0, BOOL arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _886end_wrapBlockingBlock_rnu2c5(
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

typedef void  (^_ListenerTrampoline_9)(long arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _886end_wrapListenerBlock_4sp4xj(_ListenerTrampoline_9 block) NS_RETURNS_RETAINED {
  return ^void(long arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_9)(void * waiter, long arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _886end_wrapBlockingBlock_4sp4xj(
    _BlockingTrampoline_9 block, _BlockingTrampoline_9 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(long arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_10)(BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _886end_wrapListenerBlock_1s56lr9(_ListenerTrampoline_10 block) NS_RETURNS_RETAINED {
  return ^void(BOOL arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_10)(void * waiter, BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _886end_wrapBlockingBlock_1s56lr9(
    _BlockingTrampoline_10 block, _BlockingTrampoline_10 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(BOOL arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_11)(float arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _886end_wrapListenerBlock_v5hmet(_ListenerTrampoline_11 block) NS_RETURNS_RETAINED {
  return ^void(float arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_11)(void * waiter, float arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _886end_wrapBlockingBlock_v5hmet(
    _BlockingTrampoline_11 block, _BlockingTrampoline_11 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(float arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_12)(void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _886end_wrapListenerBlock_ovsamd(_ListenerTrampoline_12 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_12)(void * waiter, void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_12 _886end_wrapBlockingBlock_ovsamd(
    _BlockingTrampoline_12 block, _BlockingTrampoline_12 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ProtocolTrampoline_25)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_ovsamd(id target, void * sel) {
  return ((_ProtocolTrampoline_25)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_13)(id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _886end_wrapListenerBlock_f167m6(_ListenerTrampoline_13 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block(objc_retainBlock(arg0));
  };
}

typedef void  (^_BlockingTrampoline_13)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_13 _886end_wrapBlockingBlock_f167m6(
    _BlockingTrampoline_13 block, _BlockingTrampoline_13 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0), {
    objc_retainBlock(block);
    block(nil, objc_retainBlock(arg0));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, objc_retainBlock(arg0));
  });
}

typedef void  (^_ListenerTrampoline_14)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _886end_wrapListenerBlock_18v1jvf(_ListenerTrampoline_14 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_14)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_14 _886end_wrapBlockingBlock_18v1jvf(
    _BlockingTrampoline_14 block, _BlockingTrampoline_14 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_26)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_18v1jvf(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_26)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_15)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _886end_wrapListenerBlock_fjrv01(_ListenerTrampoline_15 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_15)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_15 _886end_wrapBlockingBlock_fjrv01(
    _BlockingTrampoline_15 block, _BlockingTrampoline_15 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_27)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_fjrv01(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_27)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_16)(void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _886end_wrapListenerBlock_1tz5yf(_ListenerTrampoline_16 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_16)(void * waiter, void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_16 _886end_wrapBlockingBlock_1tz5yf(
    _BlockingTrampoline_16 block, _BlockingTrampoline_16 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_28)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_1tz5yf(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_28)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_17)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _886end_wrapListenerBlock_jk1ljc(_ListenerTrampoline_17 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  };
}

typedef void  (^_BlockingTrampoline_17)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_17 _886end_wrapBlockingBlock_jk1ljc(
    _BlockingTrampoline_17 block, _BlockingTrampoline_17 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), objc_retainBlock(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_29)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_jk1ljc(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_29)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_18)(void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _886end_wrapListenerBlock_8jfq1p(_ListenerTrampoline_18 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_18)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_18 _886end_wrapBlockingBlock_8jfq1p(
    _BlockingTrampoline_18 block, _BlockingTrampoline_18 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_30)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_8jfq1p(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_30)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_19)(void * arg0, id arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_19 _886end_wrapListenerBlock_2xx4dm(_ListenerTrampoline_19 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, unsigned long arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  };
}

typedef void  (^_BlockingTrampoline_19)(void * waiter, void * arg0, id arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_19 _886end_wrapBlockingBlock_2xx4dm(
    _BlockingTrampoline_19 block, _BlockingTrampoline_19 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, unsigned long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3);
  });
}

typedef void  (^_ProtocolTrampoline_31)(void * sel, id arg1, id arg2, unsigned long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_2xx4dm(id target, void * sel, id arg1, id arg2, unsigned long arg3) {
  return ((_ProtocolTrampoline_31)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_20)(void * arg0, UIDropSessionProgressIndicatorStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_20 _886end_wrapListenerBlock_b53a8b(_ListenerTrampoline_20 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, UIDropSessionProgressIndicatorStyle arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_20)(void * waiter, void * arg0, UIDropSessionProgressIndicatorStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_20 _886end_wrapBlockingBlock_b53a8b(
    _BlockingTrampoline_20 block, _BlockingTrampoline_20 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, UIDropSessionProgressIndicatorStyle arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ProtocolTrampoline_32)(void * sel, UIDropSessionProgressIndicatorStyle arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_b53a8b(id target, void * sel, UIDropSessionProgressIndicatorStyle arg1) {
  return ((_ProtocolTrampoline_32)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_21)(void * arg0, id arg1, struct CGRect arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_21 _886end_wrapListenerBlock_1u7ntgr(_ListenerTrampoline_21 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGRect arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_21)(void * waiter, void * arg0, id arg1, struct CGRect arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_21 _886end_wrapBlockingBlock_1u7ntgr(
    _BlockingTrampoline_21 block, _BlockingTrampoline_21 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGRect arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_33)(void * sel, id arg1, struct CGRect arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_1u7ntgr(id target, void * sel, id arg1, struct CGRect arg2, id arg3) {
  return ((_ProtocolTrampoline_33)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_22)(void * arg0, id arg1, id arg2, struct CGPoint arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_22 _886end_wrapListenerBlock_y4drw5(_ListenerTrampoline_22 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, struct CGPoint arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, objc_retainBlock(arg4));
  };
}

typedef void  (^_BlockingTrampoline_22)(void * waiter, void * arg0, id arg1, id arg2, struct CGPoint arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_22 _886end_wrapBlockingBlock_y4drw5(
    _BlockingTrampoline_22 block, _BlockingTrampoline_22 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, struct CGPoint arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, objc_retainBlock(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), arg3, objc_retainBlock(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_34)(void * sel, id arg1, id arg2, struct CGPoint arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_y4drw5(id target, void * sel, id arg1, id arg2, struct CGPoint arg3, id arg4) {
  return ((_ProtocolTrampoline_34)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_23)(void * arg0, id arg1, double arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_23 _886end_wrapListenerBlock_phul3w(_ListenerTrampoline_23 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, double arg2, BOOL arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_23)(void * waiter, void * arg0, id arg1, double arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_23 _886end_wrapBlockingBlock_phul3w(
    _BlockingTrampoline_23 block, _BlockingTrampoline_23 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, double arg2, BOOL arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_35)(void * sel, id arg1, double arg2, BOOL arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_phul3w(id target, void * sel, id arg1, double arg2, BOOL arg3) {
  return ((_ProtocolTrampoline_35)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_24)(void * arg0, id arg1, struct CGPoint arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_24 _886end_wrapListenerBlock_1jo11bz(_ListenerTrampoline_24 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct CGPoint arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_24)(void * waiter, void * arg0, id arg1, struct CGPoint arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_24 _886end_wrapBlockingBlock_1jo11bz(
    _BlockingTrampoline_24 block, _BlockingTrampoline_24 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct CGPoint arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_36)(void * sel, id arg1, struct CGPoint arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_1jo11bz(id target, void * sel, id arg1, struct CGPoint arg2, id arg3) {
  return ((_ProtocolTrampoline_36)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_25)(void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_25 _886end_wrapListenerBlock_xx612k(_ListenerTrampoline_25 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  };
}

typedef void  (^_BlockingTrampoline_25)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_25 _886end_wrapBlockingBlock_xx612k(
    _BlockingTrampoline_25 block, _BlockingTrampoline_25 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_37)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_xx612k(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_37)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_26)(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4, UIWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_26 _886end_wrapListenerBlock_1mifnam(_ListenerTrampoline_26 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4, UIWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), objc_retainBlock(arg7));
  };
}

typedef void  (^_BlockingTrampoline_26)(void * waiter, void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4, UIWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_26 _886end_wrapBlockingBlock_1mifnam(
    _BlockingTrampoline_26 block, _BlockingTrampoline_26 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4, UIWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), objc_retainBlock(arg7));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4), arg5, (__bridge id)(__bridge_retained void*)(arg6), objc_retainBlock(arg7));
  });
}

typedef void  (^_ProtocolTrampoline_38)(void * sel, id arg1, struct _NSRange arg2, id arg3, id arg4, UIWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_1mifnam(id target, void * sel, id arg1, struct _NSRange arg2, id arg3, id arg4, UIWritingToolsCoordinatorTextReplacementReason arg5, id arg6, id arg7) {
  return ((_ProtocolTrampoline_38)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
}

typedef void  (^_ListenerTrampoline_27)(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_27 _886end_wrapListenerBlock_1oetkgs(_ListenerTrampoline_27 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  };
}

typedef void  (^_BlockingTrampoline_27)(void * waiter, void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_27 _886end_wrapBlockingBlock_1oetkgs(
    _BlockingTrampoline_27 block, _BlockingTrampoline_27 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct _NSRange arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), objc_retainBlock(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_39)(void * sel, id arg1, struct _NSRange arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_1oetkgs(id target, void * sel, id arg1, struct _NSRange arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_39)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_28)(void * arg0, id arg1, UIWritingToolsCoordinatorContextScope arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_28 _886end_wrapListenerBlock_1ls7i4u(_ListenerTrampoline_28 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UIWritingToolsCoordinatorContextScope arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_28)(void * waiter, void * arg0, id arg1, UIWritingToolsCoordinatorContextScope arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_28 _886end_wrapBlockingBlock_1ls7i4u(
    _BlockingTrampoline_28 block, _BlockingTrampoline_28 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UIWritingToolsCoordinatorContextScope arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_40)(void * sel, id arg1, UIWritingToolsCoordinatorContextScope arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_1ls7i4u(id target, void * sel, id arg1, UIWritingToolsCoordinatorContextScope arg2, id arg3) {
  return ((_ProtocolTrampoline_40)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_29)(void * arg0, id arg1, UIWritingToolsCoordinatorState arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_29 _886end_wrapListenerBlock_112fwzu(_ListenerTrampoline_29 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UIWritingToolsCoordinatorState arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  };
}

typedef void  (^_BlockingTrampoline_29)(void * waiter, void * arg0, id arg1, UIWritingToolsCoordinatorState arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_29 _886end_wrapBlockingBlock_112fwzu(
    _BlockingTrampoline_29 block, _BlockingTrampoline_29 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UIWritingToolsCoordinatorState arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, objc_retainBlock(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_41)(void * sel, id arg1, UIWritingToolsCoordinatorState arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_112fwzu(id target, void * sel, id arg1, UIWritingToolsCoordinatorState arg2, id arg3) {
  return ((_ProtocolTrampoline_41)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_30)(void * arg0, id arg1, UIWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_30 _886end_wrapListenerBlock_1q671ww(_ListenerTrampoline_30 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, UIWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  };
}

typedef void  (^_BlockingTrampoline_30)(void * waiter, void * arg0, id arg1, UIWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_30 _886end_wrapBlockingBlock_1q671ww(
    _BlockingTrampoline_30 block, _BlockingTrampoline_30 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, UIWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, (__bridge id)(__bridge_retained void*)(arg4), objc_retainBlock(arg5));
  });
}

typedef void  (^_ProtocolTrampoline_42)(void * sel, id arg1, UIWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_1q671ww(id target, void * sel, id arg1, UIWritingToolsCoordinatorTextAnimation arg2, struct _NSRange arg3, id arg4, id arg5) {
  return ((_ProtocolTrampoline_42)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4, arg5);
}

typedef void  (^_ListenerTrampoline_31)(void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_31 _886end_wrapListenerBlock_10lndml(_ListenerTrampoline_31 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, BOOL arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_31)(void * waiter, void * arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_31 _886end_wrapBlockingBlock_10lndml(
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

typedef void  (^_ProtocolTrampoline_43)(void * sel, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_10lndml(id target, void * sel, BOOL arg1) {
  return ((_ProtocolTrampoline_43)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_32)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_32 _886end_wrapListenerBlock_1l4hxwm(_ListenerTrampoline_32 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, objc_retainBlock(arg1));
  };
}

typedef void  (^_BlockingTrampoline_32)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_32 _886end_wrapBlockingBlock_1l4hxwm(
    _BlockingTrampoline_32 block, _BlockingTrampoline_32 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, objc_retainBlock(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, objc_retainBlock(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_44)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _886end_protocolTrampoline_1l4hxwm(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_44)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_45)(void * sel, unsigned long arg1, unsigned long arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _886end_protocolTrampoline_9b3h4v(id target, void * sel, unsigned long arg1, unsigned long arg2) {
  return ((_ProtocolTrampoline_45)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_46)(void * sel, long arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _886end_protocolTrampoline_rb7anl(id target, void * sel, long arg1, id arg2) {
  return ((_ProtocolTrampoline_46)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_47)(void * sel, struct _NSZone * arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _886end_protocolTrampoline_18nsem0(id target, void * sel, struct _NSZone * arg1) {
  return ((_ProtocolTrampoline_47)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}
#undef BLOCKING_BLOCK_IMPL

#pragma clang diagnostic pop
