//
//  HelicopterScene.m
//  BaoMonkey
//
//  Created by iPPLE on 23/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "HelicopterScene.h"

@implementation HelicopterScene



- (instancetype) initWithSize:(CGSize)size parent:(SKScene *)parentScene {
    self = [super initWithSize:size];
    if (self != nil) {
        self.view.frame = CGRectMake(0, 0, size.width, size.height);
        
        self.physicsWorld.gravity = CGVectorMake(0, -10);
    }
    return (self);
}


@end
