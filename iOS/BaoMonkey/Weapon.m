//
//  Weapon.m
//  BaoMonkey
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Weapon.h"

@implementation Weapon

- (instancetype) initWithPosition:(CGPoint)position {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(display)
                                                 name:NOTIFICATION_DROP_WEAPON
                                               object:nil];

    if ((self = [super initWithPosition:position]) != nil) {
    }
    
    return (self);
}

@end
