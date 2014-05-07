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
        self.node.color = [SKColor grayColor];
    }
    return (self);
}

- (void) launchAction {
    self.node.name = WEAPON_NODE_NAME;
    self.node.hidden = YES;
}

@end
