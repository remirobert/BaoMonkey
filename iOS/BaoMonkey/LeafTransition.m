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

#define ANIMATION_SPEED    5.00

@implementation LeafTransition

-(id)initWithScene:(SKScene*)_scene{
    self = [super init];
    if (self) {
        scene = _scene;
        upLeaf = [SKSpriteNode spriteNodeWithImageNamed:@"up-leaf"];
        upLeaf.position = CGPointMake(-(upLeaf.size.width / 2), SCREEN_HEIGHT + (upLeaf.size.height / 2));
        bottomLeaf = [SKSpriteNode spriteNodeWithImageNamed:@"bottom-leaf"];
        bottomLeaf.position = CGPointMake(SCREEN_WIDTH + (bottomLeaf.size.width / 2), -(bottomLeaf.size.height / 2));
        upLeaf.zPosition = 1;
        bottomLeaf.zPosition = 1;
        bottomLeaf.name = @"LEAF_BOTTOM";
        upLeaf.name = @"LEAF_UP";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hidePauseMenu) name:NOTIFICATION_RESUME_GAME object:nil];
        pauseButton = [[NSArray alloc] initWithObjects:[BaoButton replay], [BaoButton play], [BaoButton home], [BaoButton settings], [BaoButton pauseLabel], nil];
        gameOverButton = [[NSArray alloc] initWithObjects:[Resume gameOverNode], [Resume replayNode], nil];
        
        // Init leafScene
        leafScene = [[SKScene alloc] initWithSize:scene.frame.size];
        [leafScene addChild:bottomLeaf];
        [leafScene addChild:upLeaf];
    }
    return self;
}

-(void)showLeafsScene {
    [self addGameScreenShot];
    [scene.view presentScene:leafScene];
    
    SKAction *showUpLeafAnimation = [SKAction moveTo:CGPointMake(SCREEN_WIDTH / 2, 3 * (SCREEN_HEIGHT / 4)) duration:ANIMATION_SPEED];
    SKAction *showBottomAnimation = [SKAction moveTo:CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 4) duration:ANIMATION_SPEED];
    
    [upLeaf runAction:showUpLeafAnimation];
    [bottomLeaf runAction:showBottomAnimation];
}

//-(void)showPauseLeafs {
//    upLeaf.position = CGPointMake(upLeaf.position.x + ANIMATION_SPEED, upLeaf.position.y - ANIMATION_SPEED);
//    bottomLeaf.position = CGPointMake(bottomLeaf.position.x - ANIMATION_SPEED, bottomLeaf.position.y + ANIMATION_SPEED);
//    if ((bottomLeaf.position.x > (SCREEN_WIDTH / 2)) && (upLeaf.position.x < (SCREEN_WIDTH / 2))) {
//        [self performSelector:@selector(showPauseLeafs) withObject:nil afterDelay:0.016];
//    }
//    else {
//        for (SKSpriteNode *node in pauseButton) {
//            node.zPosition = 999;
//            if (node.parent != nil){
//                [node removeFromParent];
//            }
//            [scene addChild:node];
//        }
//    }
//}
//
//-(void)showGameOverLeafs {
//    upLeaf.position = CGPointMake(upLeaf.position.x + ANIMATION_SPEED, upLeaf.position.y - ANIMATION_SPEED);
//    bottomLeaf.position = CGPointMake(bottomLeaf.position.x - ANIMATION_SPEED, bottomLeaf.position.y + ANIMATION_SPEED);
//    if ((bottomLeaf.position.x > (SCREEN_WIDTH / 2)) && (upLeaf.position.x < (SCREEN_WIDTH / 2))) {
//        [self performSelector:@selector(showGameOverLeafs) withObject:nil afterDelay:0.016];
//    }
//    else {
//        [UserData updateScore:[GameData getScore]];
//        for (SKSpriteNode *node in gameOverButton) {
//            
//            // Temporarily
//            
//            if ([node.name isEqualToString:RETRY_NODE_NAME])
//                node.position = CGPointMake(node.position.x, SCREEN_HEIGHT / 2 - (node.size.height / 2));
//            
//            // End temporarily
//            
//            node.zPosition = 999;
//            if (node.parent == nil)
//                [scene addChild:node];
//        }
//    }
//}

-(void)addGameScreenShot {
    UIImage *gameScreen;

    UIGraphicsBeginImageContextWithOptions(scene.frame.size, NO, 0.0f);
    [scene.view drawViewHierarchyInRect:scene.view.bounds afterScreenUpdates:YES];
    gameScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    SKSpriteNode *gameScreenNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:gameScreen] size:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    gameScreenNode.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
    gameScreenNode.zPosition = 0;
    [leafScene addChild:gameScreenNode];
}

-(void)runPauseTransition {
    [self showLeafsScene];
    for (SKNode *node in pauseButton) {
        [leafScene addChild:node];
    }
}

-(void)runGameOverTransition {
    [self showLeafsScene];
    for (SKNode *node in gameOverButton) {
        [leafScene addChild:node];
    }
}

-(void)hideLeafs {
    SKAction *hideUpLeafAnimation = [SKAction moveTo:CGPointMake(-(upLeaf.size.width / 2), SCREEN_HEIGHT + (upLeaf.size.height / 2)) duration:ANIMATION_SPEED];
    SKAction *hideBottomLeafAnimation = [SKAction moveTo:CGPointMake(SCREEN_WIDTH + (bottomLeaf.size.width / 2), -(bottomLeaf.size.height / 2)) duration:ANIMATION_SPEED];
    
    [upLeaf runAction:hideUpLeafAnimation];
    [bottomLeaf runAction:hideBottomLeafAnimation];
    [leafScene.view presentScene:scene];
}

-(void)hidePauseMenu {
    [scene removeChildrenInArray:pauseButton];
    [self hideLeafs];
}

@end
