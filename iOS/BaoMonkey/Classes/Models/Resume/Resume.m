//
//  Resume.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 20/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Resume.h"

@implementation Resume

static Resume *singleton;

+(id)singleton {
    if (!singleton) {
        singleton = [[Resume alloc] init];
    }
    return singleton;
}

+(SKSpriteNode *)backgroundNode{
    return [[Resume singleton] backgroundNode];
}

-(SKSpriteNode *)backgroundNode{
    SKSpriteNode *node = [[SKSpriteNode alloc] initWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]
                                                        size:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    node.anchorPoint = CGPointMake(0, 0);
    node.position = CGPointMake(0, 0);
    return node;
}

+(SKSpriteNode *)replayNode{
    return [[Resume singleton] replayNode];
}

-(SKSpriteNode *)replayNode{
    SKLabelNode *label = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    label.text = @"Replay";
    label.name = RETRY_NODE_NAME;
    
    SKSpriteNode *node = [[SKSpriteNode alloc] init];
    node.anchorPoint = CGPointMake(0, 0);
    node.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 200);
    [node addChild:label];
    
    return node;
}

+(SKSpriteNode *)resumeNode{
    return [[Resume singleton] resumeNode];
}

-(SKSpriteNode *)resumeNode{
    SKLabelNode *label = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    label.text = @"Resume";
    label.name = RESUME_NODE_NAME;
    
    SKSpriteNode *node = [[SKSpriteNode alloc] init];
    node.anchorPoint = CGPointMake(0, 0);
    node.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 250);
    [node addChild:label];
    
    return node;
}

+(SKSpriteNode *)homeNode{
    return [[Resume singleton] homeNode];
}

-(SKSpriteNode *)homeNode{
    SKLabelNode *label = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    label.text = @"Home";
    label.name = HOME_NODE_NAME;
    
    SKSpriteNode *node = [[SKSpriteNode alloc] init];
    node.anchorPoint = CGPointMake(0, 0);
    node.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 300);
    [node addChild:label];
    
    return node;
}

+(SKSpriteNode *)settingsNode{
    return [[Resume singleton] settingsNode];
}

-(SKSpriteNode *)settingsNode{
    SKLabelNode *label = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    label.text = @"Settings";
    label.name = SETTINGS_NODE_NAME;
    
    SKSpriteNode *node = [[SKSpriteNode alloc] init];
    node.anchorPoint = CGPointMake(0, 0);
    node.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 350);
    [node addChild:label];
    
    return node;
}

-(SKSpriteNode *)gameOverNode {
    SKLabelNode *label = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    label.text = @"Game Over";
    label.name = GAMEOVER_NODE_NAME;
    label.fontSize = 40;
    
    SKSpriteNode *node = [[SKSpriteNode alloc] init];
    node.anchorPoint = CGPointMake(0, 0);
    node.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 100);
    [node addChild:label];
    
    return node;
}

+(SKSpriteNode *)gameOverNode {
    return [[Resume singleton] gameOverNode];
}

@end
