//
//  LamberJackMachine.m
//  BaoMonkey
//
//  Created by iPPLE on 22/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "LamberJackMachine.h"

@implementation LamberJackMachine

- (void) initSprite {
    _node = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"machine1"]];
    _node.size = CGSizeMake(_node.size.width / 5, _node.size.height / 5);
    _node.position = CGPointMake(_node.size.width / 2 + 25, 25 + _node.size.height / 2);
    _node.name = LAMBER_JACK_MACHINE;
    _node.zPosition = 150;
    [_node runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[[SKTexture textureWithImageNamed:@"machine1"],
                                                                                   [SKTexture textureWithImageNamed:@"machine2"],
                                                                                   [SKTexture textureWithImageNamed:@"machine3"],
                                                                                   [SKTexture textureWithImageNamed:@"machine4"]] timePerFrame:0.1]]];
}

- (instancetype) init {
    self = [super init];
    
    if (self != nil) {
        [self initSprite];
    }
    return (self);
}

@end
