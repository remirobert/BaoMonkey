//
//  MultiplayerData.m
//  BaoMonkey
//
//  Created by iPPLE on 11/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "MultiplayerData.h"

@implementation MultiplayerData

+ (instancetype) data {
    static MultiplayerData *multiplayer;
    
    if (multiplayer == nil) {
        multiplayer = [[MultiplayerData alloc] init];
        multiplayer.isConnected = NO;
        multiplayer.status = NONE;
        multiplayer.isMultiplayer = NO;
        multiplayer.typeDevice = NONE_TYPE;
        multiplayer.gameScene = nil;
        multiplayer.isInit = NO;
    }
    return (multiplayer);
}

@end
