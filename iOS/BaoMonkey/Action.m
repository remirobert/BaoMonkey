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
    item.node.physicsBody.affectedByGravity = YES;
    item.node.name = WEAPON_NODE_NAME;
    item.node.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:item.node.size];
    item.node.position = CGPointMake(item.node.position.x, item.node.position.y - 40);
    item.node.hidden = NO;
}

@end
