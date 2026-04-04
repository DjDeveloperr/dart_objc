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


typedef double  (^_ProtocolTrampoline)(void * sel, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
double  _4e06o7_protocolTrampoline_mj5w82(id target, void * sel, id arg1, id arg2, long arg3) {
  return ((_ProtocolTrampoline)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef struct CGPoint  (^_ProtocolTrampoline_1)(void * sel, id arg1, struct CGPoint arg2);
__attribute__((visibility("default"))) __attribute__((used))
struct CGPoint  _4e06o7_protocolTrampoline_pftu99(id target, void * sel, id arg1, struct CGPoint arg2) {
  return ((_ProtocolTrampoline_1)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef struct CGSize  (^_ProtocolTrampoline_2)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _4e06o7_protocolTrampoline_1j20mp(id target, void * sel) {
  return ((_ProtocolTrampoline_2)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef struct CGSize  (^_ProtocolTrampoline_3)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _4e06o7_protocolTrampoline_ckubc3(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_3)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef struct CGSize  (^_ProtocolTrampoline_4)(void * sel, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
struct CGSize  _4e06o7_protocolTrampoline_141imqv(id target, void * sel, id arg1, id arg2, long arg3) {
  return ((_ProtocolTrampoline_4)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_5)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
id  _4e06o7_protocolTrampoline_1mbt9g9(id target, void * sel) {
  return ((_ProtocolTrampoline_5)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef id  (^_ProtocolTrampoline_6)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
id  _4e06o7_protocolTrampoline_xr62hr(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_6)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef id  (^_ProtocolTrampoline_7)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _4e06o7_protocolTrampoline_1yw2rcr(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_7)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef id  (^_ProtocolTrampoline_8)(void * sel, id arg1, id arg2, id arg3, struct CGPoint arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _4e06o7_protocolTrampoline_8oua50(id target, void * sel, id arg1, id arg2, id arg3, struct CGPoint arg4) {
  return ((_ProtocolTrampoline_8)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_9)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _4e06o7_protocolTrampoline_qfyidt(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_9)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_10)(void * sel, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _4e06o7_protocolTrampoline_1tgdqpb(id target, void * sel, id arg1, id arg2, long arg3) {
  return ((_ProtocolTrampoline_10)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef long  (^_ProtocolTrampoline_11)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
long  _4e06o7_protocolTrampoline_sqbvvb(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_11)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef long  (^_ProtocolTrampoline_12)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
long  _4e06o7_protocolTrampoline_1e5b3dp(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_12)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_13)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _4e06o7_protocolTrampoline_zi5eed(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_13)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_14)(void * sel, id arg1, id arg2, struct CGPoint arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _4e06o7_protocolTrampoline_11umze2(id target, void * sel, id arg1, id arg2, struct CGPoint arg3) {
  return ((_ProtocolTrampoline_14)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef struct UIEdgeInsets  (^_ProtocolTrampoline_15)(void * sel, id arg1, id arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
struct UIEdgeInsets  _4e06o7_protocolTrampoline_spyj1t(id target, void * sel, id arg1, id arg2, long arg3) {
  return ((_ProtocolTrampoline_15)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_16)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _4e06o7_protocolTrampoline_e3qsqz(id target, void * sel) {
  return ((_ProtocolTrampoline_16)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef BOOL  (^_ProtocolTrampoline_17)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _4e06o7_protocolTrampoline_2n06mv(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_17)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef BOOL  (^_ProtocolTrampoline_18)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _4e06o7_protocolTrampoline_jk8du5(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_18)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef BOOL  (^_ProtocolTrampoline_19)(void * sel, id arg1, struct objc_selector * arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _4e06o7_protocolTrampoline_1yp3wri(id target, void * sel, id arg1, struct objc_selector * arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_19)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_20)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _4e06o7_protocolTrampoline_23kxg8(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_20)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline)(void);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _4e06o7_wrapListenerBlock_1pl9qdv(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void() {
    objc_retainBlock(block);
    block();
  };
}

typedef void  (^_BlockingTrampoline)(void * waiter);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _4e06o7_wrapBlockingBlock_1pl9qdv(
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
_ListenerTrampoline_1 _4e06o7_wrapListenerBlock_xtuoz7(_ListenerTrampoline_1 block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0));
  };
}

typedef void  (^_BlockingTrampoline_1)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _4e06o7_wrapBlockingBlock_xtuoz7(
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

typedef void  (^_ListenerTrampoline_2)(id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _4e06o7_wrapListenerBlock_r8gdi7(_ListenerTrampoline_2 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_2)(void * waiter, id arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _4e06o7_wrapBlockingBlock_r8gdi7(
    _BlockingTrampoline_2 block, _BlockingTrampoline_2 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ListenerTrampoline_3)(id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _4e06o7_wrapListenerBlock_pfv6jd(_ListenerTrampoline_3 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_3)(void * waiter, id arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _4e06o7_wrapBlockingBlock_pfv6jd(
    _BlockingTrampoline_3 block, _BlockingTrampoline_3 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ListenerTrampoline_4)(BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _4e06o7_wrapListenerBlock_1s56lr9(_ListenerTrampoline_4 block) NS_RETURNS_RETAINED {
  return ^void(BOOL arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_4)(void * waiter, BOOL arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _4e06o7_wrapBlockingBlock_1s56lr9(
    _BlockingTrampoline_4 block, _BlockingTrampoline_4 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(BOOL arg0), {
    objc_retainBlock(block);
    block(nil, arg0);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0);
  });
}

typedef void  (^_ListenerTrampoline_5)(BOOL arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _4e06o7_wrapListenerBlock_14iqu8t(_ListenerTrampoline_5 block) NS_RETURNS_RETAINED {
  return ^void(BOOL arg0, BOOL arg1) {
    objc_retainBlock(block);
    block(arg0, arg1);
  };
}

typedef void  (^_BlockingTrampoline_5)(void * waiter, BOOL arg0, BOOL arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_5 _4e06o7_wrapBlockingBlock_14iqu8t(
    _BlockingTrampoline_5 block, _BlockingTrampoline_5 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(BOOL arg0, BOOL arg1), {
    objc_retainBlock(block);
    block(nil, arg0, arg1);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, arg1);
  });
}

typedef void  (^_ListenerTrampoline_6)(void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _4e06o7_wrapListenerBlock_ovsamd(_ListenerTrampoline_6 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0) {
    objc_retainBlock(block);
    block(arg0);
  };
}

typedef void  (^_BlockingTrampoline_6)(void * waiter, void * arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_6 _4e06o7_wrapBlockingBlock_ovsamd(
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

typedef void  (^_ProtocolTrampoline_21)(void * sel);
__attribute__((visibility("default"))) __attribute__((used))
void  _4e06o7_protocolTrampoline_ovsamd(id target, void * sel) {
  return ((_ProtocolTrampoline_21)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel);
}

typedef void  (^_ListenerTrampoline_7)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _4e06o7_wrapListenerBlock_18v1jvf(_ListenerTrampoline_7 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_7)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_7 _4e06o7_wrapBlockingBlock_18v1jvf(
    _BlockingTrampoline_7 block, _BlockingTrampoline_7 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_22)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _4e06o7_protocolTrampoline_18v1jvf(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_22)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_8)(void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _4e06o7_wrapListenerBlock_fjrv01(_ListenerTrampoline_8 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  };
}

typedef void  (^_BlockingTrampoline_8)(void * waiter, void * arg0, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_8 _4e06o7_wrapBlockingBlock_fjrv01(
    _BlockingTrampoline_8 block, _BlockingTrampoline_8 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2));
  });
}

typedef void  (^_ProtocolTrampoline_23)(void * sel, id arg1, id arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _4e06o7_protocolTrampoline_fjrv01(id target, void * sel, id arg1, id arg2) {
  return ((_ProtocolTrampoline_23)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_9)(void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _4e06o7_wrapListenerBlock_1tz5yf(_ListenerTrampoline_9 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  };
}

typedef void  (^_BlockingTrampoline_9)(void * waiter, void * arg0, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_9 _4e06o7_wrapBlockingBlock_1tz5yf(
    _BlockingTrampoline_9 block, _BlockingTrampoline_9 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3));
  });
}

typedef void  (^_ProtocolTrampoline_24)(void * sel, id arg1, id arg2, id arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _4e06o7_protocolTrampoline_1tz5yf(id target, void * sel, id arg1, id arg2, id arg3) {
  return ((_ProtocolTrampoline_24)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef void  (^_ListenerTrampoline_10)(void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _4e06o7_wrapListenerBlock_8jfq1p(_ListenerTrampoline_10 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, id arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_10)(void * waiter, void * arg0, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_10 _4e06o7_wrapBlockingBlock_8jfq1p(
    _BlockingTrampoline_10 block, _BlockingTrampoline_10 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, id arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), (__bridge id)(__bridge_retained void*)(arg2), (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_25)(void * sel, id arg1, id arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _4e06o7_protocolTrampoline_8jfq1p(id target, void * sel, id arg1, id arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_25)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef void  (^_ListenerTrampoline_11)(void * arg0, id arg1, struct objc_selector * arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _4e06o7_wrapListenerBlock_zthvms(_ListenerTrampoline_11 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, struct objc_selector * arg2, id arg3, id arg4) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  };
}

typedef void  (^_BlockingTrampoline_11)(void * waiter, void * arg0, id arg1, struct objc_selector * arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_11 _4e06o7_wrapBlockingBlock_zthvms(
    _BlockingTrampoline_11 block, _BlockingTrampoline_11 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, struct objc_selector * arg2, id arg3, id arg4), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, (__bridge id)(__bridge_retained void*)(arg3), (__bridge id)(__bridge_retained void*)(arg4));
  });
}

typedef void  (^_ProtocolTrampoline_26)(void * sel, id arg1, struct objc_selector * arg2, id arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
void  _4e06o7_protocolTrampoline_zthvms(id target, void * sel, id arg1, struct objc_selector * arg2, id arg3, id arg4) {
  return ((_ProtocolTrampoline_26)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef id  (^_ProtocolTrampoline_27)(void * sel, id arg1, id arg2, struct CGRect arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _4e06o7_protocolTrampoline_1l4smki(id target, void * sel, id arg1, id arg2, struct CGRect arg3) {
  return ((_ProtocolTrampoline_27)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}
#undef BLOCKING_BLOCK_IMPL

#pragma clang diagnostic pop
