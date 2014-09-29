//
//  PreloadData.m
//  BaoMonkey
//
//  Created by iPPLE on 16/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "PreloadData.h"

@interface PreloadData ()
@property (nonatomic, strong) NSMutableDictionary *data;
@end

@implementation PreloadData

+ (instancetype) defaultData {
    static PreloadData *preload;
    
    if (preload == nil) {
        preload = [[PreloadData alloc] init];
        preload.data = [[NSMutableDictionary alloc] init];
    }
    return (preload);
}

+ (void) loadDataWithKey:(id)data key:(NSString *)key {
    PreloadData *defaultData = [PreloadData defaultData];
    [defaultData.data setValue:data forKey:key];
}

+ (id) getDataWithKey:(NSString *)key {
    PreloadData *defaultData = [PreloadData defaultData];
    
    id item = [defaultData.data objectForKey:key];
    return (item);
}

+ (void) removeDataWithKey:(NSString *)key {
    PreloadData *defaultData = [PreloadData defaultData];

    [defaultData.data removeObjectForKey:key];
}

+(SKAction *)playSoundFileNamed:(NSString *)filename atVolume:(CGFloat)volume waitForCompletion:(BOOL)wait{
    return [[PreloadData defaultData] playSoundFileNamed:filename atVolume:volume waitForCompletion:wait];
}

-(SKAction *)playSoundFileNamed:(NSString *)filename atVolume:(CGFloat)volume waitForCompletion:(BOOL)wait{
    NSString *name = [filename stringByDeletingPathExtension];
    NSString *extension = [filename pathExtension];
    NSURL *path = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:name ofType:extension]];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:path error:nil];
    
    [player setVolume:volume];
    [player prepareToPlay];
    
    SKAction *playAction = [SKAction runBlock:^(void){
        [player play];
    }];
    
    if (wait) {
        SKAction *waitAction = [SKAction waitForDuration:player.duration];
        SKAction *groupsActions = [SKAction group:@[playAction, waitAction]];
        return groupsActions;
    }
    return playAction;
}

@end
