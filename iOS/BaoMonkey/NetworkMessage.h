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
    MESSAGE_COMMAND,
    MESSAGE_MONKEY_ANIMATION,
    NONE_MESSAGE
} NetworkMessageType;

@interface NetworkMessage : NSObject <NSCoding>

@property (nonatomic, strong) NSData *data;
@property (nonatomic, assign) NetworkMessageType type;

- (instancetype) initWithData:(NSData *)data;

@end
