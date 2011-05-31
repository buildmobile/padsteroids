#import <UIKit/UIKit.h>

@interface AsteroidView : UIView {
    NSArray *indents;   
    float startDegree;
    
    CGGradientRef gradient;
    
    float direction;
    float speed;
}

- (void)cycle;

@property (readwrite,assign) float direction;
@property (readwrite,assign) float speed;

@end
