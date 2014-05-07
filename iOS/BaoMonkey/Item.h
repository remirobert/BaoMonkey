//
//  Item.h
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Define.h"

#define NAME_ITEM   @"item"

@interface Item : NSObject

@property (nonatomic, strong) SKSpriteNode *node;

- (instancetype) initWithPosition:(CGPoint)position;

@end
