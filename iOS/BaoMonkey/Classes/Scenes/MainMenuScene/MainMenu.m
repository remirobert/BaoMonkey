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
    
    panel = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"panel-4buttons"]];
    panel.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - (panel.size.height / 2));
    [self addChild:panel];
    
    playNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-play"] size:CGSizeMake(80, 80)];
    playNode.position = CGPointMake(164, 306);
    playNode.name = RESUME_NODE_NAME;
    [self addChild:playNode];
    
    settingsNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-settings"] size:CGSizeMake(52, 52)];
    settingsNode.position = CGPointMake(69.5, 200);
    settingsNode.name = SETTINGS_NODE_NAME;
    [self addChild:settingsNode];
    
    gameCenterNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-gamecenter"] size:CGSizeMake(52, 52)];
    gameCenterNode.position = CGPointMake(137, 200);
    gameCenterNode.name = GAMECENTER_NODE_NAME;
    [self addChild:gameCenterNode];
    
    shareNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-share"] size:CGSizeMake(52, 52)];
    shareNode.position = CGPointMake(204, 200);
    shareNode.name = SHARE_NODE_NAME;
    [self addChild:shareNode];
    
    infosNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"button-infos"] size:CGSizeMake(52, 52)];
    infosNode.position = CGPointMake(269.5, 200);
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
        [playNode setSize:CGSizeMake(97, 97)];
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
    else if ([node.name isEqualToString:INFOS_NODE_NAME]) {
        [infosNode setTexture:[SKTexture textureWithImageNamed:@"button-infos-selected"]];
        [infosNode setSize:CGSizeMake(61, 61)];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [playNode setTexture:[SKTexture textureWithImageNamed:@"button-play"]];
    [playNode setSize:CGSizeMake(80, 80)];
    [settingsNode setTexture:[SKTexture textureWithImageNamed:@"button-settings"]];
    [settingsNode setSize:CGSizeMake(52, 52)];
    [gameCenterNode setTexture:[SKTexture textureWithImageNamed:@"button-gamecenter"]];
    [gameCenterNode setSize:CGSizeMake(52, 52)];
    [shareNode setTexture:[SKTexture textureWithImageNamed:@"button-share"]];
    [shareNode setSize:CGSizeMake(52, 52)];
    [infosNode setTexture:[SKTexture textureWithImageNamed:@"button-infos"]];
    [infosNode setSize:CGSizeMake(52, 52)];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:RESUME_NODE_NAME]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_START_GAME object:nil];
    }
    else if ([node.name isEqualToString:SETTINGS_NODE_NAME]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GO_TO_SETTINGS object:nil];
    }
    else if ([node.name isEqualToString:GAMECENTER_NODE_NAME]) {
        // Launch GameCenter
    }
    else if ([node.name isEqualToString:SHARE_NODE_NAME]) {
        // Launch Sharing
    }
    else if ([node.name isEqualToString:INFOS_NODE_NAME]) {
        // Launch Infos
    }
}


@end
