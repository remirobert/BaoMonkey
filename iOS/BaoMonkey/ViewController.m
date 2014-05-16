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

@interface ViewController ()
@property (nonatomic) MyScene *scene;
@property (nonatomic) SKView *skView;
@end

@implementation ViewController

- (void) initGame {
    _scene = [MyScene sceneWithSize:_skView.bounds.size];
    _scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [_skView presentScene:_scene];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadAssets];
    _skView = (SKView *)self.view;
    _skView.showsFPS = NO;
    _skView.showsNodeCount = YES;
    [GameController initAccelerometer];
    [GameController initOneTapOnView:_skView];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(initGame)
                                                 name:NOTIFICATION_RETRY_GAME
                                               object:nil];
    srand(time(NULL));
    [self initGame];
}

- (void) loadAssets {
    [PreloadData loadDataWithKey:[SKAction playSoundFileNamed:@"splash.mp3" waitForCompletion:NO] key:DATA_SPLASH_SOUND];
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"splash-prune"]] key:DATA_SPLASH_TEXTURE];
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"banana"]] key:DATA_BANANA_TEXTURE];
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"coconut"]] key:DATA_COCONUT_TEXTURE];
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"prune"]] key:DATA_PRUNE_TEXTURE];
    [PreloadData loadDataWithKey:[SKAction playSoundFileNamed:@"coconut.mp3" waitForCompletion:NO] key:DATA_COCONUT_SOUND];
    [PreloadData loadDataWithKey:[SKTextureAtlas atlasNamed:@"MonkeyWalking"] key:DATA_MONKEY_WALK_ATLAS];
    [PreloadData loadDataWithKey:[SKTexture textureWithImage:[UIImage imageNamed:@"monkey"]] key:DATA_MONKEY_TEXTURE];
    
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
