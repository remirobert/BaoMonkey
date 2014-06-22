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
#import "BaoSize.h"
#import "BaoPosition.h"
#import "MultiplayerData.h"
#import "NetworkMessage.h"

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
        [self initFloorsPosition];
    }
    return self;
}

#pragma mark - Enemy Controller

-(Direction)chooseDirection {
    for (Enemy *enemy in enemies) {
        if (enemy.type == EnemyTypeLamberJack) {
            if (enemy.direction == LEFT) {
                return RIGHT;
            }
            else if (enemy.direction == RIGHT) {
                return LEFT;
            }
        }
    }
    return arc4random() % 2 ? LEFT : RIGHT;
}

-(void)addLamberJack {
    LamberJack *newLamberJack;
    
    newLamberJack = [[LamberJack alloc] initWithDirection:[self chooseDirection]];

    [enemies addObject:newLamberJack];
    [scene addChild:newLamberJack.node];
    
    if ([MultiplayerData data].isConnected == YES && [MultiplayerData data].isMultiplayer == YES && [MultiplayerData data].status == HOST) {
        NSString *messageStr;
        
        if (newLamberJack.direction == LEFT)
            messageStr = @"L L";
        else if (newLamberJack.direction == RIGHT)
            messageStr = @"L R";
        NetworkMessage *messageNetwork = [[NetworkMessage alloc] initWithData:[messageStr dataUsingEncoding:NSUTF8StringEncoding]];
        
        messageNetwork.type = MESSAGE_NEW_ENEMY;
        
        [[MultiplayerData data].match sendData:[NSKeyedArchiver archivedDataWithRootObject:messageNetwork]
                                     toPlayers:[MultiplayerData data].match.playerIDs
                                  withDataMode:GKMatchSendDataUnreliable error:nil];
    }
}

-(void)addClimber {
    Climber *newClimber;
    
    if (rand() % 2 == 1)
        newClimber = [[Climber alloc] initWithDirection:LEFT];
    else
        newClimber = [[Climber alloc] initWithDirection:RIGHT];
    
    [enemies addObject:newClimber];
    [scene addChild:newClimber.node];
    if ([MultiplayerData data].isConnected == YES && [MultiplayerData data].isMultiplayer == YES && [MultiplayerData data].status == HOST) {
        NSString *messageStr;
        
        if (newClimber.direction == LEFT) {
            if (newClimber.kind == MONKEY)
                messageStr = @"C L 0";
            else
                messageStr = @"C L 1";
        }
        else if (newClimber.direction == RIGHT) {
            if (newClimber.kind == MONKEY)
                messageStr = @"C R 0";
            else
                messageStr = @"C R 1";
        }

        NetworkMessage *messageNetwork = [[NetworkMessage alloc] initWithData:[messageStr dataUsingEncoding:NSUTF8StringEncoding]];
        
        messageNetwork.type = MESSAGE_NEW_ENEMY;
        
        [[MultiplayerData data].match sendData:[NSKeyedArchiver archivedDataWithRootObject:messageNetwork]
                                     toPlayers:[MultiplayerData data].match.playerIDs
                                  withDataMode:GKMatchSendDataUnreliable error:nil];
    }
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
        
    if ([MultiplayerData data].isConnected == YES && [MultiplayerData data].isMultiplayer == YES && [MultiplayerData data].status == HOST) {
        NSString *messageStr;
        
        messageStr = [NSString stringWithFormat:@"H %d %d", hunterFloor, positionHunterInSlot];
        NetworkMessage *messageNetwork = [[NetworkMessage alloc] initWithData:[messageStr dataUsingEncoding:NSUTF8StringEncoding]];
        
        messageNetwork.type = MESSAGE_NEW_ENEMY;
        
        [[MultiplayerData data].match sendData:[NSKeyedArchiver archivedDataWithRootObject:messageNetwork]
                                     toPlayers:[MultiplayerData data].match.playerIDs
                                  withDataMode:GKMatchSendDataUnreliable error:nil];
    }
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

    if ([MultiplayerData data].isConnected == YES && [MultiplayerData data].isMultiplayer == YES && [MultiplayerData data].status == GUEST) {
        return ;
    }
    
    if ([self countOfEnemyType:EnemyTypeLamberJack] < MAX_LUMBERJACK && ((timeForAddLamberJack <= currentTime) || (timeForAddLamberJack == 0))) {
        float randomFloat = (MIN_NEXT_ENEMY + ((float)arc4random() / (0x100000000 / (MAX_NEXT_ENEMY - MIN_NEXT_ENEMY))));
        [self addLamberJack];
        timeForAddLamberJack = currentTime + randomFloat;
    }
    
    if ([GameData getLevel] >= 1)
    {
        if ([GameData getLevel] % 2 == 0) {
            if ((numberOfFloors == 0 || numberOfFloors * 2 < [GameData getLevel])) {
                
                NSString *messageStr = [NSString stringWithFormat:@"floor"];
                
                NetworkMessage *messageNetwork = [[NetworkMessage alloc] initWithData:[messageStr dataUsingEncoding:NSUTF8StringEncoding]];
                
                messageNetwork.type = MESSAGE_COMMAND;
                
                [[MultiplayerData data].match sendData:[NSKeyedArchiver archivedDataWithRootObject:messageNetwork]
                                             toPlayers:[MultiplayerData data].match.playerIDs
                                          withDataMode:GKMatchSendDataUnreliable error:nil];
                
                [self addFloor];
            }
        }
        
        if ([GameData getLevel] > 2) {
            if ([GameData getLevel] / 2 % 2 == 0)
                numberClimber = (int)[GameData getLevel] / 2;
        }
        
        if ([self countOfEnemyType:EnemyTypeClimber] < numberClimber && ((timeForAddClimber <= currentTime) || (timeForAddClimber == 0))){
            float randomFloat = (8.5 + ((float)arc4random() / (0x100000000 / (3.0 + 2 - 2.5))));
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
}

-(void)deleteEnemy:(Enemy*)enemy {
    if (enemy.type == EnemyTypeLamberJack) {
        LamberJack *lamber;
        lamber = (LamberJack*)enemy;
        [lamber stopChopping];
        [lamber startDead];
        [lamber.node runAction:[PreloadData getDataWithKey:DATA_COCONUT_SOUND]];
        [GameData addPointToScore:10];
        [enemies removeObject:enemy];
    }
    else if (enemy.type == EnemyTypeHunter) {
        Hunter *hunter = (Hunter *)enemy;
        self->slotFloor[hunter.floor - 1] -= 1 << hunter.slot;
        [hunter startDead];
        [hunter.node runAction:[PreloadData getDataWithKey:DATA_COCONUT_SOUND]];
        [GameData addPointToScore:20];
        [enemies removeObject:enemy];
    }
    else if (enemy.type == EnemyTypeClimber) {
        Climber *climb = (Climber *)enemy;
        [Climber startDead:climb :enemies];
        [climb.node runAction:[PreloadData getDataWithKey:DATA_COCONUT_SOUND]];
        [GameData addPointToScore: 30];
    }
}

#pragma mark - Floor Controller

-(void)addFloor {
    CGRect screen = [UIScreen mainScreen].bounds;
    SKAction *slide;
    
    if (numberOfFloors >= MAX_FLOOR)
        return ;
     numberHunter += 1;
    numberOfFloors++;
    SKSpriteNode *floor = [SKSpriteNode spriteNodeWithTexture:[PreloadData getDataWithKey:DATA_PLATEFORM] size:[BaoSize plateform]];
    if (numberOfFloors % 2 != 0)
    {
        floor.xScale = -1;
        floor.position = CGPointMake(-(FLOOR_WIDTH / 2), [[floorsPosition objectAtIndex:numberOfFloors - 1] doubleValue]);
        slide = [SKAction moveToX:(floor.size.width / 2) duration:0.5];
    }
    else
    {
        floor.xScale = 1;
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
                
        CGFloat posY = MIN_POSY_FLOOR + ([BaoPosition getBetweenPlateforme] * i) - 22;
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
