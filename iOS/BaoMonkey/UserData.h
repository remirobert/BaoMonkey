//
//  UserData.h
//  BaoMonkey
//
//  Created by iPPLE on 16/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject

@property (nonatomic, assign) NSInteger enemy_score;
@property (nonatomic, assign) NSInteger prune_score;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) CGFloat musicVolume;
@property (nonatomic, assign) CGFloat soundEffectsVolume;
@property (nonatomic, assign) CGFloat accelerometerSpeed;
@property (nonatomic, assign) BOOL isFirstRun;

+ (void) initUserData;
+ (void) saveUserData;
+ (void) resetUserData;
+ (void) addEnemy;
+ (void) addPrune;
+ (void) updateScore:(NSInteger)score;
+ (instancetype) defaultUser;

+(CGFloat)getAccelerometerUserSpeed;
+(CGFloat)getMusicUserVolume;
+(CGFloat)getSoundEffectsUserVolume;
+(void)setAccelerometerUserSpeed:(CGFloat)speed;
+(void)setMusicUserVolume:(CGFloat)volume;
+(void)setSoundEffectsUserVolume:(CGFloat)volume;
+(void)launch;

@end
