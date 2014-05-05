//
//  MyScene.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "MyScene.h"

# define kPlayerSpeed 10

# define IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

@implementation MyScene

@synthesize motionManager;

+ (SKSpriteNode *)spriteNodeWithImageNamed:(NSString *)name {
    if (IPAD) {
        name = [NSString stringWithFormat:@"ipad-%@", name];
    } else {
        name = [NSString stringWithFormat:@"iphone-%@", name];
    }
    return [SKSpriteNode spriteNodeWithImageNamed:name];
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        monkey = [SKSpriteNode spriteNodeWithImageNamed:@"monkey.png"];
        monkey.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        self.backgroundColor = [SKColor colorWithRed:52 green:152 blue:219 alpha:1];
        
        [self addChild:monkey];

        motionManager = [[CMMotionManager alloc] init];
        
        [self startTheGame];
    }
    return self;
}

- (void)startTheGame
{
    //setup to handle accelerometer readings using CoreMotion Framework
    [self startMonitoringAcceleration];
    
}

- (void)startMonitoringAcceleration
{
    if (motionManager.accelerometerAvailable) {
        [motionManager startAccelerometerUpdates];
        NSLog(@"accelerometer updates on...");
    }
}

- (void)stopMonitoringAcceleration
{
    if (motionManager.accelerometerAvailable && motionManager.accelerometerActive) {
        [motionManager stopAccelerometerUpdates];
        NSLog(@"accelerometer updates off...");
    }
}

- (void)updateMonkeyPositionFromMotionManager
{
    CMAccelerometerData *data = motionManager.accelerometerData;
    if (fabs(data.acceleration.x) > 0.2) {
        if (monkey.position.x > 360.0f)
            monkey.position = CGPointMake(-40.0f, monkey.position.y);
        else if (monkey.position.x < -40.0f)
            monkey.position = CGPointMake(360.0f, monkey.position.y);
        else
            monkey.position = CGPointMake(monkey.position.x + (data.acceleration.x * kPlayerSpeed), monkey.position.y);
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [self updateMonkeyPositionFromMotionManager];
}

@end
