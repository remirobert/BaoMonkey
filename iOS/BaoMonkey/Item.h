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

@interface Item : NSObject

@property (nonatomic, strong) SKSpriteNode *node;
@property (nonatomic) SEL action;
@property (nonatomic) BOOL isTaken;
@property (nonatomic) BOOL isOver;
@property (nonatomic) NSTimer *timerHide;

- (instancetype) initWithPosition:(CGPoint)position;
- (void) launchAction;
+ (void) deleteItemAfterTimer:(Item*)item;
- (void) pauseTimer;
- (void) resumeTimer;

@end
