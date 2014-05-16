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
#import "Climber.h"
#import "GameData.h"
#import "Define.h"
#import "PreloadData.h"

@implementation EnemiesController

@synthesize enemies;

-(id)initWithScene:(SKScene*)_scene {
    self = [super init];
    if (self) {
        enemies = [[NSMutableArray alloc] init];
        scene = _scene;
        timeForAddLamberJack = 0;
        timeForAddHunter = 0;
        timeForAddClimber = 0;
        numberOfFloors = 0;
        numberHunter = 0;
        numberClimber = 0;
        [self initChoppingSlots];
        [self initFloorsPosition];
    }
    return self;
}

-(void)initChoppingSlots {
    choppingSlots = [[NSMutableArray alloc] init];
    CGFloat spaceDistance;
    
    SKSpriteNode *Lamber = [SKSpriteNode spriteNodeWithImageNamed:@"lamberjack-left"];
    spaceDistance = Lamber.size.width + 2;
    for (int i = 0; i < 3 ; i++) {
        NSMutableDictionary *tmp = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"FREE", @"LEFT", @"FREE", @"RIGHT", [[NSNumber alloc] initWithFloat:(spaceDistance /2 + (spaceDistance * i))], @"posX", nil];
        [choppingSlots addObject:tmp];
    }
}

#pragma mark - Enemy Controller

-(EnemyDirection)chooseDirection {
    NSUInteger numberLeft = 0;
    NSUInteger numberRight = 0;
    
    for (Enemy *enemy in enemies) {
        if (enemy.type == EnemyTypeLamberJack) {
            if (enemy.direction == LEFT)
                numberLeft++;
            else if (enemy.direction == RIGHT)
                numberRight++;
        }
    }
    if (numberRight < numberLeft)
        return RIGHT;
    return LEFT;
}

-(void)addLamberJack {
    LamberJack *newLamberJack;
    
    newLamberJack = [[LamberJack alloc] initWithDirection:[self chooseDirection]];

    [enemies addObject:newLamberJack];
    [scene addChild:newLamberJack.node];
}

-(void)addClimber {
    Climber *newClimber;
    
    newClimber = [[Climber alloc] initWithDirection:LEFT];
    
    [enemies addObject:newClimber];
    [scene addChild:newClimber.node];
}

-(void)addHunter {
    Hunter *newHunter;
    int hunterFloor = rand() % self->numberOfFloors + 1;
    int positionHunterInSlot = 0;

    for (int currentSlot = 0; currentSlot < self->numberOfFloors; currentSlot++) {
        if (((positionHunterInSlot = [self checkPositionFloorSlot:hunterFloor - 1])) != -1)
            break;
    }
    if (positionHunterInSlot == -1)
        return ;
    
    newHunter = [[Hunter alloc] initWithFloor:hunterFloor
                                         slot:positionHunterInSlot];
    
    [enemies addObject:newHunter];
    [scene addChild:newHunter.node];
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
    int maxLamberJack;
    
    if ([GameData getLevel] >= 1)
        maxLamberJack = MAX_LUMBERJACK;
    else
        maxLamberJack = MAX_LUMBERJACK / 2;
    if ([self countOfEnemyType:EnemyTypeLamberJack] < maxLamberJack && ((timeForAddLamberJack <= currentTime) || (timeForAddLamberJack == 0))) {
        float randomFloat = (MIN_NEXT_ENEMY + ((float)arc4random() / (0x100000000 / (MAX_NEXT_ENEMY - MIN_NEXT_ENEMY))));
        [self addLamberJack];
        timeForAddLamberJack = currentTime + randomFloat;
    }
    
    if ([GameData getLevel] >= 1)
    {
        if ([GameData getLevel] % 2 == 0) {
            if ((numberOfFloors == 0 || numberOfFloors * 2 < [GameData getLevel])) {
                [self addFloor];
                numberHunter += 1;
            }
        }
        if ([GameData getLevel] % 4 == 0) {
            numberClimber += 1;
        }
        
        if ([self countOfEnemyType:EnemyTypeClimber] < numberClimber && ((timeForAddClimber <= currentTime) || (timeForAddClimber == 0))){
            float randomFloat = (MIN_NEXT_ENEMY + ((float)arc4random() / (0x100000000 / (MAX_NEXT_ENEMY + 2 - MIN_NEXT_ENEMY))));
            [self addClimber];
            timeForAddClimber = currentTime + randomFloat;
        }
        
        if (numberOfFloors > 0 &&
            [self countOfEnemyType:EnemyTypeHunter] < numberHunter && ((timeForAddHunter <= currentTime) || (timeForAddHunter == 0))){
            float randomFloat = (MIN_NEXT_ENEMY + ((float)arc4random() / (0x100000000 / (MAX_NEXT_ENEMY - MIN_NEXT_ENEMY))));
            [self addHunter];
            timeForAddHunter = currentTime + randomFloat;
        }
    }
    
    for (Enemy *enemy in enemies) {
        if (enemy.type == EnemyTypeLamberJack)
            [(LamberJack*)enemy updatePosition:choppingSlots];
    }
}

-(void)deleteEnemy:(Enemy*)enemy {
    SKAction *fadeIn = [SKAction fadeAlphaTo:0.0 duration:0.25];
    SKAction *sound = [PreloadData getDataWithKey:DATA_COCONUT_SOUND];
    if (sound != nil) {
        [enemy.node runAction:sound completion:^(void){
            [enemy.node runAction:fadeIn completion:^{
                [enemy.node removeFromParent];
            }];
        }];
    }
    
    if (enemy.type == EnemyTypeLamberJack) {
        LamberJack *lamber;
        lamber = (LamberJack*)enemy;
        [lamber freeTheSlot:choppingSlots];
        [GameData addPointToScore:10];
    }
    else if (enemy.type == EnemyTypeHunter) {
        Hunter *hunter = (Hunter *)enemy;
        self->slotFloor[hunter.floor - 1] -= 1 << hunter.slot;
        [GameData addPointToScore:20];
    }
    [enemies removeObject:enemy];
}

#pragma mark - Floor Controller

-(void)addFloor {
    CGRect screen = [UIScreen mainScreen].bounds;
    SKAction *slide;
    
    if (numberOfFloors >= MAX_FLOOR)
        return ;
    numberOfFloors++;
    SKSpriteNode *floor = [SKSpriteNode spriteNodeWithColor:[SKColor brownColor] size:CGSizeMake(FLOOR_WIDTH, FLOOR_HEIGHT)];
    if (numberOfFloors % 2 != 0)
    {
        floor.position = CGPointMake(-(FLOOR_WIDTH / 2), [[floorsPosition objectAtIndex:numberOfFloors - 1] doubleValue]);
        slide = [SKAction moveToX:(floor.size.width / 2) duration:0.5];
    }
    else
    {
        floor.position = CGPointMake(screen.size.width + (FLOOR_WIDTH / 2), [[floorsPosition objectAtIndex:numberOfFloors - 1] doubleValue]);
        slide = [SKAction moveToX:(screen.size.width - (floor.size.width / 2)) duration:0.5];
    }
    [scene addChild:floor];
    [floor runAction:slide];
}

#pragma mark - Floor Slot management

-(void)initFloorsPosition {
    NSMutableArray *positions;
    
    positions = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < MAX_FLOOR ; i++) {
        CGFloat posY = MIN_POSY_FLOOR + (SPACE_BETWEEN * i);
        [positions addObject:[NSNumber numberWithDouble:posY]];
    }
    floorsPosition = [[NSArray alloc] initWithArray:positions];
}

-(void)initFloorSlot {
    for (int index = 0; index < MAX_FLOOR; index++) {
        self->slotFloor[index] = 0;
    }
}

-(int)checkPositionFloorSlot:(NSInteger)floor {
    if (floor < MAX_FLOOR) {
        for (int rank = 3; rank >= 0; rank--) {
            if ((self->slotFloor[floor] >> rank & 0x1) == 0) {
                self->slotFloor[floor] += 1 << rank;
                return (rank + 1);
            }
        }
    }
    return (-1);
}

@end
