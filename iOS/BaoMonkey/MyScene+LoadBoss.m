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
    
    SKTransition *transitionScene = [SKTransition fadeWithDuration:1.0];
    [self.view presentScene:tankScene transition:transitionScene];
}

- (void) loadstepBoss {
    if ([GameData getScore] == 200)
        [self loadTankScene];
}

@end
