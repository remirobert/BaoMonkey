//
//  HomeViewController.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 08/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "HomeViewController.h"
#import "UserData.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    
    _enemy.text = [NSString stringWithFormat:@"enemy = %d", [UserData defaultUser].enemy_score];
    _prune.text = [NSString stringWithFormat:@"prune = %d", [UserData defaultUser].prune_score];
    _score.text = [NSString stringWithFormat:@"best score = %d", [UserData defaultUser].score];
    
    // Do any additional setup after loading the view.
}

-(IBAction)gameCenter:(id)sender {
    [GameData showLeaderboardAndAchievements:YES withViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
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
