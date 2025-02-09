#import <UIKit/UIKit.h>
#import <React/RCTComponent.h> // Import for RCTBubblingEventBlock

@interface AtomicButton : UIButton

@property (nonatomic, assign) BOOL isDisabled;
@property (nonatomic, copy) RCTBubblingEventBlock onPress; // Callback for press events

- (void)reset;

@end
