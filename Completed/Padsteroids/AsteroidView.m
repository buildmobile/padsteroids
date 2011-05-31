#import "AsteroidView.h"

@implementation AsteroidView

@synthesize direction, speed;

- (void)setupIndents {
    NSMutableArray *indentList = [[[NSMutableArray alloc] init] autorelease];
    for( int i = 0; i < 20; i++ ) {
        float indent = ( ( (float)rand()/(float)RAND_MAX ) * 0.6 ) + 0.4;
        [indentList addObject:[NSNumber numberWithFloat:indent]];
    }
    indents = [[NSArray arrayWithArray:indentList] retain];
    startDegree = 0;
    
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 1.0, 0.9, 0.9, 1.0, 1.0, 0.0, 0.0, 1.0 };
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    gradient = CGGradientCreateWithColorComponents (colorSpace, components,
                                                    locations, 2);
    
    self.opaque = FALSE;
    [self setBackgroundColor:[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.0]];
    
    CGColorSpaceRelease(colorSpace);
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupIndents];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    if ( indents == NULL ) {
        [self setupIndents];
    }
    
    CGPoint center;
    center.x = self.bounds.size.width / 2;
    center.y = self.bounds.size.height / 2;
    
    float degree = startDegree;
    float indentDegree = 360.0 / (float)[indents count];
    float radius = (float)( self.bounds.size.width / 2 ) * 0.9;
    
    BOOL firstPointDrawn = NO;
    CGPoint firstPoint;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    for( NSNumber *number in indents ) {
        CGPoint newPoint;
        
        newPoint.x = center.x + ( ( radius * [number floatValue] ) * sin( degree * 0.0174532925 ) );
        newPoint.y = center.y + ( ( radius * [number floatValue] ) * cos( degree * 0.0174532925 ) );
        
        if ( firstPointDrawn == NO ) { 
            CGPathMoveToPoint(path, NULL, newPoint.x, newPoint.y);
            firstPoint.x = newPoint.x;
            firstPoint.y = newPoint.y;
        } else {
            CGPathAddLineToPoint(path, NULL, newPoint.x, newPoint.y);
        }
        
        degree += indentDegree;
        if ( degree > 360.0 )
            degree -= 360.0;
        firstPointDrawn = YES;
    }
    
    CGPathAddLineToPoint(path, NULL, firstPoint.x, firstPoint.y);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddPath(context, path);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawLinearGradient(context, gradient, 
                                CGPointMake(self.bounds.size.width/2,0), 
                                CGPointMake(self.bounds.size.width/2,self.bounds.size.height),
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    CFRelease(path);
}

- (void)cycle {
    startDegree += 0.2;
    if ( startDegree > 360 )
        startDegree -= 360.0;
    [self setNeedsDisplay];
}

- (void)dealloc {
    [super dealloc];
    CGGradientRelease(gradient);
}

@end
