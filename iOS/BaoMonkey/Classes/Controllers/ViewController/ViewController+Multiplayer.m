//
//  ViewController+Multiplayer.m
//  BaoMonkey
//
//  Created by iPPLE on 11/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "MultiplayerData.h"
#import "ViewController+Multiplayer.h"
#import "NetworkMessage.h"
#import "define.h"

@implementation ViewController (Multiplayer)

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {
    NetworkMessage *msg = (NetworkMessage *)[NSKeyedUnarchiver unarchiveObjectWithData:data];

    if ([MultiplayerData data].status == NONE) {
        NSString *message = [[NSString alloc] initWithData:msg.data encoding:NSUTF8StringEncoding];
        
        NSArray *tabMsg = [message componentsSeparatedByString:@" "];
        
        [MultiplayerData data].status = [[tabMsg objectAtIndex:0] integerValue];
        [MultiplayerData data].typeDevice = [[tabMsg objectAtIndex:1] integerValue];
    }
    else if ([[[NSString alloc] initWithData:msg.data encoding:NSUTF8StringEncoding] integerValue] == [MultiplayerData data].status) {
        if ([MultiplayerData data].status == HOST)
            [MultiplayerData data].status = GUEST;
        else
            [MultiplayerData data].status = HOST;
    }
}

- (void)match:(GKMatch *)match player:(NSString *)playerID didChangeState:(GKPlayerConnectionState)state {
    if (state != GKPlayerStateConnected) {
        [MultiplayerData data].isConnected = NO;
    }
}

- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFindMatch:(GKMatch *)match {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [MultiplayerData data].match = match;
    [MultiplayerData data].match.delegate = self;
    [MultiplayerData data].isConnected = YES;
    
    if ([MultiplayerData data].match.expectedPlayerCount == 0) {

        NSInteger randStatus = rand() % 2;
        NSInteger typeDevice = IPAD ? 0 : 1;
        NSString *message = [NSString stringWithFormat:@"%ld %d", (long)randStatus, typeDevice];
        
        
        NetworkMessage *messageNetwork = [[NetworkMessage alloc] initWithData:[message
                                                                               dataUsingEncoding:NSUTF8StringEncoding]];
    
        NSError *err;
        
        if ([[MultiplayerData data].match sendData:[NSKeyedArchiver archivedDataWithRootObject:messageNetwork]
                                             toPlayers:[MultiplayerData data].match.playerIDs
                                          withDataMode:GKMatchSendDataUnreliable error:&err] == NO)
                NSLog(@"error send message = %@", err);
        
        [MultiplayerData data].status = randStatus;
    }
}

- (void)matchmakerViewControllerWasCancelled:(GKMatchmakerViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFailWithError:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) findPlayerMatchMaking {
    GKMatchRequest *request = [[GKMatchRequest alloc] init];
    request.minPlayers = 2;
    request.maxPlayers = 2;
    
    GKMatchmakerViewController *mmvc = [[GKMatchmakerViewController alloc] initWithMatchRequest:request];
    mmvc.matchmakerDelegate = self;
    
    [self presentViewController:mmvc animated:YES completion:nil];
}

@end
