//
//  PadsteroidsAppDelegate.h
//  Padsteroids
//
//  Created by 3Easy on 17/05/11.
//  Copyright 2011 3Easy Web Org. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PadsteroidsViewController;

@interface PadsteroidsAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet PadsteroidsViewController *viewController;

@end
