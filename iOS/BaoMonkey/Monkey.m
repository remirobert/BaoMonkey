//
//  Character.m
//  iosGame
//
//  Created by Jeremy Peltier on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "Monkey.h"

@implementation Monkey

@synthesize sprite;
@synthesize weapon;

-(id)initWithPosition:(CGPoint)position {
    self = [super init];
    if (self) {
        // Init the sprite of the Monkey
        sprite = [SKSpriteNode spriteNodeWithImageNamed:kSpriteImageName];
        sprite.position = position;
        
        // Init the accelerometer for the Monkey
        motionManager = [[CMMotionManager alloc] init];
        [self startMonitoringAcceleration];
    }
    return self;
}

#pragma mark - Accelerometer Functions

- (void)startMonitoringAcceleration
{
    if (motionManager.accelerometerAvailable) {
        [motionManager startAccelerometerUpdates];
    }
}

- (void)stopMonitoringAcceleration
{
    if (motionManager.accelerometerAvailable && motionManager.accelerometerActive) {
        [motionManager stopAccelerometerUpdates];
    }
}

#pragma mark - Update Sprite Functions

- (void)updateMonkeyPositionFromMotionManager
{
    float maxX = [UIScreen mainScreen].bounds.size.width + (sprite.size.width / 2);
    float minX = -(sprite.size.width / 2);
    
    CMAccelerometerData *data = motionManager.accelerometerData;
    if (fabs(data.acceleration.x) > 0.2) {
        if (sprite.position.x > maxX) // The Monkey exit the screen on the right, we put him on the left
            sprite.position = CGPointMake((0 - (sprite.size.width / 2)), sprite.position.y);
        else if (sprite.position.x < minX) // The Monkey exit the screen on the left, we put him on the right
            sprite.position = CGPointMake(([UIScreen mainScreen].bounds.size.width + (sprite.size.width / 2)), sprite.position.y);
        else
            sprite.position = CGPointMake(sprite.position.x + (data.acceleration.x * kSpeed), sprite.position.y);
    }
}

-(void)updatePosition{
    [self updateMonkeyPositionFromMotionManager];
}

@end
