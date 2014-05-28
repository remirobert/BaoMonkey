//
//  PauseScene.m
//  BaoMonkey
//
//  Created by Rémi Hillairet on 26/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "PauseScene.h"
#import "Define.h"
#import "MyScene.h"

@implementation PauseScene

-(id)initWithSize:(CGSize)size andScene:(SKScene*)scene{
    self = [super initWithSize:size];
    if (self) {
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background-menu"];
        background.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        [self addChild:background];
        fromScene = scene;
        panel = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"background-button"] size:CGSizeMake(306, 375)];
        panel.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - (panel.size.height / 2));
        [self addChild:panel];
        
        SKSpriteNode *resumeNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-play"] size:CGSizeMake(66, 66)];
        resumeNode.position = CGPointMake(103, 380);
        resumeNode.name = RESUME_NODE_NAME;
        [self addChild:resumeNode];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:RESUME_NODE_NAME]) {
        SKTransition *resumeTransition = [SKTransition doorwayWithDuration:1.0];
        [self.view presentScene:fromScene transition:resumeTransition];
        [(MyScene*)fromScene resumeGame];
    }
}

@end
