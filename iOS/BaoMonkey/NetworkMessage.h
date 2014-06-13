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
    NONE_MESSAGE
} NetworkMessageType;

@interface NetworkMessage : NSObject <NSCoding>

@property (nonatomic, strong) NSData *data;

- (instancetype) initWithData:(NSData *)data;

@end
