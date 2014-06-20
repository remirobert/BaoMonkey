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

#pragma mark - POSITION WITH SCREEN

+(CGPoint)middleScreen;
+(CGPoint)leftCenter;
+(CGPoint)rightCenter;

#pragma mark - TRUNK, FRONT LEAFS, BACK LEAFS

+(CGPoint)trunk;
+(CGPoint)frontLeafs:(CGSize)size;
+(CGPoint)backLeafs:(CGSize)size;

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

#pragma mark - MENU SETTINGS

+(CGPoint)buttonBackSettings;
+(CGPoint)cursorMusicSettings;
+(CGPoint)cursorSoundEffectsSettings;
+(CGPoint)cursorAccelerometerSettings;
+(CGPoint)bubblePositionSettings;

#pragma mark - CREDITS

+(CGPoint)buttonBackCredits;
+(CGPoint)creditsNameDevelopersPosition;
+(CGPoint)creditsNameGraphismPosition;

@end
