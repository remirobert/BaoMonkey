//
//  ProgressBar.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "ProgressBar.h"

@implementation ProgressBar

@synthesize position, size, cornerRadius, backgroundColor, frontColor, background, front;

-(id)initWithPosition:(CGPoint)p andSize:(CGSize)s {
    self = [super init];

    if (self) {
        position = CGPointMake(p.x, p.y);
        size = CGSizeMake(s.width, s.height);
    }
    
    return self;
}

-(void)createBackground {
    if (backgroundColor != nil) {
        background = [SKSpriteNode spriteNodeWithColor:backgroundColor size:size];
    } else {
        background = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:size];
    }
    background.position = position;
}

-(void)createFront {
    if (frontColor != nil) {
        front = [SKSpriteNode spriteNodeWithColor:frontColor size:CGSizeMake(0, background.size.height - 5)];
    } else {
        front = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(0, background.size.height - 5)];
    }
    front.anchorPoint = CGPointMake(0, 0.5);
    front.position = CGPointMake(background.position.x - (background.size.width / 2) + 2.5, position.y);
}

-(void)updateProgression:(CGFloat)progress {
    if (progress > 0 && progress < 100) {
        CGFloat percentProgress = ((background.size.width - 5) * progress) / 100;
        front.size = CGSizeMake(percentProgress, front.size.height);
    }
}

@end
