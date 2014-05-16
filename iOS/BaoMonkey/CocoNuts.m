//
//  CocoNuts.m
//  iosGame
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "CocoNuts.h"
#import "PreloadData.h"

@implementation CocoNuts

- (instancetype) initWithPosition:(CGPoint)position {
    if ((self = [super initWithPosition:position]) != nil) {
        [self.node setTexture:[PreloadData getDataWithKey:DATA_COCONUT_TEXTURE]];
        self.node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.node.size.width / 3];
        self.node.physicsBody.mass = 100;
    }
    return (self);
}

- (void) launchAction {
    SKAction *removeBlind = [SKAction fadeInWithDuration:0.0];
    [self.node runAction:removeBlind];
    self.node.physicsBody = nil;
}

@end
