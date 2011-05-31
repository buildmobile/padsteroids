#import <UIKit/UIKit.h>

@interface CircleControlView : UIView {
    BOOL initializedCenter;
    CGPoint centerPoint;
}

- (double)getAngle;
- (double)getDistance;

@end
