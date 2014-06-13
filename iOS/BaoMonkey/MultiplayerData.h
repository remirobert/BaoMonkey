//
//  MultiplayerData.h
//  BaoMonkey
//
//  Created by iPPLE on 11/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

typedef enum : NSUInteger {
    HOST,
    GUEST,
    NONE
} MultiplayerStatus;

typedef enum : NSUInteger {
    IPAD_TYPE,
    IPHONE_TYPE,
    NONE_TYPE
} DeviceType;

@interface MultiplayerData : NSObject

@property (nonatomic, strong) GKMatch *match;
@property (nonatomic, assign) MultiplayerStatus status;
@property (nonatomic, assign) DeviceType typeDevice;

@property (nonatomic, assign) BOOL isConnected;
@property (nonatomic, assign) BOOL isMultiplayer;

+ (instancetype) data;

@end
