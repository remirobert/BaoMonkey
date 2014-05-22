//
//  TankScene.m
//  BaoMonkey
//
//  Created by iPPLE on 21/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "TankScene.h"
#import "Monkey.h"
#import "GameController.h"
#import "Tank.h"
#import "GameData.h"
#import "LeafTransition.h"

@interface TankScene ()
@property (nonatomic, strong) Monkey *monkey;
@property (nonatomic, strong) Tank *tank;
@property (nonatomic, assign) NSTimeInterval timerStrat;
@property (nonatomic, assign) NSInteger currentStrat;
@property (nonatomic, assign) NSInteger currentShootTime;
@property (nonatomic, strong) SKScene *parentScene;
@property (nonatomic, assign) BOOL isPaused;
@end

@implementation TankScene

- (void) initTank {
    _tank = [[Tank alloc] init];
    
    _tank.sens = rand() % 2;
    if (_tank.sens == LEFT)
        _tank.tankSprite.position = CGPointMake(_tank.tankSprite.size.width / 2,
                                                _tank.tankSprite.size.height / 2);
    else
        _tank.tankSprite.position = CGPointMake([UIScreen mainScreen].bounds.size.width -
                                                (_tank.tankSprite.size.width / 2),
                                                _tank.tankSprite.size.height / 2);
    [self addChild:_tank.tankSprite];
}

- (void) initScene {
    self.backgroundColor = [SKColor colorWithRed:52/255.0f
                                           green:152/255.0f
                                            blue:219/255.0f
                                           alpha:1];
    
    _treeBranch = [[TreeBranch alloc] init];
    
    self.physicsBody = [SKPhysicsBody
                        bodyWithEdgeLoopFromRect:CGRectMake(_treeBranch.node.frame.origin.x,
                                                            _treeBranch.node.frame.origin.y -
                                                            (_treeBranch.node.frame.size.height / 2) +
                                                            (_treeBranch.node.frame.size.height / 2),
                                                            _treeBranch.node.frame.size.width,
                                                            _treeBranch.node.frame.size.height / 2)];
    
    [self addChild:_treeBranch.node];
    
    _monkey = [[Monkey alloc] initWithPosition:CGPointMake(self.frame.size.width/2,
                                                           _treeBranch.node.position.y + 20)];
    [self addChild:_monkey.sprite];
    [GameController initAccelerometer];
}

- (void) pauseGame {
    if (_isPaused == NO) {
        self.speed = 0.0;
        _isPaused = NO;
    }
    else {
        self.speed = 1.0;
        _isPaused = YES;
    }
}

- (instancetype) initWithSize:(CGSize)size parent:(SKScene *)parentScene {
    self = [super initWithSize:size];
    if (self != nil) {
        self.view.frame = CGRectMake(0, 0, size.width, size.height);
        self.backgroundColor = [SKColor redColor];
        _timerStrat = 0;
        _currentStrat = 0;
        _parentScene = parentScene;
        _isPaused = NO;
        [self initScene];
        [self initTank];
    }
    return (self);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if (([GameData isGameOver] && [node.name isEqualToString:RETRY_NODE_NAME]) || [node.name isEqualToString:RETRY_NODE_NAME]) {
        [GameData resetGameData];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RETRY_GAME object:nil];
        return ;
    }
}

- (void) checkCollisionMonkey {
    SKNode *monkeyNode = [self.scene nodeAtPoint:_monkey.sprite.position];
    
    [self enumerateChildNodesWithName:NAME_SPRITE_SHOOT_TANK usingBlock:^(SKNode *node, BOOL *stop) {
        
        if ([node intersectsNode:monkeyNode]) {
            [self pauseGame];
            LeafTransition *transitionGameOver = [[LeafTransition alloc] initWithScene:self];
            [transitionGameOver runGameOverTransition];
            [GameData gameOver];
        }
        if (node.position.y >= [UIScreen mainScreen].bounds.size.height)
            [node removeFromParent];
    }];
    
    [self enumerateChildNodesWithName:NAME_SPRITE_FIRE_TANK usingBlock:^(SKNode *node, BOOL *stop) {
        
        if ([node intersectsNode:monkeyNode]) {
            [self pauseGame];
            LeafTransition *transitionGameOver = [[LeafTransition alloc] initWithScene:self];
            [transitionGameOver runGameOverTransition];
            [GameData gameOver];
        }
    }];
}

- (void) performPositionShoot {
    [self enumerateChildNodesWithName:NAME_SPRITE_SHOOT_TANK usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y == _tank.tankSprite.position.y)
            node.position = CGPointMake(_tank.tankSprite.position.x, node.position.y);
    }];
}

- (void) update:(NSTimeInterval)currentTime {
    
    [self checkCollisionMonkey];
    
    if (_isPaused == NO) {
        [GameController updateAccelerometerAcceleration];
        [_monkey updateMonkeyPosition:[GameController getAcceleration]];
        [_tank move];
    }
    
    if (_timerStrat == 0) {
        _timerStrat = currentTime + 10;
        _currentShootTime = currentTime + 1;
    }
    
    if (currentTime >= _timerStrat) {
        _timerStrat = currentTime + 10;
        _tank.currentStrat += 1;
        _currentStrat += 1;
        _currentShootTime = currentTime + 1;
        if (_currentStrat == 3) {
            [GameData addPointToScore:10];
            [self.view presentScene:_parentScene];
        }
    }
    
    if (currentTime >= _currentShootTime) {
        for (int indexShoot = 0; indexShoot < _currentStrat + 1 ; indexShoot++) {
            [_tank shootTank:_monkey.sprite.position scene:self];
        }
        _currentShootTime = currentTime + 1.0;
    }
    
    [self performPositionShoot];
}

@end
