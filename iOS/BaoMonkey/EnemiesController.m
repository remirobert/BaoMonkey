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

#define MIN_POSY_FLOOR  90.0
#define SPACE_BETWEEN   60.0
#define FLOOR_WIDTH     105.0
#define FLOOR_HEIGHT    15.0

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
        [self initFloorsPosition];
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
    int positionHunterInSlot = 0;
    for (int currentSlot = 0; currentSlot < self->numberOfFloors; currentSlot++) {
        if (((positionHunterInSlot = [self checkPositionFloorSlot:currentSlot])) != -1)
            break;
    }
    if (positionHunterInSlot == -1)
        return ;
    
    newHunter = [[Hunter alloc] initWithFloor:numberOfFloors
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
    
    if ([self countOfEnemyType:EnemyTypeLamberJack] < MAX_LUMBERJACK && ((timeForAddLamberJack <= currentTime) || (timeForAddLamberJack == 0))){
        float randomFloat = (MIN_NEXT_ENEMY + ((float)arc4random() / (0x100000000 / (MAX_NEXT_ENEMY - MIN_NEXT_ENEMY))));
        [self addLamberJack];
        timeForAddLamberJack = currentTime + randomFloat;
    }
    
    if ([GameData getScore] >= 20)
    {
        if ([GameData getScore] % 20 == 0)
            [self addFloor];
        
        if ([self countOfEnemyType:EnemyTypeHunter] < MAX_HUNTER && ((timeForAddHunter <= currentTime) || (timeForAddHunter == 0))){
            float randomFloat = (MIN_NEXT_ENEMY + ((float)arc4random() / (0x100000000 / (MAX_NEXT_ENEMY - MIN_NEXT_ENEMY))));
            [self addHunter];
            timeForAddHunter = currentTime + randomFloat;
        }
    }
    
    static int a = 0;
    if (a == 0) {
        [self addClimber];
        a = 1;
    }
    
    for (Enemy *enemy in enemies) {
        if (enemy.type == EnemyTypeLamberJack)
            [(LamberJack*)enemy updatePosition:choppingSlots];
    }
}

-(void)deleteEnemy:(Enemy*)enemy {
    SKAction *fadeIn = [SKAction fadeAlphaTo:0.0 duration:0.25];
    SKAction *sound = [SKAction playSoundFileNamed:@"coconut.mp3" waitForCompletion:NO];
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
    
    if (numberOfFloors == MAX_FLOOR)
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
    for (int mask = 3; mask >= 0; mask--) {
        if ((self->slotFloor[floor] >> mask & 0x1) == 0) {
            self->slotFloor[floor] += 1 << mask;
            return (mask + 1);
        }
    }
    return (-1);
}

@end
