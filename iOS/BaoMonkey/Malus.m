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

- (instancetype) initWithPosition:(CGPoint)position {
    if ((self = [super initWithPosition:position]) != nil) {
    }
    return (self);
}

@end
