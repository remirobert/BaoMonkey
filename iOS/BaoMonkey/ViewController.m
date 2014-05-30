//
//  ViewController.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "ViewController.h"
#import "Define.h"
#import "PreloadData.h"
#import "UserData.h"
#import "Achievement.h"
#import "GameCenter.h"
#import "MainMenu.h"
#import "Settings.h"
#import "GameController.h"
#import "MyScene.h"


@interface ViewController ()
@property (nonatomic) MyScene *scene;
@property (nonatomic) SKView *skView;
@end

@implementation ViewController

- (void) initGame {
    _scene = [MyScene sceneWithSize:_skView.bounds.size];
    _scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [_skView presentScene:_scene transition:[SKTransition moveInWithDirection:SKTransitionDirectionRight duration:1.0]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self loadAssets];
    [UserData initUserData];
    
    _skView = (SKView *)self.view;
    _skView.showsFPS = NO;
    _skView.showsNodeCount = YES;
    [GameController initAccelerometer];
    [GameController initOneTapOnView:_skView];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(initGame)
                                                 name:NOTIFICATION_RETRY_GAME
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(goToHome)
                                                 name:NOTIFICATION_GO_TO_HOME
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(goToSettings)
                                                 name:NOTIFICATION_GO_TO_SETTINGS
                                               object:nil];
    
    srand(time(NULL));
    [self goToHome];
}

- (void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

- (void) loadAssets {
    if ([UserData getSoundEffectsUserVolume]) {
        [PreloadData loadDataWithKey:[PreloadData playSoundFileNamed:@"splash.mp3" atVolume:[UserData getSoundEffectsUserVolume] waitForCompletion:NO] key:DATA_SPLASH_SOUND];
        [PreloadData loadDataWithKey:[PreloadData playSoundFileNamed:@"coconut.mp3" atVolume:[UserData getSoundEffectsUserVolume] waitForCompletion:NO] key:DATA_COCONUT_SOUND];
    } else {
        [PreloadData loadDataWithKey:[PreloadData playSoundFileNamed:@"splash.mp3" atVolume:0.5 waitForCompletion:NO] key:DATA_SPLASH_SOUND];
        [PreloadData loadDataWithKey:[PreloadData playSoundFileNamed:@"coconut.mp3" atVolume:0.5 waitForCompletion:NO] key:DATA_COCONUT_SOUND];
    }
    
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"grosse_tache"]] key:DATA_SPLASH_PLUMS1];
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"petite_tache"]] key:DATA_SPLASH_PLUMS2];
    
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"splash-prune"]] key:DATA_SPLASH_TEXTURE];
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"banana"]] key:DATA_BANANA_TEXTURE];
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"coconut"]] key:DATA_COCONUT_TEXTURE];
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"prune"]] key:DATA_PRUNE_TEXTURE];
    
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"monkey-waiting"]] key:DATA_MONKEY_WAITING];
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"monkey-waiting-coconut"]] key:DATA_MONKEY_WAITING_COCONUT];
    [PreloadData loadDataWithKey:[SKTextureAtlas atlasNamed:@"MonkeyLaunch"] key:DATA_MONKEY_LAUNCH_ATLAS];
    [PreloadData loadDataWithKey:[SKTextureAtlas atlasNamed:@"MonkeyWalking"] key:DATA_MONKEY_WALKING_ATLAS];
    [PreloadData loadDataWithKey:[SKTextureAtlas atlasNamed:@"MonkeyWalkingWithCoconut"] key:DATA_MONKEY_WALKING_COCONUT_ATLAS];
    [PreloadData loadDataWithKey:[SKTextureAtlas atlasNamed:@"MonkeyDead"] key:DATA_MONKEY_DEAD_ATLAS];
    
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"lamber-jack-waiting"]] key:DATA_LAMBERJACK_WAITING];
    [PreloadData loadDataWithKey:[SKTextureAtlas atlasNamed:@"LamberJackWalking"] key:DATA_LAMBERJACK_WALKING_ATLAS];
    [PreloadData loadDataWithKey:[SKTextureAtlas atlasNamed:@"LamberJackCutting"] key:DATA_LAMBERJACK_CUTTING_ATLAS];
    [PreloadData loadDataWithKey:[SKTextureAtlas atlasNamed:@"LamberJackDead"] key:DATA_LAMBERJACK_DEAD_ATLAS];
    
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"hunter-waiting"]] key:DATA_HUNTER_WAITING];
    [PreloadData loadDataWithKey:[SKTextureAtlas atlasNamed:@"HunterWalking"] key:DATA_HUNTER_WALKING_ATLAS];
    [PreloadData loadDataWithKey:[SKTextureAtlas atlasNamed:@"HunterDead"] key:DATA_HUNTER_DEAD_ATLAS];
    
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"plateform"]] key:DATA_PLATEFORM];
    
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"button-play"] key:DATA_BUTTON_PLAY];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"button-pause"] key:DATA_BUTTON_PAUSE];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"button-replay"] key:DATA_BUTTON_REPLAY];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"button-home"] key:DATA_BUTTON_HOME];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"button-settings"] key:DATA_BUTTON_SETTINGS];
}

-(void)goToHome {
    [_skView presentScene:[[MainMenu alloc] initWithSize:_skView.frame.size]
               transition:[SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:1.0]];
}

-(void)goToSettings {
    [_skView presentScene:[[Settings alloc] initWithSize:_skView.frame.size]
               transition:[SKTransition moveInWithDirection:SKTransitionDirectionRight duration:1.0]];
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
