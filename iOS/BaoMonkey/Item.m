//
//  Item.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "Item.h"

@interface Item ()
@property (nonatomic) CGFloat saveTime;
@end

@implementation Item

- (instancetype) initWithPosition:(CGPoint)position {
    if ((self = [super init]) != nil) {
        _node = [[SKSpriteNode alloc] initWithColor:[SKColor redColor]
                                               size:CGSizeMake([UIScreen mainScreen].bounds.size.width / 10,
                                                               [UIScreen mainScreen].bounds.size.width / 10 )];
        _node.position = position;
        _node.name = ITEM_NODE_NAME;
        _node.physicsBody.affectedByGravity = YES;
        _node.physicsBody.mass = 20.0;
        _isTaken = NO;
        _isOver = NO;
        _timerHide = [NSTimer scheduledTimerWithTimeInterval:rand() % 3 + 2
                                                      target:self
                                                    selector:@selector(removeItemTimer) userInfo:nil repeats:NO];
    }
    return (self);
}

- (void) launchAction {
    if ([self respondsToSelector:_action]) {
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:_action];
    }
}

- (void) removeItemTimer {
    [Item deleteItemAfterTimer:self];
}

+ (void) deleteItemAfterTimer:(Item*)item {
    if (item == nil || item.isTaken == YES)
        return ;
    SKAction *blink = [SKAction sequence:@[[SKAction fadeOutWithDuration:0.1],
                                           [SKAction fadeInWithDuration:0.1]]];
    SKAction *blinkAction = [SKAction repeatAction:blink count:3];
    [item.node runAction:blinkAction completion:^{
        [item.node removeFromParent];
        item.isOver = YES;
    }];
}

- (void) pauseTimer {
    _saveTime = [[_timerHide fireDate] timeIntervalSinceDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    [_timerHide invalidate];
    _timerHide = nil;
}

- (void) resumeTimer {
    _timerHide = [NSTimer scheduledTimerWithTimeInterval:_saveTime
                                                  target:self
                                                selector:@selector(removeItemTimer) userInfo:nil repeats:NO];
}

@end