//
//  TutorialViewController.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 22/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "TutorialViewController.h"
#import "Define.h"
#import "UserData.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    // Do any additional setup after loading the view.
    
    MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"tutorial-panel-1"] description:@"Tilt your device to move"];
    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"tutorial-panel-2"] description:@"Catch coconuts and tap on screen to launch it on your enemies"];

    MYIntroductionView *tutorial = [[MYIntroductionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) panels:@[panel1, panel2] languageDirection:MYLanguageDirectionLeftToRight];
    tutorial.backgroundColor = [UIColor clearColor];
    tutorial.delegate = self;
    [tutorial showInView:self.view animateDuration:0.0f];
}

-(void)introductionDidFinishWithType:(MYFinishType)finishType{
    [UserData setIsFirstRun:FALSE];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_START_GAME object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
