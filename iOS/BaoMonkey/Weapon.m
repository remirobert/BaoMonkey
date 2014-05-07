//
//  Weapon.m
//  BaoMonkey
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Weapon.h"

@implementation Weapon

- (void) display {
    NSLog(@"Weapon");
}

- (instancetype) init:(CGPoint)position {
    if ((self = [super init:position :WEAPON]) != nil) {
    }
    return (self);
}

@end
