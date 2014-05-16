//
//  AppDelegate.h
//  BaoMonkey
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "GameData.h"
#import "Define.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) AVAudioPlayer *backgroundMusicPlayer;

@end
