//
//  Prune.m
//  iosGame
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "Prune.h"

@implementation Prune

- (instancetype) initWithPosition:(CGPoint)position {
    if ((self = [super initWithPosition:position]) != nil) {
        self.node.color = [SKColor purpleColor];
        self.action = @selector(actionPrune);
    }
    return (self);
}

- (void) actionPrune {
    SKAction *t = [SKAction waitForDuration:1.0];
    SKAction *move = [SKAction moveTo:CGPointMake(self.node.position.x, 200) duration:0];
    SKAction *action = [SKAction resizeToWidth:300 height:300 duration:0.5];
    
    [self.node runAction:t completion:^{
        [self.node runAction:move completion:^{
            self.node.physicsBody.affectedByGravity = NO;
            [self.node runAction:action];
        }];
    }];
}

@end
