//
//  MyScene+GeneratorWave.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "MyScene+GeneratorWave.h"

@interface MyScene ()
@property (nonatomic) CGFloat timeWeapon;
@end

@implementation MyScene (GeneratorWave)

- (void) addItemToScene:(SKSpriteNode *)node {
    [self addChild:node];
}

- (void) deleteItemAfterTime:(Item*)item {
    if (item == nil || item.isTaken == YES)
        return ;
    SKAction *blink = [SKAction sequence:@[[SKAction fadeOutWithDuration:0.1],
                                           [SKAction fadeInWithDuration:0.1]]];
    SKAction *blinkAction = [SKAction repeatAction:blink count:3];
    [item.node runAction:blinkAction completion:^{
        [item.node removeFromParent];
        [self.wave removeObject:item];
    }];
}

- (NSObject *) createItem:(CGPoint)position {
    
    NSObject *object;
    int ratio = rand() % 3;
    
    if (ratio < 2)
        object = [[Banana alloc] initWithPosition:position];
    else
        object = [[Prune alloc] initWithPosition:position];
    return (object);
}

- (void) addItem:(id)object {
    if (object == nil)
        return ;
    
    if (self.wave == nil)
        self.wave = [[NSMutableArray alloc] init];
    
    [self.wave addObject:object];
    [self performSelector:@selector(addItemToScene:)
               withObject:((Item *)object).node
               afterDelay:((float)arc4random() / 0x100000000)];
    
    [self performSelector:@selector(deleteItemAfterTime:)
               withObject:object afterDelay:rand() % 4 + 2];
}

- (void) addNewWeapon:(CFTimeInterval)currentTime {
    static CGFloat timeNext = 0.0;
    
    if (currentTime < timeNext) {
        return ;
    }

    timeNext = currentTime + 1.0;
    CGPoint position = CGPointMake(rand() % (int)([UIScreen mainScreen].bounds.size.width -
                                                  ([UIScreen mainScreen].bounds.size.width / 10)) +
                                   ([UIScreen mainScreen].bounds.size.width / 10),
                                   [UIScreen mainScreen].bounds.size.height + self.sizeBlock);
    CocoNuts *coco = [[CocoNuts alloc] initWithPosition:position];

    [self addItem:coco];
}

- (void) addNewWave:(CFTimeInterval)currentTime {
    static CGFloat timeNext = 0.0;
    
    if (currentTime < timeNext) {
        return ;
    }
    
    timeNext = currentTime + rand() % 4 + 3;
    id object = [self createItem:CGPointMake(rand() % (int)([UIScreen mainScreen].bounds.size.width -
                                                            ([UIScreen mainScreen].bounds.size.width / 10)) +
                                             ([UIScreen mainScreen].bounds.size.width / 10),
                                             [UIScreen mainScreen].bounds.size.height + self.sizeBlock)];
    [self addItem:object];
}

@end
