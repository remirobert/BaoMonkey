//
//  Settings.m
//  BaoMonkey
//
//  Created by iPPLE on 27/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Settings.h"
#import "Define.h"
#import "SpriteKitCursor.h"

@interface Settings ()
@property (nonatomic, assign) BOOL isClick;
@property (nonatomic, strong) SpriteKitCursor *cursor;
@property (nonatomic, strong) id currentCursorClicked;
@end

@implementation Settings

- (instancetype) initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    
    if (self != nil) {
        self.backgroundColor = [SKColor blueColor];
        NSLog(@"Main Menu ok");
        
        _cursor = [[SpriteKitCursor alloc] initWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width / 2, 50)
                                               position:CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 200)];
        
        [_cursor addChild:self];
    }
    return (self);
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    if ([_cursor checkCursorClickWithNode:node] == YES)
        _currentCursorClicked = _cursor;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];

    if ([_currentCursorClicked isEqual:_cursor])
        [_cursor updatePositionCursorWithLocation:location];
    
    NSLog(@"current Value = %f", _cursor.currentValue);
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    _currentCursorClicked = nil;
    _isClick = NO;
}

@end
