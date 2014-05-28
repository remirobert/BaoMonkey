//
//  Enemy.h
//  BaoMonkey
//
//  Created by Rémi Hillairet on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Define.h"

#define MAX_LUMBERJACK  2
#define MAX_HUNTER      4

typedef enum {
    EnemyTypeLamberJack,
    EnemyTypeHunter,
    EnemyTypeClimber
} EnemyType;

@interface Enemy : NSObject {
    SKSpriteNode *node;
    Direction direction;
    EnemyType type;
    float speed;
}

@property (nonatomic, strong) SKSpriteNode *node;
@property (nonatomic) Direction direction;
@property (nonatomic) EnemyType type;
@property (nonatomic, assign) int floor;

-(id)init;
-(NSString*)directionKey;

@end
