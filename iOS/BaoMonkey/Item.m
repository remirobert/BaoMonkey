//
//  Item.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "Item.h"

@implementation Item

- (instancetype) initWithPosition:(CGPoint)position {
    if ((self = [super init]) != nil) {
        _node = [[SKSpriteNode alloc] initWithColor:[SKColor redColor]
                                               size:CGSizeMake([UIScreen mainScreen].bounds.size.width / 10,
                                                               [UIScreen mainScreen].bounds.size.width / 10 )];
        _node.position = position;
        _node.name = NAME_ITEM;
        _node.physicsBody.affectedByGravity = YES;
        _node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_node.size];
    }
    return (self);
}

- (void) launchAction {
    if ([self respondsToSelector:_action]) {
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:_action];
    }
}

@end