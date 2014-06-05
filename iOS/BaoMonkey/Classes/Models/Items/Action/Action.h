//
//  Action.h
//  BaoMonkey
//
//  Created by iPPLE on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Define.h"
#import "GameController.h"
#import "Item.h"
#import "GameData.h"
#import "BaoPosition.h"

@interface Action : NSObject

+ (void) dropWeapon:(Item *)item;
+ (void) increaseMove;

@end
