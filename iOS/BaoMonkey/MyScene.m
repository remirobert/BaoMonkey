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

- (void) initScene {
    self.backgroundColor = [SKColor colorWithRed:52/255.0f green:152/255.0f blue:219/255.0f alpha:1];
    
    SKSpriteNode *trunk = [SKSpriteNode spriteNodeWithImageNamed:@"trunk.png"];
    trunk.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - 370);
    [self addChild:trunk];
    
    SKSpriteNode *back_leaf = [SKSpriteNode spriteNodeWithImageNamed:@"back-leaf.png"];
    back_leaf.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - 124);
    [self addChild:back_leaf];
    
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
    
    SKSpriteNode *front_leaf = [SKSpriteNode spriteNodeWithImageNamed:@"front-leaf.png"];
    front_leaf.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - 89);
    [self addChild:front_leaf];
    
    trunkProgressLife = [[ProgressBar alloc] initWithPosition:CGPointMake(trunk.position.x, trunk.position.y / 2)
                                                      andSize:CGSizeMake(50, 10)];
    trunkProgressLife.backgroundColor = [UIColor blackColor];//[UIColor colorWithRed:68/255.0f green:74/255.0f blue:71/255.0f alpha:1.0f];
    trunkProgressLife.frontColor = [UIColor redColor];
    [trunkProgressLife createBackground];
    [trunkProgressLife createFront];
    [self addChild:trunkProgressLife.background];
    [self addChild:trunkProgressLife.front];
    
    score = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    score.text = [NSString stringWithFormat:@"%d", [[GameData singleton] getScore]];
    score.fontSize = 25;
    score.position = CGPointMake(20, 10);
    [self addChild:score];
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [[GameData singleton] initGameData];
        [[GameData singleton] substractLifeToTrunkLife:100.0f];
        [self initScene];
        [self performSelector:@selector(addWave) withObject:nil afterDelay:1.5];
    }
    return self;
}

- (void) addWave {
    [self addNewWave];
    [self performSelector:@selector(addWave) withObject:nil afterDelay:rand() % 3 + 2];
}

-(void)update:(CFTimeInterval)currentTime {
    [monkey updateMonkeyPosition:[GameController getAccelerometerPosition]];
    [enemiesController updateEnemies:currentTime];
    
    [self enumerateChildNodesWithName:NAME_ITEM usingBlock:^(SKNode *node, BOOL *stop) {
        SKNode *tmp = [self nodeAtPoint:monkey.sprite.position];
        for (id item in _wave) {
            
//            if (CGRectIntersectsRect(, ))
            
            if (CGPointEqualToPoint(((Item *)item).node.position, tmp.position))
                [monkey catchItem:item];
//                    ((Item *)item).node.hidden = YES;
//                }
            }
    }];
    
    [[GameData singleton] regenerateTrunkLife];
    [trunkProgressLife updateProgression:[[GameData singleton] getTrunkLife]];
    score.text = [NSString stringWithFormat:@"%d", [[GameData singleton] getScore]];
}

@end
