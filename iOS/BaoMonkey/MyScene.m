//
//  MyScene.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "MyScene.h"
#import "MyScene+GeneratorWave.h"

# define IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

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
    SKLabelNode *node = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    node.text = [NSString stringWithFormat:@"Pause"];
    node.fontSize = 25;
    node.position = CGPointMake([UIScreen mainScreen].bounds.size.width - 50, [UIScreen mainScreen].bounds.size.height - 30);
    node.name = PAUSE_BUTTON_NODE_NAME;
    return node;
}

-(void)createButtons {
    [self addChild:[self pauseNode]];
}

-(SKSpriteNode *)trunkNode {
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"trunk"];
    node.position = CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT - 370));
    node.name = TRUNK_NODE_NAME;
    return node;
}

-(SKSpriteNode *)backLeafNode {
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"back-leaf"];
    node.position = CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT - 124));
    node.name = BACK_LEAF_NODE_NAME;
    return node;
}

-(SKSpriteNode *)frontLeafNode {
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"front-leaf"];
    node.position = CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT - 89));
    node.name = FRONT_LEAF_NODE_NAME;
    return node;
}

-(void)scoreNode {
    score = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    score.text = [NSString stringWithFormat:@"%d", [[GameData singleton] getScore]];
    score.fontSize = 25;
    score.position = CGPointMake(20, SCREEN_HEIGHT - 30);
    score.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    score.name = SCORE_NODE_NAME;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:PAUSE_BUTTON_NODE_NAME]) {
        if ([GameData isPause]) {
            ((SKLabelNode *)node).text = [NSString stringWithFormat:@"Pause"];
            [self resumeGravityItem];
        } else {
            ((SKLabelNode *)node).text = [NSString stringWithFormat:@"Play"];
            [self pauseGravityItem];
        }
        [GameData updatePause];
    } else if (location.y <= [UIScreen mainScreen].bounds.size.height - 30) {
        NSLog(@"touch for monkey");
        if (![GameData isPause]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DROP_MONKEY_ITEM object:nil];
        }
    }
}

- (void) initScene {
    self.backgroundColor = [SKColor colorWithRed:52/255.0f green:152/255.0f blue:219/255.0f alpha:1];
    
    SKSpriteNode *trunk = [self trunkNode];
    [self addChild:trunk];
    [self addChild:[self backLeafNode]];
    _sizeBlock = (self.frame.size.width - (self.frame.size.width / 10)) / 10;
    _treeBranch = [[TreeBranch alloc] init];
    
    self.physicsBody = [SKPhysicsBody
                        bodyWithEdgeLoopFromRect:CGRectMake(_treeBranch.node.frame.origin.x,
                                                            _treeBranch.node.frame.origin.y -
                                                            (_treeBranch.node.frame.size.height / 2) + (_treeBranch.node.frame.size.height / 2),
                                                            _treeBranch.node.frame.size.width,
                                                            _treeBranch.node.frame.size.height / 2)];
    
    [self addChild:_treeBranch.node];
    
    monkey = [[Monkey alloc] initWithPosition:CGPointMake(self.frame.size.width/2, _treeBranch.node.position.y + 20)];
    [self addChild:monkey.sprite];
    
    // Init enemies controller
    enemiesController = [[EnemiesController alloc] initWithScene:self];
    
    [self addChild:[self frontLeafNode]];
    
    trunkProgressLife = [[ProgressBar alloc] initWithPosition:CGPointMake(trunk.position.x, trunk.position.y / 2)
                                                      andSize:CGSizeMake(50, 10)];
    trunkProgressLife.backgroundColor = [UIColor blackColor];//[UIColor colorWithRed:68/255.0f green:74/255.0f blue:71/255.0f alpha:1.0f];
    trunkProgressLife.frontColor = [UIColor redColor];
    [trunkProgressLife createBackground];
    [trunkProgressLife createFront];
    trunkProgressLife.background.name = BACKGROUND_PROGRESS_BAR_NODE_NAME;
    trunkProgressLife.front.name = FRONT_PROGRESS_BAR_NODE_NAME;
    [self addChild:trunkProgressLife.background];
    [self addChild:trunkProgressLife.front];
    
    [self scoreNode];
    [self addChild:score];
    
    [self createButtons];
    
    [[GameData singleton] initPause];
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [[GameData singleton] initGameData];
        [self initScene];
    }
    return self;
}

- (void) pauseGravityItem {
    self.speed = 0;
    for (Item *item in _wave) {
        [item pauseTimer];
        item.node.physicsBody = nil;
    }
    
    [self enumerateChildNodesWithName:WEAPON_NODE_NAME usingBlock:^(SKNode *node, BOOL *stop) {
        node.physicsBody = nil;
    }];
}

- (void) resumeGravityItem {
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

-(void)update:(CFTimeInterval)currentTime {
    if ([[GameData singleton] isPause]) {
        [monkey stopAnimation];
        return;
    }
    [self addNewWeapon:currentTime];
    [self addNewWave:currentTime];
    
    [GameController updateAccelerometerAcceleration];
    [monkey updateMonkeyPosition:[GameController getAcceleration]];
    [enemiesController updateEnemies:currentTime];
    
    for (id item in _wave) {
        if (((Item *)item).isTaken == NO) {
            if (CGRectIntersectsRect(((Item *)item).node.frame, monkey.sprite.frame)) {
                [monkey catchItem:item];
                if ([((Item *)item) isKindOfClass:[Banana class]]) {
                    [Item deleteItemAfterTimer:(Item *)item];
                    [_wave removeObject:item];
                }
                break;
            }
        }
    }
    
    for (Item *item in _wave) {
        if (item.isOver == YES) {
            [_wave removeObject:item];
            break;
        }
    }
    
    [self enumerateChildNodesWithName:WEAPON_NODE_NAME usingBlock:^(SKNode *weaponNode, BOOL *stop) {
        for (Enemy *enemy in self->enemiesController.enemies) {
            
            if ([weaponNode intersectsNode:enemy.node]) {
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
                [[GameData singleton] substractLifeToTrunkLife:0.01f];
            }
        }
    }
    
    [trunkProgressLife updateProgression:[[GameData singleton] getTrunkLife]];
    score.text = [NSString stringWithFormat:@"%d", [[GameData singleton] getScore]];
}

@end
