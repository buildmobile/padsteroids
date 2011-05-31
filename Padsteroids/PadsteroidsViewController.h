//
//  PadsteroidsViewController.h
//  Padsteroids
//
//  Created by 3Easy on 17/05/11.
//  Copyright 2011 3Easy Web Org. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CircleControlView.h"
#import "GameSurface.h"

@interface PadsteroidsViewController : UIViewController {
    IBOutlet CircleControlView *motionControl;
    IBOutlet CircleControlView *fireControl;
    IBOutlet GameSurface *gameSurface;    
}

@end
