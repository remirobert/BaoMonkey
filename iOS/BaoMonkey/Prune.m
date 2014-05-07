//
//  Prune.m
//  iosGame
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "Prune.h"

@implementation Prune

- (instancetype) init:(CGPoint)position {
    if ((self = [super init:position]) != nil) {
        self.node.color = [SKColor purpleColor];
    }
    return (self);
}

-(void)display{
    [super display];

}

@end
