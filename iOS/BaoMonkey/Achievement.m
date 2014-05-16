//
//  Achievement.m
//  BaoMonkey
//
//  Created by iPPLE on 16/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Achievement.h"
#import "UserData.h"

@implementation Achievement

+ (instancetype) defaultAchievement {
    static Achievement *ach;
    
    if (ach == nil) {
        ach = [[Achievement alloc] init];
        ach.achievementScore = [[NSMutableArray alloc] init];
        ach.achievementPrune = [[NSMutableArray alloc] init];
        ach.achievementEnemy = [[NSMutableArray alloc] init];
    }
    return (ach);
}

+ (void) initAchievement {
    
}

@end
