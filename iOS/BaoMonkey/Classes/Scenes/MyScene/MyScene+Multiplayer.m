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

@implementation MyScene (Multiplayer)

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {
     NetworkMessage *msg = (NetworkMessage *)[NSKeyedUnarchiver unarchiveObjectWithData:data];

    switch (msg.type) {
        case MESSAGE_POSITION_MONKEY: {
            NSString *message = [[NSString alloc] initWithData:msg.data encoding:NSUTF8StringEncoding];
            
            if (IPAD && [MultiplayerData data].typeDevice == IPHONE_TYPE) {
                monkeyMultiplayer.sprite.position = CGPointMake([message floatValue] * 2,
                                                                monkey.sprite.position.y);
            }
            else if (!IPAD && [MultiplayerData data].typeDevice == IPAD_TYPE) {
                monkeyMultiplayer.sprite.position = CGPointMake([message floatValue] / 2,
                                                                monkey.sprite.position.y);
            }
            else {
                monkeyMultiplayer.sprite.position = CGPointMake([message floatValue],
                                                                monkey.sprite.position.y);
            }
            break;
        }
        
        case MESSAGE_COMMAND: {
            NSString *message = [[NSString alloc] initWithData:msg.data encoding:NSUTF8StringEncoding];
            
            if ([message isEqualToString:@"gameOver"] && [GameData isGameOver] == FALSE) {
                [monkey deadMonkey];
                [self gameOverCountDown];
            }
            break;
        }
            
        default:
            break;
    }
    
    if (msg.type == MESSAGE_POSITION_MONKEY) {
        NSLog(@"receive data");
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
        NSLog(@"send data");
    }
}

- (void) handleMultiplayer {
    if ([MultiplayerData data].isMultiplayer == NO || [MultiplayerData data].isConnected == NO)
        return ;
    
    [MultiplayerData data].match.delegate = self;
    [self sendPositionMonkey];
}

@end
