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
    MESSAGE_POSITION_MONKEY,
    NONE_MESSAGE
} NetworkMessageType;

@interface NetworkMessage : NSObject <NSCoding>

@property (nonatomic, strong) NSData *data;
@property (nonatomic, assign) NetworkMessageType type;

- (instancetype) initWithData:(NSData *)data;

@end
