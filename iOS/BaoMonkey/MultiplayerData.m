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
        multiplayer.isConnected = YES;
    }
    
    return (multiplayer);
}

@end
