//
//  Character.h
//  iosGame
//
//  Created by Jeremy Peltier on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>
#import "Item.h"
#import "Weapon.h"

# define kSpeed 10
# define kSpriteImageName @"monkey.png"

@interface Monkey : NSObject {
    SKSpriteNode *sprite;
    CMMotionManager *motionManager;
}

@property (nonatomic, strong) SKSpriteNode *sprite;
@property (nonatomic, strong) Item *weapon;

-(id)initWithPosition:(CGPoint)position;

-(void)updatePosition;

-(BOOL)checkIsItemIsWeapon:(Item *)item;

@end
