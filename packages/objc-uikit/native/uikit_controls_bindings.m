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


typedef double  (^_ProtocolTrampoline)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
double  _v7p84f_protocolTrampoline_5bm8w8(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_1)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
id  _v7p84f_protocolTrampoline_1xvw1tx(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_1)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_2)(void * sel, id arg1, long arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
id  _v7p84f_protocolTrampoline_17vitjj(id target, void * sel, id arg1, long arg2, long arg3) {
  return ((_ProtocolTrampoline_2)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}

typedef long  (^_ProtocolTrampoline_3)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
long  _v7p84f_protocolTrampoline_sqbvvb(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_3)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef long  (^_ProtocolTrampoline_4)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
long  _v7p84f_protocolTrampoline_1e5b3dp(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_4)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef id  (^_ProtocolTrampoline_5)(void * sel, id arg1, long arg2, long arg3, id arg4);
__attribute__((visibility("default"))) __attribute__((used))
id  _v7p84f_protocolTrampoline_16qxnpx(id target, void * sel, id arg1, long arg2, long arg3, id arg4) {
  return ((_ProtocolTrampoline_5)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3, arg4);
}

typedef BOOL  (^_ProtocolTrampoline_6)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
BOOL  _v7p84f_protocolTrampoline_1ae3jer(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_6)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef float  (^_ProtocolTrampoline_7)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
float  _v7p84f_protocolTrampoline_1o407rf(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_7)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline)(id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _v7p84f_wrapListenerBlock_xtuoz7(_ListenerTrampoline block) NS_RETURNS_RETAINED {
  return ^void(id arg0) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0));
  };
}

typedef void  (^_BlockingTrampoline)(void * waiter, id arg0);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline _v7p84f_wrapBlockingBlock_xtuoz7(
    _BlockingTrampoline block, _BlockingTrampoline listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0));
  });
}

typedef void  (^_ListenerTrampoline_1)(id arg0, id arg1, struct objc_selector * arg2, unsigned long arg3, BOOL * arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _v7p84f_wrapListenerBlock_dxmvft(_ListenerTrampoline_1 block) NS_RETURNS_RETAINED {
  return ^void(id arg0, id arg1, struct objc_selector * arg2, unsigned long arg3, BOOL * arg4) {
    objc_retainBlock(block);
    block((__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  };
}

typedef void  (^_BlockingTrampoline_1)(void * waiter, id arg0, id arg1, struct objc_selector * arg2, unsigned long arg3, BOOL * arg4);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_1 _v7p84f_wrapBlockingBlock_dxmvft(
    _BlockingTrampoline_1 block, _BlockingTrampoline_1 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(id arg0, id arg1, struct objc_selector * arg2, unsigned long arg3, BOOL * arg4), {
    objc_retainBlock(block);
    block(nil, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, (__bridge id)(__bridge_retained void*)(arg0), (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3, arg4);
  });
}

typedef void  (^_ListenerTrampoline_2)(void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _v7p84f_wrapListenerBlock_18v1jvf(_ListenerTrampoline_2 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1));
  };
}

typedef void  (^_BlockingTrampoline_2)(void * waiter, void * arg0, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_2 _v7p84f_wrapBlockingBlock_18v1jvf(
    _BlockingTrampoline_2 block, _BlockingTrampoline_2 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1));
  });
}

typedef void  (^_ProtocolTrampoline_8)(void * sel, id arg1);
__attribute__((visibility("default"))) __attribute__((used))
void  _v7p84f_protocolTrampoline_18v1jvf(id target, void * sel, id arg1) {
  return ((_ProtocolTrampoline_8)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1);
}

typedef void  (^_ListenerTrampoline_3)(void * arg0, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _v7p84f_wrapListenerBlock_1wp3it5(_ListenerTrampoline_3 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long arg2) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  };
}

typedef void  (^_BlockingTrampoline_3)(void * waiter, void * arg0, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_3 _v7p84f_wrapBlockingBlock_1wp3it5(
    _BlockingTrampoline_3 block, _BlockingTrampoline_3 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long arg2), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2);
  });
}

typedef void  (^_ProtocolTrampoline_9)(void * sel, id arg1, long arg2);
__attribute__((visibility("default"))) __attribute__((used))
void  _v7p84f_protocolTrampoline_1wp3it5(id target, void * sel, id arg1, long arg2) {
  return ((_ProtocolTrampoline_9)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2);
}

typedef void  (^_ListenerTrampoline_4)(void * arg0, id arg1, long arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _v7p84f_wrapListenerBlock_98c27v(_ListenerTrampoline_4 block) NS_RETURNS_RETAINED {
  return ^void(void * arg0, id arg1, long arg2, long arg3) {
    objc_retainBlock(block);
    block(arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  };
}

typedef void  (^_BlockingTrampoline_4)(void * waiter, void * arg0, id arg1, long arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
_ListenerTrampoline_4 _v7p84f_wrapBlockingBlock_98c27v(
    _BlockingTrampoline_4 block, _BlockingTrampoline_4 listenerBlock,
    DOBJC_Context* ctx) NS_RETURNS_RETAINED {
  BLOCKING_BLOCK_IMPL(ctx, ^void(void * arg0, id arg1, long arg2, long arg3), {
    objc_retainBlock(block);
    block(nil, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  }, {
    objc_retainBlock(listenerBlock);
    listenerBlock(waiter, arg0, (__bridge id)(__bridge_retained void*)(arg1), arg2, arg3);
  });
}

typedef void  (^_ProtocolTrampoline_10)(void * sel, id arg1, long arg2, long arg3);
__attribute__((visibility("default"))) __attribute__((used))
void  _v7p84f_protocolTrampoline_98c27v(id target, void * sel, id arg1, long arg2, long arg3) {
  return ((_ProtocolTrampoline_10)((id (*)(id, SEL, SEL))objc_msgSend)(target, @selector(getDOBJCDartProtocolMethodForSelector:), sel))(sel, arg1, arg2, arg3);
}
#undef BLOCKING_BLOCK_IMPL

#pragma clang diagnostic pop
