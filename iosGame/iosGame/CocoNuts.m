//
//  CocoNuts.m
//  iosGame
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "CocoNuts.h"

@implementation CocoNuts

- (instancetype) init:(CGPoint)position {
    if ((self = [super init:position]) != nil) {
        self.node.color = [SKColor grayColor];
    }
    return (self);
}

@end
