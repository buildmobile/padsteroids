#import <UIKit/UIKit.h>

@interface GameSurface : UIView {
    CGPoint shipLocation;
    double shipDirection;
    
    BOOL gunEnabled;
    double gunDirection;
    
    BOOL asteroidsAdded;
}

- (void)moveShip:(float)distance angle:(float)angle;

- (void)enableGun:(float)distance angle:(float)angle;
- (void)disableGun;

- (void)cycleAsteroids;

@end
