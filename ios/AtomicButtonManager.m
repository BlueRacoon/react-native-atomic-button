// atomicbuttonmanager.m
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

// Expose the "title" property
RCT_CUSTOM_VIEW_PROPERTY(title, NSString, AtomicButton)
{
  // Convert json to a string; default to empty if not provided.
  NSString *title = json ? [RCTConvert NSString:json] : @"";
  [view setTitle:title forState:UIControlStateNormal];
}

// Expose the "reset" command (already exists).
RCT_EXPORT_METHOD(reset:(nonnull NSNumber *)reactTag)
{
  // Dispatch on the main thread so UI updates are applied immediately.
  dispatch_async(dispatch_get_main_queue(), ^{
    UIView *view = [self.bridge.uiManager viewForReactTag:reactTag];
    if ([view isKindOfClass:[AtomicButton class]]) {
      AtomicButton *button = (AtomicButton *)view;
      RCTLogInfo(@"reset: about to reset button: %@", button);
      [button reset];
    } else {
      RCTLogError(@"reset: Expected an AtomicButton, got: %@", view);
    }
  });
}

// simulateTap command as before...
RCT_EXPORT_METHOD(simulateDirectTap:(nonnull NSNumber *)reactTag)
{
  // Dispatch on the main queue.
  dispatch_async(dispatch_get_main_queue(), ^{
    // Use the UIManager to get the view by reactTag.
    UIView *view = [self.bridge.uiManager viewForReactTag:reactTag];
    if ([view isKindOfClass:[AtomicButton class]]) {
      AtomicButton *button = (AtomicButton *)view;
      RCTLogInfo(@"simulateDirectTap: calling handlePress for button: %@", button);
      // Call handlePress directly.
      [button handlePress];
    } else {
      RCTLogError(@"simulateDirectTap: Expected an AtomicButton, got: %@", view);
    }
  });
}

@end
