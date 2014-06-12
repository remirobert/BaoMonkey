//
//  NetworkMessage.m
//  BaoMonkey
//
//  Created by iPPLE on 12/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "NetworkMessage.h"

@implementation NetworkMessage

- (instancetype) initWithData:(NSData *)data :(NetworkMessageType)type{
    self = [super init];
    
    if (self != nil) {
        _data = data;
        _type = type;
    }
    return (self);
}

@end
