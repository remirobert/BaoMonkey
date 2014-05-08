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

-(id)initWithFloor:(NSInteger)_floor numberHunter:(NSInteger)nbHunter {
    CGRect screen = [UIScreen mainScreen].bounds;
    CGPoint position;
    
    self = [super init];
    if (self) {
        self.direction = (_floor % 2) == 0 ? LEFT : RIGHT;
        self.type = EnemyTypeHunter;
        self.node.zPosition = 1;
        self.floor = _floor;
        
        if (self.direction == LEFT)
        {
            node = [SKSpriteNode spriteNodeWithImageNamed:@"hunter-left"];
            position.x = screen.size.width + (node.size.width / 2);
        }
        else
        {
            node = [SKSpriteNode spriteNodeWithImageNamed:@"hunter-right"];
            position.x = -(node.size.width / 2);
        }
        node.name = ENEMY_NODE_NAME;
        position.y = screen.size.height / 4 + node.size.height / 2;
        [node setPosition:position];
        
        SKAction *actionMove = [SKAction moveToX:20 * nbHunter duration:2.0];
        
        [node runAction:actionMove];
        
    }
    return self;
}

@end
