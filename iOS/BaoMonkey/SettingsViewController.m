//
//  SettingsViewController.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 16/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize musicVolume, effectsVolume, accelerometerSpeed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* Init slider min and max value */
    musicVolume.minimumValue = 0.0f;
    musicVolume.maximumValue = 1.0f;
    musicVolume.continuous = YES;
    
    effectsVolume.minimumValue = 0.0f;
    effectsVolume.maximumValue = 1.0f;
    effectsVolume.continuous = YES;
    
    accelerometerSpeed.minimumValue = 1.0f;
    accelerometerSpeed.maximumValue = 100.0f;
    accelerometerSpeed.continuous = YES;
    
    if ([GameData getMusicUserVolume]) {
        musicVolume.value = [GameData getMusicUserVolume];
    } else {
        musicVolume.value = 0.5f;
    }
    
    if ([GameData getSoundEffectsUserVolume]) {
        effectsVolume.value = [GameData getSoundEffectsUserVolume];
    } else {
        effectsVolume.value = 0.5f;
    }
    
    if ([GameData getAccelerometerUserSpeed]) {
        accelerometerSpeed.value = [GameData getAccelerometerUserSpeed];
    } else {
        accelerometerSpeed.value = kAccelerometerSpeed;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)updateMusicUserVolume:(id)sender{
    UISlider *slider = (UISlider *)sender;
    if (slider.tag == TAG_SLIDER_MUSIC_VOLUME) {
        [GameData setMusicUserVolume:slider.value];
    }
}

-(IBAction)updateSoundEffectsUserVolume:(id)sender{
    UISlider *slider = (UISlider *)sender;
    if (slider.tag == TAG_SLIDER_SOUND_EFFECTS_VOLUME) {
        [GameData setSoundEffectsUserVolume:slider.value];
    }
}

-(IBAction)updateAccelerometerUserSpeed:(id)sender{
    UISlider *slider = (UISlider *)sender;
    if (slider.tag == TAG_SLIDER_ACCELEROMETER_SPEED) {
        [GameData setAccelerometerUserSpeed:slider.value];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
