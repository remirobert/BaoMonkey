//
//  Item.h
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#define NAME_ITEM   @"item"


typedef enum {
    BANANA,
    PRUNE,
    COCONUTS
}ItemType;


@interface Item : NSObject

@property (nonatomic, strong) SKSpriteNode *node;

- (instancetype) init:(CGPoint)position;

@end
