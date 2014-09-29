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
#import "PreloadData.h"

@interface LamberJack : Enemy {
    NSArray *walkingFrames;
    NSArray *cuttingFrames;
    NSArray *deadFrames;
}

@property (nonatomic, assign) BOOL isChooping;
@property (nonatomic, assign) float slotTaken;

-(id)initWithDirection:(Direction)direction;
-(void)startChopping;
-(void)stopChopping;
-(void)startDead;

@end
