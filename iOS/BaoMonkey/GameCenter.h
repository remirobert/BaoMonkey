//
//  GameCenter.h
//  BaoMonkey
//
//  Created by iPPLE on 20/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GameCenter : NSObject <GKGameCenterControllerDelegate>

@property (nonatomic, assign) BOOL gameCenterEnabled;
@property (nonatomic, strong) NSString *leaderboardIdentifier;

+ (void) showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard withViewController:(UIViewController*)viewController;
+ (void) authenticateLocalPlayer;
+ (instancetype) defaultGameCenter;
+ (NSString *) getLeaderboardIdentifier;
+ (void) reportScore;
+ (void) getBestScorePlayer;

@end
