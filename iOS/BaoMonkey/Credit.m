//
//  Credit.m
//  BaoMonkey
//
//  Created by iPPLE on 10/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Credit.h"

@implementation Credit

- (void) initBackground {
    SKSpriteNode *bg = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"credits-background"]];
    
    bg.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2,
                              [UIScreen mainScreen].bounds.size.height / 2);
    [self addChild:bg];
}

- (void) initLabel {
    SKLabelNode *title = [[SKLabelNode alloc] init];
    title.text = @"Developer";
    title.fontSize = 10.0;
    title.position = CGPointMake(50, 100);
    
    [self addChild:title];
}

- (instancetype) initWithSize:(CGSize)size andParentScene:(SKScene *)parentScene {
    self = [super initWithSize:size];
    
    if (self != nil) {
        [self initBackground];
        [self initLabel];
    }
    return (self);
}

- (void) popBubble:(NSTimeInterval)currentTime {
    static NSTimeInterval timer = 0;
    
    if (timer == 0) {
        timer = rand() % 2 + 1 + currentTime;
    }
    
    if (currentTime >= timer) {
        timer = rand() % 2 + 1 + currentTime;
    }
}

- (void) update:(NSTimeInterval)currentTime {
    
}

@end
