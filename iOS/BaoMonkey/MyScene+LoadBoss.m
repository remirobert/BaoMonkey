//
//  MyScene+LoadBoss.m
//  BaoMonkey
//
//  Created by iPPLE on 26/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "MyScene+LoadBoss.h"
#import "GameData.h"
#import "TankScene.h"

@implementation MyScene (LoadBoss)

- (void) loadTankScene {
    TankScene *tankScene = [[TankScene alloc] initWithSize:self.size parent:self];
    
    [self.view presentScene:tankScene transition:[SKTransition fadeWithDuration:1.0]];
}

- (void) loadstepBoss {
    
    if ([GameData getScore] == STEP_TANK_BOSS) {
        [GameData addPointToScore:10];
        [self loadTankScene];
    }
}

@end
