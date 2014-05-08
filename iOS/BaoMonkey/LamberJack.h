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
@property (nonatomic, assign) float slotTaken;

-(id)initWithDirection:(EnemyDirection)direction;
-(void)startChopping;
-(void)updatePosition:(NSArray*)choppingSlots;
-(int)findFreeSlot:(NSArray*)choppingSlots;
-(void)freeTheSlot:(NSArray*)choppingSlots;
-(BOOL)reachedTheMiddle:(NSArray*)choppingSlots;

@end
