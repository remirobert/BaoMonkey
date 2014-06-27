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

# define kSpeed 10
# define kSpriteImageName @"monkey.png"

@interface Monkey : NSObject

@property (nonatomic, strong) SKSpriteNode *sprite;
@property (nonatomic, strong) SKSpriteNode *shield;
@property (nonatomic, strong) SKSpriteNode *collisionMask;
@property (nonatomic, strong) Item *weapon;
@property (nonatomic, assign) BOOL isShield;

-(id)initWithPosition:(CGPoint)position;
-(void)updateMonkeyPosition:(float)acceleration;
-(void)manageShield:(CFTimeInterval)currentTime andScene:(SKScene *)scene;
-(void)catchItem:(id)item :(SKScene *)scene;
-(void)launchWeapon;
-(void)deadMonkey;

- (void) moveActionWalking;
- (void) waitMonkey;
- (void) addShield:(SKScene *)scene;

@end
