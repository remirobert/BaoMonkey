//
//  BaoButton.m
//  BaoMonkey
//
//  Created by Rémi Hillairet on 22/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "BaoButton.h"
#import "Define.h"
#import "PreloadData.h"

# define MARGIN 20

@implementation BaoButton

+(SKSpriteNode*)play {
    SKSpriteNode *node;
    CGSize nodeSize;
    CGPoint positionNode;
    
    if (IPAD){
        nodeSize = CGSizeMake(0, 0);
        positionNode = CGPointMake(SCREEN_WIDTH / 4, 2.2 * (SCREEN_HEIGHT / 4));
    }
    else {
        nodeSize = CGSizeMake(66, 100);
        positionNode = CGPointMake(SCREEN_WIDTH / 4, 2.2 * (SCREEN_HEIGHT / 4));
    }
    node = [SKSpriteNode spriteNodeWithTexture:[PreloadData getDataWithKey:DATA_BUTTON_PLAY] size:nodeSize];
    node.position = positionNode;
    node.name = RESUME_NODE_NAME;
    return node;
}

+(SKSpriteNode*)pause {
    SKSpriteNode *node;
    CGSize nodeSize;
    CGPoint positionNode;
    
    if (IPAD){
        nodeSize = CGSizeMake(0, 0);
        positionNode = CGPointMake(SCREEN_WIDTH - (nodeSize.width / 2), SCREEN_HEIGHT);
    }
    else {
        nodeSize = CGSizeMake(50, 82);
        positionNode = CGPointMake(SCREEN_WIDTH - (nodeSize.width / 2), SCREEN_HEIGHT);
    }
    node = [SKSpriteNode spriteNodeWithTexture:[PreloadData getDataWithKey:DATA_BUTTON_PAUSE] size:nodeSize];
    node.position = positionNode;
    node.name = PAUSE_BUTTON_NODE_NAME;
    return node;
}

+(SKLabelNode*)pauseLabel {
    SKLabelNode *label = [[SKLabelNode alloc] initWithFontNamed:@"ChalkboardSE-Regular"];
    label.fontSize = 50;
    label.text = @"PAUSE";
    label.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - (SCREEN_HEIGHT / 6));
    return label;
}

+(SKSpriteNode*)replay {
    SKSpriteNode *node;
    CGSize nodeSize;
    CGPoint positionNode;
    
    if (IPAD){
        nodeSize = CGSizeMake(0, 0);
        positionNode = CGPointMake(3 * (SCREEN_WIDTH / 4), 2.2 * (SCREEN_HEIGHT / 4));
    }
    else {
        nodeSize = CGSizeMake(124, 100);
        positionNode = CGPointMake(3 * (SCREEN_WIDTH / 4), 2.2 * (SCREEN_HEIGHT / 4));
    }
    node = [SKSpriteNode spriteNodeWithTexture:[PreloadData getDataWithKey:DATA_BUTTON_REPLAY] size:nodeSize];
    node.position = positionNode;
    node.name = RETRY_NODE_NAME;
    return node;
}

+(SKSpriteNode*)home {
    SKSpriteNode *node;
    CGSize nodeSize;
    CGPoint positionNode;
    
    if (IPAD){
        nodeSize = CGSizeMake(0, 0);
        positionNode = CGPointMake(SCREEN_WIDTH / 4, SCREEN_HEIGHT / 4);
    }
    else {
        nodeSize = CGSizeMake(81, 100);
        positionNode = CGPointMake(SCREEN_WIDTH / 4, SCREEN_HEIGHT / 4);
    }
    node = [SKSpriteNode spriteNodeWithTexture:[PreloadData getDataWithKey:DATA_BUTTON_HOME] size:nodeSize];
    node.position = positionNode;
    node.name = HOME_NODE_NAME;
    return node;
}

+(SKSpriteNode*)settings {
    SKSpriteNode *node;
    CGSize nodeSize;
    CGPoint positionNode;
    
    if (IPAD){
        nodeSize = CGSizeMake(0, 0);
        positionNode = CGPointMake(3 * (SCREEN_WIDTH / 4), SCREEN_HEIGHT / 4);
    }
    else {
        nodeSize = CGSizeMake(100, 100);
        positionNode = CGPointMake(3 * (SCREEN_WIDTH / 4), SCREEN_HEIGHT / 4);
    }
    node = [SKSpriteNode spriteNodeWithTexture:[PreloadData getDataWithKey:DATA_BUTTON_SETTINGS] size:nodeSize];
    node.position = positionNode;
    node.name = SETTINGS_NODE_NAME;
    return node;
}

@end
