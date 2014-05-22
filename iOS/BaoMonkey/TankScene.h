//
//  TankScene.h
//  BaoMonkey
//
//  Created by iPPLE on 21/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TreeBranch.h"

@interface TankScene : SKScene

- (instancetype) initWithSize:(CGSize)size parent:(SKScene *)parentScene;

@property (nonatomic) TreeBranch *treeBranch;

@end
