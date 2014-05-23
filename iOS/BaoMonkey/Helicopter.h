//
//  Helicopter.h
//  BaoMonkey
//
//  Created by iPPLE on 23/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Helicopter : NSObject

@property (nonatomic, strong) SKSpriteNode *node;
@property (nonatomic, assign) NSInteger sens;

- (instancetype) init;
- (void) move;

@end
