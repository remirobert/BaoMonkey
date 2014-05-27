//
//  SpriteKitCursor.h
//  BaoMonkey
//
//  Created by iPPLE on 27/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

# define NAME_CURSOR        @"cursor"

@interface SpriteKitCursor : NSObject

@property (nonatomic, strong) SKSpriteNode *node;
@property (nonatomic, strong) SKSpriteNode *bg;
@property (nonatomic, strong) SKSpriteNode *cursor;
@property (nonatomic, assign) CGFloat currentValue;

- (instancetype) initWithSize:(CGSize)size position:(CGPoint)position;
- (void) addChild:(SKScene *)parentScene;
- (void) updatePositionCursorWithLocation:(CGPoint)location;
- (BOOL) checkCursorClickWithNode:(SKNode *)node;

#pragma mark - Custom slider
- (void) setBackgroundTexture:(UIImage *)image;
- (void) setCursorTexture:(UIImage *)image;
- (void) setForegroundTexture:(UIImage *)image;

@end
