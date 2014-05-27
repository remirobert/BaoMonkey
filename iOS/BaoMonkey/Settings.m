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
@end

@implementation Settings

- (void) initbutton {
//    _nodeVolume = [[SKSpriteNode alloc] initWithColor:[SKColor redColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width - 100, 50)];
//    
//    _nodeVolume.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
//    _nodeVolume.zPosition = 50;
//    
//    [self addChild:_nodeVolume];
//    
//    
//    SKSpriteNode *cursor = [[SKSpriteNode alloc] initWithColor:[SKColor greenColor] size:CGSizeMake(50, 50)];
//    
//    
//    NSLog(@"%f", _nodeVolume.position.x - (_nodeVolume.size.width / 2));
//    
//    cursor.zPosition = 75;
//    cursor.position = CGPointMake(_nodeVolume.position.x - (_nodeVolume.size.width / 2) + 25, [UIScreen mainScreen].bounds.size.height / 2);
//    cursor.name = @"cursor";
//    
//    [self addChild:cursor];
}

- (instancetype) initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    
    if (self != nil) {
        self.backgroundColor = [SKColor blueColor];
        NSLog(@"Main Menu ok");
//        [self initbutton];
        
        _cursor = [[SpriteKitCursor alloc] initWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width / 2, 50) position:CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 200)];
        
        [_cursor addChild:self];
        
    }
    return (self);
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"cursor"])
        _isClick = YES;
    else
        _isClick = NO;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];

    
    [_cursor updatePositionCursorWithNode:[self nodeAtPoint:location] location:location];
//    if (_isClick == YES) {
//        SKNode *node = [self childNodeWithName:@"cursor"];
//        
//        if (node.position.x >= _nodeVolume.position.x - (_nodeVolume.size.width / 2) &&
//            node.position.x <= _nodeVolume.position.x + (_nodeVolume.size.width / 2))
//        node.position = CGPointMake(location.x, node.position.y);
//        
//        if (node.position.x - (node.frame.size.width / 2) < _nodeVolume.position.x - (_nodeVolume.size.width / 2))
//            node.position = CGPointMake(_nodeVolume.position.x - (_nodeVolume.size.width / 2) + (node.frame.size.width / 2), node.position.y);
//        if (node.position.x + (node.frame.size.width / 2) > _nodeVolume.position.x + (_nodeVolume.size.width / 2))
//            node.position = CGPointMake(_nodeVolume.position.x + (_nodeVolume.size.width / 2) - (node.frame.size.width / 2), node.position.y);
//    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    _isClick = NO;
}

@end
