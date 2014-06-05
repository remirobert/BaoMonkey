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
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorille-ground-1"] key:@"gorille-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorille-ground-2"] key:@"gorille-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorille-ground-3"] key:@"gorille-3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorille-ground-4"] key:@"gorille-4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorille-tree-1"] key:@"gorille-tree-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorille-tree-2"] key:@"gorille-tree-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorille-tree-3"] key:@"gorille-tree-3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorille-tree-4"] key:@"gorille-tree-4"];

    //load commando
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-1"] key:@"commando-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-2"] key:@"commando-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-3"] key:@"commando-3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-4"] key:@"commando-4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-5"] key:@"commando-5"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-6"] key:@"commando-6"];

    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-climb1"] key:@"commando-climb1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-climb1"] key:@"commando-climb2"];
    
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando_fall_ground1"] key:@"commando_fall_ground1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando_fall_ground2"] key:@"commando_fall_ground2"];
    
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-fall1"] key:@"commando-fall1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-fall2"] key:@"commando-fall2"];
    
    //load lamberJack
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber_jack_1"] key:@"lamber_jack_1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber_jack_2"] key:@"lamber_jack_2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber_jack_3"] key:@"lamber_jack_3"];

    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber_jack_K1"] key:@"lamber_jack_K1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber_jack_K2"] key:@"lamber_jack_K2"];

    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber_jack_walking1"] key:@"lamber_jack_walking1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber_jack_walking2"] key:@"lamber_jack_walking2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber_jack_walking3"] key:@"lamber_jack_walking3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber_jack_walking4"] key:@"lamber_jack_walking4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber_jack_walking5"] key:@"lamber_jack_walking5"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber_jack_walking6"] key:@"lamber_jack_walking6"];
    
    //load hunter
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"hunter-1"] key:@"hunter-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"hunter-2"] key:@"hunter-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"hunter-3"] key:@"hunter-3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"hunter-4"] key:@"hunter-4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"hunter-5"] key:@"hunter-5"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"hunter-6"] key:@"hunter-6"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"hunter-7"] key:@"hunter-7"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"hunter-8"] key:@"hunter-8"];

    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"munition-explosive"] key:@"munition-explosive"];
    
    //load monkey
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"course_simple1"] key:@"run1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"singe_course_simple2"] key:@"run2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"singe_course_simple3"] key:@"run3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"singe_course_simple4"] key:@"run4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"singe_course_simple5"] key:@"run5"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"singe_course_simple6"] key:@"run6"];
    
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"singe_course1"] key:@"coco1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"singe_course2"] key:@"coco2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"singe_course3"] key:@"coco3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"singe_course4"] key:@"coco4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"singe_course5"] key:@"coco5"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"singe_course6"] key:@"coco6"];

    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"singe_stand1"] key:@"stand"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"singe_stand2"] key:@"stand2"];

    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"singe_lance"] key:@"lance"];
    
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
