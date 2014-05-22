//
//  LeafTransition.m
//  BaoMonkey
//
//  Created by Rémi Hillairet on 20/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "LeafTransition.h"
#import "GameData.h"
#import "Define.h"
#import "BaoButton.h"
#import "UserData.h"
#import "Resume.h"

#define ANIMATION_SPEED    20

@implementation LeafTransition

-(id)initWithScene:(SKScene*)_scene{
    self = [super init];
    if (self) {
        scene = _scene;
        upLeaf = [SKSpriteNode spriteNodeWithImageNamed:@"up-leaf"];
        upLeaf.position = CGPointMake(-(upLeaf.size.width / 2), SCREEN_HEIGHT + (upLeaf.size.height / 2));
        bottomLeaf = [SKSpriteNode spriteNodeWithImageNamed:@"bottom-leaf"];
        bottomLeaf.position = CGPointMake(SCREEN_WIDTH + (bottomLeaf.size.width / 2), -(bottomLeaf.size.height / 2));
        upLeaf.zPosition = 998;
        bottomLeaf.zPosition = 998;
        bottomLeaf.name = @"LEAF_BOTTOM";
        upLeaf.name = @"LEAF_UP";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidePauseMenu) name:NOTIFICATION_RESUME_GAME object:nil];
        pauseButton = [[NSArray alloc] initWithObjects:[BaoButton replay], [BaoButton play], [BaoButton home], [BaoButton settings], [BaoButton pauseLabel], nil];
        gameOverButton = [[NSArray alloc] initWithObjects:[Resume gameOverNode], [Resume replayNode], nil];
    }
    return self;
}

-(void)showPauseLeafs {
    upLeaf.position = CGPointMake(upLeaf.position.x + ANIMATION_SPEED, upLeaf.position.y - ANIMATION_SPEED);
    bottomLeaf.position = CGPointMake(bottomLeaf.position.x - ANIMATION_SPEED, bottomLeaf.position.y + ANIMATION_SPEED);
    if ((bottomLeaf.position.x > (SCREEN_WIDTH / 2)) && (upLeaf.position.x < (SCREEN_WIDTH / 2))) {
        [self performSelector:@selector(showPauseLeafs) withObject:nil afterDelay:0.016];
    }
    else {
        for (SKSpriteNode *node in pauseButton) {
            node.zPosition = 999;
            if (node.parent != nil){
                [node removeFromParent];
            }
            [scene addChild:node];
        }
    }
}

-(void)showGameOverLeafs {
    upLeaf.position = CGPointMake(upLeaf.position.x + ANIMATION_SPEED, upLeaf.position.y - ANIMATION_SPEED);
    bottomLeaf.position = CGPointMake(bottomLeaf.position.x - ANIMATION_SPEED, bottomLeaf.position.y + ANIMATION_SPEED);
    if ((bottomLeaf.position.x > (SCREEN_WIDTH / 2)) && (upLeaf.position.x < (SCREEN_WIDTH / 2))) {
        [self performSelector:@selector(showGameOverLeafs) withObject:nil afterDelay:0.016];
    }
    else {
        [UserData updateScore:[GameData getScore]];
        for (SKSpriteNode *node in gameOverButton) {
            
            // Temporarily
            
            if ([node.name isEqualToString:RETRY_NODE_NAME])
                node.position = CGPointMake(node.position.x, SCREEN_HEIGHT / 2 - (node.size.height / 2));
            
            // End temporarily
            
            node.zPosition = 999;
            if (node.parent == nil)
                [scene addChild:node];
        }
    }
}

-(void)runPauseTransition {
    if (![GameData isPause]) {
        if (upLeaf.parent == nil) {
            [scene addChild:upLeaf];
        }
        if (bottomLeaf.parent == nil) {
            [scene addChild:bottomLeaf];
        }
        [self showPauseLeafs];
    }
}

-(void)runGameOverTransition {
    if (![GameData isPause] && ![GameData isGameOver]) {
        if (upLeaf.parent == nil) {
            [scene addChild:upLeaf];
        }
        if (bottomLeaf.parent == nil) {
            [scene addChild:bottomLeaf];
        }
        [self showGameOverLeafs];
    }
}

-(void)hideLeafs {
    upLeaf.position = CGPointMake(upLeaf.position.x - ANIMATION_SPEED, upLeaf.position.y + ANIMATION_SPEED);
    bottomLeaf.position = CGPointMake(bottomLeaf.position.x + ANIMATION_SPEED, bottomLeaf.position.y - ANIMATION_SPEED);
    if ((bottomLeaf.position.x < (SCREEN_WIDTH + (bottomLeaf.size.width / 2))) && (upLeaf.position.x > -(upLeaf.size.width / 2))) {
        [self performSelector:@selector(hideLeafs) withObject:nil afterDelay:0.016];
    }
    else {
        [upLeaf removeFromParent];
        [bottomLeaf removeFromParent];
    }
}

-(void)hidePauseMenu {
    [scene removeChildrenInArray:pauseButton];
    [self hideLeafs];
}

@end
