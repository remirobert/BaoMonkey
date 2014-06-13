//
//  BaoPosition.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 05/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "BaoPosition.h"

@implementation BaoPosition

+(CGPoint)treeBranch{
    return IPAD ? CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 320) : CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 180);
}

+(CGPoint)monkey{
    return IPAD ? CGPointMake(SCREEN_WIDTH / 2, ([BaoPosition treeBranch]).y + 60) : CGPointMake(SCREEN_WIDTH / 2, ([BaoPosition treeBranch].y + 30));
}

+(NSInteger)dropAction{
    return IPAD ? (SCREEN_HEIGHT - 340) : (SCREEN_HEIGHT - 200);
}

+ (CGFloat) getBetweenPlateforme {
    return IPAD ? 120.0 : 60.0;
}

+ (NSString *) pathFireTank {
    return IPAD ? [[NSBundle mainBundle] pathForResource:@"fire_ipad" ofType:@"sks"] :
    [[NSBundle mainBundle] pathForResource:@"fire" ofType:@"sks"];
}

#pragma mark - POSITION WITH SCREEN

+(CGPoint)middleScreen {
    return CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT / 2));
}

+(CGPoint)leftCenter{
    return CGPointMake(0, (SCREEN_HEIGHT / 2));
}

+(CGPoint)rightCenter{
    return CGPointMake(SCREEN_WIDTH, (SCREEN_HEIGHT / 2));
}

#pragma mark - TRUNK, FRONT LEAFS, BACK LEAFS

+(CGPoint)frontLeafs:(CGSize)size{
    return CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT - (size.height / 2)));
}

+(CGPoint)backLeafs:(CGSize)size{
    return CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT - (size.height / 2)));
}

#pragma mark - BIG BUTTON

+(CGPoint)bigButtonPlay{
    return IPAD ? CGPointMake(390, 503) : CGPointMake(164, 306);
}

+(CGPoint)bigButtonReplay{
    return IPAD ? CGPointMake(390, 503) : CGPointMake(164, 306);
}

#pragma mark - MENU MAIN MENU

+(CGPoint)buttonSettingsMainMenu{
    return IPAD ? CGPointMake(197.5, 285) : CGPointMake(69.5, 200);
}

+(CGPoint)buttonGameCenterMainMenu{
    return IPAD ? CGPointMake(335, 285) : CGPointMake(137, 200);
}

+(CGPoint)buttonShareMainMenu{
    return IPAD ? CGPointMake(470, 285) : CGPointMake(204, 200);
}

+(CGPoint)buttonInformationsMainMenu{
    return IPAD ? CGPointMake(603, 285) : CGPointMake(269.5, 200);
}

#pragma mark - MENU PAUSE

+(CGPoint)buttonReplayPause{
    return IPAD ? CGPointMake(197.5, 287) : CGPointMake(69.5, 200);
}

+(CGPoint)buttonHomePause{
    return IPAD ? CGPointMake(393.5, 287) : CGPointMake(204, 200);
}

+(CGPoint)buttonSettingsPause{
    return IPAD ? CGPointMake(601, 287) : CGPointMake(269.5, 200);
}

#pragma mark - MENU GAME OVER

+(CGPoint)buttonHomeGameOver{
    return IPAD ? CGPointMake(197.5, 285) : CGPointMake(69.5, 200);
}

+(CGPoint)buttonGameCenterGameOver{
    return IPAD ? CGPointMake(335, 285) : CGPointMake(137, 200);
}

+(CGPoint)buttonShareGameOver{
    return IPAD ? CGPointMake(470, 285) : CGPointMake(204, 200);
}

+(CGPoint)buttonSettingsGameOver{
    return IPAD ? CGPointMake(603, 285) : CGPointMake(269.5, 200);
}

#pragma mark - MENU SETTINGS

+(CGPoint)buttonBackSettings{
    return IPAD ? CGPointMake(SCREEN_WIDTH / 2 + 22.5f, SCREEN_HEIGHT / 2 - 295) : CGPointMake(SCREEN_WIDTH - 150, SCREEN_HEIGHT - 440);
}

+(CGPoint)cursorMusicSettings{
    return IPAD ? CGPointMake(SCREEN_WIDTH / 2 + 64, SCREEN_HEIGHT / 2 + 203) : CGPointMake(SCREEN_WIDTH - 130, SCREEN_HEIGHT - 168.5f);
}

+(CGPoint)cursorSoundEffectsSettings{
    return IPAD ? CGPointMake(SCREEN_WIDTH / 2 + 64, SCREEN_HEIGHT / 2 + 83) : CGPointMake(SCREEN_WIDTH - 130, SCREEN_HEIGHT - 234.5f);
}

+(CGPoint)cursorAccelerometerSettings{
    return IPAD ? CGPointMake(SCREEN_WIDTH / 2 + 64, SCREEN_HEIGHT / 2 - 37) : CGPointMake(SCREEN_WIDTH - 130, SCREEN_HEIGHT - 300);
}

@end
