#import "AtomicButton.h"

@implementation AtomicButton

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.isDisabled = NO;
    // Ensure the button is enabled for user interaction initially.
    self.userInteractionEnabled = YES;
    [self addTarget:self action:@selector(handlePress) forControlEvents:UIControlEventTouchUpInside];
  }
  return self;
}

- (void)handlePress {
  // If already disabled, do nothing.
  if (self.isDisabled) {
    return;
  }
  
  // Immediately disable the button and provide visual feedback.
  self.isDisabled = YES;
  self.userInteractionEnabled = NO;
  self.alpha = 0.5; // Change appearance instantly
  
  // Call the onPress callback if provided.
  if (self.onPress) {
    // You can pass an empty dictionary or any event details.
    self.onPress(@{});
  }
}

- (void)reset {
  // Reset the button so that it can be pressed again.
  self.isDisabled = NO;
  self.userInteractionEnabled = YES;
  self.alpha = 1.0;
}

@end