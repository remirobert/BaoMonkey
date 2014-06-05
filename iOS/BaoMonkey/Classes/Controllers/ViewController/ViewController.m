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
    
    [_skView presentScene:_scene transition:[SKTransition pushWithDirection:SKTransitionDirectionLeft duration:0.5]];
}

- (void) relaunchGame {
    _scene = [MyScene sceneWithSize:_skView.bounds.size];
    _scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [_skView presentScene:_scene transition:[SKTransition pushWithDirection:SKTransitionDirectionRight duration:0.5]];
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
                                             selector:@selector(relaunchGame)
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
    
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"banana"]] key:DATA_BANANA_TEXTURE];
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"coconut"]] key:DATA_COCONUT_TEXTURE];
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"prune"]] key:DATA_PRUNE_TEXTURE];
    
    
    [PreloadData loadDataWithKey:[SKTextureAtlas atlasNamed:@"MonkeyMenu"] key:DATA_MONKEY_MENU_ATLAS];
    
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"plateform"]] key:DATA_PLATEFORM];
    
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"button-play"] key:DATA_BUTTON_PLAY];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"button-pause"] key:DATA_BUTTON_PAUSE];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"button-replay"] key:DATA_BUTTON_REPLAY];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"button-home"] key:DATA_BUTTON_HOME];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"button-settings"] key:DATA_BUTTON_SETTINGS];
    
    
    //load gorille
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorille-1"] key:@"gorille-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorille-2"] key:@"gorille-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorille-3"] key:@"gorille-3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorille-4"] key:@"gorille-4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorille-arbre-1"] key:@"gorille-arbre-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorille-arbre-2"] key:@"gorille-arbre-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorille-arbre-3"] key:@"gorille-arbre-3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorille-arbre-4"] key:@"gorille-arbre-4"];

    //load commando
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-1"] key:@"commando-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-2"] key:@"commando-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-3"] key:@"commando-3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-4"] key:@"commando-4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-arbre1"] key:@"commando-arbre1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-arbre2"] key:@"commando-arbre2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-arbre3"] key:@"commando-arbre3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-arbre4"] key:@"commando-arbre4"];
    
    //load lamberJack
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"bucheron-1"] key:@"bucheron-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"bucheron-4"] key:@"bucheron-4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"bucheron-5"] key:@"bucheron-5"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"bucheron-6"] key:@"bucheron-6"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"bucheron-7"] key:@"bucheron-7"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"bucheron-8"] key:@"bucheron-8"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"courseb1"] key:@"courseb1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"courseb2"] key:@"courseb2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"courseb3"] key:@"courseb3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"courseb4"] key:@"courseb4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"courseb5"] key:@"courseb5"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"courseb6"] key:@"courseb6"];
    
    //load hunter
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"chasseur-1"] key:@"chasseur-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"chasseur-4"] key:@"chasseur-4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"chasseur-5"] key:@"chasseur-5"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"chasseur-0b"] key:@"chasseur-0b"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"chasseur-1b"] key:@"chasseur-1b"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"chasseur-2b"] key:@"chasseur-2b"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"chasseur-3b"] key:@"chasseur-3b"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"chasseur-4b"] key:@"chasseur-4b"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"chasseur-5b"] key:@"chasseur-5b"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"munition-explosive"] key:@"munition-explosive"];
    
    //load monkey
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"stand"] key:@"stand"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"stand2"] key:@"stand2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"run1"] key:@"run1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"run2"] key:@"run2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"run3"] key:@"run3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"run4"] key:@"run4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"run5"] key:@"run5"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"run6"] key:@"run6"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"coco1"] key:@"coco1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"coco2"] key:@"coco2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"coco3"] key:@"coco3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"coco4"] key:@"coco4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"coco5"] key:@"coco5"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"coco6"] key:@"coco6"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lance"] key:@"lance"];
    
    //load plums
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"grosse"] key:@"grosse"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"petite"] key:@"petite"];
}

-(void)goToHome {
    [_skView presentScene:[[MainMenu alloc] initWithSize:_skView.frame.size]];
}

-(void)goToSettings {
    [_skView presentScene:[[Settings alloc] initWithSize:_skView.frame.size]
               transition:[SKTransition pushWithDirection:SKTransitionDirectionLeft duration:0.5]];
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
