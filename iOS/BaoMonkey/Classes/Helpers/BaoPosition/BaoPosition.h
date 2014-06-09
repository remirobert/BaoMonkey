//
//  BaoPosition.h
//  BaoMonkey
//
//  Created by Jeremy Peltier on 05/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Define.h"

@interface BaoPosition : NSObject

+(CGPoint)treeBranch;
+(CGPoint)monkey;
+(NSInteger)dropAction;
+(CGFloat)getBetweenPlateforme;
+(NSString *)pathFireTank;

#pragma mark - BIG BUTTON

+(CGPoint)bigButtonPlay;
+(CGPoint)bigButtonReplay;

#pragma mark - MENU MAIN MENU

+(CGPoint)buttonSettingsMainMenu;
+(CGPoint)buttonGameCenterMainMenu;
+(CGPoint)buttonShareMainMenu;
+(CGPoint)buttonInformationsMainMenu;

#pragma mark - MENU PAUSE

+(CGPoint)buttonReplayPause;
+(CGPoint)buttonHomePause;
+(CGPoint)buttonSettingsPause;

#pragma mark - MENU GAME OVER

+(CGPoint)buttonHomeGameOver;
+(CGPoint)buttonGameCenterGameOver;
+(CGPoint)buttonShareGameOver;
+(CGPoint)buttonSettingsGameOver;

@end