// File: ios/AtomicButton.h
#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>

@interface AtomicButton : UIButton
@property (nonatomic, assign) BOOL isDisabled;
- (void)reset;
@end
`