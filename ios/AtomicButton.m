#import <React/RCTLog.h>
#import "AtomicButton.h"

@implementation AtomicButton

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.isDisabled = NO;
    self.userInteractionEnabled = YES;
    [self addTarget:self action:@selector(handlePress) forControlEvents:UIControlEventTouchUpInside];
  }
  return self;
}

- (void)handlePress {
  if (self.isDisabled) {
    RCTLogInfo(@"AtomicButton handlePress ignored because button is disabled");
    return;
  }
  RCTLogInfo(@"AtomicButton handlePress called");
  self.isDisabled = YES;
  self.userInteractionEnabled = NO;
  self.alpha = 0.5;
  if (self.onPress) {
    self.onPress(@{});
  }
}

- (void)reset {
  self.isDisabled = NO;
  self.userInteractionEnabled = YES;
  self.alpha = 1.0;
}

@end
