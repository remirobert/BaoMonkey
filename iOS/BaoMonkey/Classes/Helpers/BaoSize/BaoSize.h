//
//  Size.h
//  BaoMonkey
//
//  Created by Jeremy Peltier on 22/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaoSize : NSObject

#pragma mark - PLATEFORM

+(CGSize)plateform;

#pragma mark - MENU SETTINGS

+(CGSize)cursorSettings;

+ (CGFloat) sizeMoveAccelerometer;

@end
