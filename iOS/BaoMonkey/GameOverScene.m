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

@implementation GameOverScene

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
        
        replayNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-replay"] size:CGSizeMake(52, 52)];
        replayNode.position = CGPointMake(224, 380);
        replayNode.name = RETRY_NODE_NAME;
        [self addChild:replayNode];
        
        homeNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-home"] size:CGSizeMake(52, 52)];
        homeNode.position = CGPointMake(102, 270);
        homeNode.name = HOME_NODE_NAME;
        [self addChild:homeNode];
        
        settingsNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-settings"] size:CGSizeMake(52, 52)];
        settingsNode.position = CGPointMake(224, 270);
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
        [replayNode setSize:CGSizeMake(66, 66)];
    }
    else if ([node.name isEqualToString:HOME_NODE_NAME]) {
        [homeNode setTexture:[SKTexture textureWithImageNamed:@"button-home-selected"]];
        [homeNode setSize:CGSizeMake(66, 66)];
    }
    else if ([node.name isEqualToString:SETTINGS_NODE_NAME]) {
        [settingsNode setTexture:[SKTexture textureWithImageNamed:@"button-settings-selected"]];
        [settingsNode setSize:CGSizeMake(66, 66)];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
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
    
   if ([node.name isEqualToString:RETRY_NODE_NAME]) {
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
