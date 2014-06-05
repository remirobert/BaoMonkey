//
//  BaoPosition.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 05/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "BaoPosition.h"

@implementation BaoPosition

+(CGPoint)treeBranch{
    return IPAD ? CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 320) : CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 180);
}

+(CGPoint)monkey{
    return IPAD ? CGPointMake(SCREEN_WIDTH / 2, ([BaoPosition treeBranch]).y + 60) : CGPointMake(SCREEN_WIDTH / 2, ([BaoPosition treeBranch].y + 30));
}

@end
