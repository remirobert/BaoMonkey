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
    int positionX = ((7 + 25) * (rand() % 10)) + SIZE_BLOCK / 2;
    
    while (isTaken) {
        isTaken = NO;
        for (Block *currentBlock in wave) {
            if (currentBlock.node.position.x == positionX) {
                isTaken = YES;
                return (positionX);
            }
        }
    }
    return (positionX);
}

- (void) addNewWave {
    NSMutableArray *wave = [[NSMutableArray alloc] init];
    int nbBlock = rand() % 10;

    for (int i = 0; i < nbBlock; i++) {
        if (wave != nil)
        
        [wave addObject:[[Block alloc]
                         init:CGPointMake([self getPosition:wave],
                                          [UIScreen mainScreen].bounds.size.height + SIZE_BLOCK)]];
        [self addChild:((Block *)[wave objectAtIndex:i]).node];
    }
}

- (void) moveWave {
    [self enumerateChildNodesWithName:NAME_BLOCK usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = CGPointMake(node.position.x, node.position.y - 2);
        if (node.position.y < 0)
            [node removeFromParent];
    }];
}

@end
