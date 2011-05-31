//
//  CircleControlView.m
//  Padsteroids
//
//  Created by 3Easy on 30/05/11.
//  Copyright 2011 3Easy Web Org. All rights reserved.
//

#import "CircleControlView.h"


@implementation CircleControlView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        initializedCenter = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if ( initializedCenter == NO ) {
        centerPoint.x = self.bounds.size.width / 2;
        centerPoint.y = self.bounds.size.height / 2;
        initializedCenter = YES;
    }
    
	CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShouldAntialias( context, true );
    
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetAlpha( context, 0.2 );
    CGContextFillEllipseInRect( context, CGRectInset( self.bounds, 5, 5 ) );
    
    CGContextSetAlpha( context, 0.7 );
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
	CGContextSetLineWidth(context, 2.0);
    CGContextStrokeEllipseInRect( context, CGRectInset( self.bounds, 5, 5 ) );
    
    CGContextSetAlpha( context, 0.5 );
    
    CGRect ballRect;
    ballRect.origin.x = centerPoint.x - 20;
    ballRect.origin.y = centerPoint.y - 20;
    ballRect.size.width = 40;
    ballRect.size.height = 40;
    
	CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
	CGContextSetLineWidth(context, 1.0);
    CGContextFillEllipseInRect( context, ballRect );
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    centerPoint.x = self.bounds.size.width / 2;
    centerPoint.y = self.bounds.size.height / 2;
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    centerPoint = [[touches anyObject] locationInView: self];
    [self setNeedsDisplay];
}

- (double)getDistance { 
    double d = 0.0;
    
    CGPoint circCenter;
    circCenter.x = self.bounds.size.width / 2;
    circCenter.y = self.bounds.size.height / 2;
    
    double d1 = ( circCenter.x - centerPoint.x ) * ( circCenter.x - centerPoint.x );
    double d2 = ( circCenter.y - centerPoint.y ) * ( circCenter.y - centerPoint.y );
    d = sqrt( d1 + d2 );
    
    d = d / (double) ( self.bounds.size.width / 2 );
    
    return d;
}

- (double)getAngle { 
    double angle = 0.0;
    
    CGPoint circCenter;
    circCenter.x = self.bounds.size.width / 2;
    circCenter.y = self.bounds.size.height / 2;
    
    if ( circCenter.x == centerPoint.x && circCenter.y == centerPoint.y ) {
        angle = 0.0;
    } else if ( circCenter.x == centerPoint.x && centerPoint.y < circCenter.y  ) {
        angle = 0.0;
    } else if ( circCenter.x == centerPoint.x && centerPoint.y > circCenter.y ) {
        angle = 180.0;
    } else if ( centerPoint.x < circCenter.x && centerPoint.y == circCenter.y ) {
        angle = 270.0;
    } else if ( centerPoint.x > circCenter.x && centerPoint.y == circCenter.y ) {
        angle = 90.0;
    } else {
        double p1 = abs( centerPoint.x - circCenter.x );
        double p2 = abs( centerPoint.y - circCenter.y );
        angle = atan( p1 / p2 ) * 57.29577951;
        if ( centerPoint.x > circCenter.x && centerPoint.y > circCenter.y ) {
            angle = 180 - angle;
        } else if ( centerPoint.x < circCenter.x && centerPoint.y > circCenter.y ) {
            angle = 180 + angle;
        } else if ( centerPoint.x < circCenter.x && centerPoint.y < circCenter.y ) {
            angle = 360 - angle;
        }
    }
    
    while ( angle > 360.0 ) {
        angle -= 360.0;
    }
    while ( angle < 0 ) {
        angle += 360.0;
    }
    
    return angle;
}

- (void)dealloc
{
    [super dealloc];
}

@end
