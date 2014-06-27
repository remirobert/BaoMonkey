//
//  MyScene.h
//  iosGame
//

//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>
#import <GameKit/GameKit.h>
#import "TreeBranch.h"
#import "ProgressBar.h"
#import "GameData.h"
#import "GameController.h"
#import "Monkey.h"
#import "Item.h"
#import "TreeBranch.h"
#import "GameController.h"
#import "Monkey.h"
#import "Enemy.h"
#import "LamberJack.h"
#import "Hunter.h"
#import "EnemiesController.h"
#import "ProgressBar.h"
#import "Define.h"
#import "Resume.h"
#import "PauseScene.h"
#import "GameOverScene.h"

@interface MyScene : SKScene {
    CFTimeInterval pauseTime;
    CFTimeInterval lastTime;
    Monkey *monkey;
    EnemiesController *enemiesController;
    GameController *gc;
    SKLabelNode *score;
    dispatch_once_t oncePause;
    dispatch_once_t oncePlay;
    SKTransition *menuTransition;
    SKSpriteNode *trunk;
    BOOL tutoStep;
    NSInteger numTutoStep;
    CFTimeInterval tutorialStepTime;
}

@property (nonatomic) int sizeBlock;
@property (nonatomic) TreeBranch *treeBranch;
@property (nonatomic) NSMutableArray *wave;

- (void) resumeGame;
- (void) gameOverCountDown;

@end
