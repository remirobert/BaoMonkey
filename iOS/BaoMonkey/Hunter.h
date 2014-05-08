//
//  Hunter.h
//  BaoMonkey
//
//  Created by Rémi Hillairet on 08/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Enemy.h"

@interface Hunter : Enemy

-(id)initWithDirection:(EnemyDirection)_direction;
-(void)updatePosition;

@end
