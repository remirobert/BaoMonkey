//
//  Tank.h
//  BaoMonkey
//
//  Created by iPPLE on 21/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

# define NAME_SPRITE_SHOOT_TANK     @"sprite_name_shoot_tank"
# define NAME_SPRITE_FIRE_TANK      @"sprite_name_fire_tank"

NS_ENUM(int, SENS_TANK){
    LEFT = 0,
    RIGHT = 1
};
@interface Tank : NSObject

@property (nonatomic, strong) SKSpriteNode *tankSprite;
@property (nonatomic, assign) enum SENS_TANK sens;
@property (nonatomic, assign) NSInteger currentStrat;

- (instancetype) init;
- (void) move;
- (void) shootTank:(CGPoint)positionMonkey scene:(SKScene *)scene;

@end