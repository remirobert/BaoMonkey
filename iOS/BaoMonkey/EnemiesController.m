//
//  EnemiesController.m
//  BaoMonkey
//
//  Created by Rémi Hillairet on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "EnemiesController.h"
#import "LamberJack.h"

#define MAX_LUMBERJACK  4

@implementation EnemiesController

@synthesize enemies;

-(id)initWithScene:(SKScene*)_scene {
    self = [super init];
    if (self) {
        enemies = [[NSMutableArray alloc] init];
        scene = _scene;
        timeForAddEnemy = 0;
    }
    return self;
}

-(EnemyDirection)chooseDirection {
    NSUInteger numberLeft = 0;
    NSUInteger numberRight = 0;
    
    for (Enemy *enemy in enemies) {
        if (enemy.direction == LEFT)
            numberLeft++;
        else if (enemy.direction == RIGHT)
            numberRight++;
    }
    if (numberRight < numberLeft)
        return RIGHT;
    return LEFT;
}

-(void)addEnemy {
    LamberJack *newLamberJack;
    
    newLamberJack = [[LamberJack alloc] initWithDirection:[self chooseDirection]];

    [enemies addObject:newLamberJack];
    [scene addChild:newLamberJack.node];
}

-(NSDictionary*)LamberJacksState
{
    NSMutableDictionary *LBState = [[NSMutableDictionary alloc] init];
    
    [LBState setObject:@"0" forKey:@"numberChoppingOnLeft"];
    [LBState setObject:@"0" forKey:@"numberChoppingOnRight"];
    for (Enemy *enemy in enemies) {
        if (enemy.type == EnemyTypeLamberJack) {
            LamberJack *tmp = (LamberJack*)enemy;
            if (tmp.isChooping)
            {
                int number;
                if (tmp.direction == LEFT)
                {
                    number = [[LBState objectForKey:@"numberChoppingOnLeft"] intValue];
                    number++;
                    [LBState setObject:[NSString stringWithFormat:@"%d", number] forKey:@"numberChoppingOnLeft"];
                }
                else if (tmp.direction == RIGHT)
                {
                    number = [[LBState objectForKey:@"numberChoppingOnRight"] intValue];
                    number++;
                    [LBState setObject:[NSString stringWithFormat:@"%d", number] forKey:@"numberChoppingOnRight"];
                }
            }
        }
    }
    return LBState;
}

-(void)updateEnemies:(CFTimeInterval)currentTime {
    NSMutableArray *enemiesDeleted = [[NSMutableArray alloc] init];
    
    if ([enemies count] < MAX_LUMBERJACK && ((timeForAddEnemy <= currentTime) || (timeForAddEnemy == 0))){
        float randomFloat = (1.5 + ((float)arc4random() / (0x100000000 / (3.0 - 1.5))));
        [self addEnemy];
        timeForAddEnemy = currentTime + randomFloat;
    }
    //NSLog(@"Update Enemies");
    for (Enemy *enemy in enemies) {
        [(LamberJack*)enemy updatePosition];
        [self LamberJacksState];
        //NSLog(@"Enemy : x %f y %f", enemy.node.position.x, enemy.node.position.y);
    }
    
    // Delete enemies that reached the middle
    for (Enemy *enemy in enemiesDeleted) {
        [self deleteEnemy:enemy];
    }
}

-(void)deleteEnemy:(Enemy*)enemy {
    [enemy.node removeFromParent];
    [enemies removeObject:enemy];
}

@end
