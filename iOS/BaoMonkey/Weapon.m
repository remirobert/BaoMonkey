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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(display) name:NOTIFICATION_DROP_WEAPON object:nil];

    if ((self = [super init:position :WEAPON :@selector(display)]) != nil) {
    }
    return (self);
}

@end
