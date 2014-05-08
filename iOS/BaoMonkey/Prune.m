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
        [self.node setTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"prune"]]];
        self.action = @selector(actionPrune);
    }
    return (self);
}

- (void) actionPrune {
    SKAction *move = [SKAction moveTo:CGPointMake(self.node.position.x, 200) duration:0];
    SKAction *action = [SKAction resizeToWidth:640 height:512 duration:0.3];
    
    self.node.physicsBody = nil;
    [self.node setTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"splash-prune"]]];
    
    self.node.physicsBody.affectedByGravity = NO;
    [self.node runAction:move completion:^{
            [self.node runAction:action];
        }];
}

@end
