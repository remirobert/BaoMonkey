//
//  UserData.m
//  BaoMonkey
//
//  Created by iPPLE on 16/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "UserData.h"
#import "Define.h"

@interface UserData ()
@property (nonatomic, strong) NSUserDefaults *user;
@end

@implementation UserData

+ (instancetype) defaultUser {
    static UserData *userData;
    
    if (userData == nil) {
        userData = [[UserData alloc] init];
        userData.user = [NSUserDefaults standardUserDefaults];
    }
    return (userData);
}

+ (void) initUserData {
    UserData *userData;
    
    userData = [UserData defaultUser];
    userData.enemy_score = [userData.user integerForKey:ENEMY_KEY];
    userData.prune_score = [userData.user integerForKey:PRUNE_KEY];
    userData.score = [userData.user integerForKey:SCORE_KEY];
}

+ (void) saveUserData {
    UserData *userData;
    
    userData = [UserData defaultUser];
    [userData.user setInteger:userData.enemy_score forKey:ENEMY_KEY];
    [userData.user setInteger:userData.prune_score forKey:PRUNE_KEY];
    [userData.user setInteger:userData.score forKey:SCORE_KEY];
}

+ (void) resetUserData {
    UserData *userData;
    
    userData = [UserData defaultUser];
    userData.enemy_score = userData.prune_score = userData.score = 0;
    [self saveUserData];
}

+ (void) addEnemy {
    UserData *userData;
    
    userData = [UserData defaultUser];
    userData.enemy_score++;
}

+ (void) addPrune {
    UserData *userData;
    
    userData = [UserData defaultUser];
    userData.prune_score++;
}

+ (void) updateScore:(NSInteger)score {
    UserData *userData;
    
    userData = [UserData defaultUser];
    if (userData.score < score)
        userData.score = score;
}

@end
