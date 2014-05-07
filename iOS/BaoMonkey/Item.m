//
//  Item.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "Item.h"

@implementation Item

- (instancetype) init:(CGPoint)position :(ItemType)type {
    NSLog(@"Item");
    if ((self = [super init]) != nil) {
        _node = [[SKSpriteNode alloc] initWithColor:[SKColor redColor]
                                                size:CGSizeMake(25, 25)];
        _node.position = position;
        _node.name = NAME_ITEM;
        _node.physicsBody.affectedByGravity = YES;
        _node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_node.size];
        
        _type = type;
        
    }
    return (self);
}

@end
