//
//  GameOverScene.m
//  BaoMonkey
//
//  Created by Rémi Hillairet on 26/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "GameOverScene.h"
#import "Define.h"
#import "MyScene.h"
#import "Settings.h"

@implementation GameOverScene

-(id)initWithSize:(CGSize)size andScene:(SKScene*)scene{
    self = [super initWithSize:size];
    if (self) {
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background-right"];
        background.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        [self addChild:background];
        fromScene = scene;
        panel = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"panel-4buttons"]];
        panel.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - (panel.size.height / 2));
        [self addChild:panel];
        
        replayNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-replay"] size:CGSizeMake(80, 80)];
        replayNode.position = CGPointMake(164, 306);
        replayNode.name = RETRY_NODE_NAME;
        [self addChild:replayNode];
        
        homeNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-home"] size:CGSizeMake(52, 52)];
        homeNode.position = CGPointMake(69.5, 200);
        homeNode.name = HOME_NODE_NAME;
        [self addChild:homeNode];
        
        gameCenterNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-gamecenter"] size:CGSizeMake(52, 52)];
        gameCenterNode.position = CGPointMake(137, 200);
        gameCenterNode.name = GAMECENTER_NODE_NAME;
        [self addChild:gameCenterNode];
        
        shareNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-share"] size:CGSizeMake(52, 52)];
        shareNode.position = CGPointMake(204, 200);
        shareNode.name = SHARE_NODE_NAME;
        [self addChild:shareNode];
        
        settingsNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-settings"] size:CGSizeMake(52, 52)];
        settingsNode.position = CGPointMake(269.5, 200);
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
    
    if ([node.name isEqualToString:RETRY_NODE_NAME]) {
        [replayNode setTexture:[SKTexture textureWithImageNamed:@"button-replay-selected"]];
        [replayNode setSize:CGSizeMake(97, 97)];
    }
    else if ([node.name isEqualToString:HOME_NODE_NAME]) {
        [homeNode setTexture:[SKTexture textureWithImageNamed:@"button-home-selected"]];
        [homeNode setSize:CGSizeMake(61, 61)];
    }
    else if ([node.name isEqualToString:SETTINGS_NODE_NAME]) {
        [settingsNode setTexture:[SKTexture textureWithImageNamed:@"button-settings-selected"]];
        [settingsNode setSize:CGSizeMake(61, 61)];
    }
    else if ([node.name isEqualToString:GAMECENTER_NODE_NAME]) {
        [gameCenterNode setTexture:[SKTexture textureWithImageNamed:@"button-gamecenter-selected"]];
        [gameCenterNode setSize:CGSizeMake(61, 61)];
    }
    else if ([node.name isEqualToString:SHARE_NODE_NAME]) {
        [shareNode setTexture:[SKTexture textureWithImageNamed:@"button-share-selected"]];
        [shareNode setSize:CGSizeMake(61, 61)];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [replayNode setTexture:[SKTexture textureWithImageNamed:@"button-replay"]];
    [replayNode setSize:CGSizeMake(80, 80)];
    [homeNode setTexture:[SKTexture textureWithImageNamed:@"button-home"]];
    [homeNode setSize:CGSizeMake(52, 52)];
    [gameCenterNode setTexture:[SKTexture textureWithImageNamed:@"button-gamecenter"]];
    [gameCenterNode setSize:CGSizeMake(52, 52)];
    [shareNode setTexture:[SKTexture textureWithImageNamed:@"button-share"]];
    [shareNode setSize:CGSizeMake(52, 52)];
    [settingsNode setTexture:[SKTexture textureWithImageNamed:@"button-settings"]];
    [settingsNode setSize:CGSizeMake(52, 52)];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
   if ([node.name isEqualToString:RETRY_NODE_NAME]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RETRY_GAME object:nil];
        [replayNode setTexture:[SKTexture textureWithImageNamed:@"button-replay"]];
        [replayNode setSize:CGSizeMake(80, 80)];
    }
    else if ([node.name isEqualToString:HOME_NODE_NAME]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GO_TO_HOME object:nil];
        [homeNode setTexture:[SKTexture textureWithImageNamed:@"button-home"]];
        [homeNode setSize:CGSizeMake(52, 52)];
    }
    else if ([node.name isEqualToString:SETTINGS_NODE_NAME]) {
        [settingsNode setTexture:[SKTexture textureWithImageNamed:@"button-settings"]];
        [settingsNode setSize:CGSizeMake(52, 52)];
        [self.view presentScene:[[Settings alloc] initWithSize:self.size withParentScene:self] transition:[SKTransition fadeWithDuration:1.0]];
    }
    else if ([node.name isEqualToString:GAMECENTER_NODE_NAME]) {
        // Call GameCenter
    }
    else if ([node.name isEqualToString:SHARE_NODE_NAME]) {
        // Call Sharing
    }
}

@end
