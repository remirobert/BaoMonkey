//
//  GameOver.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 09/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "GameOver.h"
#import "GameData.h"

@implementation GameOver

-(id)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PAUSE_GAME object:nil];
    }
    return self;
}

-(SKSpriteNode *)launchGameOverView {
    SKSpriteNode *node = [[SKSpriteNode alloc] initWithColor:[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.5]
                                                        size:CGSizeMake((SCREEN_WIDTH - 30), (SCREEN_HEIGHT - 30))];
    node.position = CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT / 2));
    
    SKLabelNode *gameOver = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    gameOver.text = @"Game Over";
    gameOver.fontSize = 30;
    gameOver.fontColor = [UIColor whiteColor];
    gameOver.position = CGPointMake(0, ((node.size.height / 2) - 100));
    [node addChild:gameOver];
    
    SKLabelNode *retry = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    retry.text = @"Retry";
    retry.name = RETRY_NODE_NAME;
    retry.fontSize = 20;
    retry.fontColor = [UIColor whiteColor];
    [node addChild:retry];
    
    return node;
}

@end
