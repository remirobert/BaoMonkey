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

- (void) addNewWave {
    NSMutableArray *wave = [[NSMutableArray alloc] init];
    int nbBlock = rand() % 2 + 1;

    for (int i = 0; i < nbBlock; i++) {
        if (wave != nil)
        
        [wave addObject:[[Item alloc]
                         init:CGPointMake([self getPosition:wave],
                                          [UIScreen mainScreen].bounds.size.height + self.sizeBlock)]];
        
        [self performSelector:@selector(addItemToScene:)
                   withObject:((Item *)[wave objectAtIndex:i]).node
                   afterDelay:((float)arc4random() / 0x100000000)];
    }
}

@end
