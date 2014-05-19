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

+ (void) updateScore {
    Achievement *ach = [Achievement defaultAchievement];
    NSInteger currentScore = [[UserData defaultUser] score];
    int indexAchievement = 0;
    
    for (int index = 1; index < [((NSArray *)ACHIEVEMENT_POINTS) count]; index += 2) {
        if (currentScore >= [[((NSArray *)ACHIEVEMENT_POINTS) objectAtIndex:index] integerValue]) {
            ((GKAchievement *)[ach.achievementScore objectAtIndex:indexAchievement++]).percentComplete = 100.0;
            [GKNotificationBanner showBannerWithTitle:@"Challenge"
                                              message:[((NSArray *)ACHIEVEMENT_POINTS) objectAtIndex:index - 1]
                                             duration:0.5
                                    completionHandler:nil];
        }
        else
            return ;
    }
}

+ (void) updateEnemy {
    Achievement *ach = [Achievement defaultAchievement];
    NSInteger currentEnemy = [[UserData defaultUser] enemy_score];
    
    int indexAchievement = 0;
    
    for (int index = 1; index < [((NSArray *)ACHIEVEMENT_ENEMIES) count]; index += 2) {
         if (currentEnemy <= [[((NSArray *)ACHIEVEMENT_ENEMIES) objectAtIndex:index] integerValue]) {
             ((GKAchievement *)[ach.achievementEnemy
                                objectAtIndex:indexAchievement++]).percentComplete = 100 *
            currentEnemy / [[((NSArray *)ACHIEVEMENT_ENEMIES) objectAtIndex:index] integerValue];
            if (currentEnemy == [[((NSArray *)ACHIEVEMENT_ENEMIES) objectAtIndex:index] integerValue]) {
                [GKNotificationBanner showBannerWithTitle:@"Challenge"
                                                  message:[((NSArray *)ACHIEVEMENT_ENEMIES) objectAtIndex:index - 1]
                                                 duration:0.5
                                        completionHandler:nil];
            }
         }
    }
}

+ (void) updatePlums {
    Achievement *ach = [Achievement defaultAchievement];
    NSInteger currentPrune = [[UserData defaultUser] prune_score];
    
    int indexAchievement = 0;
    
    for (int index = 1; index < [((NSArray *)ACHIEVEMENT_PLUMS) count]; index += 2) {
        if (currentPrune <= [[((NSArray *)ACHIEVEMENT_PLUMS) objectAtIndex:index] integerValue]) {
            ((GKAchievement *)[ach.achievementPlums
                               objectAtIndex:indexAchievement]).percentComplete = 100 *
            currentPrune / [[((NSArray *)ACHIEVEMENT_PLUMS) objectAtIndex:index] integerValue];
            if (currentPrune == [[((NSArray *)ACHIEVEMENT_PLUMS) objectAtIndex:index] integerValue]) {
                [GKNotificationBanner showBannerWithTitle:@"Challenge"
                                                  message:[((NSArray *)ACHIEVEMENT_PLUMS) objectAtIndex:index - 1]
                                                 duration:0.5
                                        completionHandler:nil];
            }
        }
        indexAchievement++;
    }
}

+ (void) updateAchievement {
    Achievement *ach = [Achievement defaultAchievement];
    [Achievement updateEnemy];
    [Achievement updateScore];
    [Achievement updatePlums];
    
    NSArray *achievementsToComplete = [NSArray arrayWithObjects:
                                       [ach.achievementScore objectAtIndex:0],
                                       [ach.achievementScore objectAtIndex:1],
                                       [ach.achievementScore objectAtIndex:2],
                                       [ach.achievementEnemy objectAtIndex:0],
                                       [ach.achievementEnemy objectAtIndex:1],
                                       [ach.achievementEnemy objectAtIndex:2],
                                       [ach.achievementPlums objectAtIndex:0],
                                       [ach.achievementPlums objectAtIndex:1],
                                       [ach.achievementPlums objectAtIndex:2],
                                       nil];

    [GKAchievement reportAchievements:achievementsToComplete
                withCompletionHandler:nil];
}

+ (void) initUserConfigPlayer {
    Achievement *ach = [Achievement defaultAchievement];
    
    NSInteger plums = 0;
    int indexValue = 1;
    
    for (int index = 0; index < 3; index += 1) {
        NSLog(@"%f", ((GKAchievement *)[ach.achievementEnemy
                                        objectAtIndex:index]).percentComplete);
        if (((GKAchievement *)[ach.achievementEnemy
                               objectAtIndex:index]).percentComplete != 100) {
            plums = ([[((NSArray *)ACHIEVEMENT_ENEMIES) objectAtIndex:indexValue] integerValue]) /
            (100 / ((GKAchievement *)[ach.achievementEnemy
                                      objectAtIndex:index]).percentComplete);
            indexValue += 2;
        }
    }
    indexValue = 0;
    for (int index = 0; index < 3; index += 1) {
        NSLog(@"%f", ((GKAchievement *)[ach.achievementPlums
                                        objectAtIndex:index]).percentComplete);
        if (((GKAchievement *)[ach.achievementPlums
                               objectAtIndex:index]).percentComplete != 100) {
            plums = ([[((NSArray *)ACHIEVEMENT_PLUMS) objectAtIndex:indexValue] integerValue]) /
            (100 / ((GKAchievement *)[ach.achievementPlums
                                      objectAtIndex:index]).percentComplete);
            indexValue += 2;
        }
    }
    NSLog(@"init plums = %d", plums);
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
