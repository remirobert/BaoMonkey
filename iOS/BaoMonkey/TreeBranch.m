//
//  Trunk.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "TreeBranch.h"

@implementation TreeBranch

- (instancetype) init {
    if ((self = [TreeBranch alloc]) != nil) {
        
        _node = [[SKSpriteNode alloc] initWithImageNamed:@"tree-branch.png"];
        
        _node.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2,
                                     [UIScreen mainScreen].bounds.size.height - 180);
        
        _node.name = @"treeBranch";
    }
    return (self);
}

@end
