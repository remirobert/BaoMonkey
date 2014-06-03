//
//  Tank.h
//  BaoMonkey
//
//  Created by iPPLE on 21/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Define.h"

# define NAME_SPRITE_SHOOT_TANK     @"sprite_name_shoot_tank"
# define NAME_SPRITE_FIRE_TANK      @"sprite_name_fire_tank"

@interface Tank : NSObject

@property (nonatomic, strong) SKSpriteNode *tankSprite;
@property (nonatomic, strong) SKSpriteNode *tower;
@property (nonatomic, strong) SKSpriteNode *canon;
@property (nonatomic, assign) Direction sens;
@property (nonatomic, assign) NSInteger currentStrat;

- (instancetype) init;
- (void) move;
- (void) shootTank:(CGPoint)positionMonkey scene:(SKScene *)scene;

@end