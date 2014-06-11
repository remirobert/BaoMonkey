//
//  MultiplayerData.h
//  BaoMonkey
//
//  Created by iPPLE on 11/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface MultiplayerData : NSObject

@property (nonatomic, strong) GKMatch *match;

+ (instancetype) data;

@end
