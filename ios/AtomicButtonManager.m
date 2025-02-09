#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>
#import <React/RCTConvert.h>
#import "AtomicButton.h"

@interface AtomicButtonManager : RCTViewManager
@end

@implementation AtomicButtonManager

RCT_EXPORT_MODULE(AtomicButton)

- (UIView *)view {
  return [[AtomicButton alloc] initWithFrame:CGRectZero];
}

// Map the testID prop to iOS accessibilityIdentifier
RCT_CUSTOM_VIEW_PROPERTY(testID, NSString, AtomicButton)
{
  if (json) {
    view.accessibilityIdentifier = [RCTConvert NSString:json];
  } else {
    view.accessibilityIdentifier = nil;
  }
}

// Expose the onPress event to JS
RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)

// Expose a command to reset the button
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

@end