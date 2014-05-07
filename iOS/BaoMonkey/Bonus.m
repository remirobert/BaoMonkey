//
//  Bonus.m
//  BaoMonkey
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Bonus.h"

@implementation Bonus

- (void) display {
    NSLog(@"bonus");
}

- (instancetype) init:(CGPoint)position {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(display) name:@"runAction" object:nil];

    if ((self = [super init:position :BONUS :@selector(display)]) != nil) {
    }
    return (self);
}

@end
