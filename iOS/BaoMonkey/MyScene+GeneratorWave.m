//
//  MyScene+GeneratorWave.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "MyScene+GeneratorWave.h"

@implementation MyScene (GeneratorWave)

- (void) addItemToScene:(SKSpriteNode *)node {
    [self addChild:node];
}

- (void) deleteItemAfterTime:(Item*)item {
    if (item.isTaken == YES)
        return ;
    [item.node removeFromParent];
    [self.wave removeObject:item];
}

- (NSObject *) createItem:(CGPoint)position {
    
    NSObject *object;

    switch (rand() % 3) {
        case 0:
            object = [[Prune alloc] initWithPosition:position];
            break;

        case 1:
            object = [[Banana alloc] initWithPosition:position];
            break;

        case 2:
            object = [[CocoNuts alloc] initWithPosition:position];
            break;

        default:
            return (nil);
    }
    return (object);
}

- (void) addNewWave {
    
    id object = [self createItem:CGPointMake(rand() % (int)([UIScreen mainScreen].bounds.size.width -
                                                            ([UIScreen mainScreen].bounds.size.width / 10)) +
                                             ([UIScreen mainScreen].bounds.size.width / 10),
                                             [UIScreen mainScreen].bounds.size.height + self.sizeBlock)];
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

@end
