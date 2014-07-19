//
//  MyScene+LoadBoss.m
//  BaoMonkey
//
//  Created by iPPLE on 26/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "MyScene+LoadBoss.h"
#import "TankScene.h"
#import "LamberJackMachineScene.h"

@implementation MyScene (LoadBoss)

- (void) loadTankScene {
    TankScene *tankScene = [[TankScene alloc] initWithSize:self.size parent:self];

    [self.timerLoop freezeTimer];
    [self cleanEnemiesScene];
    [self.view presentScene:tankScene transition:[SKTransition fadeWithDuration:2.0]];
}

- (void) loadLamberJackGeantMachineScene {
    LamberJackMachineScene *lamberJack = [[LamberJackMachineScene alloc] initWithSize:self.size parent:self];
    
    [self cleanEnemiesScene];
    [self.view presentScene:lamberJack transition:[SKTransition fadeWithDuration:2.0]];
}

- (void) cleanEnemiesScene {

    [self enumerateChildNodesWithName:ENEMY_NODE_NAME usingBlock:^(SKNode *node, BOOL *stop) {
        [node removeFromParent];
    }];
    
    [self->enemiesController.enemies removeAllObjects];
    
    [self enumerateChildNodesWithName:WEAPON_NODE_NAME usingBlock:^(SKNode *node, BOOL *stop) {
        [node removeFromParent];
    }];
}


@end
