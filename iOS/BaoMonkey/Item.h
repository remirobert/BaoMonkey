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


typedef enum {
    WEAPON,
    BONUS,
    MALUS
}ItemType;


@interface Item : NSObject

@property (nonatomic, strong) SKSpriteNode *node;
@property (nonatomic) ItemType type;

- (instancetype) init:(CGPoint)position :(ItemType)type :(SEL)actionFunction;
- (void) runAction;

@end
