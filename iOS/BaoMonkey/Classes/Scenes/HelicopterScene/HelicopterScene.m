//
//  HelicopterScene.m
//  BaoMonkey
//
//  Created by iPPLE on 23/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "HelicopterScene.h"
#import "Helicopter.h"
@interface HelicopterScene ()
@property (nonatomic, strong) Helicopter *heli;
@end

@implementation HelicopterScene

- (void) initHelicopter {
    _heli = [[Helicopter alloc] init];
    [self addChild:_heli.node];
}

- (instancetype) initWithSize:(CGSize)size parent:(SKScene *)parentScene {
    self = [super initWithSize:size];
    if (self != nil) {
        self.view.frame = CGRectMake(0, 0, size.width, size.height);
        
        self.physicsWorld.gravity = CGVectorMake(0, -10);
        [self initHelicopter];
    }
    return (self);
}


- (void) update:(NSTimeInterval)currentTime {
    [_heli move];
}

@end
