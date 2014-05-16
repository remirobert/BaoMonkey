//
//  PreloadData.h
//  BaoMonkey
//
//  Created by iPPLE on 16/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PreloadData : NSObject

+ (void) loadDataWithKey:(id)data key:(NSString *)key;
+ (id) getDataWithKey:(NSString *)key;

@end
