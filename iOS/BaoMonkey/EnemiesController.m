//
//  EnemiesController.m
//  BaoMonkey
//
//  Created by Rémi Hillairet on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "EnemiesController.h"
#import "LamberJack.h"

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

-(void)addEnemy {
    CGRect screen = [UIScreen mainScreen].bounds;
    CGPoint position;
    LamberJack *newLamberJack;
    
    if ((arc4random() % 2) == 0) {
        newLamberJack = [[LamberJack alloc] initWithDirection:LEFT];
        position.x = screen.size.width + (newLamberJack.node.size.width / 2);
    }
    else {
        newLamberJack = [[LamberJack alloc] initWithDirection:RIGHT];
        position.x = -(newLamberJack.node.size.width / 2);
    }
    position.y = newLamberJack.node.size.height / 2;
    [newLamberJack.node setPosition:position];
    [enemies addObject:newLamberJack];
    [scene addChild:newLamberJack.node];
}

-(void)updateEnemies:(CFTimeInterval)currentTime {
    NSMutableArray *enemiesDeleted = [[NSMutableArray alloc] init];
    
    if ([enemies count] < 4 && ((timeForAddEnemy <= currentTime) || (timeForAddEnemy == 0))){
        float randomFloat = (1.5 + ((float)arc4random() / (0x100000000 / (3.0 - 1.5))));
        [self addEnemy];
        timeForAddEnemy = currentTime + randomFloat;
    }
    //NSLog(@"Update Enemies");
    for (Enemy *enemy in enemies) {
        [enemy updatePosition];
        if ([enemy reachedTheMiddle])
            [enemiesDeleted addObject:enemy];
        //NSLog(@"Enemy : x %f y %f", enemy.node.position.x, enemy.node.position.y);
    }
    
    // Delete enemies that reached the middle
    for (Enemy *enemy in enemiesDeleted) {
        [self deleteEnemy:enemy];
    }
}

-(void)deleteEnemy:(Enemy*)enemy {
    NSLog(@"Delete enemy");
    [enemy.node removeFromParent];
    [enemies removeObject:enemy];
}

@end
