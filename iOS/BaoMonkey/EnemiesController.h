//
//  EnemiesController.h
//  BaoMonkey
//
//  Created by Rémi Hillairet on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Enemy.h"

@interface EnemiesController : NSObject {
    CFTimeInterval timeForAddEnemy;
    NSMutableArray *enemies;
    SKScene *scene;
    NSMutableArray *choppingSlots;
}

@property (nonatomic, strong) NSMutableArray *enemies;

-(id)initWithScene:(SKScene*)_scene;
-(void)initChoppingSlots;
-(void)updateEnemies:(CFTimeInterval)currentTime;
-(void)deleteEnemy:(Enemy*)enemy;

@end
