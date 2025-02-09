#import <UIKit/UIKit.h>

// Optionally, if you need React types, import them too:
// #import <React/RCTView.h>

@interface AtomicButton : UIButton

@property (nonatomic, assign) BOOL isDisabled;

- (void)reset;

@end
