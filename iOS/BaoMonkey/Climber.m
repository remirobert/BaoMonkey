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

-(id)initWithDirection:(Direction)_direction {
    self = [super init];
    
    if (self) {
        CGPoint position;
        self.direction = _direction;
        self.type = EnemyTypeClimber;
        self.node.zPosition = 10;
        node = [SKSpriteNode spriteNodeWithImageNamed:@"gorille-1"];
        node.size = CGSizeMake(node.size.width / 3, node.size.height / 3);
        
        if (self.direction == LEFT)
        {
            position.x = 0;
            _climbPositionX = ([UIScreen mainScreen].bounds.size.width / 2) - 40;
        }
        else
        {
            node.xScale = -1.0;
            position.x = [UIScreen mainScreen].bounds.size.width + (node.size.width / 2);
            _climbPositionX = ([UIScreen mainScreen].bounds.size.width / 2) + 40;
        }
        
        node.name = ENEMY_NODE_NAME;
        position.y = node.size.height / 2;
        [node setPosition:position];
        _isClimb = NO;
        _isOnPlateform = NO;
    }
    return (self);
}

- (void) actionClimber:(NSInteger)positionclimb {
    if (_isClimb == YES)
        return ;
    _isClimb = YES;
    SKAction *moveToTrunk = [SKAction moveToX:_climbPositionX
                                     duration:1.5];
    SKAction *waitClimb = [SKAction waitForDuration:0.25];
    SKAction *climb = [SKAction moveToY:positionclimb
                               duration:5.5];

    SKAction *act = [SKAction sequence:@[waitClimb, moveToTrunk, waitClimb, climb]];
    
    [self.node runAction:act completion:^{
        _isOnPlateform = YES;
        node.name = SHOOT_NODE_NAME;
    }];
}

@end
