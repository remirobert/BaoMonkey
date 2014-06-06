//
//  MainMenu.m
//  BaoMonkey
//
//  Created by iPPLE on 27/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "MainMenu.h"
#import "Define.h"
#import "PreloadData.h"
#import "Settings.h"
#import "BaoPosition.h"

@interface MainMenu ()
@end

@implementation MainMenu

- (instancetype) initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    
    if (self != nil) {
        self.backgroundColor = [SKColor redColor];
        
        static bool onceToken = TRUE;
        if (onceToken) {
            [self displayLoadingScreen];
            [self performSelector:@selector(initMainMenu) withObject:nil afterDelay:2.0];
            onceToken = FALSE;
        }
        else {
            [self initMainMenu];
        }

    }
    return (self);
}

- (void)displayLoadingScreen {
    SKSpriteNode *splashScreenNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"LaunchImage-700-568h"]];
    splashScreenNode.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
    [self addChild:splashScreenNode];
}

-(void)initMainMenu {
    [self removeAllChildren];
    
    background = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"background-left"]];
    background.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
    [self addChild:background];
    
    panel = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"panel-4-buttons"]];
    panel.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - (panel.size.height / 2));
    [self addChild:panel];
    
    playNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"big-button-play"]];
    playNode.position = [BaoPosition bigButtonPlay];
    playNode.name = RESUME_NODE_NAME;
    [self addChild:playNode];
    
    settingsNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-settings"]];
    settingsNode.position = [BaoPosition buttonSettingsMainMenu];
    settingsNode.name = SETTINGS_NODE_NAME;
    [self addChild:settingsNode];
    
    gameCenterNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-game-center"]];
    gameCenterNode.position = [BaoPosition buttonGameCenterMainMenu];
    gameCenterNode.name = GAMECENTER_NODE_NAME;
    [self addChild:gameCenterNode];
    
    shareNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-share"]];
    shareNode.position = [BaoPosition buttonShareMainMenu];
    shareNode.name = SHARE_NODE_NAME;
    [self addChild:shareNode];
    
    infosNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-informations"]];
    infosNode.position = [BaoPosition buttonInformationsMainMenu];
    infosNode.name = INFOS_NODE_NAME;
    [self addChild:infosNode];
    
    [self loadMonkeyAnimation];
    
    monkey = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"monkey-menu-1"] size:CGSizeMake(200, 197)];
    monkey.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - (monkey.size.height / 2));
    [self addChild:monkey];
    
    //[monkey runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:monkeyFrames timePerFrame:0.5f resize:NO restore:NxO]]];
}

-(void)loadMonkeyAnimation {
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    SKTextureAtlas *atlas = [PreloadData getDataWithKey:DATA_MONKEY_MENU_ATLAS];
    NSUInteger numberOfFrames = atlas.textureNames.count;
    
    for (int i = 1; i <= numberOfFrames; i++) {
        NSString *textureName = [NSString stringWithFormat:@"monkey-menu-%d", i];
        SKTexture *tmp = [atlas textureNamed:textureName];
        [frames addObject:tmp];
    }
    monkeyFrames = [[NSArray alloc] initWithArray:frames];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:RESUME_NODE_NAME]) {
        [playNode setTexture:[SKTexture textureWithImageNamed:@"button-play-selected"]];
    } else if ([node.name isEqualToString:SETTINGS_NODE_NAME]) {
        [settingsNode setTexture:[SKTexture textureWithImageNamed:@"button-settings-selected"]];
    } else if ([node.name isEqualToString:GAMECENTER_NODE_NAME]) {
        [gameCenterNode setTexture:[SKTexture textureWithImageNamed:@"button-game-center-selected"]];
    } else if ([node.name isEqualToString:SHARE_NODE_NAME]) {
        [shareNode setTexture:[SKTexture textureWithImageNamed:@"button-share-selected"]];
    } else if ([node.name isEqualToString:INFOS_NODE_NAME]) {
        [infosNode setTexture:[SKTexture textureWithImageNamed:@"button-infos-selected"]];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [playNode setTexture:[SKTexture textureWithImageNamed:@"button-play"]];
    [settingsNode setTexture:[SKTexture textureWithImageNamed:@"button-settings"]];
    [gameCenterNode setTexture:[SKTexture textureWithImageNamed:@"button-game-center"]];
    [shareNode setTexture:[SKTexture textureWithImageNamed:@"button-share"]];
    [infosNode setTexture:[SKTexture textureWithImageNamed:@"button-infos"]];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:RESUME_NODE_NAME]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_START_GAME object:nil];
    } else if ([node.name isEqualToString:SETTINGS_NODE_NAME]) {
        [self.view presentScene:[[Settings alloc] initWithSize:self.size withParentScene:self] transition:[SKTransition fadeWithDuration:1.0]];
    } else if ([node.name isEqualToString:GAMECENTER_NODE_NAME]) {
        // Launch GameCenter
    } else if ([node.name isEqualToString:SHARE_NODE_NAME]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notification_share" object:nil];
    } else if ([node.name isEqualToString:INFOS_NODE_NAME]) {
        // Launch Infos
    }
}


@end
