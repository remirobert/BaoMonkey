//
//  SpriteKitCursor.m
//  BaoMonkey
//
//  Created by iPPLE on 27/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "SpriteKitCursor.h"

@implementation SpriteKitCursor

@synthesize currentValue = _currentValue;

- (void) initSprite:(CGSize)size position:(CGPoint)position {
    _node = [[SKSpriteNode alloc] initWithColor:[SKColor redColor] size:size];
    _node.position = position;
    _node.zPosition = 50;
    
    _bg = [[SKSpriteNode alloc] initWithColor:[SKColor orangeColor] size:CGSizeMake(0, size.height)];
    _bg.position = CGPointMake(position.x - _node.size.width / 2, position.y);
    _bg.zPosition = 55;
    
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
    [parentScene addChild:_bg];
    [parentScene addChild:_cursor];
}

- (BOOL) checkCursorClickWithNode:(SKNode *)node {
    return ([_cursor isEqual:node]);
}

- (void) updatePositionCursorWithLocation:(CGPoint)location {
    if (_cursor.position.x >= _node.position.x - (_node.size.width / 2) &&
        _cursor.position.x <= _node.position.x + (_node.size.width / 2))
        _cursor.position = CGPointMake(location.x, _cursor.position.y);
        
    if (_cursor.position.x - (_cursor.frame.size.width / 2) < _node.position.x - (_node.size.width / 2))
        _cursor.position = CGPointMake(_node.position.x - (_node.size.width / 2) + (_cursor.frame.size.width / 2), _cursor.position.y);
    if (_cursor.position.x + (_cursor.frame.size.width / 2) > _node.position.x + (_node.size.width / 2))
        _cursor.position = CGPointMake(_node.position.x + (_node.size.width / 2) - (_cursor.frame.size.width / 2), _cursor.position.y);

    _bg.size = CGSizeMake((_cursor.position.x - (([UIScreen mainScreen].bounds.size.width - _node.size.width) / 2) -
                           (_cursor.size.width / 2)), _bg.size.height);
    _bg.position = CGPointMake((_bg.size.width  / 2) + (_node.position.x - _node.size.width / 2), _bg.position.y);
}

- (CGFloat) currentValue {
    return (100 * (_cursor.position.x - (([UIScreen mainScreen].bounds.size.width - _node.size.width) / 2) -
                   (_cursor.size.width / 2)) / (([UIScreen mainScreen].bounds.size.width -
                                                 _node.size.width - (_cursor.size.width))));
}

@end
