// File: ios/AtomicButton.m
#import "AtomicButton.h"

@implementation AtomicButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.isDisabled = NO;
        [self addTarget:self action:@selector(handlePress) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)handlePress {
    if (!self.isDisabled) {
        self.isDisabled = YES;
        self.alpha = 0.5; // Visual feedback
        // Send a control event that the manager can observe
        [self sendActionsForControlEvents:UIControlEventPrimaryActionTriggered];
    }
}

- (void)reset {
    self.isDisabled = NO;
    self.alpha = 1.0;
}
@end
