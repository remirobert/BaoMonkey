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
#import "Settings.h"
#import "iADController.h"

@implementation PauseScene

-(id)initWithSize:(CGSize)size andScene:(SKScene*)scene{
    self = [super initWithSize:size];
    if (self) {
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background-right"];
        background.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        [self addChild:background];
        fromScene = scene;
        panel = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"panel-3-buttons"]];
        panel.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - (panel.size.height / 2));
        [self addChild:panel];
        
        resumeNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"big-button-play"]];
        resumeNode.position = [BaoPosition bigButtonPlay];
        resumeNode.name = RESUME_NODE_NAME;
        [self addChild:resumeNode];
        
        replayNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-replay"]];
        replayNode.position = [BaoPosition buttonReplayPause];
        replayNode.name = RETRY_NODE_NAME;
        [self addChild:replayNode];
        
        homeNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-home"]];
        homeNode.position = [BaoPosition buttonHomePause];
        homeNode.name = HOME_NODE_NAME;
        [self addChild:homeNode];
        
        settingsNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-settings"]];
        settingsNode.position = [BaoPosition buttonSettingsPause];
        settingsNode.name = SETTINGS_NODE_NAME;
        [self addChild:settingsNode];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SHOW_AD object:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:RESUME_NODE_NAME]) {
        [resumeNode setTexture:[SKTexture textureWithImageNamed:@"big-button-play-selected"]];
    }
    else if ([node.name isEqualToString:RETRY_NODE_NAME]) {
        [replayNode setTexture:[SKTexture textureWithImageNamed:@"button-replay-selected"]];
    }
    else if ([node.name isEqualToString:HOME_NODE_NAME]) {
        [homeNode setTexture:[SKTexture textureWithImageNamed:@"button-home-selected"]];
    }
    else if ([node.name isEqualToString:SETTINGS_NODE_NAME]) {
        [settingsNode setTexture:[SKTexture textureWithImageNamed:@"button-settings-selected"]];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [resumeNode setTexture:[SKTexture textureWithImageNamed:@"big-button-play"]];
    [replayNode setTexture:[SKTexture textureWithImageNamed:@"button-replay"]];
    [homeNode setTexture:[SKTexture textureWithImageNamed:@"button-home"]];
    [settingsNode setTexture:[SKTexture textureWithImageNamed:@"button-settings"]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:RESUME_NODE_NAME]) {
        [iAdController hideADBanner];
        [resumeNode setTexture:[SKTexture textureWithImageNamed:@"big-button-play"]];
        SKTransition *resumeTransition = [SKTransition pushWithDirection:SKTransitionDirectionRight duration:0.5];
        [self.view presentScene:fromScene transition:resumeTransition];
        [(MyScene*)fromScene resumeGame];
    }
    else if ([node.name isEqualToString:RETRY_NODE_NAME]) {
        [iAdController hideADBanner];
        [replayNode setTexture:[SKTexture textureWithImageNamed:@"button-replay"]];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RETRY_GAME object:nil];
    }
    else if ([node.name isEqualToString:HOME_NODE_NAME]) {
        [iAdController hideADBanner];
        [homeNode setTexture:[SKTexture textureWithImageNamed:@"button-home"]];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GO_TO_HOME object:nil];
    }
    else if ([node.name isEqualToString:SETTINGS_NODE_NAME]) {
        [iAdController hideADBanner];
        [settingsNode setTexture:[SKTexture textureWithImageNamed:@"button-settings"]];
        [self.view presentScene:[[Settings alloc] initWithSize:self.size withParentScene:self] transition:[SKTransition pushWithDirection:SKTransitionDirectionUp duration:1.0]];

    }
}

@end
