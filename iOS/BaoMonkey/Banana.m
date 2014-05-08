//
//  Banana.m
//  iosGame
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "Banana.h"

@implementation Banana

- (instancetype) initWithPosition:(CGPoint)position {
    if ((self = [super initWithPosition:position]) != nil) {
        [self.node setTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"banana"]]];
        self.action = @selector(actionBanana);
        self.node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.node.size.width / 2];
    }
    return (self);
}

- (void) actionBanana {
    self.node.hidden = YES;
    [Action increaseMove];
}

@end
