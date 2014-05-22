//
//  LamberJackMachine.m
//  BaoMonkey
//
//  Created by iPPLE on 22/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "LamberJackMachine.h"

@implementation LamberJackMachine

- (instancetype) init {
    self = [super init];
    
    if (self != nil) {
        _node = [[SKSpriteNode alloc] initWithColor:[SKColor blackColor]
                                               size:CGSizeMake(30, 50)];
        _node.position = CGPointMake(0, 25);
        _node.name = LAMBER_JACK_MACHINE;
    }
    return (self);
}

@end
