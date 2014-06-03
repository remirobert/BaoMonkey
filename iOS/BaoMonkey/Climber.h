//
//  Climber.h
//  BaoMonkey
//
//  Created by iPPLE on 09/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Enemy.h"

typedef enum : NSUInteger {
    MONKEY = 0,
    COMANDO = 1,
} Kind;

@interface Climber : Enemy

@property (nonatomic, assign) BOOL isClimb;
@property (nonatomic, assign) BOOL isOnPlateform;
@property (nonatomic, assign) BOOL isClimbing;
@property (nonatomic, assign) Kind kind;

-(id)initWithDirection:(Direction)_direction;
- (void) actionClimber:(NSInteger)positionclimb;

+ (void) startDead:(Climber *)climber :(NSMutableArray *)enemiesTab;

@end
