//
//  Music.h
//  BaoMonkey
//
//  Created by Jeremy Peltier on 21/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <SpriteKit/SpriteKit.h>
#import "UserData.h"

@interface Music : NSObject {
    AVAudioPlayer *backgroundMusicPlayer;
}

+(void)initAndPlayBackgroundMusic;
+(void)playBackgroundMusic;
+(void)pauseBackgroundMusic;
+(void)updateBackgroundMusicVolume:(CGFloat)volume;

@end
