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
#import "GameController.h"
#import "MyScene.h"
#import "ViewController+Multiplayer.h"
#import "TutorialViewController.h"


@interface ViewController ()
@property (nonatomic) MyScene *scene;
@property (nonatomic) SKView *skView;
@end

@implementation ViewController

- (void) initGame {
    if ([[UserData defaultUser] isFirstRun] == TRUE) {
        [self launchTutorial];
    }
    else {
        _scene = [MyScene sceneWithSize:_skView.bounds.size];
        _scene.scaleMode = SKSceneScaleModeAspectFill;
        [_skView presentScene:_scene transition:[SKTransition pushWithDirection:SKTransitionDirectionLeft duration:0.5]];
    }
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
    [GameData pauseGame];
    
    _skView = (SKView *)self.view;
    _skView.showsFPS = NO;
    _skView.showsNodeCount = NO;
    [GameController initAccelerometer];
    [GameController initOneTapOnView:_skView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(initGame)
                                                 name:NOTIFICATION_START_GAME
                                               object:nil];

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(share)
                                                 name:@"notification_share"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(shareScore)
                                                 name:@"notification_share_score"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(findPlayerMatchMaking)
                                                 name:@"find_player"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showGameCenter)
                                                 name:NOTIFICATION_SHOW_GAME_CENTER
                                               object:nil];

    srand(time(NULL));
    mainMenu = [[MainMenu alloc] initWithSize:_skView.frame.size];
    settingsMenu = [[Settings alloc] initWithSize:_skView.frame.size];
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
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"coconut"] key:DATA_COCONUT_TEXTURE];
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"plum"]] key:DATA_PRUNE_TEXTURE];
    
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"monkey-waiting"]] key:DATA_MONKEY_WAITING];
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"monkey-waiting-coconut"]] key:DATA_MONKEY_WAITING_COCONUT];
    
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"platform"]] key:DATA_PLATEFORM];
    
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"button-play"] key:DATA_BUTTON_PLAY];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"button-pause"] key:DATA_BUTTON_PAUSE];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"button-replay"] key:DATA_BUTTON_REPLAY];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"button-home"] key:DATA_BUTTON_HOME];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"button-settings"] key:DATA_BUTTON_SETTINGS];
    
    //load gorille
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorilla-walking-1"] key:@"gorilla-walking-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorilla-walking-2"] key:@"gorilla-walking-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorilla-walking-dead-1"] key:@"gorilla-walking-dead-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorilla-walking-dead-2"] key:@"gorilla-walking-dead-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorilla-climbing-1"] key:@"gorilla-climbing-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorilla-climbing-2"] key:@"gorilla-climbing-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorilla-climbing-dead-1"] key:@"gorilla-climbing-dead-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"gorilla-climbing-dead-2"] key:@"gorilla-climbing-dead-2"];

    //load commando
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-walking-1"] key:@"commando-walking-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-walking-2"] key:@"commando-walking-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-walking-3"] key:@"commando-walking-3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-walking-4"] key:@"commando-walking-4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-walking-5"] key:@"commando-walking-5"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-walking-6"] key:@"commando-walking-6"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-climbing-1"] key:@"commando-climbing-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-climbing-2"] key:@"commando-climbing-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando_walking-dead-1"] key:@"commando-walking-dead-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando_walking-dead-2"] key:@"commando-walking-dead-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-climbing-dead-1"] key:@"commando-climbing-dead-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"commando-climbing-dead-2"] key:@"commando-climbing-dead-2"];
    
    //load lamberJack
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber-jack-chopping-1"] key:@"lamber-jack-chopping-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber-jack-chopping-2"] key:@"lamber-jack-chopping-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber-jack-chopping-3"] key:@"lamber-jack-chopping-3"];

    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber-jack-dead-1"] key:@"lamber-jack-dead-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber-jack-dead-2"] key:@"lamber-jack-dead-2"];

    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber-jack-walking-1"] key:@"lamber-jack-walking-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber-jack-walking-2"] key:@"lamber-jack-walking-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber-jack-walking-3"] key:@"lamber-jack-walking-3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber-jack-walking-4"] key:@"lamber-jack-walking-4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber-jack-walking-5"] key:@"lamber-jack-walking-5"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"lamber-jack-walking-6"] key:@"lamber-jack-walking-6"];
    
    //load hunter
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"hunter-walking-1"] key:@"hunter-walking-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"hunter-walking-2"] key:@"hunter-walking-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"hunter-walking-3"] key:@"hunter-walking-3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"hunter-walking-4"] key:@"hunter-walking-4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"hunter-walking-5"] key:@"hunter-walking-5"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"hunter-walking-6"] key:@"hunter-walking-6"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"hunter-dead-1"] key:@"hunter-dead-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"hunter-dead-2"] key:@"hunter-dead-2"];

    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"munition-explosive"] key:@"munition-explosive"];
    
    //load monkey
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"waiting"] key:@"waiting"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"waiting-coconut"] key:@"waiting-coconut"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"monkey-walking-1"] key:@"monkey-walking-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"monkey-walking-2"] key:@"monkey-walking-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"monkey-walking-3"] key:@"monkey-walking-3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"monkey-walking-4"] key:@"monkey-walking-4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"monkey-walking-5"] key:@"monkey-walking-5"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"monkey-walking-6"] key:@"monkey-walking-6"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"monkey-walking-coconut-1"] key:@"monkey-walking-coconut-1"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"monkey-walking-coconut-2"] key:@"monkey-walking-coconut-2"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"monkey-walking-coconut-3"] key:@"monkey-walking-coconut-3"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"monkey-walking-coconut-4"] key:@"monkey-walking-coconut-4"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"monkey-walking-coconut-5"] key:@"monkey-walking-coconut-5"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"monkey-walking-coconut-6"] key:@"monkey-walking-coconut-6"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"monkey-launch"] key:@"monkey-launch"];

    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"singe_lance"] key:@"lance"];
    
    //load plums
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"small-splash"] key:@"big-splash-plums"];
    [PreloadData loadDataWithKey:[SKTexture textureWithImageNamed:@"big-splash"] key:@"small-splash-plums"];
}

-(void)goToHome {
    [_skView presentScene:mainMenu transition:[SKTransition flipVerticalWithDuration:0.5]];
}

-(void)goToSettings {
    [_skView presentScene:settingsMenu
               transition:[SKTransition pushWithDirection:SKTransitionDirectionLeft duration:0.5]];
}

-(void)share{
    NSMutableArray *activityItems = [[NSMutableArray alloc] init];
    NSString *string = @"BaoMonkey, the new crazy iOS game! More informations on http://www.baomonkey.com";
    [activityItems addObject:string];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList, UIActivityTypeAirDrop, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo, UIActivityTypePostToWeibo];
    [activityViewController.navigationController.navigationBar setHidden:YES];
    [activityViewController performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    [self presentViewController:activityViewController animated:YES completion:nil];
}

-(void)shareScore{
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    NSMutableArray *activityItems = [[NSMutableArray alloc] init];
    NSString *string = [NSString stringWithFormat:@"I get %ld on BaoMonkey! Can you do better ? More information on http://www.baomonkey.com", (long)[GameData getScore]];
    [activityItems addObject:string];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList, UIActivityTypeAirDrop, UIActivityTypePostToFlickr, UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo, UIActivityTypePostToWeibo];
    [self presentViewController:activityViewController animated:YES completion:nil];
}

-(void)showGameCenter {
    [GameCenter showLeaderboardAndAchievements:YES withViewController:self];
}

-(void)launchTutorial {
    TutorialViewController *controller = [[TutorialViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
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
