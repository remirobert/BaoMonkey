//
//  MyScene.h
//  iosGame
//

//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>
#import "Monkey.h"

@interface MyScene : SKScene {
    CMMotionManager *motionManager;
    Monkey *monkey;
}

@property (strong, nonatomic) CMMotionManager *motionManager;

@end
