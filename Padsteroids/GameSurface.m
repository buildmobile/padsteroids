//
//  GameSurface.m
//  Padsteroids
//
//  Created by 3Easy on 17/05/11.
//  Copyright 2011 3Easy Web Org. All rights reserved.
//

#import "GameSurface.h"

@implementation GameSurface

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        shipLocation.x = 0;
        shipLocation.y = 0;
        shipDirection = 0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextTranslateCTM( context, ( self.bounds.size.width / 2 ) + shipLocation.x, ( self.bounds.size.height / 2 ) + shipLocation.y );
    
    CGContextSaveGState(context);
    CGContextRotateCTM(context, shipDirection * 0.0174532925 );
    
    CGContextMoveToPoint(context, 0.0, -15.0);
    CGContextAddLineToPoint(context, 15.0, 30.0);
    CGContextAddLineToPoint(context, 0.0, 15.0);
    CGContextAddLineToPoint(context, -15.0, 30.0);
    CGContextAddLineToPoint(context, 0.0, -15.0);
    CGContextFillPath(context);
    
    CGContextRestoreGState(context);
}

- (void)dealloc
{
    [super dealloc];
}

@end
