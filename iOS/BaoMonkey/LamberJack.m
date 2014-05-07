//
//  LamberJack.m
//  BaoMonkey
//
//  Created by Rémi Hillairet on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "LamberJack.h"
#import "Define.h"

@implementation LamberJack

-(id)initWithDirection:(EnemyDirection)_direction {
    self = [super init];
    if (self) {
        self.direction =_direction;
        self.type = EnemyTypeLamberJack;
        
        if (self.direction == LEFT)
            node = [SKSpriteNode spriteNodeWithImageNamed:@"lamberjack-left"];
        else
            node = [SKSpriteNode spriteNodeWithImageNamed:@"lamberjack-right"];
        node.name = ENEMY_NODE_NAME;
    }
    return self;
}

@end
