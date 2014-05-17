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
#import "Define.h"

@interface Achievement ()
@property (nonatomic, strong) NSArray *achievementScore;
@property (nonatomic, strong) NSArray *achievementPlums;
@property (nonatomic, strong) NSArray *achievementEnemy;
@end

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


+ (void) updateScore:(NSArray *)tabScore {
    Achievement *ach = [Achievement defaultAchievement];
    NSInteger currentScore = [[UserData defaultUser] score];
    int indexAchievement = 0;
    
    for (int index = 1; index < [((NSArray *)ACHIEVEMENT_POINTS) count]; index += 2) {
        if (currentScore >= [[((NSArray *)ACHIEVEMENT_POINTS) objectAtIndex:index] integerValue]) {
            ((GKAchievement *)[ach.achievementScore objectAtIndex:indexAchievement++]).percentComplete = 100.0;
        }
        else
            return ;
    }
}



+ (instancetype) defaultAchievement {
    static Achievement *ach;
    
    if (ach == nil) {
        ach = [[Achievement alloc] init];
        
        ach.achievementEnemy = @[[[GKAchievement alloc] initWithIdentifier: [((NSArray *)ACHIEVEMENT_ENEMIES) objectAtIndex:0]],
                                 [[GKAchievement alloc] initWithIdentifier: [((NSArray *)ACHIEVEMENT_ENEMIES) objectAtIndex:2]],
                                 [[GKAchievement alloc] initWithIdentifier: [((NSArray *)ACHIEVEMENT_ENEMIES) objectAtIndex:4]],
                                 [[GKAchievement alloc] initWithIdentifier: [((NSArray *)ACHIEVEMENT_ENEMIES) objectAtIndex:6]]];
        ach.achievementScore = @[[[GKAchievement alloc] initWithIdentifier: [((NSArray *)ACHIEVEMENT_POINTS) objectAtIndex:0]],
                                 [[GKAchievement alloc] initWithIdentifier: [((NSArray *)ACHIEVEMENT_POINTS) objectAtIndex:2]],
                                 [[GKAchievement alloc] initWithIdentifier: [((NSArray *)ACHIEVEMENT_POINTS) objectAtIndex:4]],
                                 [[GKAchievement alloc] initWithIdentifier: [((NSArray *)ACHIEVEMENT_POINTS) objectAtIndex:6]]];
        ach.achievementPlums = @[[[GKAchievement alloc] initWithIdentifier: [((NSArray *)ACHIEVEMENT_PLUMS) objectAtIndex:0]],
                                 [[GKAchievement alloc] initWithIdentifier: [((NSArray *)ACHIEVEMENT_PLUMS) objectAtIndex:2]],
                                 [[GKAchievement alloc] initWithIdentifier: [((NSArray *)ACHIEVEMENT_PLUMS) objectAtIndex:4]],
                                 [[GKAchievement alloc] initWithIdentifier: [((NSArray *)ACHIEVEMENT_PLUMS) objectAtIndex:6]]];
    }
    return (ach);
}

@end
