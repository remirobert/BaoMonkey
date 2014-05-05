//
//  Block.h
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>

#define NAME_BLOCK  @"block"
#define SIZE_BLOCK  25

@interface Block : NSObject

- (instancetype) init:(CGPoint)position;

@property (nonatomic) SKSpriteNode *node;
@property (nonatomic) BOOL isTouch;

@end
