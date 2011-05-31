//
//  CircleControlView.h
//  Padsteroids
//
//  Created by 3Easy on 30/05/11.
//  Copyright 2011 3Easy Web Org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleControlView : UIView {
    BOOL initializedCenter;
    CGPoint centerPoint;
}

- (double)getAngle;
- (double)getDistance;

@end
