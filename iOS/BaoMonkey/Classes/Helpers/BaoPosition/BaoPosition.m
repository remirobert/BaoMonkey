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
    return IPAD ? CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 320) : IPHONE_4 ? CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 180 + 88) : CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 180);
}

+(CGPoint)monkey{
    return IPAD ? CGPointMake(SCREEN_WIDTH / 2, ([BaoPosition treeBranch]).y + 70) : CGPointMake(SCREEN_WIDTH / 2, ([BaoPosition treeBranch].y + 35));
}

+(NSInteger)dropAction{
    return IPAD ? (SCREEN_HEIGHT - 340) : (SCREEN_HEIGHT - 200);
}

+ (CGFloat) getBetweenPlateforme {
    return IPAD ? 120.0 : 60.0;
}
//88
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

+(CGPoint)trunk{
    return IPAD ? CGPointMake((SCREEN_WIDTH / 2), 350) : CGPointMake((SCREEN_WIDTH / 2), 200);
}

+(CGPoint)frontLeafs:(CGSize)size{
    return IPHONE_4 ? CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT - (size.height / 2) + 88)) : CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT - (size.height / 2)));
}

+(CGPoint)backLeafs:(CGSize)size{
    
    return IPHONE_4 ? CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT - (size.height / 2) + 88)) : CGPointMake((SCREEN_WIDTH / 2), (SCREEN_HEIGHT - (size.height / 2)));
}

#pragma mark - BIG BUTTON

+(CGPoint)bigButtonPlay{
    return IPAD ? CGPointMake(390, 503) : CGPointMake(164, SCREEN_HEIGHT - 262);
}

+(CGPoint)bigButtonReplay{
    return IPAD ? CGPointMake(390, 503) : CGPointMake(164, SCREEN_HEIGHT - 262);
}

#pragma mark - MENU MAIN MENU

+(CGPoint)buttonSettingsMainMenu{
    return IPAD ? CGPointMake(197.5, 285) : CGPointMake(69.5, SCREEN_HEIGHT - 368);
}

+(CGPoint)buttonGameCenterMainMenu{
    return IPAD ? CGPointMake(335, 285) : CGPointMake(137, SCREEN_HEIGHT - 368);
}

+(CGPoint)buttonShareMainMenu{
    return IPAD ? CGPointMake(470, 285) : CGPointMake(204, SCREEN_HEIGHT - 368);
}

+(CGPoint)buttonInformationsMainMenu{
    return IPAD ? CGPointMake(603, 285) : CGPointMake(269.5, SCREEN_HEIGHT - 368);
}

#pragma mark - MENU PAUSE

+(CGPoint)buttonReplayPause{
    return IPAD ? CGPointMake(197.5, 287) : CGPointMake(69.5, SCREEN_HEIGHT - 368);
}

+(CGPoint)buttonHomePause{
    return IPAD ? CGPointMake(393.5, 287) : CGPointMake(167, SCREEN_HEIGHT - 368);
}

+(CGPoint)buttonSettingsPause{
    return IPAD ? CGPointMake(601, 287) : CGPointMake(269.5, SCREEN_HEIGHT - 368);
}

#pragma mark - MENU GAME OVER

+(CGPoint)buttonHomeGameOver{
    return IPAD ? CGPointMake(197.5, 285) : CGPointMake(69.5, SCREEN_HEIGHT - 368);
}

+(CGPoint)buttonGameCenterGameOver{
    return IPAD ? CGPointMake(335, 285) : CGPointMake(137, SCREEN_HEIGHT - 368);
}

+(CGPoint)buttonShareGameOver{
    return IPAD ? CGPointMake(470, 285) : CGPointMake(204, SCREEN_HEIGHT - 368);
}

+(CGPoint)buttonSettingsGameOver{
    return IPAD ? CGPointMake(603, 285) : CGPointMake(269.5, SCREEN_HEIGHT - 368);
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

+(CGPoint)bubblePositionSettings{
    return IPAD ? CGPointMake(((rand() % 10) + (SCREEN_WIDTH / 2 - 120)), ((SCREEN_HEIGHT / 2) - 37)) : CGPointMake(((rand() % 5) + (SCREEN_WIDTH / 2 - 70)), ((SCREEN_HEIGHT / 2) - 15));
}

#pragma mark - CREDITS

+(CGPoint)creditsNameDevelopersPosition{
    return IPAD ? CGPointMake(300, 400) : CGPointMake(107, 200);
}

+(CGPoint)creditsNameGraphismPosition{
    return IPAD ? CGPointMake(300, 100) : CGPointMake(107, 50);
}

@end
