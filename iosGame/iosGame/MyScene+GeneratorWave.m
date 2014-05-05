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

- (void) addNewWave {
    NSMutableArray *wave = [[NSMutableArray alloc] init];
    int nbBlock = rand() % 5;

    for (int i = 0; i < nbBlock; i++) {
        if (wave != nil)
        
        [wave addObject:[[Item alloc]
                         init:CGPointMake([self getPosition:wave],
                                          [UIScreen mainScreen].bounds.size.height + self.sizeBlock)]];
        [self addChild:((Item *)[wave objectAtIndex:i]).node];
    }
}

- (void) deleteItemAfterTime:(SKNode *)node {
    [node removeFromParent];
}

- (void) moveWave {
    
    [self enumerateChildNodesWithName:NAME_ITEM usingBlock:^(SKNode *node, BOOL *stop) {
        if (self.trunk.node.position.y < node.position.y - (node.frame.size.width / 2)) {
        
            node.position = CGPointMake(node.position.x, node.position.y - 2);
        
            if (node.position.y < 0)
                [node removeFromParent];
        }
        else
            [self performSelector:@selector(deleteItemAfterTime:) withObject:node afterDelay:1.0];
        
    }];
}

@end
