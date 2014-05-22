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

@interface LamberJackMachineScene ()
@property (nonatomic, strong) SKScene *parentScene;
@property (nonatomic, assign) NSTimeInterval timer;
@property (nonatomic, strong) Monkey *monkey;
@property (nonatomic, strong) SKSpriteNode *treeBranch;
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
    
    _treeBranch = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width / 2, 35)];
    
    _treeBranch.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2,
                                       [UIScreen mainScreen].bounds.size.height - 180);
    
    _treeBranch.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_treeBranch.size];
    _treeBranch.physicsBody.mass = 1000000;
    _treeBranch.physicsBody.affectedByGravity = NO;
    _treeBranch.physicsBody.dynamic = NO;
    _treeBranch.physicsBody.allowsRotation = NO;
    
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

        self.physicsWorld.gravity = CGVectorMake(0, -10);
        
        _timer = 0;
        _parentScene = parentScene;
    }
    return (self);
}

- (void) update:(NSTimeInterval)currentTime {
    if (_timer == 0) {
        _timer = currentTime + 30;
    }

    if (currentTime >= _timer) {
        [GameData addPointToScore:10];
        [self.view presentScene:_parentScene];
    }
    
    [GameController updateAccelerometerAcceleration];
    [_monkey updateMonkeyPosition:[GameController getAcceleration]];
}

@end
