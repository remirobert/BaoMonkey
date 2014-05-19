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
    static PreloadData *preload;
    
    if (preload == nil) {
        preload = [[PreloadData alloc] init];
        preload.data = [[NSMutableDictionary alloc] init];
    }
    
    return (preload);
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
