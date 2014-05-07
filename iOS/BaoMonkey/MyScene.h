//
//  MyScene.h
//  iosGame
//

//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>
#import "GameData.h"
#import "GameController.h"
#import "Monkey.h"
#import "Item.h"
#import "TreeBranch.h"
#import "EnemiesController.h"
#import "ProgressBar.h"


@interface MyScene : SKScene {
    Monkey *monkey;
    EnemiesController *enemiesController;
    GameController *gc;
    
    ProgressBar *trunkProgressLife;
    SKLabelNode *score;
}

@property (nonatomic) int sizeBlock;
@property (nonatomic) TreeBranch *treeBranch;
@property (nonatomic) NSMutableArray *wave;

@end
