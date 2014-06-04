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
#import "Shield.h"

# define kSpeed 10
# define kSpriteImageName @"monkey.png"

@interface Monkey : NSObject

@property (nonatomic, strong) SKSpriteNode *sprite;
@property (nonatomic, strong) SKSpriteNode *collisionMask;
@property (nonatomic, strong) Item *weapon;
@property (nonatomic, assign) BOOL isShield;

-(id)initWithPosition:(CGPoint)position;
-(void)updateMonkeyPosition:(float)acceleration;
-(void
  )manageShield:(CFTimeInterval)currentTime;
-(void)catchItem:(id)item;
-(void)launchWeapon;
-(void)deadMonkey;

@end
