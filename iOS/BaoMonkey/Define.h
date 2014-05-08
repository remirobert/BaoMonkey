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

/*
** SKACTION KEY
*/

# define SKACTION_MONKEY_WALKING @"SKACTION_MONKEY_WALKING"

/*
** NODE NAME
*/

# define ENEMY_NODE_NAME @"EnemyNode"
# define WEAPON_NODE_NAME @"Weapon"
# define ITEM_NODE_NAME @"Item"
# define PAUSE_BUTTON_NODE_NAME @"PAUSE"
# define TRUNK_NODE_NAME @"TRUNK"
# define BACK_LEAF_NODE_NAME @"BACK_LEAF"
# define FRONT_LEAF_NODE_NAME @"FRONT_LEAF"
# define BACKGROUND_PROGRESS_BAR_NODE_NAME @"trunkProgressLife background"
# define FRONT_PROGRESS_BAR_NODE_NAME @"trunkProgressLife front"
# define SCORE_NODE_NAME @"SCORE"

#endif
