//
//  MyScene.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "MyScene.h"
#import "MyScene+GeneratorWave.h"

@implementation MyScene

- (void) initScene {
    self.backgroundColor = [SKColor colorWithRed:0.15
                                           green:0.15
                                            blue:0.3
                                           alpha:1.0];
    
    _sizeBlock = (self.frame.size.width - (self.frame.size.width / 10)) / 10;
    _trunk = [[Trunk alloc] init];
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:_trunk.node.frame];
    
    [self addChild:_trunk.node];
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [self initScene];
        [self performSelector:@selector(addWave) withObject:nil afterDelay:rand() % 3 + 1];
    }
    return self;
}

- (void) addWave {
    [self addNewWave];
    [self performSelector:@selector(addWave) withObject:nil afterDelay:rand() % 3 + 1];
}

-(void)update:(CFTimeInterval)currentTime {
}

@end
