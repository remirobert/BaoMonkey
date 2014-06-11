//
//  ViewController+Multiplayer.h
//  BaoMonkey
//
//  Created by iPPLE on 11/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (Multiplayer) <GKMatchmakerViewControllerDelegate>

- (void) findPlayerMatchMaking;

@end
