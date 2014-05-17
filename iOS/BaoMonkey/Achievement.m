//
//  Achievement.m
//  BaoMonkey
//
//  Created by remi on 17/05/14.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "UserData.h"
#import "Achievement.h"

@implementation Achievement

- (void) completeMultipleAchievements
{
    GKAchievement *achievement1 = [[GKAchievement alloc] initWithIdentifier: @"DefeatedFinalBoss"];
    GKAchievement *achievement2 = [[GKAchievement alloc] initWithIdentifier: @"FinishedTheGame"];
    GKAchievement *achievement3 = [[GKAchievement alloc] initWithIdentifier: @"PlayerIsAwesome"];
    achievement1.percentComplete = 100.0;
    achievement2.percentComplete = 100.0;
    achievement3.percentComplete = 100.0;
    
    NSArray *achievementsToComplete = [NSArray arrayWithObjects:achievement1,achievement2,achievement3, nil];
    [GKAchievement reportAchievements: achievementsToComplete withCompletionHandler:^(NSError *error)
     {
         if (error != nil)
         {
             NSLog(@"Error in reporting achievements: %@", error);
         }
     }];
}


+ (void) initializeAchieviement:(NSArray *)tab {
}

+ (instancetype) defaultAchievement {
    static Achievement *ach;
    
    if (ach == nil) {
        ach = [[Achievement alloc] init];
    }
    return (ach);
}

@end
