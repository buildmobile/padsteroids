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

- (void)moveShip:(float)distance angle:(float)angle {
    shipLocation.x -= ( distance * 3.0 ) * cos((angle+90.0) * 0.0174532925);
    shipLocation.y -= ( distance * 3.0 ) * sin((angle+90.0) * 0.0174532925);
    shipDirection = angle;
    [self setNeedsDisplay];
}

- (void)enableGun:(float)distance angle:(float)angle {
    gunEnabled = YES;
    gunDirection = angle;
    
    CGPoint laserStart, laserEnd;
    laserStart.x = ( self.bounds.size.width / 2 ) + shipLocation.x;
    laserStart.y = ( self.bounds.size.height / 2 ) + shipLocation.y;
    laserEnd.x = laserStart.x + ( 1000.0 * cos((gunDirection+90.0) * 0.0174532925) ) * -1;
    laserEnd.y = laserStart.y + ( 1000.0 * sin((gunDirection+90.0) * 0.0174532925) ) * -1;
    
    [self setNeedsDisplay];
}

- (void)disableGun {
    gunEnabled = NO;
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [super dealloc];
}

@end
