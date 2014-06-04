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

#define MIN_NEXT_ENEMY  2.0
#define MAX_NEXT_ENEMY  3.0
#define MAX_FLOOR       4

@interface EnemiesController : NSObject {
    CFTimeInterval timeForAddLamberJack;
    CFTimeInterval timeForAddHunter;
    CFTimeInterval timeForAddClimber;
    NSMutableArray *enemies;
    SKScene *scene;
    NSMutableArray *choppingSlots;
    int numberOfFloors;
    int numberHunter;
    int numberClimber;
    char slotFloor[MAX_FLOOR]; //representation of the floor's slots.
    NSArray *floorsPosition;
}

@property (nonatomic, strong) NSMutableArray *enemies;

-(id)initWithScene:(SKScene*)_scene;
-(void)initChoppingSlots;
-(void)updateEnemies:(CFTimeInterval)currentTime;
-(void)deleteEnemy:(Enemy*)enemy;

@end
