//
//  AppDelegate.m
//  BaoMonkey
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "AppDelegate.h"
#import "UserData.h"
#import "GameCenter.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [GameCenter authenticateLocalPlayer];
    [GameData initGameData];
    
    [UserData initUserData];
    [self loadMusicPlayer];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self.backgroundMusicPlayer pause];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PAUSE_GAME object:nil];
    [UserData saveUserData];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self.backgroundMusicPlayer play];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [UserData saveUserData];
}

-(void)loadMusicPlayer
{
    NSError *error;
    NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"baomonkey" withExtension:@"m4a"];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer.numberOfLoops = -1;
    if ([UserData getMusicUserVolume]) {
        self.backgroundMusicPlayer.volume = [UserData getMusicUserVolume];
    } else {
        self.backgroundMusicPlayer.volume = 0.5;
    }
    [self.backgroundMusicPlayer prepareToPlay];
    [self.backgroundMusicPlayer play];
}

@end
