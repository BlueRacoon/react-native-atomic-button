#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>
#import <React/RCTConvert.h>
#import "AtomicButton.h"

@interface AtomicButtonManager : RCTViewManager
@end

@implementation AtomicButtonManager

RCT_EXPORT_MODULE(AtomicButton)

// Return a new instance of the native view.
- (UIView *)view {
  return [[AtomicButton alloc] initWithFrame:CGRectZero];
}

// Map the testID prop to accessibilityIdentifier.
RCT_CUSTOM_VIEW_PROPERTY(testID, NSString, AtomicButton)
{
  if (json) {
    view.accessibilityIdentifier = [RCTConvert NSString:json];
  } else {
    view.accessibilityIdentifier = nil;
  }
}

// Expose the onPress event to JS.
RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)

// Expose the "reset" command (already exists).
RCT_EXPORT_METHOD(reset:(nonnull NSNumber *)reactTag)
{
  RCTUIManager *uiManager = [self.bridge moduleForName:@"UIManager" lazilyLoadIfNecessary:YES];
  [uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry) {
    AtomicButton *button = (AtomicButton *)viewRegistry[reactTag];
    if (![button isKindOfClass:[AtomicButton class]]) {
      RCTLogError(@"Invalid view returned from registry, expecting AtomicButton, got: %@", button);
    } else {
      [button reset];
    }
  }];
}

// **Updated Command: simulateTap**
// This method will trigger the native touch event.
RCT_EXPORT_METHOD(simulateTap:(nonnull NSNumber *)reactTag)
{
  // Dispatch on the UIManager queue instead of the main queue.
  dispatch_async(RCTGetUIManagerQueue(), ^{
    RCTUIManager *uiManager = [self.bridge moduleForName:@"UIManager" lazilyLoadIfNecessary:YES];
    [uiManager addUIBlock:^(RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry) {
      AtomicButton *button = (AtomicButton *)viewRegistry[reactTag];
      if ([button isKindOfClass:[AtomicButton class]]) {
        // This sends the "touch up inside" event to the button.
        [button sendActionsForControlEvents:UIControlEventTouchUpInside];
      } else {
        RCTLogError(@"simulateTap: Expected an AtomicButton, got: %@", button);
      }
    }];
  });
}

@end
