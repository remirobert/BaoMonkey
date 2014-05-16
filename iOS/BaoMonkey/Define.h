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
** GENERAL
*/

# define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
# define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/*
** USER INFORMATIONS
*/

# define ENEMY_KEY                          @"enemy_key"
# define PRUNE_KEY                          @"prune_key"
# define SCORE_KEY                          @"score_key"

/*
** ACCELEROMETER
*/

# define kAccelerometerTilt 0.1
# define kAccelerometerSpeed 25

/*
** NOTIFICATIONS
*/

# define NOTIFICATION_DROP_MONKEY_ITEM      @"NOTIFICATION_DROP_MONKEY_ITEM"
# define NOTIFICATION_DROP_WEAPON           @"NOTIFICATION_DROP_WEAPON"
# define NOTIFICATION_PAUSE_GAME            @"NOTIFICATION_PAUSE_GAME"
# define NOTIFICATION_RETRY_GAME            @"NOTIFICATION_RETRY_GAME"

/*
** SKACTION KEY
*/

# define SKACTION_MONKEY_WALKING            @"SKACTION_MONKEY_WALKING"
# define SKACTION_PRUNE_SPLASH              @"SKACTION_PRUNE_SPLASH"

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

/*
** POS FLOOR
*/

#define MIN_POSY_FLOOR  90.0
#define SPACE_BETWEEN   60.0
#define FLOOR_WIDTH     105.0
#define FLOOR_HEIGHT    15.0

/*
** NSUSERDEFAULT
*/

# define NSUSERDEFAULT_ACCELEROMETER_SPEED @"NSUSERDEFAULT_ACCELEROMETER_SPEED"
# define NSUSERDEFAULT_MUSIC_VOLUME @"NSUSERDEFAULT_MUSIC_VOLUME"
# define NSUSERDEFAULT_EFFECTS_VOLUME @"NSUSERDEFAULT_EFFECTS_VOLUME"

/*
** Stroryboard tag
*/

# define TAG_SLIDER_MUSIC_VOLUME 1
# define TAG_SLIDER_SOUND_EFFECTS_VOLUME 2
# define TAG_SLIDER_ACCELEROMETER_SPEED 3

#endif
