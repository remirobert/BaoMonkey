//
//  Settings.m
//  BaoMonkey
//
//  Created by iPPLE on 27/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Settings.h"
#import "Define.h"
#import "SpriteKitCursor.h"
#import "GameData.h"
#import "UserData.h"
#import "Music.h"
#import "PreloadData.h"

@interface Settings ()
@property (nonatomic, strong) SpriteKitCursor *cursorVolumeSound;
@property (nonatomic, strong) SpriteKitCursor *cursorVolumeMusic;
@property (nonatomic, strong) SpriteKitCursor *cursorAccelerometer;
@property (nonatomic, strong) id currentCursorClicked;
@end

@implementation Settings

- (void) customCursor {
    [_cursorAccelerometer setCursorTexture:[UIImage imageNamed:@"selector-slider@2x"] withSize:CGSizeMake(25, 25)];
    [_cursorVolumeMusic setCursorTexture:[UIImage imageNamed:@"selector-slider@2x"] withSize:CGSizeMake(25, 25)];
    [_cursorVolumeSound setCursorTexture:[UIImage imageNamed:@"selector-slider@2x"] withSize:CGSizeMake(25, 25)];
    
    [_cursorAccelerometer setBackgroundTexture:[UIImage imageNamed:@"front-slider@2x"]];
    [_cursorVolumeSound setBackgroundTexture:[UIImage imageNamed:@"front-slider@2x"]];
    [_cursorVolumeMusic setBackgroundTexture:[UIImage imageNamed:@"front-slider@2x"]];
    
    [_cursorAccelerometer setForegroundTexture:[UIImage imageNamed:@"back-slider@2x"]];
    [_cursorVolumeMusic setForegroundTexture:[UIImage imageNamed:@"back-slider@2x"]];
    [_cursorVolumeSound setForegroundTexture:[UIImage imageNamed:@"back-slider@2x"]];
}

- (void) initCursor {
    _cursorVolumeSound = [[SpriteKitCursor alloc] initWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 25)
                                                      position:CGPointMake([UIScreen mainScreen].bounds.size.width / 2,
                                                                           [UIScreen mainScreen].bounds.size.height / 2 + 100)];
    
    _cursorVolumeMusic = [[SpriteKitCursor alloc] initWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 25)
                                                      position:CGPointMake([UIScreen mainScreen].bounds.size.width / 2,
                                                                           [UIScreen mainScreen].bounds.size.height / 2)];
    
    _cursorAccelerometer = [[SpriteKitCursor alloc] initWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width / 2, 25)
                                                        position:CGPointMake([UIScreen mainScreen].bounds.size.width / 2,
                                                                             [UIScreen mainScreen].bounds.size.height / 2 - 100)];
    
    [self customCursor];
    
    
    [_cursorVolumeMusic setCurrentValue:[UserData getMusicUserVolume] * 100];
    [_cursorVolumeSound setCurrentValue:[UserData getSoundEffectsUserVolume] * 100];
    [_cursorAccelerometer setCurrentValue:[UserData getAccelerometerUserSpeed]];
}

- (instancetype) initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    
    if (self != nil) {
        self.backgroundColor = [SKColor blueColor];
        
        [self initCursor];
        
        [_cursorAccelerometer addChild:self];
        [_cursorVolumeMusic addChild:self];
        [_cursorVolumeSound addChild:self];
        
        
        
        SKLabelNode * homeButton = [[SKLabelNode alloc] init];
        
        homeButton.text = @"home";
        homeButton.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2,
                                          [UIScreen mainScreen].bounds.size.height / 2 - 200);
        homeButton.name = @"home";
        
        [self addChild:homeButton];
    }
    return (self);
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    
    if ([node.name isEqualToString:@"home"]) {
        [UserData setAccelerometerUserSpeed:_cursorAccelerometer.currentValue];
        [self updateMusicUserVolume];
        [self updateSoundEffectsUserVolume];
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GO_TO_HOME object:nil];

    }
    if ([_cursorAccelerometer checkCursorClickWithNode:node] == YES)
        _currentCursorClicked = _cursorAccelerometer;
    else if ([_cursorVolumeMusic checkCursorClickWithNode:node] == YES)
        _currentCursorClicked = _cursorVolumeMusic;
    else if ([_cursorVolumeSound checkCursorClickWithNode:node] == YES)
        _currentCursorClicked = _cursorVolumeSound;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];

    if ([_currentCursorClicked isEqual:_cursorAccelerometer])
        [_cursorAccelerometer updatePositionCursorWithLocation:location];
    else if ([_currentCursorClicked isEqual:_cursorVolumeMusic])
        [_cursorVolumeMusic updatePositionCursorWithLocation:location];
    else if ([_currentCursorClicked isEqual:_cursorVolumeSound])
        [_cursorVolumeSound updatePositionCursorWithLocation:location];
}

- (void) updateMusicUserVolume {
        [Music updateBackgroundMusicVolume:_cursorVolumeMusic.currentValue / 100.0];
        [UserData setMusicUserVolume:_cursorVolumeMusic.currentValue / 100.0];
}

- (void) updateSoundEffectsUserVolume {
    [PreloadData removeDataWithKey:DATA_SPLASH_SOUND];
    [PreloadData removeDataWithKey:DATA_COCONUT_SOUND];
    [UserData setSoundEffectsUserVolume:_cursorVolumeSound.currentValue / 100.0];
    [PreloadData loadDataWithKey:[PreloadData playSoundFileNamed:@"splash.mp3"
                                                        atVolume:_cursorVolumeSound.currentValue / 100.0
                                               waitForCompletion:NO] key:DATA_SPLASH_SOUND];
    [PreloadData loadDataWithKey:[PreloadData playSoundFileNamed:@"coconut.mp3"
                                                        atVolume:_cursorVolumeSound.currentValue / 100.0
                                               waitForCompletion:NO] key:DATA_COCONUT_SOUND];
}

- (void) updateAccelerometerUserSpeed {
    [UserData setAccelerometerUserSpeed:_cursorAccelerometer.currentValue + 1.0];
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    _currentCursorClicked = nil;
}

@end
