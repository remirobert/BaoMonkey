//
//  EnemiesController.m
//  BaoMonkey
//
//  Created by Rémi Hillairet on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "EnemiesController.h"
#import "LamberJack.h"
#import "Hunter.h"
#import "GameData.h"

@implementation EnemiesController

@synthesize enemies;

-(id)initWithScene:(SKScene*)_scene {
    self = [super init];
    if (self) {
        enemies = [[NSMutableArray alloc] init];
        scene = _scene;
        timeForAddLamberJack = 0;
        numberOfFloors = 0;
        [self initChoppingSlots];
    }
    return self;
}

-(void)initChoppingSlots {
    choppingSlots = [[NSMutableArray alloc] init];
    CGFloat spaceDistance;
    
    SKSpriteNode *Lamber = [SKSpriteNode spriteNodeWithImageNamed:@"lamberjack-left"];
    spaceDistance = Lamber.size.width / 2 - 2;
    for (int i = 0; i < 3 ; i++) {
        NSMutableDictionary *tmp = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"FREE", @"LEFT", @"FREE", @"RIGHT", [NSString stringWithFormat:@"%f", (spaceDistance + (spaceDistance * i))], @"posX", nil];
        [choppingSlots addObject:tmp];
    }
}

#pragma mark - Enemy Controller

-(EnemyDirection)chooseDirection {
    NSUInteger numberLeft = 0;
    NSUInteger numberRight = 0;
    
    for (Enemy *enemy in enemies) {
        if (enemy.direction == LEFT)
            numberLeft++;
        else if (enemy.direction == RIGHT)
            numberRight++;
    }
    if (numberRight < numberLeft)
        return RIGHT;
    return LEFT;
}

-(void)addEnemy {
    LamberJack *newLamberJack;
    
    newLamberJack = [[LamberJack alloc] initWithDirection:[self chooseDirection]];

    [enemies addObject:newLamberJack];
    [scene addChild:newLamberJack.node];
}

-(NSUInteger)countOfEnemyType:(EnemyType)_type
{
    NSUInteger count = 0;
    
    for (Enemy *enemy in enemies) {
        if (enemy.type == _type)
            count++;
    }
    return count;
}

-(void)updateEnemies:(CFTimeInterval)currentTime {
    
    if ([self countOfEnemyType:EnemyTypeLamberJack] < MAX_LUMBERJACK && ((timeForAddLamberJack <= currentTime) || (timeForAddLamberJack == 0))){
        float randomFloat = (MIN_NEXT_ENEMY + ((float)arc4random() / (0x100000000 / (MAX_NEXT_ENEMY - MIN_NEXT_ENEMY))));
        [self addEnemy];
        timeForAddLamberJack = currentTime + randomFloat;
    }
    
    if ([GameData getScore] > 100)
    {
        if (numberOfFloors == 0)
            [self addFloor];
        
//        if ([self countOfEnemyType:EnemyTypeHunter] < MAX_HUNTER && ((timeForAddHunter <= currentTime) || (timeForAddHunter == 0))){
//            float randomFloat = (MIN_NEXT_ENEMY + ((float)arc4random() / (0x100000000 / (MAX_NEXT_ENEMY - MIN_NEXT_ENEMY))));
//            [self addEnemy];
//            timeForAddLamberJack = currentTime + randomFloat;
//        }
    }
    
    for (Enemy *enemy in enemies) {
        if (enemy.type == EnemyTypeLamberJack)
            [(LamberJack*)enemy updatePosition:choppingSlots];
//        else if (enemy.type == EnemyTypeHunter)
//            [(Hunter*)enemy updatePosition];
    }
}

-(void)deleteEnemy:(Enemy*)enemy {
    SKAction *fadeIn = [SKAction fadeAlphaTo:0.0 duration:0.25];
    [enemy.node runAction:fadeIn completion:^{
        [enemy.node removeFromParent];
    }];
    
    if (enemy.type == EnemyTypeLamberJack) {
        LamberJack *lamber;
        lamber = (LamberJack*)enemy;
        [lamber freeTheSlot:choppingSlots];
        [GameData addPointToScore:10];
    }
    [enemies removeObject:enemy];
}

#pragma mark - Floor Controller

-(void)addFloor {
    CGRect screen = [UIScreen mainScreen].bounds;
    numberOfFloors++;
    SKSpriteNode *floor = [SKSpriteNode spriteNodeWithColor:[SKColor brownColor] size:CGSizeMake(screen.size.width / 2 - 20, 10)];
    floor.position = CGPointMake(-screen.size.width / 2, screen.size.height / MAX_FLOOR);
    [scene addChild:floor];
    SKAction *slide = [SKAction moveToX:(floor.size.width / 2) duration:0.5];
    [floor runAction:slide];
}

@end
