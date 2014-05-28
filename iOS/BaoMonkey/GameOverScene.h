//
//  GameOverScene.h
//  BaoMonkey
//
//  Created by Rémi Hillairet on 26/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameOverScene : SKScene {
    SKSpriteNode *panel;
    SKSpriteNode *replayNode;
    SKSpriteNode *homeNode;
    SKSpriteNode *settingsNode;
    SKScene *fromScene;
}

-(id)initWithSize:(CGSize)size andScene:(SKScene*)scene;

@end
