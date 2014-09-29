//
//  Achievement.h
//  BaoMonkey
//
//  Created by remi on 17/05/14.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Achievement : NSObject

+ (void) updateAchievement;
+ (instancetype) defaultAchievement;
+ (void) updateScore;

@end
