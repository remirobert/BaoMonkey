//
//  Malus.m
//  BaoMonkey
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Malus.h"

@implementation Malus

- (void) display {
    NSLog(@"Malus");
}

- (instancetype) init:(CGPoint)position {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(display) name:@"runAction" object:nil];

    if ((self = [super init:position :MALUS :@selector(display)]) != nil) {
    }
    return (self);
}

@end
