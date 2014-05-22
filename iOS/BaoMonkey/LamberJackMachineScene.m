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
@property (nonatomic, strong) Monkey *monkey;
@property (nonatomic, strong) TreeBranch *treeBranch;
@end

@implementation LamberJackMachineScene

- (void) initMonkey {
    _monkey = [[Monkey alloc] initWithPosition:CGPointMake(self.frame.size.width/2,
                                                           _treeBranch.node.position.y + 20)];

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
    
    _treeBranch = [[TreeBranch alloc] init];
    
    _treeBranch.node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_treeBranch.node.size];
    
    self.physicsWorld.speed = 0.25;
    self.physicsBody = [SKPhysicsBody
                        bodyWithEdgeLoopFromRect:self.frame];
    [GameController initAccelerometer];
    
    [self addChild:_treeBranch.node];
    
    SKAction *rotate = [SKAction moveToY:100 duration:1.0];
    
    [_treeBranch.node runAction:rotate];
}

- (instancetype) initWithSize:(CGSize)size parent:(SKScene *)parentScene {
    self = [super initWithSize:size];
    if (self != nil) {
        self.view.frame = CGRectMake(0, 0, size.width, size.height);

        [self initScene];
        [self initMonkey];

        self.physicsWorld.gravity = CGVectorMake(0, -10);
        
        _parentScene = parentScene;
    }
    return (self);
}

- (void) update:(NSTimeInterval)currentTime {
//    [GameController updateAccelerometerAcceleration];
//    [_monkey updateMonkeyPosition:[GameController getAcceleration]];
}

@end
