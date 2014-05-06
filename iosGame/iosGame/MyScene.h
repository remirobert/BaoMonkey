//
//  MyScene.h
//  iosGame
//

//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
<<<<<<< HEAD
#import "Item.h"
#import "Trunk.h"
=======
#import <CoreMotion/CoreMotion.h>
#import "Monkey.h"
>>>>>>> c82e9e1d61387d22549462d3fe939d70e2f95bab

@interface MyScene : SKScene {
    CMMotionManager *motionManager;
    Monkey *monkey;
}

@property (strong, nonatomic) CMMotionManager *motionManager;

@property (nonatomic) int sizeBlock;
@property (nonatomic) Trunk *trunk;

@end
