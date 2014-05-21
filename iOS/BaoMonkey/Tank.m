//
//  Tank.m
//  BaoMonkey
//
//  Created by iPPLE on 21/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Tank.h"

@implementation Tank

- (void) initSpriteTank {
    _tankSprite = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor]
                                               size:CGSizeMake(80, 40)];
}

- (instancetype) init {
    self = [super init];
    
    if (self != nil) {
        [self initSpriteTank];
    }
    
    return (self);
}

- (void) move {
    if (_sens == RIGHT) {
        if (_tankSprite.position.x + 1 + (_tankSprite.size.width / 2) >=
            [UIScreen mainScreen].bounds.size.width) {
            _sens = LEFT;
            return ;
        }
        _tankSprite.position = CGPointMake(_tankSprite.position.x + 1,
                                               _tankSprite.position.y);
    }
    else {
        if (_tankSprite.position.x - 1 - (_tankSprite.size.width / 2) <= 0) {
            _sens = RIGHT;
            return ;
        }

        self.tankSprite.position = CGPointMake(_tankSprite.position.x - 1,
                                               _tankSprite.position.y);
    }
}

- (void) shootTank:(CGPoint)positionMonkey scene:(SKScene *)scene {
    SKSpriteNode *nodeShoot = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(25, 25)];
    
    nodeShoot.position = _tankSprite.position;
    nodeShoot.name = NAME_SPRITE_SHOOT_TANK;
    [scene addChild:nodeShoot];
    
    SKAction *shoot = [SKAction moveTo:CGPointMake(rand() % 40 + (positionMonkey.x - 20), [UIScreen mainScreen].bounds.size.height) duration:1.5];
    
    SKAction *sequenceShoot = [SKAction sequence:@[shoot]];
    [nodeShoot runAction:sequenceShoot];
}

@end
