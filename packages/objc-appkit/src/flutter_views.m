#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

typedef void ObjCObjectImpl;

#define DOBJC_APPKIT_EXPORT __attribute__((visibility("default"))) \
    __attribute__((used))

@protocol DOBJCFlutterStandardMessageCodecClass
+ (instancetype)sharedInstance;
@end

static NSMutableDictionary<NSNumber*, id>* _dobjcTransferredPlatformViews;

__attribute__((constructor)) static void DOBJCInitializeTransferredViewStore() {
  _dobjcTransferredPlatformViews = [[NSMutableDictionary alloc] init];
}

static NSNumber* DOBJCTransferredPlatformViewToken(id args) {
  if ([args respondsToSelector:@selector(longLongValue)]) {
    return @([(id)args longLongValue]);
  }
  return nil;
}

static id DOBJCTakeTransferredPlatformView(id args) {
  NSNumber* token = DOBJCTransferredPlatformViewToken(args);
  if (token == nil) return nil;
  @synchronized(_dobjcTransferredPlatformViews) {
    id view = _dobjcTransferredPlatformViews[token];
    if (view != nil) {
      [_dobjcTransferredPlatformViews removeObjectForKey:token];
    }
    return view;
  }
}

static NSObject* DOBJCStandardMessageCodec(void) {
  Class codecClass = NSClassFromString(@"FlutterStandardMessageCodec");
  if (codecClass == Nil) return nil;
  return [(Class<DOBJCFlutterStandardMessageCodecClass>)codecClass
      sharedInstance];
}

@interface DOBJCTransferredAppKitFactory : NSObject
@end

@implementation DOBJCTransferredAppKitFactory
- (NSObject*)createArgsCodec {
  return DOBJCStandardMessageCodec();
}

- (NSView*)createWithViewIdentifier:(int64_t)viewId arguments:(id)args {
  (void)viewId;
  return DOBJCTakeTransferredPlatformView(args);
}
@end

DOBJC_APPKIT_EXPORT void DOBJCAPPKIT_storeTransferredPlatformView(
    int64_t token,
    ObjCObjectImpl* view) {
  if (view == NULL) return;
  id object = (__bridge id)view;
  @synchronized(_dobjcTransferredPlatformViews) {
    _dobjcTransferredPlatformViews[@(token)] = object;
  }
}

DOBJC_APPKIT_EXPORT ObjCObjectImpl* DOBJCAPPKIT_newTransferredPlatformViewFactory(
    void) {
  return (__bridge_retained ObjCObjectImpl*)[[DOBJCTransferredAppKitFactory alloc]
      init];
}
