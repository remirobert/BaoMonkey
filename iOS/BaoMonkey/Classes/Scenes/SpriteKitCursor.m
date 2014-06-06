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
    _foreground = [[SKSpriteNode alloc] initWithColor:[SKColor redColor] size:size];
    _foreground.position = position;
    _foreground.zPosition = 50;
    
    _background = [[SKSpriteNode alloc] initWithColor:[SKColor orangeColor] size:CGSizeMake(0, size.height)];
    _background.position = CGPointMake(position.x - _foreground.size.width / 2, position.y);
    _background.zPosition = 55;
    
    _cursor = [[SKSpriteNode alloc] initWithColor:[SKColor greenColor] size:CGSizeMake(size.height, size.height)];
    _cursor.position = CGPointMake(_foreground.position.x - _foreground.size.width / 2 + _foreground.size.height / 2, position.y);
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
    [parentScene addChild:_foreground];
    [parentScene addChild:_background];
    [parentScene addChild:_cursor];
}

- (BOOL) checkCursorClickWithNode:(SKNode *)node {
    return ([_cursor isEqual:node]);
}

- (void) setCurrentValue:(CGFloat)currentValue {
    
    if (currentValue < 0)
        currentValue = 0.0;
    if (currentValue > 100.0)
        currentValue = 100.0;
    
    CGFloat positionX = ((currentValue * _foreground.size.width) / 100);
    
    [self updatePositionCursorWithLocation:CGPointMake(positionX +
                                                       (_foreground.position.x -
                                                        _foreground.size.width / 2), 0)];
}

- (void) updatePositionCursorWithLocation:(CGPoint)location {
    if (_cursor.position.x >= _foreground.position.x - (_foreground.size.width / 2) &&
        _cursor.position.x <= _foreground.position.x + (_foreground.size.width / 2))
        _cursor.position = CGPointMake(location.x, _cursor.position.y);
        
    if (_cursor.position.x - (_cursor.frame.size.width / 2) < _foreground.position.x - (_foreground.size.width / 2))
        _cursor.position = CGPointMake(_foreground.position.x - (_foreground.size.width / 2) + (_cursor.frame.size.width / 2), _cursor.position.y);
    if (_cursor.position.x + (_cursor.frame.size.width / 2) > _foreground.position.x + (_foreground.size.width / 2))
        _cursor.position = CGPointMake(_foreground.position.x + (_foreground.size.width / 2) - (_cursor.frame.size.width / 2), _cursor.position.y);

    _background.size = CGSizeMake((_cursor.position.x - (_foreground.position.x -
                                                  _foreground.size.width / 2) -
                           (_cursor.size.width / 2)), _background.size.height);

    _background.position = CGPointMake((_background.size.width  / 2) + (_foreground.position.x - _foreground.size.width / 2), _background.position.y);
}

- (CGFloat) currentValue {
    return (100 * ([UIScreen mainScreen].bounds.size.width - _foreground.size.width) / ((([UIScreen mainScreen].bounds.size.width - _foreground.size.width) / 2) - (_cursor.size.width / 2)));
}

#pragma mark - Custom slider

- (void) setBackgroundTexture:(UIImage *)image {
    [_background setTexture:[SKTexture textureWithImage:image]];
}

- (void) setCursorTexture:(UIImage *)image {
    [_cursor setTexture:[SKTexture textureWithImage:image]];
}

- (void) setForegroundTexture:(UIImage *)image {
    [_foreground setTexture:[SKTexture textureWithImage:image]];
}

- (void) setBackgroundTexture:(UIImage *)image withSize:(CGSize)size {
    [_background setTexture:[SKTexture textureWithImage:image]];
    _background.size = size;
}

- (void) setCursorTexture:(UIImage *)image withSize:(CGSize)size {
    [_cursor setTexture:[SKTexture textureWithImage:image]];
    _cursor.size = size;
}

- (void) setForeground:(UIImage *)image withSize:(CGSize)size {
    [_foreground setTexture:[SKTexture textureWithImage:image]];
    _foreground.size = size;
}

@end
