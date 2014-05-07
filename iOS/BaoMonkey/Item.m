//
//  Item.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "Item.h"

@interface Item ()
@property (nonatomic) SEL actionFunction;
@end

@implementation Item

- (instancetype) init:(CGPoint)position :(ItemType)type :(SEL)actionFunction {
    if ((self = [Item alloc]) != nil) {
        _node = [[SKSpriteNode alloc] initWithColor:[SKColor redColor]
                                                size:CGSizeMake(25, 25)];
        _node.position = position;
        _node.name = NAME_ITEM;
        _node.physicsBody.affectedByGravity = YES;
        _node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_node.size];
        
        _type = type;
        
        //[[self superclass] instanceMethodForSelector:_actionFunction];
        _actionFunction = actionFunction;
    }
    return (self);
}

- (void) display {

    NSLog(@"Item");
    
    /*
    
    if ([self respondsToSelector:_actionFunction])
        [self performSelector:_actionFunction];
//        [self performSelectorOnMainThread:_actionFunction withObject:nil waitUntilDone:0];
    else
        NSLog(@"dont respond to the selector");
     */
}

@end
