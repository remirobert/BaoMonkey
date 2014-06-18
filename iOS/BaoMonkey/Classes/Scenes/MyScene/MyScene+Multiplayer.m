//
//  MyScene+Multiplayer.m
//  BaoMonkey
//
//  Created by iPPLE on 13/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "MyScene+Multiplayer.h"
#import "NetworkMessage.h"
#import "MultiplayerData.h"
#import "CocoNuts.h"
#import "Enemy.h"
#import "LamberJack.h"
#import "Hunter.h"
#import "Climber.h"

@implementation MyScene (Multiplayer)

- (void)match:(GKMatch *)match player:(NSString *)playerID didChangeState:(GKPlayerConnectionState)state {
    NSLog(@"change status");
    if (state != GKPlayerStateConnected) {
        NSLog(@"change status unknow");
    }
}

- (void)match:(GKMatch *)match didFailWithError:(NSError *)error {
    NSLog(@"Error match");
}

- (void) monkeyAnimationMultiplayer:(NetworkMessage *)msg {
    static CGFloat previousXscale = 0.0;
    
    NSString *message = [[NSString alloc] initWithData:msg.data encoding:NSUTF8StringEncoding];
    NSArray *tabMsg = [message componentsSeparatedByString:@" "];
    
    if ([message isEqualToString:@"wait"]) {
        if (previousXscale != 0)
            [monkeyMultiplayer waitMonkey];
        previousXscale = 0.0;
    }
    else if ([[tabMsg objectAtIndex:0] isEqualToString:@"walking"]) {
        if ([[tabMsg objectAtIndex:1] floatValue] != previousXscale) {
            monkeyMultiplayer.sprite.xScale = [[tabMsg objectAtIndex:1] floatValue];
            [monkeyMultiplayer moveActionWalking];
        }
        previousXscale = [[tabMsg objectAtIndex:1] floatValue];
    }
}

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {
     NetworkMessage *msg = (NetworkMessage *)[NSKeyedUnarchiver unarchiveObjectWithData:data];

    switch (msg.type) {
        case MESSAGE_POSITION_MONKEY: {
            NSString *message = [[NSString alloc] initWithData:msg.data encoding:NSUTF8StringEncoding];
            
            if (IPAD && [MultiplayerData data].typeDevice == IPHONE_TYPE) {
                monkeyMultiplayer.sprite.position = CGPointMake([message floatValue] * 2.4,
                                                                monkey.sprite.position.y);
            }
            else if (!IPAD && [MultiplayerData data].typeDevice == IPAD_TYPE) {
                monkeyMultiplayer.sprite.position = CGPointMake([message floatValue] * 0.416,
                                                                monkey.sprite.position.y);
            }
            else {
                monkeyMultiplayer.sprite.position = CGPointMake([message floatValue],
                                                                monkey.sprite.position.y);
            }
            monkeyMultiplayer.shield.position = monkeyMultiplayer.sprite.position;
            break;
        }
        
        case MESSAGE_COMMAND: {
            NSString *message = [[NSString alloc] initWithData:msg.data encoding:NSUTF8StringEncoding];
            
            if ([message isEqualToString:@"gameOver"] && [GameData isGameOver] == FALSE) {
                [monkey deadMonkey];
                [monkeyMultiplayer deadMonkey];
                [self gameOverCountDown];
            }

            if ([message isEqualToString:@"catch"]) {
                if (monkeyMultiplayer.weapon == nil) {
                    CocoNuts *coco = [[CocoNuts alloc] initWithPosition:monkeyMultiplayer.sprite.position];
                    [[MultiplayerData data].gameScene addChild:coco.node];
                    coco.isTaken = YES;
                    coco.node.hidden = YES;
                    monkeyMultiplayer.weapon = coco;
                }
            }
            
            if ([message isEqualToString:@"launch"]) {
                if (monkeyMultiplayer.weapon == nil)
                    break ;
                monkeyMultiplayer.weapon.node.hidden = FALSE;
                monkeyMultiplayer.weapon.node.position = CGPointMake(monkeyMultiplayer.sprite.position.x,
                                                                    monkeyMultiplayer.weapon.node.position.y);
                [Action dropWeapon:monkeyMultiplayer.weapon];
                monkeyMultiplayer.weapon = nil;
                
                [monkeyMultiplayer.sprite runAction:[SKAction animateWithTextures:@[[PreloadData getDataWithKey:@"monkey-launch"],
                                                                                    [PreloadData getDataWithKey:@"monkey-launch"],
                                                                                    [PreloadData getDataWithKey:@"monkey-launch"]]
                                                                     timePerFrame:0.5] completion:^{
                    [monkeyMultiplayer waitMonkey];
                }];
            }
            
            if ([message isEqualToString:@"shield"]) {
                if (monkeyMultiplayer.isShield == NO) {
                    [monkeyMultiplayer addShield:[MultiplayerData data].gameScene];
                }
            }

            if ([message isEqualToString:@"removeShield"]) {
                if (monkeyMultiplayer. isShield == YES) {
                    [monkeyMultiplayer.shield removeFromParent];
                    monkeyMultiplayer.shield = nil;
                    monkeyMultiplayer.isShield = NO;
                }
            }
            
            if ([message isEqualToString:@"floor"]) {
                [enemiesController addFloor];
            }
            
            break;
        }
            
        case MESSAGE_MONKEY_ANIMATION: {
            [self monkeyAnimationMultiplayer:(msg)];
            break;
        }
            
        case MESSAGE_NEW_ENEMY: {

            NSString *message = [[NSString alloc] initWithData:msg.data encoding:NSUTF8StringEncoding];
            NSArray *tabMessage = [message componentsSeparatedByString:@" "];
            Enemy *newEnemy;
            
            if ([tabMessage count] == 2 && [[tabMessage objectAtIndex:0] isEqualToString:@"L"]) {
                Direction sens = RIGHT;
                
                if ([[tabMessage objectAtIndex:1] isEqualToString:@"L"])
                    sens = LEFT;

                newEnemy= [[LamberJack alloc] initWithDirection:sens];
            }
            else if ([tabMessage count] == 3 && [[tabMessage objectAtIndex:0] isEqualToString:@"H"]) {
                newEnemy = [[Hunter alloc] initWithFloor:[[tabMessage objectAtIndex:1] intValue] slot:[[tabMessage objectAtIndex:2] intValue]];
            }
            else if ([tabMessage count] == 3 && [[tabMessage objectAtIndex:0] isEqualToString:@"C"]) {
                Direction sens = RIGHT;
                
                if ([[tabMessage objectAtIndex:1] isEqualToString:@"L"])
                    sens = LEFT;
                
                newEnemy = [[Climber alloc] initWithDirection:sens andKind:[[tabMessage objectAtIndex:2] integerValue]];
            }
            if (newEnemy != nil) {
                [enemiesController.enemies addObject:newEnemy];
                [[MultiplayerData data].gameScene addChild:newEnemy.node];
            }
        }
            
        default:
            break;
    }
}

- (void) sendGameOverGame {
    if ([MultiplayerData data].isConnected == NO || [MultiplayerData data].isMultiplayer == NO)
        return ;
    
    NetworkMessage *messageNetwork = [[NetworkMessage alloc] initWithData:[@"gameOver" dataUsingEncoding:NSUTF8StringEncoding]];
    
    messageNetwork.type = MESSAGE_COMMAND;
    
    [[MultiplayerData data].match sendData:[NSKeyedArchiver archivedDataWithRootObject:messageNetwork]
                                 toPlayers:[MultiplayerData data].match.playerIDs
                              withDataMode:GKMatchSendDataUnreliable error:nil];
}

- (void) sendPositionMonkey {
    static CGPoint previousPosition;

    if (previousPosition.x != monkey.sprite.position.x) {
        
        NetworkMessage *messageNetwork = [[NetworkMessage alloc] initWithData:[[NSString stringWithFormat:@"%f",
                                                                                monkey.sprite.position.x]
                                                                               dataUsingEncoding:NSUTF8StringEncoding]];
        messageNetwork.type = MESSAGE_POSITION_MONKEY;
        
        [[MultiplayerData data].match sendData:[NSKeyedArchiver archivedDataWithRootObject:messageNetwork]
                                     toPlayers:[MultiplayerData data].match.playerIDs
                                  withDataMode:GKMatchSendDataUnreliable error:nil];
        previousPosition = CGPointMake(monkey.sprite.position.x, monkey.sprite.position.y);
    }
}

- (void) handleMultiplayer {
    if ([MultiplayerData data].isMultiplayer == NO || [MultiplayerData data].isConnected == NO)
        return ;
    
    [MultiplayerData data].match.delegate = self;
    [self sendPositionMonkey];
}

@end
