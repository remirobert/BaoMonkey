//
//  PauseScene.h
//  BaoMonkey
//
//  Created by Rémi Hillairet on 26/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PauseScene : SKScene {
    SKSpriteNode *panel;
    SKSpriteNode *resumeNode;
    SKSpriteNode *replayNode;
    SKSpriteNode *homeNode;
    SKSpriteNode *settingsNode;
    SKScene *fromScene;
}

-(id)initWithSize:(CGSize)size andScene:(SKScene*)scene;

@end
