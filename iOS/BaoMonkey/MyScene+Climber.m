//
//  MyScene+Climber.m
//  BaoMonkey
//
//  Created by iPPLE on 22/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "MyScene+Climber.h"
#import "Enemy.h"
#import "Climber.h"

@implementation MyScene (Climber)

- (void) actionClimber {
    
    for (Enemy *currrentEnemy in self->enemiesController.enemies) {
        if ([currrentEnemy isKindOfClass:[Climber class]]) {
            if (((Climber *)currrentEnemy).isClimb == NO) {
                [((Climber *)currrentEnemy) actionClimber:self.treeBranch.node.position.y + 20];
            }
        }
    }
}

@end
