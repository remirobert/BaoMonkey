//
//  SpriteKitCursor.m
//  BaoMonkey
//
//  Created by iPPLE on 27/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "SpriteKitCursor.h"

@implementation SpriteKitCursor

- (void) initSprite:(CGSize)size position:(CGPoint)position {
    _node = [[SKSpriteNode alloc] initWithColor:[SKColor redColor] size:size];
    _node.position = position;
    _node.zPosition = 50;
    
    _cursor = [[SKSpriteNode alloc] initWithColor:[SKColor greenColor] size:CGSizeMake(size.height, size.height)];
    _cursor.position = CGPointMake(_node.position.x - _node.size.width / 2 + _node.size.height / 2, position.y);
    _cursor.zPosition = 75;
}

- (instancetype) initWithSize:(CGSize)size position:(CGPoint)position {
    self = [super init];
    
    if (self  != nil) {
        [self initSprite:size position:position];
    }
    return (self);
}

- (void) addChild:(SKScene *)parentScene {
    [parentScene addChild:_node];
    [parentScene addChild:_cursor];
}

- (void) updatePositionCursorWithNode:(SKNode *)nodeTouch location:(CGPoint)location {
    
    if ([_cursor isEqual:nodeTouch] == YES) {
        NSLog(@"detect OK");
        
        if (nodeTouch.position.x >= _node.position.x - (_node.size.width / 2) &&
            nodeTouch.position.x <= _node.position.x + (_node.size.width / 2))
            nodeTouch.position = CGPointMake(location.x, nodeTouch.position.y);
        
        if (nodeTouch.position.x - (nodeTouch.frame.size.width / 2) < _node.position.x - (_node.size.width / 2))
            nodeTouch.position = CGPointMake(_node.position.x - (_node.size.width / 2) + (nodeTouch.frame.size.width / 2), nodeTouch.position.y);
        if (nodeTouch.position.x + (nodeTouch.frame.size.width / 2) > _node.position.x + (_node.size.width / 2))
            nodeTouch.position = CGPointMake(_node.position.x + (_node.size.width / 2) - (nodeTouch.frame.size.width / 2), nodeTouch.position.y);
    }
}

@end
