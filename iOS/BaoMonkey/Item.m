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

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype) init:(CGPoint)position :(ItemType)type :(SEL)actionFunction {
    if ((self = [super init]) != nil) {
        _node = [[SKSpriteNode alloc] initWithColor:[SKColor redColor]
                                                size:CGSizeMake([UIScreen mainScreen].bounds.size.width / 10, [UIScreen mainScreen].bounds.size.width / 10 )];
        _node.position = position;
        _node.name = NAME_ITEM;
        _node.physicsBody.affectedByGravity = YES;
        _node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_node.size];
        
        _type = type;
        
        _actionFunction = actionFunction;
    }
    return (self);
}

- (void) runAction {
    
    if ([self respondsToSelector:_actionFunction]) {
//        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//            [self performSelector:_actionFunction];
    }
    else
        NSLog(@"respond FALSE");
}

@end
