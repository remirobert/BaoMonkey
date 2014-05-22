//
//  Tank.m
//  BaoMonkey
//
//  Created by iPPLE on 21/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Tank.h"

@interface Tank ()
@property (nonatomic, assign) CGPoint positionMediumStrat;
@property (nonatomic, assign) BOOL isShoot;
@property (nonatomic, assign) BOOL isMediumStrat;
@property (nonatomic, assign) BOOL isHardStrat;
@end

@implementation Tank

- (void) initSpriteTank {
    _tankSprite = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor]
                                               size:CGSizeMake(80, 40)];
}

- (instancetype) init {
    self = [super init];
    
    if (self != nil) {
        [self initSpriteTank];
        
        _isHardStrat = _isMediumStrat = NO;
        
        _positionMediumStrat = CGPointMake(rand() % (int)([UIScreen mainScreen].bounds.size.width / 2)+ ([UIScreen mainScreen].bounds.size.width / 2), [UIScreen mainScreen].bounds.size.height);
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

- (void) lowStrat:(CGPoint)positionMonkey :(SKScene *)scene {
    SKSpriteNode *nodeShoot = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(15, 15)];
    
    nodeShoot.position = _tankSprite.position;
    nodeShoot.name = NAME_SPRITE_SHOOT_TANK;
    
    SKAction *shoot = [SKAction moveTo:CGPointMake(rand() % 80 + (positionMonkey.x - 40), [UIScreen mainScreen].bounds.size.height) duration:1.5];
    
    SKAction *wait = [SKAction waitForDuration:1.0 withRange:1.0];
    [scene addChild:nodeShoot];
    
    SKAction *sequenceAction = [SKAction sequence:@[wait, shoot]];
    
    [nodeShoot runAction:sequenceAction];
}

- (void) shootFireBomb:(CGPoint)positionMonkey :(SKScene *)scene {
    SKSpriteNode *nodeShoot;
    
    nodeShoot = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(20, 20)];
    
    nodeShoot.name = NAME_SPRITE_FIRE_TANK;
    [scene addChild:nodeShoot];
    
    nodeShoot.position = _tankSprite.position;
    SKAction *moveShoot = [SKAction moveTo:CGPointMake(rand() % (int)([UIScreen mainScreen].bounds.size.width), positionMonkey.y) duration:2.0];
    
    SKAction *fireAction = [SKAction resizeToWidth:rand() % 20 + 40 duration:1.5];
    
    [nodeShoot runAction:moveShoot completion:^{
        [nodeShoot runAction:fireAction];
        _isShoot = YES;
    }];
}

- (void) mediumStrat:(CGPoint)positionMonkey :(SKScene *)scene {

    if (_isMediumStrat == NO) {
        _isMediumStrat = YES;
        _isShoot = NO;
        [self shootFireBomb:positionMonkey :scene];
    };
    if (_isShoot == 1) {
        [self lowStrat:positionMonkey :scene];
    }
}

- (void) hardStrat:(CGPoint)positionMonkey :(SKScene *)scene {

    if (_isHardStrat == NO) {
        _isHardStrat = YES;
        _isShoot = NO;
        
        [scene enumerateChildNodesWithName:NAME_SPRITE_FIRE_TANK usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
        
        [self shootFireBomb:positionMonkey :scene];
    };
    if (_isShoot == YES)
        [self lowStrat:positionMonkey :scene];
}

- (void) shootTank:(CGPoint)positionMonkey scene:(SKScene *)scene {
    
    if (_currentStrat == 0)
        [self lowStrat:positionMonkey :scene];
    else if (_currentStrat == 1)
        [self mediumStrat:positionMonkey :scene];
    else if (_currentStrat == 2)
        [self hardStrat:positionMonkey :scene];
}

@end
