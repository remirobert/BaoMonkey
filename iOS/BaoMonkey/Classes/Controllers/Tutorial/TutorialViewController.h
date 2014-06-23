//
//  TutorialViewController.h
//  BaoMonkey
//
//  Created by Jeremy Peltier on 22/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>

@interface TutorialViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageController;

@end
