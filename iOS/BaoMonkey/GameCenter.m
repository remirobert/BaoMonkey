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
        
        if (error != nil) {
            NSLog(@"Error debug for download achievement : %@", error);
            return ;
        }
        NSInteger indexPlums = 1;
        NSInteger indexEnemie = 1;
        
        for (GKAchievement *currentAchievement in achievements) {
            NSArray *tabParseIdentifer = [currentAchievement.identifier componentsSeparatedByString:@"0"];
            
            if (currentAchievement.percentComplete != 100) {
                if (indexPlums < [ACHIEVEMENT_PLUMS count] &&
                    [((NSString *)[tabParseIdentifer objectAtIndex:[tabParseIdentifer count] - 1]) isEqualToString:@"plums"]) {
                    NSLog(@"Plums = %f", [[ACHIEVEMENT_PLUMS objectAtIndex:indexPlums] integerValue] * currentAchievement.percentComplete / 100);
                    NSLog(@"CHACK VALUES = %d %d", [[UserData defaultUser] prune_score], [[ACHIEVEMENT_PLUMS objectAtIndex:indexPlums] integerValue]);
//                    [[UserData defaultUser] setPrune_score:0];
                }
                else if (indexEnemie < [ACHIEVEMENT_ENEMIES count] &&
                         [((NSString *)[tabParseIdentifer objectAtIndex:[tabParseIdentifer count] - 1]) isEqualToString:@"Enemies"]) {
                    NSLog(@"Enemies = %f", [[ACHIEVEMENT_ENEMIES objectAtIndex:indexEnemie] integerValue] * currentAchievement.percentComplete / 100);
                    NSLog(@"CHACK VALUES = %d %d", [[UserData defaultUser] enemy_score], [[ACHIEVEMENT_ENEMIES objectAtIndex:indexPlums] integerValue]);

//                    [[UserData defaultUser] setEnemy_score:0];
                }
            }
            
            if ([((NSString *)[tabParseIdentifer objectAtIndex:[tabParseIdentifer count] - 1]) isEqualToString:@"plums"]) {
                indexPlums += 2;
            }
            else if ([((NSString *)[tabParseIdentifer objectAtIndex:[tabParseIdentifer count] - 1]) isEqualToString:@"Enemies"]) {
                indexEnemie += 2;
            }
            NSLog(@"check value = %d %d", indexEnemie, indexPlums);
        }
    }];
    
}

@end
