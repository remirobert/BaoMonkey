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
#import "GameOverScene.h"
#import "UserData.h"
#import "GameCenter.h"
#import "MyScene.h"

@interface TankScene ()
@property (nonatomic, strong) Monkey *monkey;
@property (nonatomic, strong) Tank *tank;
@property (nonatomic, assign) NSTimeInterval timerStrat;
@property (nonatomic, assign) NSInteger currentStrat;
@property (nonatomic, assign) NSInteger currentShootTime;
@property (nonatomic, strong) SKScene *parentScene;
@property (nonatomic, assign) BOOL isPaused;
@property (nonatomic, strong) SKEmitterNode *smoke;
@end

@implementation TankScene

- (void) initSmoke {
    NSString *burstPath =
    [[NSBundle mainBundle] pathForResource:@"smokeTank" ofType:@"sks"];
    
    _smoke = [NSKeyedUnarchiver unarchiveObjectWithFile:burstPath];
    
    _smoke.zPosition = 50;
    [self addChild:_smoke];
}

- (void) initTank {
    _tank = [[Tank alloc] init];
    
    _tank.sens = rand() % 2;
    if (_tank.sens == LEFT)
        _tank.tankSprite.position = CGPointMake(_tank.tankSprite.size.width / 2,
                                                _tank.tankSprite.size.height / 2 + 22);
    else
        _tank.tankSprite.position = CGPointMake([UIScreen mainScreen].bounds.size.width -
                                                (_tank.tankSprite.size.width / 2),
                                                _tank.tankSprite.size.height / 2 + 22);
    [self initSmoke];
    [self addChild:_tank.tankSprite];
    [self addChild:_tank.tower];
    [self addChild:_tank.canon];
    [self addChild:_tank.wheel];
}

- (void) initTrunk {
    SKSpriteNode *trunk = [SKSpriteNode spriteNodeWithImageNamed:@"trunk-step-1"];
    trunk.position = [BaoPosition trunk];
    trunk.name = TRUNK_NODE_NAME;
    
    NSInteger trunkLife = [GameData getTrunkLife];
    static NSInteger step = 0;
    
    if ((trunkLife > 90 && trunkLife <= 100) && step != 0) {
        [trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-0"]];
        step = 0;
    } else if ((trunkLife > 80 && trunkLife <= 90) && step != 1) {
        [trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-1"]];
        step = 1;
    } else if ((trunkLife > 70 && trunkLife <= 80) && step != 2) {
        [trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-2"]];
        step = 2;
    } else if ((trunkLife > 60 && trunkLife <= 70) && step != 3) {
        [trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-3"]];
        step = 3;
    } else if ((trunkLife > 50 && trunkLife <= 60) && step != 4){
        [trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-4"]];
        step = 4;
    } else if ((trunkLife > 40 && trunkLife <= 50) && step != 5) {
        [trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-5"]];
        step = 5;
    } else if ((trunkLife > 30 && trunkLife <= 40) && step != 6) {
        [trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-6"]];
        step = 6;
    } else if ((trunkLife > 20 && trunkLife <= 30) && step != 7) {
        [trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-7"]];
        step = 7;
    } else if ((trunkLife > 10 && trunkLife <= 20) && step != 8) {
        [trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-8"]];
        step = 8;
    } else if ((trunkLife > 0 && trunkLife <= 10) && step != 9){
        [trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-9"]];
        step = 9;
    }
    [self addChild:trunk];
}

- (void) initScene {

    SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"background-center"];
    bg.position = CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT / 2));
    [self addChild:bg];
    
    
    SKSpriteNode *frontLeaf = [SKSpriteNode spriteNodeWithImageNamed:@"leafs"];
    frontLeaf.position = CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT - (frontLeaf.size.height / 2)));
    frontLeaf.zPosition = 50;
    [self addChild:frontLeaf];
    
    SKSpriteNode *backLeaf = [SKSpriteNode spriteNodeWithImageNamed:@"back-leafs"];
    backLeaf.position = [BaoPosition backLeafs:backLeaf.size];
    backLeaf.name = BACK_LEAF_NODE_NAME;
    [self addChild:backLeaf];
    
    
    TreeBranch *treeBranch = [[TreeBranch alloc] init];
    
    self.physicsBody = [SKPhysicsBody
                        bodyWithEdgeLoopFromRect:CGRectMake(treeBranch.node.frame.origin.x,
                                                            treeBranch.node.frame.origin.y -
                                                            (treeBranch.node.frame.size.height / 2) +
                                                            (treeBranch.node.frame.size.height / 2),
                                                            treeBranch.node.frame.size.width,
                                                            treeBranch.node.frame.size.height / 2)];
    
    [self addChild:treeBranch.node];
    
    
    _monkey = [[Monkey alloc] initWithPosition:[BaoPosition monkey]];
    [self addChild:_monkey.sprite];
    [self addChild:_monkey.collisionMask];
    [GameController initAccelerometer];
    [self initTrunk];
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
        _timerStrat = 0;
        _currentStrat = 0;
        _parentScene = parentScene;
        _isPaused = NO;
        [self initScene];
        [self initTank];
        [_monkey.sprite removeAllActions];
        [UserData defaultUser].boss = NO;
        [((MyScene *)parentScene) resumeGame];
    }
    return (self);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if (([GameData isGameOver] && [node.name isEqualToString:RETRY_NODE_NAME]) ||
        [node.name isEqualToString:RETRY_NODE_NAME]) {
        [GameData resetGameData];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RETRY_GAME object:nil];
        return ;
    }
}

- (void) gameOverCountDown {
    static BOOL gameOver = NO;
    
    if (gameOver) {
        gameOver = NO;
        [GameData pauseGame];
        GameOverScene *gameOverScene = [[GameOverScene alloc] initWithSize:self.size andScene:self];
        [self.view presentScene:gameOverScene transition:[SKTransition pushWithDirection:SKTransitionDirectionLeft duration:0.5]];
    }
    else {
        [GameData gameOver];
        gameOver = YES;
        [self performSelector:@selector(gameOverCountDown) withObject:nil afterDelay:2.0];
    }
}

- (void) checkCollisionMonkey {
    [self enumerateChildNodesWithName:NAME_SPRITE_SHOOT_TANK usingBlock:^(SKNode *node, BOOL *stop) {
        
        if ([node intersectsNode:_monkey.collisionMask]) {

            [GameCenter getBestScorePlayer];
            [_monkey deadMonkey];
            if (![GameData isGameOver])
                [self gameOverCountDown];
        }
        if (node.position.y >= [UIScreen mainScreen].bounds.size.height)
            [node removeFromParent];
    }];
    
    [self enumerateChildNodesWithName:NAME_SPRITE_FIRE_TANK usingBlock:^(SKNode *node, BOOL *stop) {
        
        if ([node intersectsNode:_monkey.collisionMask]) {
            if ([node intersectsNode:_monkey.collisionMask]) {
                
                [GameCenter getBestScorePlayer];
                [_monkey deadMonkey];
                if (![GameData isGameOver])
                    [self gameOverCountDown];
            }
            if (node.position.y >= [UIScreen mainScreen].bounds.size.height)
                [node removeFromParent];
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
    
    _smoke.position = CGPointMake(_tank.tankSprite.position.x - _tank.tankSprite.size.width / 2,
                                  _tank.tankSprite.position.y + _tank.tankSprite.size.height / 2);
        
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
            [((MyScene *)_parentScene).timerLoop restartTimer];
            [self.view presentScene:_parentScene transition:[SKTransition fadeWithDuration:2.0]];
        }
    }
    
    if (currentTime >= _currentShootTime) {
        for (int indexShoot = 0; indexShoot < _currentStrat + 2 ; indexShoot++) {
            [_tank shootTank:_monkey.sprite.position scene:self];
        }
        _currentShootTime = currentTime + 1.0;
    }
    [self performPositionShoot];
}

@end
