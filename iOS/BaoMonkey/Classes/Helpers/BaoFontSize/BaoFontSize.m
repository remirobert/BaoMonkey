//
//  BaoFontSize.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 13/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "BaoFontSize.h"
#import "Define.h"

@implementation BaoFontSize

#pragma mark - SCORE

+(NSInteger)scoreFontSize{
    return IPAD ? 46.0 : 23.0;
}

#pragma mark - CREDITS

+(NSInteger)creditsFontSize{
    return IPAD ? 22.0 : 11.0;
}

@end
