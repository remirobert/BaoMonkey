//
//  LamberJackMachineScene.m
//  BaoMonkey
//
//  Created by iPPLE on 22/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "LamberJackMachineScene.h"
#import "GameController.h"
#import "TreeBranch.h"
#import "Monkey.h"
#import "LamberJackMachine.h"

#define NAME_NODE_TREEBRANCH    @"name_node_treebranch"

@interface LamberJackMachineScene ()
@property (nonatomic, strong) SKScene *parentScene;
@property (nonatomic, assign) NSTimeInterval timer;
@property (nonatomic, assign) NSTimeInterval timerMove;
@property (nonatomic, assign) NSInteger pushforce;
@property (nonatomic, strong) Monkey *monkey;
@property (nonatomic, strong) SKSpriteNode *treeBranch;
@property (nonatomic, strong) LamberJackMachine *lamber;
@property (nonatomic, assign) NSInteger sens;
@end

@implementation LamberJackMachineScene

- (void) initMonkey {
    _monkey = [[Monkey alloc] initWithPosition:CGPointMake(self.frame.size.width/2,
                                                           _treeBranch.position.y + 20)];

    _monkey.sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_monkey.sprite.size];
    _monkey.sprite.physicsBody.affectedByGravity = YES;
    _monkey.sprite.physicsBody.mass = 50;
    [self addChild:_monkey.sprite];
}

- (void) initScene {
    self.backgroundColor = [SKColor colorWithRed:52/255.0f
                                           green:152/255.0f
                                            blue:219/255.0f
                                           alpha:1];
    
    _treeBranch = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width / 2 + 60, 35)];
    
    _treeBranch.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2,
                                       [UIScreen mainScreen].bounds.size.height - 180);
    
    _treeBranch.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_treeBranch.size];
    _treeBranch.physicsBody.mass = 1000000;
    _treeBranch.physicsBody.affectedByGravity = NO;
    _treeBranch.physicsBody.dynamic = NO;
    _treeBranch.physicsBody.allowsRotation = NO;
    
    _treeBranch.name = NAME_NODE_TREEBRANCH;
    
    self.physicsBody = [SKPhysicsBody
                        bodyWithEdgeLoopFromRect:CGRectMake(0, 0,
                                                            [UIScreen mainScreen].bounds.size.width - _monkey.sprite.size.width,
                                                            [UIScreen mainScreen].bounds.size.height)];
    [GameController initAccelerometer];
    [self addChild:_treeBranch];
}

- (instancetype) initWithSize:(CGSize)size parent:(SKScene *)parentScene {
    self = [super initWithSize:size];
    if (self != nil) {
        self.view.frame = CGRectMake(0, 0, size.width, size.height);

        [self initScene];
        [self initMonkey];
        
        _lamber = [[LamberJackMachine alloc] init];
        [self addChild:_lamber.node];

        self.physicsWorld.gravity = CGVectorMake(0, -10);

        _pushforce = 3;
        _sens = 0;
        _timer = 0;
        _parentScene = parentScene;
    }
    return (self);
}

- (void) moveVariationTree {
    [_treeBranch runAction:[SKAction moveTo:CGPointMake(_treeBranch.position.x,
                                                        _treeBranch.position.y + 10) duration:0.15] completion:^{
        _treeBranch.position = CGPointMake(_treeBranch.position.x, _treeBranch.position.y + 10);
        [_treeBranch runAction:[SKAction moveTo:CGPointMake(_treeBranch.position.x,
                                                            _treeBranch.position.y + 10) duration:0.15] completion:^{
            _treeBranch.position = CGPointMake(_treeBranch.position.x, _treeBranch.position.y - 10);
            [_treeBranch runAction:[SKAction moveTo:CGPointMake(_treeBranch.position.x,
                                                                _treeBranch.position.y + 10) duration:0.15] completion:^{
                _treeBranch.position = CGPointMake(_treeBranch.position.x, _treeBranch.position.y + 10);
                [_treeBranch runAction:[SKAction moveTo:CGPointMake(_treeBranch.position.x,
                                                                    _treeBranch.position.y + 10) duration:0.15] completion:^{
                    _treeBranch.position = CGPointMake(_treeBranch.position.x, _treeBranch.position.y - 10);
                }];
            }];
        }];
    }];
}

- (void) stressTree:(NSTimeInterval)currentTime {
    static NSTimeInterval time = 0;
    NSInteger pushStress = 20;
    CGFloat timerStress = 0.15;
    
    if (time == 0) {
        time = currentTime + rand() % 5 + 2;
        return ;
    }
    if (currentTime >= time) {
        
//        [self moveVariationTree];
        [_treeBranch runAction:[SKAction moveTo:CGPointMake(_treeBranch.position.x - (rand() % 10 + pushStress),
                                                            _treeBranch.position.y) duration:timerStress] completion:^{
            [_treeBranch runAction:[SKAction moveTo:CGPointMake(_treeBranch.position.x,
                                                                _treeBranch.position.y + 10) duration:0.05] completion:^{
                [_treeBranch runAction:[SKAction moveTo:CGPointMake(_treeBranch.position.x + (rand() % 10 + pushStress),
                                                                    _treeBranch.position.y) duration:timerStress] completion:^{
                    [_treeBranch runAction:[SKAction moveTo:CGPointMake(_treeBranch.position.x,
                                                                        _treeBranch.position.y - 10) duration:timerStress] completion:^{
                        [_treeBranch runAction:[SKAction moveTo:CGPointMake(_treeBranch.position.x - (rand() % 10 + pushStress),
                                                                            _treeBranch.position.y) duration:0.05] completion:^{
                            [_treeBranch runAction:[SKAction moveTo:CGPointMake(_treeBranch.position.x,
                                                                                _treeBranch.position.y + 10) duration:0.05] completion:^{
                                [_treeBranch runAction:[SKAction moveTo:CGPointMake(_treeBranch.position.x + (rand() % 10 + pushStress),
                                                                                    _treeBranch.position.y) duration:timerStress] completion:^{
                                    [_treeBranch runAction:[SKAction moveTo:CGPointMake(_treeBranch.position.x,
                                                                                        _treeBranch.position.y - 10) duration:0.05] completion:^{
                                    }];
                                }];
                            }];
                        }];
                    }];
                }];
            }];
        }];
        
        time = currentTime + rand() % 5 + 2;

    }
}

- (void) moveTreeBranch {
    if (_sens == 1) {
        if (_treeBranch.position.x < [UIScreen mainScreen].bounds.size.width)
            _treeBranch.position = CGPointMake(_treeBranch.position.x + _pushforce,
                                               _treeBranch.position.y);
        else
            _sens = 0;
    }
    else if (_sens == 0) {
        if (_treeBranch.position.x > 0)
            _treeBranch.position = CGPointMake(_treeBranch.position.x - _pushforce,
                                               _treeBranch.position.y);
        else
            _sens = 1;
    }
}

- (void) update:(NSTimeInterval)currentTime {
    if (_timer == 0) {
        _timer = currentTime + 30;
        _timerMove = currentTime + 5;
    }

    if (currentTime >= _timer) {
        [GameData addPointToScore:10];
        [self.view presentScene:_parentScene];
    }
    
    if (currentTime >= _timerMove) {
        _timerMove = currentTime + 5;
        _pushforce += 1;
    }
    
    [GameController updateAccelerometerAcceleration];
    [_monkey updateMonkeyPosition:[GameController getAcceleration]];

    [self moveTreeBranch];
    [self stressTree:currentTime];
}

@end
