//
//  Enemy.h
//  BaoMonkey
//
//  Created by Rémi Hillairet on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

typedef enum {
    LEFT,
    RIGHT
} EnemyDirection;

typedef enum {
    EnemyTypeLamberJack,
    EnemyTypeHunter
} EnemyType;

@interface Enemy : NSObject {
    SKSpriteNode *node;
    EnemyDirection direction;
    EnemyType type;
}

@property (nonatomic, strong) SKSpriteNode *node;
@property (nonatomic) EnemyDirection direction;
@property (nonatomic) EnemyType type;

-(id)init;
-(void)updatePosition;
-(BOOL)reachedTheMiddle;

@end
