#import "GameSurface.h"
#import "AsteroidView.h"

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

- (void)buildAsteroid {
    CGRect safeZone = CGRectMake((self.bounds.size.width/2)-50, 
                                 (self.bounds.size.height/2)-50, 100, 100);
    
    CGRect aFrame;
    while( true ) {
        aFrame.size.width = aFrame.size.height = ( ( (float)rand() / (float)RAND_MAX ) * 100.0 ) + 50;
        aFrame.origin.x = ( (float)rand() / (float)RAND_MAX ) * ( self.bounds.size.width - aFrame.size.width );
        aFrame.origin.y = ( (float)rand() / (float)RAND_MAX ) * ( self.bounds.size.height - aFrame.size.height );
        if ( CGRectIntersectsRect(aFrame, safeZone) == FALSE )
            break;
    }
    
    AsteroidView *av = [[AsteroidView alloc] initWithFrame:aFrame];
    av.direction = ( (float)rand() / (float)RAND_MAX ) * 360.0;
    av.speed = ( ( (float)rand() / (float)RAND_MAX ) * 1.0 ) + 0.2;
    [self addSubview:av];
    asteroidsAdded = YES;
}

- (void)createAsteroids {
    for( int i = 0; i < 20; i++ ) {
        [self buildAsteroid];
    }
}

- (void)drawRect:(CGRect)rect
{
    if ( asteroidsAdded == NO ) {
        [self createAsteroids];
    }
    
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    
    CGContextTranslateCTM( context, ( self.bounds.size.width / 2 ) + shipLocation.x, ( self.bounds.size.height / 2 ) + shipLocation.y );
      
    if ( gunEnabled ) {
        CGContextSaveGState(context);
        
        CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
        CGContextSetLineWidth(context, 5.0);
        
        CGPoint target;
        target.x = ( 1000.0 * cos((gunDirection+90.0) * 0.0174532925) ) * -1;
        target.y = ( 1000.0 * sin((gunDirection+90.0) * 0.0174532925) ) * -1;
        
        CGContextMoveToPoint(context, 0.0, 0.0);
        CGContextAddLineToPoint(context, target.x, target.y);
        
        CGContextStrokePath(context);
        
        CGContextRestoreGState(context);
    }

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

- (BOOL)lineIntersects:(CGRect)rect start:(CGPoint)start end:(CGPoint)end {
    double minX = start.x;
    double maxX = end.x;
    
    if(start.x > end.x) {
        minX = end.x;
        maxX = start.x;
    }
    
    if(maxX > rect.origin.x+rect.size.width)
        maxX = rect.origin.x+rect.size.width;
    
    if(minX < rect.origin.x)
        minX = rect.origin.x;
    
    if(minX > maxX)
        return NO;
    
    double minY = start.y;
    double maxY = end.y;
    
    double dx = end.x - start.x;
    
    if(abs(dx) > 0.0000001) {
        double a = (end.y - start.y) / dx;
        double b = start.y - a * start.x;
        minY = a * minX + b;
        maxY = a * maxX + b;
    }
    
    if(minY > maxY) {
        double tmp = maxY;
        maxY = minY;
        minY = tmp;
    }
    
    if(maxY > rect.origin.y + rect.size.height)
        maxY = rect.origin.y + rect.size.height;
    
    if(minY < rect.origin.y)
        minY = rect.origin.y;
    
    if(minY > maxY)
        return NO;
    
    return YES;
}


- (void)enableGun:(float)distance angle:(float)angle {
    gunEnabled = YES;
    gunDirection = angle;
    
    CGPoint laserStart, laserEnd;
    laserStart.x = ( self.bounds.size.width / 2 ) + shipLocation.x;
    laserStart.y = ( self.bounds.size.height / 2 ) + shipLocation.y;
    laserEnd.x = laserStart.x + ( 1000.0 * cos((gunDirection+90.0) * 0.0174532925) ) * -1;
    laserEnd.y = laserStart.y + ( 1000.0 * sin((gunDirection+90.0) * 0.0174532925) ) * -1;
    
    for( AsteroidView *v in [self subviews] ) {
        if ( [self lineIntersects:v.frame start:laserStart end:laserEnd] ) {
            [v removeFromSuperview];
        }
    }
    
    [self setNeedsDisplay];
}


- (void)disableGun {
    gunEnabled = NO;
    
    if ( [[self subviews] count] == 0 ) {
        [self createAsteroids];
    }
    
    [self setNeedsDisplay];
}

- (void)cycleAsteroids {
    for( AsteroidView *v in [self subviews] ) {
        if ( v ) {
            CGPoint vorigin;
            vorigin.x = v.frame.origin.x + ( v.speed * sin( v.direction * 0.0174532925 ) );
            vorigin.y = v.frame.origin.y + ( v.speed * cos( v.direction * 0.0174532925 ) );
            
            if ( vorigin.x < 0 || vorigin.y < 0 ||
                vorigin.x + v.bounds.size.width > self.bounds.size.width ||
                vorigin.y + v.bounds.size.height > self.bounds.size.height ) {
                v.direction = v.direction + ( ( ( (float)rand() / (float)RAND_MAX ) * 180.0 ) + 180.0 );
                if ( v.direction > 360.0 )
                    v.direction -= 360.0;
            }
            else {
                [v setFrame:CGRectMake(vorigin.x, vorigin.y, v.bounds.size.width, v.bounds.size.height)];
            }
            
            [v cycle];
        }
    }
}

- (void)dealloc
{
    [super dealloc];
}

@end
