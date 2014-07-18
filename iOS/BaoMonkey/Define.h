//
//  Define.h
//  BaoMonkey
//
//  Created by Jeremy Peltier on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#ifndef __DEFINE_H__
# define __DEFINE_H__

/*
** SYSTEM
*/

# define IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
# define IPHONE_4 ([UIScreen mainScreen].bounds.size.height == 480)

/*
** GENERAL
*/

# define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
# define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/*
** LOAD DATA
*/

# define DATA_SPLASH_SOUND                  @"splash_prune"
# define DATA_SPLASH_TEXTURE                @"splash_texture"
# define DATA_SPLASH_PLUMS1                 @"splash_plums1"
# define DATA_SPLASH_PLUMS2                 @"splash_plums2"
# define DATA_COCONUT_TEXTURE               @"coconut_texture"
# define DATA_BANANA_TEXTURE                @"banana_texture"
# define DATA_PRUNE_TEXTURE                 @"prune_texture"
# define DATA_COCONUT_SOUND                 @"coconut_sound"

# define DATA_MONKEY_WAITING                @"DATA_MONKEY_WAITING"
# define DATA_MONKEY_WALKING_ATLAS          @"DATA_MONKEY_WALKING_ATLAS"
# define DATA_MONKEY_WALKING_COCONUT_ATLAS  @"DATA_MONKEY_WALKING_COCONUT_ATLAS"
# define DATA_MONKEY_WAITING_COCONUT        @"DATA_MONKEY_WAITING_COCONUT"
# define DATA_MONKEY_LAUNCH_ATLAS           @"DATA_MONKEY_LAUNCH_ATLAS"
# define DATA_MONKEY_LAUNCH_COCONUT         @"DATA_MONKEY_LAUNCH_COCONUT"
# define DATA_MONKEY_DEAD_ATLAS             @"DATA_MONKEY_DEAD_ATLAS"
# define DATA_MONKEY_MENU_ATLAS             @"DATA_MONKEY_MENU_ATLAS"

# define DATA_LAMBERJACK_WALKING_ATLAS      @"DATA_LAMBERJACK_WALKING_ATLAS"
# define DATA_LAMBERJACK_CUTTING_ATLAS      @"DATA_LAMBERJACK_CUTTING_ATLAS"
# define DATA_LAMBERJACK_DEAD_ATLAS         @"DATA_LAMBERJACK_DEAD_ATLAS"
# define DATA_LAMBERJACK_WAITING            @"DATA_LAMBERJACK_WAITING"

# define DATA_HUNTER_WALKING_ATLAS          @"DATA_HUNTER_WALKING_ATLAS"
# define DATA_HUNTER_DEAD_ATLAS             @"DATA_HUNTER_DEAD_ATLAS"
# define DATA_HUNTER_WAITING                @"DATA_HUNTER_WAITING"

# define DATA_PLATEFORM                     @"DATA_PLATEFORM"

# define DATA_BUTTON_PLAY                   @"DATA_BUTTON_PLAY"
# define DATA_BUTTON_REPLAY                 @"DATA_BUTTON_REPLAY"
# define DATA_BUTTON_HOME                   @"DATA_BUTTON_HOME"
# define DATA_BUTTON_SETTINGS               @"DATA_BUTTON_SETTINGS"
# define DATA_BUTTON_PAUSE                  @"DATA_BUTTON_PAUSE"

/*
** USER INFORMATIONS
*/

# define ENEMY_KEY                          @"enemy_key"
# define PRUNE_KEY                          @"prune_key"
# define SCORE_KEY                          @"score_key"
# define LAUNCH_KEY                         @"launch_key"

# define ACHIEVEMENT_SCORE1                 @"Achievement_500points"
# define ACHIEVEMENT_SCORE2                 @"Achievement_1000points"
# define ACHIEVEMENT_SCORE3                 @"Achievement_1500points"
# define ACHIEVEMENT_SCORE4                 @"Achievement_5000points"

# define ACHIEVEMENT_PLUMS1                 @"Achievement_10plums"
# define ACHIEVEMENT_PLUMS2                 @"Achievement_50plums"
# define ACHIEVEMENT_PLUMS3                 @"Achievement_500plums"
# define ACHIEVEMENT_PLUMS4                 @"Achievement_2500plums"

# define ACHIEVEMENT_ENEMY1                 @"Achievement_50Enemies"
# define ACHIEVEMENT_ENEMY2                 @"Achievement_500Enemies"
# define ACHIEVEMENT_ENEMY3                 @"Achievement_5000Enemies"
# define ACHIEVEMENT_ENEMY4                 @"Achievement_15000Enemies"


/*
** ACCELEROMETER
*/

# define kAccelerometerTilt 0.15
# define kAccelerometerSpeed 25

/*
** NOTIFICATIONS
*/

# define NOTIFICATION_DROP_MONKEY_ITEM      @"NOTIFICATION_DROP_MONKEY_ITEM"
# define NOTIFICATION_DROP_WEAPON           @"NOTIFICATION_DROP_WEAPON"
# define NOTIFICATION_PAUSE_GAME            @"NOTIFICATION_PAUSE_GAME"
# define NOTIFICATION_RESUME_GAME           @"NOTIFICATION_RESUME_GAME"
# define NOTIFICATION_RETRY_GAME            @"NOTIFICATION_RETRY_GAME"
# define NOTIFICATION_START_GAME            @"NOTIFICATION_START_GAME"
# define NOTIFICATION_GO_TO_HOME            @"NOTIFICATION_GO_TO_HOME"
# define NOTIFICATION_GO_TO_SETTINGS        @"NOTIFICATION_GO_TO_SETTINGS"
# define NOTIFICATION_SHOW_GAME_CENTER      @"NOTIFICATION_SHOW_GAME_CENTER"
# define NOTIFICATION_SHOW_GAME_CENTER_LOGIN      @"NOTIFICATION_SHOW_GAME_CENTER_LOGIN"
# define NOTIFICATION_SHOW_AD               @"NOTIFICATION_SHOW_AD"

/*
** SKACTION KEY
*/

# define SKACTION_MONKEY_WALKING            @"SKACTION_MONKEY_WALKING"
# define SKACTION_MONKEY_WALKING_COCONUT    @"SKACTION_MONKEY_WALKING_COCONUT"
# define SKACTION_MONKEY_LAUNCH             @"SKACTION_MONKEY_LAUNCH"
# define SKACTION_MONKEY_DEAD               @"SKACTION_MONKEY_DEAD"

# define SKACTION_PRUNE_SPLASH              @"SKACTION_PRUNE_SPLASH"

# define SKACTION_LAMBERJACK_WALKING        @"SKACTION_LAMBERJACK_WALKING"
# define SKACTION_LAMBERJACK_CUTTING        @"SKACTION_LAMBERJACK_CUTTING"
# define SKACTION_LAMBERJACK_DEAD           @"SKACTION_LAMBERJACK_DEAD"

# define SKACTION_HUNTER_WALKING            @"SKACTION_HUNTER_WALKING"
# define SKACTION_HUNTER_DEAD               @"SKACTION_HUNTER_DEAD"

/*
** NODE NAME
*/

# define ENEMY_NODE_NAME                    @"ENEMY_NODE_NAME"
# define WEAPON_NODE_NAME                   @"WEAPON_NODE_NAME"
# define ITEM_NODE_NAME                     @"ITEM_NODE_NAME"
# define PAUSE_BUTTON_NODE_NAME             @"PAUSE_NODE_NAME"
# define TRUNK_NODE_NAME                    @"TRUNK_NODE_NAME"
# define BACK_LEAF_NODE_NAME                @"BACK_LEAF_NODE_NAME"
# define FRONT_LEAF_NODE_NAME               @"FRONT_LEAF_NODE_NAME"
# define BACKGROUND_PROGRESS_BAR_NODE_NAME  @"trunkProgressLife background"
# define FRONT_PROGRESS_BAR_NODE_NAME       @"trunkProgressLife front"
# define SCORE_NODE_NAME                    @"SCORE_NODE_NAME"
# define SHOOT_NODE_NAME                    @"SHOOT_NODE_NAME"
# define CLOUD_NODE_NAME                    @"CLOUD_NODE_NAME"
# define RETRY_NODE_NAME                    @"RETRY_NODE_NAME"
# define RESUME_NODE_NAME                   @"RESUME_NODE_NAME"
# define HOME_NODE_NAME                     @"HOME_NODE_NAME"
# define SETTINGS_NODE_NAME                 @"SETTINGS_NODE_NAME"
# define COUNTDOWN_NODE_NAME                @"COUNTDOWN_NODE_NAME"
# define GAMEOVER_NODE_NAME                 @"GAMEOVER_NODE_NAME"
# define GAMECENTER_NODE_NAME               @"GAMECENTER_NODE_NAME"
# define SHARE_NODE_NAME                    @"SHARE_NODE_NAME"
# define INFOS_NODE_NAME                    @"INFOS_NODE_NAME"

/*
** POS FLOOR
*/

#define MIN_POSY_FLOOR  90.0
#define SPACE_BETWEEN   60.0
#define FLOOR_WIDTH     105.0
#define FLOOR_HEIGHT    30.0

/*
** NSUSERDEFAULT
*/

# define NSUSERDEFAULT_ACCELEROMETER_SPEED  @"NSUSERDEFAULT_ACCELEROMETER_SPEED"
# define NSUSERDEFAULT_MUSIC_VOLUME         @"NSUSERDEFAULT_MUSIC_VOLUME"
# define NSUSERDEFAULT_EFFECTS_VOLUME       @"NSUSERDEFAULT_EFFECTS_VOLUME"

/*
** STORYBOARD TAG
*/

# define TAG_SLIDER_MUSIC_VOLUME 1
# define TAG_SLIDER_SOUND_EFFECTS_VOLUME 2
# define TAG_SLIDER_ACCELEROMETER_SPEED 3

/*
** STORYBOARD VIEW CONTROLLER IDENTIFIER
*/

# define STORYBOARD_IDENTIFIER_SETTINGS @"SETTINGS_VIEW_CONTROLLER"

/*
** ACHIEVEMENTS
*/

# define    ACHIEVEMENT_POINTS  [NSArray arrayWithObjects:@"Achievement_500points", @"500", @"Achievement_1000points", @"1000", @"Achievement_1500points", @"1500", @"Achievement_5000points", @"5000", nil]
# define    ACHIEVEMENT_PLUMS   [NSArray arrayWithObjects:@"Achievement_10plums", @"10", @"Achievement_50plums", @"50", @"Achievement_500plums", @"500", @"Achievement_2500plums", @"2500", nil]
# define    ACHIEVEMENT_ENEMIES [NSArray arrayWithObjects:@"Achievement_50Enemies", @"50", @"Achievement_500Enemies", @"500", @"Achievement_5000Enemies", @"5000", @"Achievement_15000Enemies", @"15000", nil]

# define    STR_ACHIEVEMENT_POINTS  [NSArray arrayWithObjects:@"500 points", @"500", @"1000 points", @"1000", @"1500 points", @"1500", @"5000 points", @"5000", nil]
# define    STR_ACHIEVEMENT_PLUMS   [NSArray arrayWithObjects:@"10 plums", @"10", @"50 plums", @"50", @"500 plums", @"500", @"2500 plums", @"2500", nil]
# define    STR_ACHIEVEMENT_ENEMIES [NSArray arrayWithObjects:@"50 Enemies killed", @"50", @"500 Enemies killed", @"500", @"5000 Enemies killed", @"5000", @"15000 Enemies killed", @"15000", nil]


/*
** TRUNK LIFE
*/

# define LUMBERJACK_DESTROY_POINT 0.1
# define TRUNKLIFE_REGENERATE 0.05

/*
** ENUM
*/

typedef enum {
    LEFT,
    RIGHT,
    FRONT,
    BACK
} Direction;

#endif
