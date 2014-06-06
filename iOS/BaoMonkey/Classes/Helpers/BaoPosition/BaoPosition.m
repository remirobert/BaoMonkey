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

+(NSInteger)dropAction{
    return IPAD ? (SCREEN_HEIGHT - 340) : (SCREEN_HEIGHT - 200);
}

+ (CGFloat) getBetweenPlateforme {
    return IPAD ? 120.0 : 60.0;
}

+ (NSString *) pathFireTank {
    return IPAD ? [[NSBundle mainBundle] pathForResource:@"fire_ipad" ofType:@"sks"] :
    [[NSBundle mainBundle] pathForResource:@"fire" ofType:@"sks"];
}

@end
