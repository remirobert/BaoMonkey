//
//  SettingsViewController.h
//  BaoMonkey
//
//  Created by Jeremy Peltier on 16/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Define.h"
#import "UserData.h"
#import "Music.h"
#import "PreloadData.h"

@interface SettingsViewController : UIViewController

@property (nonatomic, strong) IBOutlet UISlider *musicVolume;
@property (nonatomic, strong) IBOutlet UISlider *effectsVolume;
@property (nonatomic, strong) IBOutlet UISlider *accelerometerSpeed;

@end
