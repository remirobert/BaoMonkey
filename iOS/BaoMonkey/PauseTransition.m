//
//  PauseTransition.m
//  BaoMonkey
//
//  Created by Rémi Hillairet on 20/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "PauseTransition.h"
#import "GameData.h"
#import "Define.h"
#import "Resume.h"

#define ANIMATION_SPEED    20

@implementation PauseTransition

-(id)init {
    self = [super init];
    if (self) {
        upLeaf = [SKSpriteNode spriteNodeWithImageNamed:@"up-leaf"];
        upLeaf.position = CGPointMake(-(upLeaf.size.width / 2), SCREEN_HEIGHT + (upLeaf.size.height / 2));
        bottomLeaf = [SKSpriteNode spriteNodeWithImageNamed:@"bottom-leaf"];
        bottomLeaf.position = CGPointMake(SCREEN_WIDTH + (bottomLeaf.size.width / 2), -(bottomLeaf.size.height / 2));
        upLeaf.zPosition = 998;
        bottomLeaf.zPosition = 998;
        bottomLeaf.name = @"LEAF";
        upLeaf.name = @"LEAF";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidePauseMenu) name:NOTIFICATION_RESUME_GAME object:nil];
        pauseButton = [[NSArray alloc] initWithObjects:[Resume replayNode], [Resume resumeNode], [Resume homeNode], [Resume settingsNode], nil];
    }
    return self;
}

-(void)showLeafs {
    upLeaf.position = CGPointMake(upLeaf.position.x + ANIMATION_SPEED, upLeaf.position.y - ANIMATION_SPEED);
    bottomLeaf.position = CGPointMake(bottomLeaf.position.x - ANIMATION_SPEED, bottomLeaf.position.y + ANIMATION_SPEED);
    if ((bottomLeaf.position.y < (SCREEN_HEIGHT / 4)) && (upLeaf.position.y > (3 * (SCREEN_HEIGHT / 4)))) {
        [self performSelector:@selector(showLeafs) withObject:nil afterDelay:0.016];
    }
    else {
        for (SKSpriteNode *node in pauseButton) {
            node.zPosition = 999;
            [scene addChild:node];
        }
    }
}

-(void)runTransition:(SKScene*)_scene {
    if (![GameData isPause]) {
        if (scene == nil) {
            scene = _scene;
            [scene addChild:upLeaf];
            [scene addChild:bottomLeaf];
        }
        
        NSLog(@"upLeaf position %f x %f y", upLeaf.position.x, upLeaf.position.y);
        NSLog(@"bottomLeaf position %f x %f y", bottomLeaf.position.x, bottomLeaf.position.y);
        [self performSelector:@selector(showLeafs) withObject:nil afterDelay:0];
    }
}

-(void)hidePauseMenu {
    [scene removeChildrenInArray:pauseButton];
    [upLeaf removeFromParent];
    [bottomLeaf removeFromParent];
    scene = nil;
    upLeaf.position = CGPointMake(-(upLeaf.size.width / 2), SCREEN_HEIGHT + (upLeaf.size.height / 2));
    bottomLeaf.position = CGPointMake(SCREEN_WIDTH + (bottomLeaf.size.width / 2), -(bottomLeaf.size.height / 2));
}

@end
