//
//  Trunk.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "Trunk.h"

@implementation Trunk

- (instancetype) init {
    if ((self = [Trunk alloc]) != nil) {
        
        _node = [[SKSpriteNode alloc]
                 initWithColor:[[SKColor greenColor]
                                colorWithAlphaComponent:0.65]
                 size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 30)];
        _node.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2,
                                     [UIScreen mainScreen].bounds.size.height -
                                     ([UIScreen mainScreen].bounds.size.height / 3));
        _node.name = @"trunk";
    }
    return (self);
}

@end
