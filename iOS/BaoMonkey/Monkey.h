//
//  Character.h
//  iosGame
//
//  Created by Jeremy Peltier on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Item.h"
#import "Weapon.h"
#import "Define.h"
#import "Action.h"

# define kSpeed 10
# define kSpriteImageName @"monkey.png"

@interface Monkey : NSObject {
    SKSpriteNode *sprite;
}

@property (nonatomic, strong) SKSpriteNode *sprite;
@property (nonatomic, strong) Item *weapon;

-(id)initWithPosition:(CGPoint)position;

-(void)updateMonkeyPosition:(float)acceleration;

-(BOOL)checkIsItemIsWeapon:(id)item;

@end
