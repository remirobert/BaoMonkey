//
//  GameController.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "GameController.h"

@implementation GameController

static GameController *singleton;

+(id)singleton {
    if (!singleton) {
        singleton = [[GameController alloc] init];
    }
    return singleton;
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

+(float)getAccelerometerPosition {
    return [[GameController singleton] getAccelerometerPosition];
}

-(float)getAccelerometerPosition {
    CMAccelerometerData *data = motionManager.accelerometerData;
    
    float acceleration = 0.0f;
    
    if (fabs(data.acceleration.x) > 0.2) {
        acceleration = data.acceleration.x * kAccelerometerSpeed;
    }
    
    return acceleration;
}

#pragma mark - OneTap Functions

+(void)initOneTapOnView:(SKView *)view {
    [[GameController singleton] initOneTapOnView:view];
}

-(void)initOneTapOnView:(SKView *)view {
    UITapGestureRecognizer *oneFingerOneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTapDetected)];
    [oneFingerOneTap setNumberOfTapsRequired:1];
    [view addGestureRecognizer:oneFingerOneTap];
}

-(void)oneTapDetected {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DROP_MONKEY_ITEM object:nil];
}

@end
