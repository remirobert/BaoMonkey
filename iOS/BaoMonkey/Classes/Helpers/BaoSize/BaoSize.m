//
//  Size.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 22/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "BaoSize.h"
#import "Define.h"

@implementation BaoSize

#pragma mark - PLATEFORM

+(CGSize)plateform{
    return IPAD ? CGSizeMake(300, 116) : CGSizeMake(150, 58);
}

#pragma mark - MENU SETTINGS

+(CGSize)cursorSettings{
    return IPAD ? CGSizeMake(330, 41.5f) : CGSizeMake(180, 22.5f);
}

@end
