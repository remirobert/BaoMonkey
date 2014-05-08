//
//  LamberJack.h
//  BaoMonkey
//
//  Created by Rémi Hillairet on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Enemy.h"
#import "GameData.h"

@interface LamberJack : Enemy

@property (nonatomic, assign) BOOL isChooping;

-(id)initWithDirection:(EnemyDirection)direction;
-(void)startChopping;
-(void)updatePosition;
-(BOOL)reachedTheMiddle;

@end
