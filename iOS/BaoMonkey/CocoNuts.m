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
    }
    return (self);
}

- (void) launchAction {    
    self.node.physicsBody = nil;
}

@end
