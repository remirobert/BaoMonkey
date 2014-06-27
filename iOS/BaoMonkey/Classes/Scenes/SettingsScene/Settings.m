//
//  Settings.m
//  BaoMonkey
//
//  Created by iPPLE on 27/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Settings.h"
#import "Define.h"
#import "BaoPosition.h"
#import "BaoSize.h"
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
@property (nonatomic, strong) SKScene *parentScene;
@property (nonatomic, assign) CGPoint prevLocationCursor;
@end

@implementation Settings

- (void) customCursor {
    [_cursorAccelerometer setCursorTexture:[UIImage imageNamed:@"cursor-settings"]];
    [_cursorVolumeMusic setCursorTexture:[UIImage imageNamed:@"cursor-settings"]];
    [_cursorVolumeSound setCursorTexture:[UIImage imageNamed:@"cursor-settings"]];
    
    [_cursorAccelerometer setBackgroundTexture:[UIImage imageNamed:@"progress-settings"]];
    [_cursorVolumeSound setBackgroundTexture:[UIImage imageNamed:@"progress-settings"]];
    [_cursorVolumeMusic setBackgroundTexture:[UIImage imageNamed:@"progress-settings"]];
}

- (void) initCursor {
    _cursorVolumeSound = [[SpriteKitCursor alloc] initWithSize:[BaoSize cursorSettings]
                                                      position:[BaoPosition cursorSoundEffectsSettings]];
    
    _cursorVolumeMusic = [[SpriteKitCursor alloc] initWithSize:[BaoSize cursorSettings]
                                                      position:[BaoPosition cursorMusicSettings]];
    
    _cursorAccelerometer = [[SpriteKitCursor alloc] initWithSize:[BaoSize cursorSettings]
                                                        position:[BaoPosition cursorAccelerometerSettings]];
    
    [_cursorVolumeMusic setCurrentValue:[UserData getMusicUserVolume] * 100];
    [_cursorVolumeSound setCurrentValue:[UserData getSoundEffectsUserVolume] * 100];
    [_cursorAccelerometer setCurrentValue:[UserData getAccelerometerUserSpeed]];
    [self customCursor];
}

- (void) initButton {
    SKSpriteNode *backButton = [[SKSpriteNode alloc] initWithImageNamed:@"back-button-settings"];
    backButton.position = [BaoPosition buttonBackSettings];
    backButton.name = @"back";
    [self addChild:backButton];
}

- (instancetype) initWithSize:(CGSize)size withParentScene:(SKScene *)parentScene {
    self = [super initWithSize:size];
    
    if (self != nil) {
        
        SKSpriteNode *background = [[SKSpriteNode alloc] initWithImageNamed:@"background-settings"];
        background.position = [BaoPosition middleScreen];
        [self addChild:background];
        
        [self initCursor];
        
        [_cursorAccelerometer addChild:self];
        [_cursorVolumeMusic addChild:self];
        [_cursorVolumeSound addChild:self];
        
        _parentScene = parentScene;
        [self initButton];
    }
    return (self);
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"back"]) {
        [(SKSpriteNode*)node setTexture:[SKTexture textureWithImageNamed:@"back-button-settings-selected"]];
    
    }
    
    NSArray *array = [touches allObjects];
    
    for (UITouch *touch in array) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        if ([node.name isEqualToString:@"cursor"]) {
            if ([_cursorAccelerometer checkCursorClickWithNode:node] == YES)
                _currentCursorClicked = _cursorAccelerometer;
            else if ([_cursorVolumeMusic checkCursorClickWithNode:node] == YES)
                _currentCursorClicked = _cursorVolumeMusic;
            else if ([_cursorVolumeSound checkCursorClickWithNode:node] == YES)
                _currentCursorClicked = _cursorVolumeSound;
            return;
        }
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    _prevLocationCursor = ((SpriteKitCursor *)_currentCursorClicked).cursor.position;
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    SKSpriteNode *node = (SKSpriteNode *)[self childNodeWithName:@"back"];
    [node setTexture:[SKTexture textureWithImageNamed:@"back-button-settings"]];

    if ([_currentCursorClicked isEqual:_cursorAccelerometer])
        [_cursorAccelerometer updatePositionCursorWithLocation:location];
    else if ([_currentCursorClicked isEqual:_cursorVolumeMusic])
        [_cursorVolumeMusic updatePositionCursorWithLocation:location];
    else if ([_currentCursorClicked isEqual:_cursorVolumeSound])
        [_cursorVolumeSound updatePositionCursorWithLocation:location];
        
    if (location.x - _prevLocationCursor.x > 0) {
        [((SpriteKitCursor *)_currentCursorClicked).cursor runAction:[SKAction rotateByAngle:-0.1f duration:0.1f]];
    } else if (location.x - _prevLocationCursor.x < 0) {
        [((SpriteKitCursor *)_currentCursorClicked).cursor runAction:[SKAction rotateByAngle:0.1f duration:0.1f]];
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"back"]) {
        [(SKSpriteNode*)node setTexture:[SKTexture textureWithImageNamed:@"back-button-settings"]];
        [UserData setAccelerometerUserSpeed:_cursorAccelerometer.currentValue];
        [self updateMusicUserVolume];
        [self updateSoundEffectsUserVolume];
        [self.view presentScene:_parentScene transition:[SKTransition pushWithDirection:SKTransitionDirectionDown duration:1.0f]];
    }
    if (_currentCursorClicked != nil) {
        [UserData setAccelerometerUserSpeed:_cursorAccelerometer.currentValue];
        [self updateMusicUserVolume];
        [self updateSoundEffectsUserVolume];
    }
    _currentCursorClicked = nil;
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

- (void) popBubble:(NSTimeInterval)currentTime {
    static NSTimeInterval timer = 0;
    //NSArray *tabImage = @[@"water-bubble-1", @"water-bubble-2", @"water-bubble-3"];
    
    if (timer == 0) {
        timer = rand() % 2 + 1 + currentTime;
    }
    
    if (currentTime >= timer) {
        SKSpriteNode *bubble = [SKSpriteNode spriteNodeWithImageNamed:@"water-bubble-2"];
        
        bubble.position = [BaoPosition bubblePositionSettings];
        bubble.zPosition = 100;
        
        [self addChild:bubble];
        
        if (bubble.position.x <= SCREEN_WIDTH / 2) {
            [bubble runAction:[SKAction moveToY:(IPAD ? SCREEN_HEIGHT / 2 + 303 : SCREEN_HEIGHT / 2 + 150) duration:2.0]];
            [bubble runAction:[SKAction fadeOutWithDuration:2.0]];
        }
        else {
            [bubble runAction:[SKAction moveToY:(IPAD ? SCREEN_HEIGHT / 2 + 203 : SCREEN_HEIGHT / 2 + 100) duration:1.5]];
            [bubble runAction:[SKAction fadeOutWithDuration:1.5]];
        }
        timer = 1.75f + currentTime;
    }
}

- (void) update:(NSTimeInterval)currentTime {
    [self popBubble:currentTime];
}

@end
