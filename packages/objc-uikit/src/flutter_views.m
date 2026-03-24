#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void ObjCObjectImpl;

#define DOBJC_UIKIT_EXPORT __attribute__((visibility("default"))) \
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

@interface DOBJCTransferredUIKitPlatformView : NSObject
@property(nonatomic, strong) UIView* view;
- (instancetype)initWithView:(UIView*)view;
@end

@implementation DOBJCTransferredUIKitPlatformView
- (instancetype)initWithView:(UIView*)view {
  self = [super init];
  if (self) {
    _view = view;
  }
  return self;
}
@end

@interface DOBJCTransferredUIKitFactory : NSObject
@end

@implementation DOBJCTransferredUIKitFactory
- (NSObject*)createArgsCodec {
  return DOBJCStandardMessageCodec();
}

- (NSObject*)createWithFrame:(CGRect)frame
              viewIdentifier:(int64_t)viewId
                   arguments:(id)args {
  (void)viewId;
  UIView* view = DOBJCTakeTransferredPlatformView(args);
  if (view == nil) return nil;
  view.frame = frame;
  view.opaque = NO;
  view.backgroundColor = UIColor.clearColor;
  view.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  return [[DOBJCTransferredUIKitPlatformView alloc] initWithView:view];
}
@end

DOBJC_UIKIT_EXPORT void DOBJCUIKIT_storeTransferredPlatformView(
    int64_t token,
    ObjCObjectImpl* view) {
  if (view == NULL) return;
  id object = (__bridge id)view;
  @synchronized(_dobjcTransferredPlatformViews) {
    _dobjcTransferredPlatformViews[@(token)] = object;
  }
}

DOBJC_UIKIT_EXPORT ObjCObjectImpl* DOBJCUIKIT_newTransferredPlatformViewFactory(
    void) {
  return (__bridge_retained ObjCObjectImpl*)[[DOBJCTransferredUIKitFactory alloc]
      init];
}
