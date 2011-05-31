#import "PadsteroidsViewController.h"

@implementation PadsteroidsViewController

- (void)dealloc {
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSTimer scheduledTimerWithTimeInterval:0.01
                                     target:self
                                   selector:@selector(gameUpdate:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)gameUpdate:(NSTimer*)theTimer {
    [gameSurface cycleAsteroids];
    if ( [motionControl getDistance] > 0 ) {
        [gameSurface moveShip:[motionControl getDistance] angle:[motionControl getAngle]];
    }
    if ( [fireControl getDistance] > 0 ) {
        [gameSurface enableGun:[fireControl getDistance] angle:[fireControl getAngle]];
    } else {
        [gameSurface disableGun];
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
