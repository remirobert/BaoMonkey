//
//  GameCenter.m
//  BaoMonkey
//
//  Created by iPPLE on 20/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "GameCenter.h"
#import "UserData.h"
#import "Define.h"

@implementation GameCenter

+ (instancetype) defaultGameCenter {
    static GameCenter *gameCenter;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        gameCenter = [[GameCenter alloc] init];        
    });
    return (gameCenter);
}

# pragma mark - GameCenter authentification

+(void)authenticateLocalPlayer {
    [[GameCenter defaultGameCenter] authenticateLocalPlayer];
}

-(void)authenticateLocalPlayer{
    _localPlayer = [GKLocalPlayer localPlayer];
    
    __weak typeof(self) weakSelf = self;
    _localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error){
        if ([GKLocalPlayer localPlayer].authenticated) {
            weakSelf.gameCenterEnabled = YES;
            
            // Get the default leaderboard identifier.
            [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *defaultLeaderboardIdentifier, NSError *error) {
                
                if (error != nil) {
                    NSLog(@"%@", [error localizedDescription]);
                }
                else{
                    weakSelf.leaderboardIdentifier = defaultLeaderboardIdentifier;
                    NSLog(@"player %@", weakSelf.localPlayer.playerID);
                }
            }];
        }
        
        else {
            weakSelf.gameCenterEnabled = NO;
        }
    };
}

# pragma mark - GameCenter LeaderBoard

+(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard withViewController:(UIViewController*)viewController{
    [[GameCenter defaultGameCenter] showLeaderboardAndAchievements:shouldShowLeaderboard withViewController:viewController];
}

-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard withViewController:(UIViewController*)viewController{
    GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
    
    gcViewController.gameCenterDelegate = self;
    
    if (shouldShowLeaderboard) {
        gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gcViewController.leaderboardIdentifier = _leaderboardIdentifier;
    }
    else{
        gcViewController.viewState = GKGameCenterViewControllerStateAchievements;
    }
    [viewController presentViewController:gcViewController animated:YES completion:nil];
}

-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

+(NSString*)getLeaderboardIdentifier {
    return [[GameCenter defaultGameCenter] leaderboardIdentifier];
}

-(NSString*)getLeaderboardIdentifier {
    return _leaderboardIdentifier;
}

# pragma mark - GameCenter score

+ (void) reportScore {
    GKScore *scoreReport = [[GKScore alloc] initWithLeaderboardIdentifier:@"baoMonkeyLeaderboard"];
    scoreReport.value = [[UserData defaultUser] score];
    
    NSArray *tabScore = [NSArray arrayWithObjects:scoreReport, nil];
    
    [GKScore reportScores:tabScore withCompletionHandler:nil];
}

+ (void) getBestScorePlayer {
    GKLeaderboard *leaderboardRequest = [[GKLeaderboard alloc] init];
    leaderboardRequest.identifier = [[GameCenter defaultGameCenter] leaderboardIdentifier];
    
    [leaderboardRequest loadScoresWithCompletionHandler:^(NSArray *scores, NSError *error) {
        
        if (scores) {
            [UserData defaultUser].score = (int)leaderboardRequest.localPlayerScore.value;
        }
        return ;
    }];
}

+ (void) initUserDataProgress {
    if (![[GameCenter defaultGameCenter] gameCenterEnabled])
        return ;
    
    [GKAchievement loadAchievementsWithCompletionHandler:^(NSArray *achievements, NSError *error) {
        for (GKAchievement *currentAchievement in achievements) {
            NSArray *tabParseIdentifer = [currentAchievement.identifier componentsSeparatedByString:@"0"];
            
            NSLog(@"first = ù%@")
            
            NSLog(@"%@ = %f", currentAchievement.identifier, currentAchievement.percentComplete);
        }
    }];
    
}

@end
