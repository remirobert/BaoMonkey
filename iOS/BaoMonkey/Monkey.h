//
//  Character.h
//  iosGame
//
//  Created by Jeremy Peltier on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "GameData.h"
#import "Item.h"
#import "Malus.h"
#import "Bonus.h"
#import "Weapon.h"
#import "Define.h"
#import "Action.h"

# define kSpeed 10
# define kSpriteImageName @"monkey.png"

@interface Monkey : NSObject

@property (nonatomic, strong) SKSpriteNode *sprite;
@property (nonatomic, strong) SKSpriteNode *collisionMask;
@property (nonatomic, strong) Item *weapon;

-(id)initWithPosition:(CGPoint)position;
-(void)updateMonkeyPosition:(float)acceleration;
-(void)catchItem:(id)item;
-(void)launchWeapon;
- (void) deadMonkey;

@end
