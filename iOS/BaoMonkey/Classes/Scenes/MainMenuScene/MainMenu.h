//
//  MainMenu.h
//  BaoMonkey
//
//  Created by iPPLE on 27/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>

@interface MainMenu : SKScene {
    SKSpriteNode *background;
    SKSpriteNode *panel;
    SKSpriteNode *playNode;
    SKSpriteNode *settingsNode;
    SKSpriteNode *gameCenterNode;
    SKSpriteNode *shareNode;
    SKSpriteNode *infosNode;
    SKSpriteNode *monkey;
    SKSpriteNode *multiPlayer;
    NSArray *monkeyFrames;
}

- (instancetype) initWithSize:(CGSize)size;

@end
