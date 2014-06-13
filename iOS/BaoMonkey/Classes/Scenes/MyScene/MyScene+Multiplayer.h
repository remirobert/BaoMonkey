//
//  MyScene+Multiplayer.h
//  BaoMonkey
//
//  Created by iPPLE on 13/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "MyScene.h"
#import <GameKit/GameKit.h>

@interface MyScene (Multiplayer) <GKMatchDelegate>

- (void) sendPositionMonkey;
- (void) handleMultiplayer;
- (void) sendGameOverGame;

@end
