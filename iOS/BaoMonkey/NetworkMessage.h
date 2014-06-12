//
//  NetworkMessage.h
//  BaoMonkey
//
//  Created by iPPLE on 12/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MESSAGE_RANDOM,
    MESSAGE_DATA,
    NONE
} NetworkMessageType;

@interface NetworkMessage : NSObject

@property (nonatomic, strong) NSData *data;
@property (nonatomic, assign) NetworkMessageType type;

@end
