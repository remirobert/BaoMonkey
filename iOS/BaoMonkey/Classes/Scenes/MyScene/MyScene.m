//
//  MyScene.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "MyScene.h"
#import "MyScene+GeneratorWave.h"
#import "MyScene+Climber.h"
#import "BaoButton.h"
#import "MyScene+LoadBoss.h"
#import "GameCenter.h"
#import "Settings.h"
#import "MultiplayerData.h"
#import "MyScene+Multiplayer.h"

@implementation MyScene

+ (SKSpriteNode *)spriteNodeWithImageNamed:(NSString *)name {
    if (IPAD) {
        name = [NSString stringWithFormat:@"ipad-%@", name];
    } else {
        name = [NSString stringWithFormat:@"iphone-%@", name];
    }
    return [SKSpriteNode spriteNodeWithImageNamed:name];
}

-(SKLabelNode *)pauseNode {
    SKLabelNode *node = [SKLabelNode labelNodeWithFontNamed:@"Ravie"];
    node.text = [NSString stringWithFormat:@"Pause"];
    node.fontSize = 25;
    node.position = CGPointMake([UIScreen mainScreen].bounds.size.width - 50, [UIScreen mainScreen].bounds.size.height - 30);
    node.name = PAUSE_BUTTON_NODE_NAME;
    node.zPosition = 55;
    return node;
}

-(void)createButtons {
    [self addChild:[BaoButton pause]];
}

-(SKSpriteNode *)backgroundNode {
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"background-center"];
    node.position = CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT / 2));
    node.name = TRUNK_NODE_NAME;
    return node;
}

-(SKSpriteNode *)frontLeafNode {
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"leafs"];
    node.position = CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT - (node.size.height / 2)));
    node.name = FRONT_LEAF_NODE_NAME;
    node.zPosition = 50;
    return node;
}

-(void)scoreNode {
    score = [SKLabelNode labelNodeWithFontNamed:@"Ravie"];
    score.text = [NSString stringWithFormat:@"%ld", (long)[[GameData singleton] getScore]];
    score.fontSize = 25;
    score.position = CGPointMake(20, SCREEN_HEIGHT - 30);
    score.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    score.name = SCORE_NODE_NAME;
    score.zPosition = 55;
}

-(SKLabelNode*)countDownNode {
    SKLabelNode *countDownNode = [SKLabelNode labelNodeWithFontNamed:@"ChalkboardSE-Regular"];
    countDownNode.text = @"3";
    countDownNode.fontSize = 120;
    countDownNode.position = CGPointMake(SCREEN_WIDTH / 2, (SCREEN_HEIGHT / 2) - (countDownNode.fontSize / 2));
    countDownNode.name = COUNTDOWN_NODE_NAME;
    return countDownNode;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if (([GameData isGameOver] && [node.name isEqualToString:RETRY_NODE_NAME]) || [node.name isEqualToString:RETRY_NODE_NAME]) {
        [GameData resetGameData];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RETRY_GAME object:nil];
        return ;
    }
    
    if ([node.name isEqualToString:PAUSE_BUTTON_NODE_NAME]) {
        if (![GameData isPause]) {
            [self pauseGame];
        }
    } else if ([node.name isEqualToString:RESUME_NODE_NAME]){
        if ([GameData isPause]) {
            [self resumeGame];
        }
    }else if (location.y <= [UIScreen mainScreen].bounds.size.height - 30) {
        if (![GameData isPause]) {
            if (monkey == nil)
                NSLog(@"monkey is nil");
            [monkey launchWeapon];
        }
    }
    
    if ([node.name isEqualToString:HOME_NODE_NAME]){
        NSLog(@"HOME");
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GO_TO_HOME object:nil];
    }
    
    if ([node.name isEqualToString:SETTINGS_NODE_NAME]){
        [self.view presentScene:[[Settings alloc] initWithSize:self.size withParentScene:self] transition:[SKTransition fadeWithDuration:1.0]];
    }
}

- (void) initMonkey {
    monkey = [[Monkey alloc] initWithPosition:[BaoPosition monkey]];
    [self addChild:monkey.sprite];
    [self addChild:monkey.collisionMask];

    if ([MultiplayerData data].isMultiplayer == YES) {
        monkeyMultiplayer = [[Monkey alloc] initWithPosition:[BaoPosition monkey]];
        [self addChild:monkeyMultiplayer.sprite];
        [self addChild:monkeyMultiplayer.collisionMask];
    }
}

- (void) initScene {
    self.backgroundColor = [SKColor colorWithRed:52/255.0f green:152/255.0f blue:219/255.0f alpha:1];
    
    SKSpriteNode *trunk = [self backgroundNode];
    [self addChild:trunk];
    
    
    _sizeBlock = (self.frame.size.width - (self.frame.size.width / 10)) / 10;
    _treeBranch = [[TreeBranch alloc] init];
    
    self.physicsBody = [SKPhysicsBody
                        bodyWithEdgeLoopFromRect:CGRectMake(_treeBranch.node.frame.origin.x,
                                                            _treeBranch.node.frame.origin.y -
                                                            (_treeBranch.node.frame.size.height / 2) +
                                                            (_treeBranch.node.frame.size.height / 2),
                                                            _treeBranch.node.frame.size.width,
                                                            _treeBranch.node.frame.size.height / 2)];
    
    [self addChild:_treeBranch.node];
    
    [self initMonkey];
    
    // Init enemies controller
    enemiesController = [[EnemiesController alloc] initWithScene:self];
    
    [self addChild:[self frontLeafNode]];
    
    trunkProgressLife = [[ProgressBar alloc] initWithPosition:CGPointMake(trunk.position.x, trunk.position.y / 2)
                                                      andSize:CGSizeMake(50, 10)];
    trunkProgressLife.background.name = BACKGROUND_PROGRESS_BAR_NODE_NAME;
    [trunkProgressLife updateProgression:100.0f];
    [self addChild:trunkProgressLife.background];
    
    [self scoreNode];
    [self addChild:score];
    
    [self createButtons];
    
    [[GameData singleton] initPause];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pauseGame)
                                                 name:NOTIFICATION_PAUSE_GAME object:nil];
    
    
    pauseTime = 0;
    lastTime = 0;
    oncePause = 0;
    oncePlay = -1;
    
    menuTransition = [SKTransition pushWithDirection:SKTransitionDirectionLeft duration:0.5];    
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        [[GameData singleton] initGameData];
        [self initScene];
        [GameData pauseGame];
        [self gameCountDown];
    }
    return self;
}

- (void) gameCountDown {
    static BOOL resumeGame = NO;
    
    if (resumeGame){
        resumeGame = NO;
        [GameData resumeGame];

        // Reactive speed & physics
        self.speed = 1.0;

        for (Item *item in _wave) {
            [item resumeTimer];
            if (item.isTaken == NO)
                item.node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:item.node.frame.size.width / 2];
        }

        [self enumerateChildNodesWithName:WEAPON_NODE_NAME usingBlock:^(SKNode *node, BOOL *stop) {
            node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:node.frame.size.width / 2];
        }];
    }
    else {
        resumeGame = YES;
        [self performSelector:@selector(gameCountDown) withObject:nil afterDelay:1.0];
    }
}

-(void)displayGameOverMenu {
    GameOverScene *gameOverScene = [[GameOverScene alloc] initWithSize:self.size andScene:self];
    [self.view presentScene:gameOverScene transition:menuTransition];
}

- (void) gameOverCountDown {
    static BOOL gameOver = NO;
    
    if (gameOver) {
        gameOver = NO;
        [GameData pauseGame];
        [self displayGameOverMenu];
    }
    else {
        [GameData gameOver];
        gameOver = YES;
        [self performSelector:@selector(gameOverCountDown) withObject:nil afterDelay:2.0];
    }
}

- (void) pauseGame {
    //[self launchPauseView];
    
    self.speed = 0;
    for (Item *item in _wave) {
        [item pauseTimer];
        item.node.physicsBody = nil;
    }
    
    [self enumerateChildNodesWithName:WEAPON_NODE_NAME usingBlock:^(SKNode *node, BOOL *stop) {
        node.physicsBody = nil;
    }];

    [GameData pauseGame];
    
    // Present pause scene
    
    PauseScene *pauseScene = [[PauseScene alloc] initWithSize:self.size andScene:self];
    [self.view presentScene:pauseScene transition:menuTransition];
}

- (void) resumeGame {
    //[self removePauseView];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RESUME_GAME object:nil];
    [self gameCountDown];
}

-(void)update:(CFTimeInterval)currentTime {

    NSInteger oldLevel = [GameData getLevel];        
        
    if ([[GameData singleton] isPause]) {
        
        dispatch_once(&oncePause, ^{
            oncePlay = 0;
            lastTime = currentTime;
            NSLog(@"lastTime : %f", lastTime);
        });
        return;
    }
    
    dispatch_once(&oncePlay, ^{
        oncePause = 0;
        pauseTime += currentTime - lastTime;
        NSLog(@"pauseTime : %f", pauseTime);
    });
    
    [monkey manageShield:currentTime andScene:self];
    
    currentTime -= pauseTime;
    [self addNewWeapon:currentTime];
    [self addNewWave:currentTime];
    [self addBonus:currentTime];
    
    [GameController updateAccelerometerAcceleration];
    [monkey updateMonkeyPosition:[GameController getAcceleration]];    
    
    [self handleMultiplayer];
    
    [enemiesController updateEnemies:currentTime];
    
    for (id item in _wave) {
        if (((Item *)item).isTaken == NO) {
            if (CGRectIntersectsRect(((Item *)item).node.frame, monkey.collisionMask.frame)) {
                [monkey catchItem:item :self];
                if ([((Item *)item) isKindOfClass:[Banana class]]) {
                    [Item deleteItemAfterTimer:(Item *)item];
                    [_wave removeObject:item];
                }
                break;
            }
        }
    }
    
    [self enumerateChildNodesWithName:SHOOT_NODE_NAME usingBlock:^(SKNode *node, BOOL *stop) {
        if (CGRectIntersectsRect(node.frame, monkey.collisionMask.frame)) {
            //[leafTransition runGameOverTransition];
            if (!monkey.isShield) {
                [GameCenter getBestScorePlayer];
                [monkey deadMonkey];
                if (![GameData isGameOver])
                    [self sendGameOverGame];
                    [self gameOverCountDown];
            } else {
                [monkey.shield removeFromParent];
                monkey.isShield = FALSE;
            }
            [node removeFromParent];
        }
    }];
    
    for (Item *item in _wave) {
        if (item.isOver == YES) {
            [_wave removeObject:item];
            break;
        }
    }
    
    [self enumerateChildNodesWithName:WEAPON_NODE_NAME usingBlock:^(SKNode *weaponNode, BOOL *stop) {
        for (Enemy *enemy in self->enemiesController.enemies) {
            
            if ([weaponNode intersectsNode:enemy.node]) {
                [UserData addEnemy];
                [self->enemiesController deleteEnemy:enemy];
                [weaponNode removeFromParent];
                for (Item *item in _wave) {
                    if (item.node == weaponNode) {
                        [_wave removeObject:item];
                        break;
                    }
                }
                break;
            }
        }
    }];
    
    [[GameData singleton] regenerateTrunkLife];
    
    for (Enemy *enemy in self->enemiesController.enemies) {
        if (enemy.type == EnemyTypeLamberJack) {
            if (((LamberJack *)enemy).isChooping) {
                [[GameData singleton] substractLifeToTrunkLife:LUMBERJACK_DESTROY_POINT];
            }
        }
        else if (enemy.type == EnemyTypeHunter && ((Hunter *)enemy).isMoving == NO) {
            SKSpriteNode *tmp = [((Hunter *)enemy) shootMonkey:currentTime :monkey.collisionMask.position];
            if (tmp != nil)
                [self addChild:tmp];
        }
    }
    
    [self actionClimber];
    
    if ([GameData getTrunkLife] < 0) {
        // Call the GameOver view when the trunk is dead
    } else{
        [trunkProgressLife updateProgression:[GameData getTrunkLife]];
    }
    score.text = [NSString stringWithFormat:@"%ld", (long)[[GameData singleton] getScore]];
    
    if (oldLevel != [GameData getLevel]) {
        if (oldLevel == STEP_TANK_BOSS) {
            [self loadTankScene];
        }
    }
}

@end