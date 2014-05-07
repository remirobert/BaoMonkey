//
//  Banana.m
//  iosGame
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "Banana.h"

@implementation Banana

- (instancetype) initWithPosition:(CGPoint)position {
    if ((self = [super initWithPosition:position]) != nil) {
        self.node.color = [SKColor yellowColor];
        self.action = @selector(actionBanana);
    }
    return (self);
}

- (void) actionBanana {
    NSLog(@"banana action");
}

@end
