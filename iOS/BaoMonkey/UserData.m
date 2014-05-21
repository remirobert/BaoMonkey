//
//  UserData.m
//  BaoMonkey
//
//  Created by iPPLE on 16/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "UserData.h"
#import "Define.h"
#import "Achievement.h"

@interface UserData ()
@property (nonatomic, strong) NSUserDefaults *user;

@property (nonatomic, assign) BOOL achievement_score_1;
@property (nonatomic, assign) BOOL achievement_score_2;
@property (nonatomic, assign) BOOL achievement_score_3;
@property (nonatomic, assign) BOOL achievement_score_4;

@property (nonatomic, assign) BOOL achievement_enemy_1;
@property (nonatomic, assign) BOOL achievement_enemy_2;
@property (nonatomic, assign) BOOL achievement_enemy_3;
@property (nonatomic, assign) BOOL achievement_enemy_4;

@property (nonatomic, assign) BOOL achievement_plums_1;
@property (nonatomic, assign) BOOL achievement_plums_2;
@property (nonatomic, assign) BOOL achievement_plums_3;
@property (nonatomic, assign) BOOL achievement_plums_4;
@end

@implementation UserData

@synthesize musicVolume, soundEffectsVolume, accelerometerSpeed;

+ (instancetype) defaultUser {
    static UserData *userData;
    
    if (userData == nil) {
        userData = [[UserData alloc] init];
        userData.user = [NSUserDefaults standardUserDefaults];
    }
    return (userData);
}

+ (void) launch {
    UserData *userData;
    
    userData = [UserData defaultUser];
    [userData.user setBool:YES forKey:LAUNCH_KEY];
}

+ (void) initUserData {
    UserData *userData;
    
    userData = [UserData defaultUser];
    userData.enemy_score = [userData.user integerForKey:ENEMY_KEY];
    userData.prune_score = [userData.user integerForKey:PRUNE_KEY];
    userData.score = [userData.user integerForKey:SCORE_KEY];
    
    userData.achievement_enemy_1 = [userData.user boolForKey:ACHIEVEMENT_ENEMY1];
    userData.achievement_enemy_2 = [userData.user boolForKey:ACHIEVEMENT_ENEMY2];
    userData.achievement_enemy_3 = [userData.user boolForKey:ACHIEVEMENT_ENEMY3];
    userData.achievement_enemy_4 = [userData.user boolForKey:ACHIEVEMENT_ENEMY4];

    userData.achievement_score_1 = [userData.user boolForKey:ACHIEVEMENT_SCORE1];
    userData.achievement_score_2 = [userData.user boolForKey:ACHIEVEMENT_SCORE2];
    userData.achievement_score_3 = [userData.user boolForKey:ACHIEVEMENT_SCORE3];
    userData.achievement_score_4 = [userData.user boolForKey:ACHIEVEMENT_SCORE4];

    userData.achievement_plums_1 = [userData.user boolForKey:ACHIEVEMENT_PLUMS1];
    userData.achievement_plums_2 = [userData.user boolForKey:ACHIEVEMENT_PLUMS2];
    userData.achievement_plums_3 = [userData.user boolForKey:ACHIEVEMENT_PLUMS3];
    userData.achievement_plums_4 = [userData.user boolForKey:ACHIEVEMENT_PLUMS4];
}

+ (BOOL) check

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
    [Achievement updateAchievement];
}

+ (void) addPrune {
    UserData *userData;
    
    userData = [UserData defaultUser];
    userData.prune_score++;
    [Achievement updateAchievement];
}

+ (void) updateScore:(NSInteger)score {
    UserData *userData;
    
    userData = [UserData defaultUser];
    if (userData.score < score) {
        userData.score = score;
        [Achievement updateAchievement];
    }
}

#pragma mark - User Settings values

+(CGFloat)getAccelerometerUserSpeed{
    return [[UserData defaultUser] getAccelerometerUserSpeed];
}

-(CGFloat)getAccelerometerUserSpeed{
    return accelerometerSpeed;
}

+(CGFloat)getMusicUserVolume{
    return [[UserData defaultUser] getMusicUserVolume];
}

-(CGFloat)getMusicUserVolume{
    return musicVolume;
}

+(CGFloat)getSoundEffectsUserVolume{
    return [[UserData defaultUser] getSoundEffectsUserVolume];
}

-(CGFloat)getSoundEffectsUserVolume{
    return musicVolume;
}

+(void)setAccelerometerUserSpeed:(CGFloat)speed{
    [[UserData defaultUser] setAccelerometerUserSpeed:speed];
}

-(void)setAccelerometerUserSpeed:(CGFloat)speed{
    if (accelerometerSpeed != speed) {
        accelerometerSpeed = speed;
        UserData *userData = [UserData defaultUser];
        [userData.user setFloat:speed forKey:NSUSERDEFAULT_ACCELEROMETER_SPEED];
    }
}

+(void)setMusicUserVolume:(CGFloat)volume{
    [[UserData defaultUser] setMusicUserVolume:volume];
}

-(void)setMusicUserVolume:(CGFloat)volume{
    if (musicVolume != volume) {
        musicVolume = volume;
        UserData *userData = [UserData defaultUser];
        [userData.user setFloat:volume forKey:NSUSERDEFAULT_MUSIC_VOLUME];
    }
}

+(void)setSoundEffectsUserVolume:(CGFloat)volume{
    [[UserData defaultUser] setSoundEffectsUserVolume:volume];
}

-(void)setSoundEffectsUserVolume:(CGFloat)volume{
    if (soundEffectsVolume != volume) {
        soundEffectsVolume = volume;
        UserData *userData = [UserData defaultUser];
        [userData.user setFloat:volume forKey:NSUSERDEFAULT_EFFECTS_VOLUME];
    }
}

@end
