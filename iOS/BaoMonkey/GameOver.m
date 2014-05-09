//
//  GameOver.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 09/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "GameOver.h"

@implementation GameOver

-(id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

-(void)createCloud {
    cloud = [[SKSpriteNode alloc] initWithImageNamed:@"cloud"];
    cloud.position = CGPointMake(-(SCREEN_WIDTH * 2), -(SCREEN_HEIGHT * 2));
    cloud.name = CLOUD_NODE_NAME;
}

-(void)runActionCloud {
    [cloud runAction:[SKAction moveTo:CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT / 2)) duration:0.3] completion:^(void){
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PAUSE_GAME object:nil];
    }];
}

-(SKSpriteNode *)launchGameOverView {
    SKSpriteNode *node = [[SKSpriteNode alloc] init];
    node.size = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    node.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);

    [self createCloud];
    [node addChild:cloud];
    [self runActionCloud];
    
    SKLabelNode *gameOver = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    gameOver.text = @"Game Over";
    gameOver.fontSize = 30;
    gameOver.fontColor = [UIColor whiteColor];
    gameOver.position = CGPointMake(0, ((node.size.height / 2) - 100));
    [node addChild:gameOver];
    
    SKLabelNode *retry = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    retry.text = @"Retry";
    retry.fontSize = 20;
    retry.fontColor = [UIColor whiteColor];
    [node addChild:retry];
    
    return node;
}

@end
