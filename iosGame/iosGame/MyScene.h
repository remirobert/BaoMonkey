//
//  MyScene.h
//  iosGame
//

//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>

@interface MyScene : SKScene {
    SKSpriteNode *monkey;
    CMMotionManager *motionManager;
}

@property (strong, nonatomic) CMMotionManager *motionManager;

@end
