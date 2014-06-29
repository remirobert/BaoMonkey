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
#import "iAdController.h"
#import "BaoFontSize.h"

@implementation GameOverScene

-(id)initWithSize:(CGSize)size andScene:(SKScene*)scene{
    self = [super initWithSize:size];
    if (self) {
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background-right"];
        background.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        [self addChild:background];
        fromScene = scene;
        panel = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"panel-4-buttons"]];
        panel.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - (panel.size.height / 2));
        [self addChild:panel];
        
        replayNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"big-button-replay"]];
        replayNode.position = [BaoPosition bigButtonReplay];
        replayNode.name = RETRY_NODE_NAME;
        [self addChild:replayNode];
        
        homeNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-home"]];
        homeNode.position = [BaoPosition buttonHomeGameOver];
        homeNode.name = HOME_NODE_NAME;
        [self addChild:homeNode];
        
        gameCenterNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-game-center"]];
        gameCenterNode.position = [BaoPosition buttonGameCenterGameOver];
        gameCenterNode.name = GAMECENTER_NODE_NAME;
        [self addChild:gameCenterNode];
        
        shareNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-share"]];
        shareNode.position = [BaoPosition buttonShareGameOver];
        shareNode.name = SHARE_NODE_NAME;
        [self addChild:shareNode];
        
        settingsNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-settings"]];
        settingsNode.position = [BaoPosition buttonSettingsGameOver];
        settingsNode.name = SETTINGS_NODE_NAME;
        [self addChild:settingsNode];
        
        SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Ravie"];
        scoreLabel.fontColor = [SKColor whiteColor];
        scoreLabel.fontSize = [BaoFontSize scoreFontSize];
        scoreLabel.text = [NSString stringWithFormat:@"SCORE : %d", (int)[GameData getScore]];
        scoreNode = [[SKSpriteNode alloc] init];
        [scoreNode addChild:scoreLabel];
        scoreNode.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - (panel.size.height / 2));
        [self addChild:scoreNode];
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
    
    if ([node.name isEqualToString:RETRY_NODE_NAME]) {
        [replayNode setTexture:[SKTexture textureWithImageNamed:@"big-button-replay-selected"]];
    }
    else if ([node.name isEqualToString:HOME_NODE_NAME]) {
        [homeNode setTexture:[SKTexture textureWithImageNamed:@"button-home-selected"]];
    }
    else if ([node.name isEqualToString:SETTINGS_NODE_NAME]) {
        [settingsNode setTexture:[SKTexture textureWithImageNamed:@"button-settings-selected"]];
    }
    else if ([node.name isEqualToString:GAMECENTER_NODE_NAME]) {
        [gameCenterNode setTexture:[SKTexture textureWithImageNamed:@"button-game-center-selected"]];
    }
    else if ([node.name isEqualToString:SHARE_NODE_NAME]) {
        [shareNode setTexture:[SKTexture textureWithImageNamed:@"button-share-selected"]];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [replayNode setTexture:[SKTexture textureWithImageNamed:@"big-button-replay"]];
    [homeNode setTexture:[SKTexture textureWithImageNamed:@"button-home"]];
    [gameCenterNode setTexture:[SKTexture textureWithImageNamed:@"button-game-center"]];
    [shareNode setTexture:[SKTexture textureWithImageNamed:@"button-share"]];
    [settingsNode setTexture:[SKTexture textureWithImageNamed:@"button-settings"]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
   if ([node.name isEqualToString:RETRY_NODE_NAME]) {
        [iAdController hideADBanner];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RETRY_GAME object:nil];
        [replayNode setTexture:[SKTexture textureWithImageNamed:@"button-replay"]];
    }
    else if ([node.name isEqualToString:HOME_NODE_NAME]) {
        [iAdController hideADBanner];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GO_TO_HOME object:nil];
        [homeNode setTexture:[SKTexture textureWithImageNamed:@"button-home"]];
    }
    else if ([node.name isEqualToString:SETTINGS_NODE_NAME]) {
        [iAdController hideADBanner];
        [settingsNode setTexture:[SKTexture textureWithImageNamed:@"button-settings"]];
        [self.view presentScene:[[Settings alloc] initWithSize:self.size withParentScene:self] transition:[SKTransition pushWithDirection:SKTransitionDirectionUp duration:1.0]];
    }
    else if ([node.name isEqualToString:GAMECENTER_NODE_NAME]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_SHOW_GAME_CENTER object:nil];
        [gameCenterNode setTexture:[SKTexture textureWithImageNamed:@"button-game-center"]];
    }
    else if ([node.name isEqualToString:SHARE_NODE_NAME]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_share_score" object:nil];
        [shareNode setTexture:[SKTexture textureWithImageNamed:@"button-share"]];
    }
}

@end
