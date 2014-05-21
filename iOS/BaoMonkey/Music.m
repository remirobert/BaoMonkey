//
//  Music.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 21/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Music.h"

@implementation Music

+(instancetype)singleton {
    static Music *singleton;
    
    if (singleton == nil) {
        singleton = [[Music alloc] init];
    }
    return singleton;
}

+(void)initAndPlayBackgroundMusic {
    [[Music singleton] initAndPlayBackgroundMusic];
}

-(void)initAndPlayBackgroundMusic {
    NSError *error;
    NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"baomonkey" withExtension:@"m4a"];
    backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    backgroundMusicPlayer.numberOfLoops = -1;
    if ([UserData getMusicUserVolume]) {
        backgroundMusicPlayer.volume = [UserData getMusicUserVolume];
    } else {
        backgroundMusicPlayer.volume = 0.5;
    }
    [backgroundMusicPlayer prepareToPlay];
    [backgroundMusicPlayer play];
}

+(void)playBackgroundMusic {
    [[Music singleton] playBackgroundMusic];
}

-(void)playBackgroundMusic {
    [backgroundMusicPlayer play];
}

+(void)pauseBackgroundMusic {
    [[Music singleton] pauseBackgroundMusic];
}

-(void)pauseBackgroundMusic {
    [backgroundMusicPlayer pause];
}

+(void)updateBackgroundMusicVolume:(CGFloat)volume {
    [[Music singleton] updateBackgroundMusicVolume:volume];
}

-(void)updateBackgroundMusicVolume:(CGFloat)volume {
    backgroundMusicPlayer.volume = volume;
}

@end
