//
//  CocoNuts.m
//  iosGame
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "CocoNuts.h"

@implementation CocoNuts

- (instancetype) initWithPosition:(CGPoint)position {
    if ((self = [super initWithPosition:position]) != nil) {
        [self.node setTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"coconut"]]];
        self.node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.node.size.width / 2];
    }
    return (self);
}

- (void) launchAction {
    SKAction *removeBlind = [SKAction fadeInWithDuration:0.0];
    [self.node runAction:removeBlind];
    self.node.physicsBody = nil;
}

@end
