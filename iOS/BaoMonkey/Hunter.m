//
//  Hunter.m
//  BaoMonkey
//
//  Created by Rémi Hillairet on 08/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Hunter.h"
#import "Define.h"

@implementation Hunter

-(id)initWithFloor:(NSInteger)nbFloor slot:(NSInteger)slotFloor {
    CGRect screen = [UIScreen mainScreen].bounds;
    CGPoint position;
    
    self = [super init];
    if (self) {
        self.direction = (nbFloor % 2) == 0 ? LEFT : RIGHT;
        self.type = EnemyTypeHunter;
        self.node.zPosition = 1;
        self.floor = nbFloor;
        
        _slot = slotFloor -1;
        
        if (self.direction == LEFT)
        {
            node = [SKSpriteNode spriteNodeWithImageNamed:@"hunter-left"];
            position.x = screen.size.width + (node.size.width / 2);
        }
        else
        {
            node = [SKSpriteNode spriteNodeWithImageNamed:@"hunter-right"];
            position.x = - (node.size.width / 2);
        }
        node.name = ENEMY_NODE_NAME;
        position.y = screen.size.height / 4 + node.size.height / 2;
        [node setPosition:position];
                
        SKAction *actionMove = [SKAction moveToX:(screen.size.width / 2 - 20) / 4 * slotFloor duration:2.0];
        
        [node runAction:actionMove];
        
    }
    return self;
}

@end
