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
    if ((self = [super init:position :BONUS :nil]) != nil) {
    }
    return (self);
}

@end
