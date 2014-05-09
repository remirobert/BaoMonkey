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
** ACCELEROMETER
*/

# define kAccelerometerSpeed 15

/*
** NOTIFICATIONS
*/

# define NOTIFICATION_DROP_MONKEY_ITEM @"NOTIFICATION_DROP_MONKEY_ITEM"
# define NOTIFICATION_DROP_WEAPON @"NOTIFICATION_DROP_WEAPON"
# define NOTIFICATION_PAUSE_GAME @"NOTIFICATION_PAUSE_GAME"

/*
** SKACTION KEY
*/

# define SKACTION_MONKEY_WALKING @"SKACTION_MONKEY_WALKING"
# define SKACTION_PRUNE_SPLASH @"SKACTION_PRUNE_SPLASH"

/*
** NODE NAME
*/

# define ENEMY_NODE_NAME                    @"EnemyNode"
# define WEAPON_NODE_NAME                   @"Weapon"
# define ITEM_NODE_NAME                     @"Item"
# define PAUSE_BUTTON_NODE_NAME             @"PAUSE"
# define TRUNK_NODE_NAME                    @"TRUNK"
# define BACK_LEAF_NODE_NAME                @"BACK_LEAF"
# define FRONT_LEAF_NODE_NAME               @"FRONT_LEAF"
# define BACKGROUND_PROGRESS_BAR_NODE_NAME  @"trunkProgressLife background"
# define FRONT_PROGRESS_BAR_NODE_NAME       @"trunkProgressLife front"
# define SCORE_NODE_NAME                    @"SCORE"
# define SHOOT_NODE_NAME                    @"Shoot"

/*
** POS FLOOR
*/

#define MIN_POSY_FLOOR  90.0
#define SPACE_BETWEEN   60.0
#define FLOOR_WIDTH     105.0
#define FLOOR_HEIGHT    15.0

#endif
