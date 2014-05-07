//
//  GameController.h
//  BaoMonkey
//
//  Created by Jeremy Peltier on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "Define.h"

@interface GameController : NSObject{
    CMMotionManager *motionManager;
}

+(id)singleton;

+(float)getAccelerometerPosition;

+(void)initAccelerometer;

+(void)initOneTapOnView:(SKView *)view;

@end
