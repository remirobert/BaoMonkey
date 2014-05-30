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
        panel = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"background-panel-3buttons"] size:CGSizeMake(307, 421)];
        panel.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - (panel.size.height / 2));
        [self addChild:panel];
        
        resumeNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-play"] size:CGSizeMake(80, 80)];
        resumeNode.position = CGPointMake(163, 302);
        resumeNode.name = RESUME_NODE_NAME;
        [self addChild:resumeNode];
        
        replayNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-replay"] size:CGSizeMake(52, 52)];
        replayNode.position = CGPointMake(65, 191);
        replayNode.name = RETRY_NODE_NAME;
        [self addChild:replayNode];
        
        homeNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-home"] size:CGSizeMake(52, 52)];
        homeNode.position = CGPointMake(166, 191);
        homeNode.name = HOME_NODE_NAME;
        [self addChild:homeNode];
        
        settingsNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-settings"] size:CGSizeMake(52, 52)];
        settingsNode.position = CGPointMake(272, 191);
        settingsNode.name = SETTINGS_NODE_NAME;
        [self addChild:settingsNode];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:RESUME_NODE_NAME]) {
        [resumeNode setTexture:[SKTexture textureWithImageNamed:@"button-play-selected"]];
        [resumeNode setSize:CGSizeMake(97, 97)];
    }
    else if ([node.name isEqualToString:RETRY_NODE_NAME]) {
        [replayNode setTexture:[SKTexture textureWithImageNamed:@"button-replay-selected"]];
        [replayNode setSize:CGSizeMake(61, 61)];
    }
    else if ([node.name isEqualToString:HOME_NODE_NAME]) {
        [homeNode setTexture:[SKTexture textureWithImageNamed:@"button-home-selected"]];
        [homeNode setSize:CGSizeMake(61, 61)];
    }
    else if ([node.name isEqualToString:SETTINGS_NODE_NAME]) {
        [settingsNode setTexture:[SKTexture textureWithImageNamed:@"button-settings-selected"]];
        [settingsNode setSize:CGSizeMake(61, 61)];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [resumeNode setTexture:[SKTexture textureWithImageNamed:@"button-play"]];
    [resumeNode setSize:CGSizeMake(80, 80)];
    [replayNode setTexture:[SKTexture textureWithImageNamed:@"button-replay"]];
    [replayNode setSize:CGSizeMake(52, 52)];
    [homeNode setTexture:[SKTexture textureWithImageNamed:@"button-home"]];
    [homeNode setSize:CGSizeMake(52, 52)];
    [settingsNode setTexture:[SKTexture textureWithImageNamed:@"button-settings"]];
    [settingsNode setSize:CGSizeMake(52, 52)];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:RESUME_NODE_NAME]) {
        SKTransition *resumeTransition = [SKTransition pushWithDirection:SKTransitionDirectionLeft duration:0.5];
        [self.view presentScene:fromScene transition:resumeTransition];
        [(MyScene*)fromScene resumeGame];
        [resumeNode setTexture:[SKTexture textureWithImageNamed:@"button-play"]];
        [resumeNode setSize:CGSizeMake(80, 80)];
    }
    else if ([node.name isEqualToString:RETRY_NODE_NAME]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RETRY_GAME object:nil];
        [replayNode setTexture:[SKTexture textureWithImageNamed:@"button-replay"]];
        [replayNode setSize:CGSizeMake(52, 52)];
    }
    else if ([node.name isEqualToString:HOME_NODE_NAME]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GO_TO_HOME object:nil];
        [homeNode setTexture:[SKTexture textureWithImageNamed:@"button-home"]];
        [homeNode setSize:CGSizeMake(52, 52)];
    }
    else if ([node.name isEqualToString:SETTINGS_NODE_NAME]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GO_TO_SETTINGS object:nil];
        [settingsNode setTexture:[SKTexture textureWithImageNamed:@"button-settings"]];
        [settingsNode setSize:CGSizeMake(52, 52)];
    }
}

@end
