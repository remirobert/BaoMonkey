//
//  NetworkMessage.m
//  BaoMonkey
//
//  Created by iPPLE on 12/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "NetworkMessage.h"

@implementation NetworkMessage

- (instancetype) initWithData:(NSData *)data {
    self = [super init];
    
    if (self != nil) {
        _data = data;
        _type = NONE_MESSAGE;
    }
    return (self);
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];

    if (self != nil) {
        self.data = [decoder decodeObjectForKey:@"data"];
        self.type = [decoder decodeIntegerForKey:@"type"];
    }
    return (self);
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.data forKey:@"data"];
    [encoder encodeInteger:self.type forKey:@"type"];
}

@end
