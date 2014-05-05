//
//  Block.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "Block.h"

@implementation Block

- (instancetype) init:(CGPoint)position {
    if ((self = [Block alloc]) != nil) {
        _node = [[SKSpriteNode alloc] initWithColor:[SKColor redColor]
                                               size:CGSizeMake(SIZE_BLOCK, SIZE_BLOCK)];
        _node.name = NAME_BLOCK;
        _node.position = position;
        _isTouch = NO;
    }
    return (self);
}

@end
