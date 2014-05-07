//
//  MyScene+GeneratorWave.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "MyScene+GeneratorWave.h"

@implementation MyScene (GeneratorWave)

- (int) getPosition:(NSMutableArray *)wave {
    BOOL isTaken = YES;
    int positionX = ((7 + 25) * (rand() % 10)) + self.sizeBlock / 2;
    
    while (isTaken) {
        isTaken = NO;
        for (Item *currentBlock in wave) {
            if (currentBlock.node.position.x == positionX) {
                isTaken = YES;
                return (positionX);
            }
        }
    }
    return (positionX);
}

- (void) addItemToScene:(SKSpriteNode *)node {
    [self addChild:node];
}

- (void) deleteItemAfterTime:(Item*)item {
    [item.node removeFromParent];
    [self.wave removeObject:item];
}

- (id) createItem:(CGPoint)position {
    
    id object;
    
    switch (rand() % 3) {
        case 0:
            object = [[Prune alloc] init:position];
            break;

        case 1:
            object = [[Banana alloc] init:position];
            break;
            
        case 2:
            object = [[CocoNuts alloc] init:position];
            break;
            
        default:
            return (nil);
    }
    return (object);
}

- (void) addNewWave {
    id object = [self createItem:CGPointMake(((7 + 25) * (rand() % 10)) + self.sizeBlock / 2,
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
