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
@property (nonatomic, assign) BOOL isOnPlateform;

-(id)initWithDirection:(Direction)_direction;
- (void) actionClimber:(NSInteger)positionclimb;

@end
