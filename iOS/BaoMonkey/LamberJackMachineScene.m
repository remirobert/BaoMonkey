//
//  LamberJackMachineScene.m
//  BaoMonkey
//
//  Created by iPPLE on 22/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "LamberJackMachineScene.h"
#import "GameController.h"
#import "TreeBranch.h"
#import "Monkey.h"
#import "LamberJackMachine.h"
#import "CocoNuts.h"
#import "Define.h"
#import "LeafTransition.h"
#import "GameData.h"

#define NAME_NODE_TREEBRANCH    @"name_node_treebranch"

@interface LamberJackMachineScene ()
@property (nonatomic, strong) SKScene *parentScene;
@property (nonatomic, assign) NSTimeInterval timer;
@property (nonatomic, assign) NSTimeInterval timerMove;
@property (nonatomic, assign) CGFloat pushforce;
@property (nonatomic, strong) Monkey *monkey;
@property (nonatomic, strong) SKSpriteNode *treeBranch;
@property (nonatomic, strong) LamberJackMachine *lamber;
@property (nonatomic, assign) NSInteger sens;
@property (nonatomic, assign) BOOL lanchMove;
@end

@implementation LamberJackMachineScene

- (void) initMonkey {
    _monkey = [[Monkey alloc] initWithPosition:CGPointMake(self.frame.size.width/2,
                                                           _treeBranch.position.y + 20)];

    _monkey.sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_monkey.sprite.size];
    _monkey.sprite.physicsBody.affectedByGravity = YES;
    _monkey.sprite.physicsBody.mass = 50;
    _monkey.sprite.name = @"monkey_node_name";
    
    [self addChild:_monkey.sprite];
}

- (void) initScene {
    self.backgroundColor = [SKColor colorWithRed:52/255.0f
                                           green:152/255.0f
                                            blue:219/255.0f
                                           alpha:1];
    
    _treeBranch = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor]
                                                 size:CGSizeMake([UIScreen mainScreen].bounds.size.width / 2 + 60, 35)];
    
    _treeBranch.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2,
                                       [UIScreen mainScreen].bounds.size.height - 180);
    
    _treeBranch.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_treeBranch.size];
    _treeBranch.physicsBody.mass = 100;
    _treeBranch.physicsBody.resting = YES;
    _treeBranch.physicsBody.affectedByGravity = NO;
    _treeBranch.physicsBody.dynamic = NO;
    _treeBranch.physicsBody.allowsRotation = NO;
    
    _treeBranch.name = NAME_NODE_TREEBRANCH;
    
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

        _lanchMove = NO;
        _pushforce = 2;
        _sens = rand() % 2;
        _timer = 0;
        _parentScene = parentScene;
        [self updateAngleTree];
    }
    return (self);
}

- (void) popCocoNuts {
    NSInteger nbCocoNuts = rand() % 2 + 2;
    
    for (int index = 0; index <= nbCocoNuts; index ++) {
        CocoNuts *coco = [[CocoNuts alloc]
                          initWithPosition:CGPointMake((rand() %
                                                        (int)(_treeBranch.size.width)) +
                                                       (_treeBranch.position.x - (_treeBranch.size.width / 2)),
                                                       [UIScreen mainScreen].bounds.size.height + 35)];
        coco.node.name = @"invalid_coco";
        coco.node.physicsBody.mass = 20.0;
        [coco.timerHide invalidate];
        [self addChild:coco.node];
        SKPhysicsBody *tmpBody = coco.node.physicsBody;
        coco.node.physicsBody = nil;
        [coco.node runAction:[SKAction waitForDuration:(float)arc4random() / 0x100000000] completion:^{
            coco.node.physicsBody = tmpBody;
        }];
    }
}

- (void) stressTree:(NSTimeInterval)currentTime {
    static NSTimeInterval time = 0;
    NSInteger pushStress = 20;
    CGFloat timerStress = 0.05;
    
    if (time == 0) {
        time = currentTime + rand() % 5 + 2;
        return ;
    }
    if (currentTime >= time) {
        [self performSelector:@selector(popCocoNuts)];

        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
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

- (void) updateAngleTree {
    if (_sens == 0 && _treeBranch.position.x > [UIScreen mainScreen].bounds.size.width / 2) {
        [_treeBranch runAction:[SKAction rotateToAngle:0.2 duration:0.5]];
    }
    else if (_sens == 1 && _treeBranch.position.x < [UIScreen mainScreen].bounds.size.width / 2){
        [_treeBranch runAction:[SKAction rotateToAngle:-0.2 duration:0.5]];
    }
}

- (void) moveTreeBranch {
    
    if (_sens == 1) {
        if (_treeBranch.position.x < [UIScreen mainScreen].bounds.size.width)
            _treeBranch.position = CGPointMake(_treeBranch.position.x + _pushforce,
                                               _treeBranch.position.y);
        else {
            _sens = 0;
        }
    }
    else if (_sens == 0) {
        if (_treeBranch.position.x > 0)
            _treeBranch.position = CGPointMake(_treeBranch.position.x - _pushforce,
                                               _treeBranch.position.y);
        else {
            _sens = 1;
        }
    }
    [self updateAngleTree];
}

- (void) toreBranch:(NSTimeInterval)currentTime {
    static NSTimeInterval time = 0;
    
    if (time == 0) {
        time = currentTime + rand() % 3 + 2;
    }
    
    if (currentTime < time)
        return ;

    time = currentTime + rand() % 5 + 3;

    CGFloat angleStress = 1.0;
    
    if (_sens == 0)
        angleStress = -1.0;

    [_treeBranch runAction:[SKAction rotateByAngle: angleStress duration:0.1] completion:^{
        [_treeBranch runAction:[SKAction rotateByAngle: angleStress * -1 duration:0.1] completion:^{
            [_treeBranch runAction:[SKAction rotateByAngle: angleStress duration:0.1] completion:^{
                [_treeBranch runAction:[SKAction rotateByAngle: angleStress * -1 duration:0.1] completion:^{
                    
                    [self updateAngleTree];
                }];
            }];
        }];
    }];
}

- (void) update:(NSTimeInterval)currentTime {
    
    if (_timer == 0) {
        _timer = currentTime + 30;
        _timerMove = currentTime + 5;
        _lanchMove = YES;
    }

    if (currentTime >= _timer) {
        [GameData addPointToScore:10];
        [self.view presentScene:_parentScene];
    }
    
    if (currentTime >= _timerMove) {
        _timerMove = currentTime + 5;
        _pushforce += 0.75;
    }
    
    [GameController updateAccelerometerAcceleration];
    [_monkey updateMonkeyPosition:[GameController getAcceleration]];

    if (_lanchMove == YES) {
        [self moveTreeBranch];
        [self stressTree:currentTime];
        [self toreBranch:currentTime];
    }
    
    [self enumerateChildNodesWithName:@"invalid_coco" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0)
            [node removeFromParent];
    }];
    
    [self enumerateChildNodesWithName:@"monkey_node_name" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < [UIScreen mainScreen].bounds.size.height / 2) {
            LeafTransition *transitionGameOver = [[LeafTransition alloc] initWithScene:self];
            [transitionGameOver runGameOverTransition];
            [GameData gameOver];
        }
    }];
}

@end
