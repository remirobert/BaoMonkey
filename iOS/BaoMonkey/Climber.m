//
//  Climber.m
//  BaoMonkey
//
//  Created by iPPLE on 09/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Climber.h"
#import "Define.h"

@interface Climber ()
@property (nonatomic, assign) NSInteger climbPositionX;
@end

@implementation Climber

-(id)initWithDirection:(EnemyDirection)_direction {
    self = [super init];
    
    if (self) {
        CGPoint position;
        self.direction = _direction;
        self.type = EnemyTypeClimber;
        self.node.zPosition = 1;
        
        if (self.direction == LEFT)
        {
            node = [SKSpriteNode spriteNodeWithImageNamed:@"hunter-right"];
            position.x = 0;
            _climbPositionX = ([UIScreen mainScreen].bounds.size.width / 2) - 40;
        }
        else
        {
            node = [SKSpriteNode spriteNodeWithImageNamed:@"hunter-left"];
            position.x = [UIScreen mainScreen].bounds.size.width + (node.size.width / 2);
            _climbPositionX = ([UIScreen mainScreen].bounds.size.width / 2) + 40;
        }
        
        node.name = ENEMY_NODE_NAME;
        position.y = node.size.height / 2;
        [node setPosition:position];
        [self actionClimber];
    }
    
    return (self);
}

- (void) actionClimber {
    SKAction *moveToTrunk = [SKAction moveToX:_climbPositionX
                                     duration:1.5];
    SKAction *waitClimb = [SKAction waitForDuration:0.5];
    SKAction *climb = [SKAction moveToY:[UIScreen mainScreen].bounds.size.height - 180
                               duration:4.0];

    SKAction *act = [SKAction sequence:@[waitClimb, moveToTrunk, waitClimb, climb]];
    
    [self.node runAction:act];
}

-(void)loadWalkingSprites {
    
}

-(void)loadClumbingSprites {
    
}

@end
