//
//  GameController.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "GameController.h"
#import "GameData.h"

@implementation GameController

static GameController *singleton;

+(id)singleton {
    if (!singleton) {
        singleton = [[GameController alloc] init];
        singleton->speed = 0.0;
    }
    return singleton;
}

#pragma mark - Reset GameController

+(void)resetAccelerometer {
    [[GameController singleton] initAccelerometer];
}

#pragma mark - Accelerometer Functions

+(void)initAccelerometer {
    [[GameController singleton] initAccelerometer];
}

-(void)initAccelerometer {
    motionManager = [[CMMotionManager alloc] init];
    [self startMonitoringAcceleration];
}

-(void)startMonitoringAcceleration {
    if (motionManager.accelerometerAvailable) {
        [motionManager startAccelerometerUpdates];
    }
}

-(void)stopMonitoringAcceleration {
    if (motionManager.accelerometerAvailable && motionManager.accelerometerActive) {
        [motionManager stopAccelerometerUpdates];
    }
}

+(void)updateAccelerometerAcceleration {
    [[GameController singleton] updateAccelerometerAcceleration];
}

-(void)updateAccelerometerAcceleration{
    CMAccelerometerData *data = motionManager.accelerometerData;
    
    acceleration = 0.0f;
    
    if (fabs(data.acceleration.x) > kAccelerometerTilt) {
        if ([UserData getAccelerometerUserSpeed]) {
            acceleration = data.acceleration.x * ([UserData getAccelerometerUserSpeed] + speed);
        } else {
            acceleration = data.acceleration.x * (kAccelerometerSpeed + speed);
        }
    }
}

+(void)updateAcceleration:(float)a {
    [[GameController singleton] updateAcceleration:a];
}

-(void)updateAcceleration:(float)a {
    speed = a;
}

+(float)getAcceleration {
    return [GameData isGameOver] ? 0.0 : [[GameController singleton] getAcceleration];
}

-(float)getAcceleration {
    return acceleration;
}

#pragma mark - OneTap Functions

+(void)initOneTapOnView:(SKView *)view {
    //[[GameController singleton] initOneTapOnView:view];
}

/*-(void)initOneTapOnView:(SKView *)view {
    UITapGestureRecognizer *oneFingerOneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTapDetected)];
    [oneFingerOneTap setNumberOfTapsRequired:1];
    [view addGestureRecognizer:oneFingerOneTap];
}

-(void)oneTapDetected {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DROP_MONKEY_ITEM object:nil];
}*/

@end
