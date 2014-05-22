//
//  Climber.h
//  BaoMonkey
//
//  Created by iPPLE on 09/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Enemy.h"

@interface Climber : Enemy

@property (nonatomic, assign) BOOL isClimb;

-(id)initWithDirection:(EnemyDirection)_direction;
- (void) actionClimber:(NSInteger)positionclimb;

@end
