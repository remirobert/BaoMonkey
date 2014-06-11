//
//  ViewController+Multiplayer.m
//  BaoMonkey
//
//  Created by iPPLE on 11/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "MultiplayerData.h"
#import "ViewController+Multiplayer.h"

@implementation ViewController (Multiplayer)

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {
    NSString *str = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    NSLog(@"msg receive = %@", str);
}

- (void) handleDataMultiPlayer {
    while ([MultiplayerData data].isConnected == YES) {
        
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
    
    NSThread *th = [[NSThread alloc] initWithTarget:self selector:@selector(handleDataMultiPlayer) object:nil];
    
    [th start];
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
