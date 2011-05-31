#import <UIKit/UIKit.h>

#import "CircleControlView.h"
#import "GameSurface.h"

@interface PadsteroidsViewController : UIViewController {
    IBOutlet CircleControlView *motionControl;
    IBOutlet CircleControlView *fireControl;
    IBOutlet GameSurface *gameSurface;    
}

@end
