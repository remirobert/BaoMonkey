//
//  PreloadData.m
//  BaoMonkey
//
//  Created by iPPLE on 16/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "PreloadData.h"

@interface PreloadData ()
@property (nonatomic, strong) NSMutableDictionary *data;
@end

@implementation PreloadData

+ (instancetype) defaultData {
    static PreloadData *defautl;
    
    if (defautl == nil) {
        defautl = [[PreloadData alloc] init];
        defautl.data = [[NSMutableDictionary alloc] init];
    }
    
    return (defautl);
}

+ (void) loadDataWithKey:(id)data key:(NSString *)key {
    PreloadData *defaultData = [PreloadData defaultData];
    [defaultData.data setValue:data forKey:key];
}

+ (id) getDataWithKey:(NSString *)key {
    PreloadData *defaultData = [PreloadData defaultData];
    
    id item = [defaultData.data objectForKey:key];
    return (item);
}

@end
