//
//  Enemy.m
//  BaoMonkey
//
//  Created by Rémi Hillairet on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Enemy.h"
#import "Define.h"

#define SPEED_MIN   0.5
#define SPEED_MAX   1.5

@implementation Enemy

@synthesize node, direction, type;

-(id)init {
    self = [super init];
    if (self) {
        speed = SPEED_MIN + ((float)arc4random() / (0x100000000 / (SPEED_MAX - SPEED_MIN)));
    }
    return self;
}

-(void)updatePosition {
    CGRect screen = [UIScreen mainScreen].bounds;

    if (self.direction == LEFT
        && ((self.node.position.x - (self.node.size.width / 5)) > (screen.size.width / 2)))
    {
        [node setPosition:CGPointMake(node.position.x - speed, node.position.y)];
    }
    else if (self.direction == RIGHT
             && ((self.node.position.x + (self.node.size.width / 5)) < (screen.size.width / 2)))
    {
        [node setPosition:CGPointMake(node.position.x + speed, node.position.y)];
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
