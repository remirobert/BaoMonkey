//
//  Tank.m
//  BaoMonkey
//
//  Created by iPPLE on 21/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Tank.h"

#define SK_DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) * 0.01745329252f)

@interface Tank ()
@property (nonatomic, assign) CGPoint positionMediumStrat;
@property (nonatomic, assign) BOOL isShoot;
@property (nonatomic, assign) BOOL isMediumStrat;
@property (nonatomic, assign) BOOL isHardStrat;
@end

@implementation Tank

- (void) initSpriteTank {
    _tankSprite = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"chassis"]]];
    _tankSprite.size = CGSizeMake(_tankSprite.size.width / 9, _tankSprite.size.height / 9);
    
    _tower = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"tourelle"]]];
    
    _tower.size = CGSizeMake(_tower.size.width / 9, _tower.size.height / 9);
    _tower.zPosition = 45;

    _canon = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"canon"]]];
    _canon.position = CGPointMake(_tankSprite.position.x, _tankSprite.position.y + _tankSprite.size.height / 2 - 5);
    _canon.size = CGSizeMake(_canon.size.width / 9, _canon.size.height / 9);
    _canon.zPosition = 20;
        
    
    _tankSprite.zPosition = 50;
}

- (instancetype) init {
    self = [super init];
    
    if (self != nil) {
        [self initSpriteTank];
        
        _isHardStrat = _isMediumStrat = NO;
        
        _positionMediumStrat = CGPointMake(rand() % (int)([UIScreen mainScreen].bounds.size.width / 2) +
                                           ([UIScreen mainScreen].bounds.size.width / 2),
                                           [UIScreen mainScreen].bounds.size.height);
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
        _tower.xScale = 1.0;
        _tankSprite.position = CGPointMake(_tankSprite.position.x + 1,
                                               _tankSprite.position.y);
    }
    else {
        if (_tankSprite.position.x - 1 - (_tankSprite.size.width / 2) <= 0) {
            _sens = RIGHT;
            return ;
        }
        _tower.xScale = -1.0;
        self.tankSprite.position = CGPointMake(_tankSprite.position.x - 1,
                                               _tankSprite.position.y);
    }
    _tower.position = CGPointMake(_tankSprite.position.x - 20, _tankSprite.position.y + 40);
    _canon.position = CGPointMake(_tankSprite.position.x, _tankSprite.position.y + _tankSprite.size.height / 2 + 10);
}

- (void) lowStrat:(CGPoint)positionMonkey :(SKScene *)scene {
    //SKSpriteNode *nodeShoot = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:CGSizeMake(15, 15)];
    SKSpriteNode *nodeShoot = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"munition-explosive"]];
    nodeShoot.size = CGSizeMake(nodeShoot.size.width / 2, nodeShoot.size.height / 2);
    
    float angle = atan2f(positionMonkey.y, positionMonkey.x);
    nodeShoot.zRotation = angle;
    
    nodeShoot.position = _tankSprite.position;
    nodeShoot.name = NAME_SPRITE_SHOOT_TANK;
    
    SKAction *shoot = [SKAction moveTo:CGPointMake(rand() % 80 + (positionMonkey.x - 40),
                                                   [UIScreen mainScreen].bounds.size.height) duration:1.5];
    
    SKAction *wait = [SKAction waitForDuration:1.0 withRange:1.0];
    [scene addChild:nodeShoot];
    
    [nodeShoot runAction:wait completion:^{
        float angle = atan2f(positionMonkey.y, positionMonkey.x);
        _canon.zRotation = angle;
        [nodeShoot runAction:shoot];
    }];
}

- (void) shootFireBomb:(CGPoint)positionMonkey :(SKScene *)scene {
    SKSpriteNode *nodeShoot;
    
    nodeShoot = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"munitions-incendiaire"]];
    nodeShoot.size = CGSizeMake(nodeShoot.size.width / 3, nodeShoot.size.height / 3);
    
    float angle = atan2f(positionMonkey.y, positionMonkey.x);
    nodeShoot.zRotation = angle;
    
    nodeShoot.name = NAME_SPRITE_FIRE_TANK;
    [scene addChild:nodeShoot];
    
    nodeShoot.position = _tankSprite.position;
    SKAction *moveShoot = [SKAction moveTo:CGPointMake(rand() % (int)([UIScreen mainScreen].bounds.size.width),
                                                       positionMonkey.y) duration:2.0];
    
    SKAction *fireAction = [SKAction resizeToWidth:rand() % 20 duration:1.5];
    
    [nodeShoot runAction:moveShoot completion:^{
        
        nodeShoot.color = [SKColor colorWithRed:0 green:0 blue:0 alpha:0];
        
        [nodeShoot runAction:fireAction];
        NSString *burstPath =
        [[NSBundle mainBundle] pathForResource:@"fire" ofType:@"sks"];
        
        SKEmitterNode *fire = [NSKeyedUnarchiver unarchiveObjectWithFile:burstPath];
        fire.position = CGPointMake(nodeShoot.position.x, nodeShoot.position.y - 30);
        fire.name = NAME_SPRITE_FIRE_TANK;
        fire.zPosition = 1;
        [scene addChild:fire];

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
