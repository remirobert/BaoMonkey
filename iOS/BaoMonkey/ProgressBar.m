//
//  ProgressBar.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "ProgressBar.h"

@implementation ProgressBar

@synthesize position, size, background, front, progress;

-(id)initWithPosition:(CGPoint)p andSize:(CGSize)s {
    self = [super init];

    if (self) {
        position = CGPointMake(p.x, p.y);
        size = CGSizeMake(s.width, s.height);
    }
    return self;
}

-(void)createBackground {
    background = [SKSpriteNode node];
    background.position = position;
}

-(void)createFront {
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"front-progress-bar"];
    SKCropNode *crop = [SKCropNode node];
    SKShapeNode *mask = [SKShapeNode node];
    
    [mask setPath:CGPathCreateWithRoundedRect(CGRectMake(node.frame.origin.x, node.frame.origin.y, node.frame.size.width, node.frame.size.height),
                                              node.frame.size.width / 2,
                                              node.frame.size.height / 2,
                                              nil)];
    [mask setFillColor:[SKColor blackColor]];
    [crop setMaskNode:mask];
    [crop addChild:node];
    front = [SKSpriteNode node];
    [front addChild:crop];
    front.anchorPoint = CGPointMake(0, 0.5);
    front.position = CGPointMake(background.position.x - (background.size.width + 2) + 2.5, position.y);
}

-(void)updateProgression:(CGFloat)p {
    /*if (p > 0 && p < 100) {
        CGFloat percentProgress = ((background.size.width - 5) * p) / 100;
        front.size = CGSizeMake(percentProgress, front.size.height);
    }*/
}

@end
