//
//  PadsteroidsAppDelegate.h
//  Padsteroids
//
//  Created by Jack Herrington on 4/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PadsteroidsViewController;

@interface PadsteroidsAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet PadsteroidsViewController *viewController;

@end
