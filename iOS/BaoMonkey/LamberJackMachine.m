//
//  LamberJackMachine.m
//  BaoMonkey
//
//  Created by iPPLE on 22/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "LamberJackMachine.h"

@implementation LamberJackMachine

- (void) initSprite {
    _node = [[SKSpriteNode alloc] initWithColor:[SKColor blackColor]
                                           size:CGSizeMake(30, 50)];
    _node.position = CGPointMake(0, 25);
    _node.name = LAMBER_JACK_MACHINE;
    _node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_node.size];
    _node.physicsBody.affectedByGravity = NO;
}

- (instancetype) init {
    self = [super init];
    
    if (self != nil) {
        [self initSprite];
    }
    return (self);
}

@end
