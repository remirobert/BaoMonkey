//
//  Action.m
//  BaoMonkey
//
//  Created by iPPLE on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Action.h"

@implementation Action

+ (void) dropWeapon:(Item *)item {
    if ([GameData isPause])
        return ;
    item.node.physicsBody.affectedByGravity = YES;
    item.node.name = WEAPON_NODE_NAME;
    item.node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:item.node.size];
    item.node.position = CGPointMake(item.node.position.x, [BaoPosition dropAction]);
}

+ (void) decreaseMove {
    [GameController updateAcceleration:0.0];
}

+ (void) increaseMove {
    [GameController updateAcceleration:25.0];
    [NSTimer scheduledTimerWithTimeInterval:0.75 target:self
                                            selector:@selector(decreaseMove)
                                            userInfo:nil repeats:NO];
}

@end
