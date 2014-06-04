//
//  Shield.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 03/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Shield.h"

@implementation Shield

- (instancetype) initWithPosition:(CGPoint)position {
    if ((self = [super initWithPosition:position]) != nil) {
        [self.node setTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"shield"]]];
        self.node.size = CGSizeMake(30, 30);
        self.node.position = position;
        self.node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.node.size.width / 3];
        self.node.physicsBody.mass = 200;
        self.node.name = @"SHIELD_NODE_NAME";
    }
    return (self);
}

- (void) updatePosition:(CGPoint)position {
    self.node.position = position;
}

@end
