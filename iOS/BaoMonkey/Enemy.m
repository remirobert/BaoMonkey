//
//  Enemy.m
//  BaoMonkey
//
//  Created by Rémi Hillairet on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Enemy.h"

#define SPEED   0.6

@implementation Enemy

@synthesize node, direction, type;

-(id)init {
    self = [super init];
    if (self) {
        // Do some stuff
    }
    return self;
}

-(void)updatePosition {
    CGRect screen = [UIScreen mainScreen].bounds;

    if (self.direction == LEFT
        && ((self.node.position.x - (self.node.size.width / 5)) > (screen.size.width / 2)))
    {
        [node setPosition:CGPointMake(node.position.x - SPEED, node.position.y)];
    }
    else if (self.direction == RIGHT
             && ((self.node.position.x + (self.node.size.width / 5)) < (screen.size.width / 2)))
    {
        [node setPosition:CGPointMake(node.position.x + SPEED, node.position.y)];
    }
}

-(BOOL)reachedTheMiddle {
    CGRect screen = [UIScreen mainScreen].bounds;
    
    if ((self.node.position.x - (self.node.size.width / 5)) > (screen.size.width / 2))
        return FALSE;
    else if ((self.node.position.x + (self.node.size.width / 5)) < (screen.size.width / 2))
        return FALSE;
    return TRUE;
}

@end
