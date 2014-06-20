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
#import "GameOverScene.h"
#import "GameData.h"

#define NAME_NODE_TREEBRANCH    @"name_node_treebranch"

@interface LamberJackMachineScene ()
@property (nonatomic, strong) SKScene *parentScene;
@property (nonatomic, assign) NSTimeInterval timer;
@property (nonatomic, assign) NSTimeInterval timerMove;
@property (nonatomic, assign) CGFloat pushforce;
@property (nonatomic, strong) Monkey *monkey;
@property (nonatomic, strong) TreeBranch *treeBranch;
@property (nonatomic, strong) LamberJackMachine *lamber;
@property (nonatomic, assign) NSInteger sens;
@property (nonatomic, assign) BOOL lanchMove;
@property (nonatomic, strong) SKSpriteNode *bg;
@property (nonatomic, strong) SKSpriteNode *trunk;
@property (nonatomic, strong) SKSpriteNode *backLeaf;
@property (nonatomic, strong) SKSpriteNode *frontLeaf;
@property (nonatomic, strong) SKSpriteNode *mecanicArm;
@property (nonatomic, strong) SKSpriteNode *mecanicHand;

@property (nonatomic, assign) CGPoint positionMecanicArm;
@property (nonatomic, assign) CGPoint positionLamber;
@property (nonatomic, assign) CGPoint positionMecanicHand;
@end

@implementation LamberJackMachineScene

- (void) initTrunk {
    _trunk = [SKSpriteNode spriteNodeWithImageNamed:@"trunk-step-1"];
    _trunk.position = [BaoPosition trunk];
    _trunk.name = TRUNK_NODE_NAME;
    
    NSInteger trunkLife = [GameData getTrunkLife];
    static NSInteger step = 0;
    
    if ((trunkLife > 90 && trunkLife <= 100) && step != 0) {
        [_trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-0"]];
        step = 0;
    } else if ((trunkLife > 80 && trunkLife <= 90) && step != 1) {
        [_trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-1"]];
        step = 1;
    } else if ((trunkLife > 70 && trunkLife <= 80) && step != 2) {
        [_trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-2"]];
        step = 2;
    } else if ((trunkLife > 60 && trunkLife <= 70) && step != 3) {
        [_trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-3"]];
        step = 3;
    } else if ((trunkLife > 50 && trunkLife <= 60) && step != 4){
        [_trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-4"]];
        step = 4;
    } else if ((trunkLife > 40 && trunkLife <= 50) && step != 5) {
        [_trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-5"]];
        step = 5;
    } else if ((trunkLife > 30 && trunkLife <= 40) && step != 6) {
        [_trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-6"]];
        step = 6;
    } else if ((trunkLife > 20 && trunkLife <= 30) && step != 7) {
        [_trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-7"]];
        step = 7;
    } else if ((trunkLife > 10 && trunkLife <= 20) && step != 8) {
        [_trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-8"]];
        step = 8;
    } else if ((trunkLife > 0 && trunkLife <= 10) && step != 9){
        [_trunk setTexture:[SKTexture textureWithImageNamed:@"trunk-step-9"]];
        step = 9;
    }
    [self addChild:_trunk];
}

- (void) initSmokeLamberJack {
    NSString *burstPath =
    [[NSBundle mainBundle] pathForResource:@"smokeLamberJack" ofType:@"sks"];
    
    SKEmitterNode *smoke = [NSKeyedUnarchiver unarchiveObjectWithFile:burstPath];
    
    smoke.zPosition = 50;
    smoke.position = CGPointMake(_lamber.node.position.x - _lamber.node.size.width / 2,
                                 _lamber.node.position.y);
    [self addChild:smoke];
}

- (void) initMonkeyPhysic {
    CGFloat offsetX = _monkey.sprite.frame.size.width * _monkey.sprite.anchorPoint.x;
    CGFloat offsetY = _monkey.sprite.frame.size.height * _monkey.sprite.anchorPoint.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 48 - offsetX, 46 - offsetY);
    CGPathAddLineToPoint(path, NULL, 17 - offsetX, 45 - offsetY);
    CGPathAddLineToPoint(path, NULL, 9 - offsetX, 28 - offsetY);
    CGPathAddLineToPoint(path, NULL, 13 - offsetX, 6 - offsetY);
    CGPathAddLineToPoint(path, NULL, 13 - offsetX, 6 - offsetY);
    CGPathAddLineToPoint(path, NULL, 22 - offsetX, 1 - offsetY);
    CGPathAddLineToPoint(path, NULL, 46 - offsetX, 2 - offsetY);
    CGPathAddLineToPoint(path, NULL, 55 - offsetX, 17 - offsetY);
    
    CGPathCloseSubpath(path);
    
    _monkey.sprite.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
}

- (void) initMonkey {
    _monkey = [[Monkey alloc] initWithPosition:CGPointMake(self.frame.size.width/2,
                                                           [UIScreen mainScreen].bounds.size.height)];

    [self initMonkeyPhysic];
    
    _monkey.sprite.physicsBody.affectedByGravity = YES;
    _monkey.sprite.physicsBody.mass = 10;
    _monkey.sprite.physicsBody.allowsRotation = NO;
    _monkey.sprite.physicsBody.usesPreciseCollisionDetection = YES;
    _monkey.sprite.name = @"monkey_node_name";
    [self addChild:_monkey.sprite];
}

- (void) initScene {
    _bg = [SKSpriteNode spriteNodeWithImageNamed:@"background-center"];
    _bg.position = CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT / 2));
    [self addChild:_bg];

    
    _backLeaf = [SKSpriteNode spriteNodeWithImageNamed:@"back-leaf-boss"];
//    _backLeaf.size = CGSizeMake(_frontLeaf.size.width - 100, _frontLeaf.size.height - 100);
//    _backLeaf.position = [BaoPosition backLeafs:_backLeaf.size];
    _backLeaf.position = CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT) - 100);
    _backLeaf.name = BACK_LEAF_NODE_NAME;
    [self addChild:_backLeaf];

    _frontLeaf = [SKSpriteNode spriteNodeWithImageNamed:@"front-leaf-boss"];
    _frontLeaf.size = CGSizeMake(_frontLeaf.size.width - 100, _frontLeaf.size.height - 100);
    _frontLeaf.position = CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT) - 50);
    _frontLeaf.zPosition = 50;
    [self addChild:_frontLeaf];
    
    
    _treeBranch = [[TreeBranch alloc] init];
    
    _treeBranch.node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_treeBranch.node.size];
    _treeBranch.node.physicsBody.mass = 100;
    _treeBranch.node.physicsBody.resting = YES;
    _treeBranch.node.physicsBody.affectedByGravity = NO;
    _treeBranch.node.physicsBody.dynamic = NO;
    _treeBranch.node.physicsBody.allowsRotation = NO;
    _treeBranch.node.name = NAME_NODE_TREEBRANCH;
    
    [GameController initAccelerometer];
    
    //_tree.size = CGSizeMake(_tree.size.width / 2, _tree.size.height / 2);
    
    [self addChild:_treeBranch.node];
    [self initTrunk];
    
    _monkey.sprite.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2,
                                          _treeBranch.node.position.y + (_treeBranch.node.size.height / 2));
}

- (instancetype) initWithSize:(CGSize)size parent:(SKScene *)parentScene {
    self = [super initWithSize:size];
    if (self != nil) {
        self.view.frame = CGRectMake(0, 0, size.width, size.height);

        [self initScene];
        [self initMonkey];
        
        _lamber = [[LamberJackMachine alloc] init];
        _lamber.node.zPosition = 100;
        [self addChild:_lamber.node];

        self.physicsWorld.gravity = CGVectorMake(0, -10);
        
        _lanchMove = NO;
        _pushforce = 2;
        _sens = rand() % 2;
        _timer = 0;
        _parentScene = parentScene;
        [self updateAngleTree];
        [self initSmokeLamberJack];

        _mecanicArm = [[SKSpriteNode alloc] initWithImageNamed:@"arm"];
        _mecanicArm.size = CGSizeMake(_mecanicArm.size.width / 5, _mecanicArm.size.height / 5);
        _mecanicArm.position = CGPointMake(_lamber.node.position.x + _lamber.node.size.width - 25,
                                           _lamber.node.position.y + _lamber.node.size.height / 2);
        
        _positionLamber = _lamber.node.position;
        _positionMecanicArm = _mecanicArm.position;
        
        _mecanicHand = [SKSpriteNode spriteNodeWithImageNamed:@"hand"];
        _mecanicHand.size = CGSizeMake(_mecanicHand.size.width / 5, _mecanicHand.size.height / 5);
        _mecanicHand.position = CGPointMake(_mecanicArm.position.x + _mecanicArm.size.width / 2 + _mecanicHand.size.width,
                                            _mecanicArm.position.y - _mecanicArm.size.height / 2);
        _positionMecanicHand = _mecanicArm.position;
        
        [self addChild:_mecanicHand];
        [self addChild:_mecanicArm];
    }
    return (self);
}

- (void) popCocoNuts {
    NSInteger nbCocoNuts = rand() % 2 + 2;
    
    for (int index = 0; index <= nbCocoNuts; index ++) {
        CocoNuts *coco = [[CocoNuts alloc]
                          initWithPosition:CGPointMake((rand() %
                                                        (int)(_treeBranch.node.size.width)) +
                                                       (_treeBranch.node.position.x - (_treeBranch.node.size.width / 2)),
                                                       [UIScreen mainScreen].bounds.size.height + 35)];
        
        coco.node.size = CGSizeMake(coco.node.size.width * 2, coco.node.size.height * 2);
        coco.node.name = @"invalid_coco";
        [coco.timerHide invalidate];
        [self addChild:coco.node];
        coco.node.physicsBody = nil;
        [coco.node runAction:[SKAction waitForDuration:(float)arc4random() / 0x100000000] completion:^{
            NSLog(@"physic");
            coco.node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:coco.node.size];
            coco.node.physicsBody.mass = 25.0;
            coco.node.physicsBody.usesPreciseCollisionDetection = YES;
        }];
    }
}

- (void) stressTree:(NSTimeInterval)currentTime {
    static NSTimeInterval time = 0;
    NSInteger pushStress = 20 + rand() % 10;
    CGFloat timerStress = 0.05;
    
    if (time == 0) {
        time = currentTime + rand() % 5 + 2;
        return ;
    }
    if (currentTime >= time) {
        [self performSelector:@selector(popCocoNuts)];

        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        [_treeBranch.node runAction:[SKAction moveTo:CGPointMake(_treeBranch.node.position.x - (rand() % 10 + pushStress),
                                                            _treeBranch.node.position.y) duration:timerStress] completion:^{
            [_treeBranch.node runAction:[SKAction moveTo:CGPointMake(_treeBranch.node.position.x,
                                                                _treeBranch.node.position.y + 10) duration:0.05] completion:^{
                [_treeBranch.node runAction:[SKAction moveTo:CGPointMake(_treeBranch.node.position.x + (rand() % 10 + pushStress),
                                                                    _treeBranch.node.position.y) duration:timerStress] completion:^{
                    [_treeBranch.node runAction:[SKAction moveTo:CGPointMake(_treeBranch.node.position.x,
                                                                        _treeBranch.node.position.y - 10) duration:timerStress] completion:^{
                        [_treeBranch.node runAction:[SKAction moveTo:CGPointMake(_treeBranch.node.position.x - (rand() % 10 + pushStress),
                                                                            _treeBranch.node.position.y) duration:0.05] completion:^{
                            [_treeBranch.node runAction:[SKAction moveTo:CGPointMake(_treeBranch.node.position.x,
                                                                                _treeBranch.node.position.y + 10) duration:0.05] completion:^{
                                [_treeBranch.node runAction:[SKAction moveTo:CGPointMake(_treeBranch.node.position.x + (rand() % 10 + pushStress),
                                                                                    _treeBranch.node.position.y) duration:timerStress] completion:^{
                                    [_treeBranch.node runAction:[SKAction moveTo:CGPointMake(_treeBranch.node.position.x,
                                                                                        _treeBranch.node.position.y - 10) duration:0.05] completion:^{
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
    if (_sens == 0 && _treeBranch.node.position.x > [UIScreen mainScreen].bounds.size.width / 2) {
        [_treeBranch.node runAction:[SKAction rotateToAngle:0.2 duration:0.5]];
    }
    else if (_sens == 1 && _treeBranch.node.position.x < [UIScreen mainScreen].bounds.size.width / 2){
        [_treeBranch.node runAction:[SKAction rotateToAngle:-0.2 duration:0.5]];
    }
}

- (void) moveTreeBranch {
    
    if (_sens == 1) {
        if (_treeBranch.node.position.x < [UIScreen mainScreen].bounds.size.width - 100)
            _treeBranch.node.position = CGPointMake(_treeBranch.node.position.x + _pushforce,
                                               _treeBranch.node.position.y);
        else {
            _sens = 0;
        }
    }
    else if (_sens == 0) {
        if (_treeBranch.node.position.x > 100)
            _treeBranch.node.position = CGPointMake(_treeBranch.node.position.x - _pushforce,
                                               _treeBranch.node.position.y);
        else {
            _sens = 1;
        }
    }
    [self updateAngleTree];
}

- (void) updateTreePosition {
    _backLeaf.zRotation = _treeBranch.node.zRotation;
    _trunk.zRotation = _treeBranch.node.zRotation;
    _frontLeaf.zRotation = _treeBranch.node.zRotation;
    [_mecanicArm runAction:[SKAction moveToX:_positionMecanicArm.x + _treeBranch.node.zRotation * 100 duration:0.1]];
    [_lamber.node runAction:[SKAction moveToX:_positionLamber.x + _treeBranch.node.zRotation * 100 duration:0.1]];
    [_mecanicHand runAction:[SKAction moveToX:_positionMecanicHand.x + _treeBranch.node.zRotation * 100 duration:0.1]];
}

- (void) toreBranch:(NSTimeInterval)currentTime {
    static NSTimeInterval time = 0;
    
    if (time == 0) {
        time = currentTime + rand() % 2 + 1;
    }
    
    if (currentTime < time)
        return ;

    time = currentTime + rand() % 2 + 1;

    CGFloat angleStress = 0.75;
    
    if (_sens == 0)
        angleStress = -0.75;

    [_treeBranch.node runAction:[SKAction rotateByAngle: angleStress duration:0.1] completion:^{
        [_treeBranch.node runAction:[SKAction rotateByAngle: angleStress * -1 duration:0.1] completion:^{
            [_treeBranch.node runAction:[SKAction rotateByAngle: angleStress duration:0.1] completion:^{
                [_treeBranch.node runAction:[SKAction rotateByAngle: angleStress * -1 duration:0.1] completion:^{
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
    
    [self updateTreePosition];
    
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
            GameOverScene *gameOverScene = [[GameOverScene alloc] initWithSize:self.size andScene:self];
            [self.view presentScene:gameOverScene];
            [GameData gameOver];
        }
    }];
}

@end
