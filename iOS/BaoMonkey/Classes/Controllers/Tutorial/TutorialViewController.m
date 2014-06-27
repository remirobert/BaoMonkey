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
#import "PageTutorial.h"
#import "MyScene.h"

@interface TutorialViewController ()
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSArray *pageTutoriels;
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

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return (3);
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return (0);
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [(PageTutorial *)viewController index];
    
     NSLog(@"index = %lu", (unsigned long)index);
    
    if (index == 0) {
        return nil;
    }
    index--;

    return ([PageTutorial newPage:index :[UIImage imageNamed:[_images objectAtIndex:index]]]);
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
     NSUInteger index = [(PageTutorial *)viewController index];

    NSLog(@"index = %lu", (unsigned long)index);

    if (index >= 2) {
        return nil;
    }
    index++;
    return ([PageTutorial newPage:index :[UIImage imageNamed:[_images objectAtIndex:index]]]);
}

- (void) initPageController {
    _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                    options:nil];
    
    _pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    NSArray *viewControllers = [NSArray arrayWithObject:[_pageTutoriels objectAtIndex:0]];
    
    [_pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward
                               animated:YES completion:nil];
    
    [self addChildViewController:_pageController];
    [[self view] addSubview:[_pageController view]];
    [self.pageController didMoveToParentViewController:self];
}

- (void) startPlay {
    NSLog(@"clic");
    
    [UserData setIsFirstRun:TRUE];
        
    //[[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_START_GAME object:nil];
//    [self.pageController dismissViewControllerAnimated:NO completion:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startPlay) name:@"play-game-after-tutoriel" object:nil];
    
    PageTutorial *page1 = [[PageTutorial alloc] init];
    page1.index = 0;
    page1.imageTuto = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tutorial-panel-1"]];
    page1.imageTuto.frame = self.view.frame;
    
    PageTutorial *page2 = [[PageTutorial alloc] init];
    page2.index = 0;
    page2.imageTuto = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tutorial-panel-2"]];
    page2.imageTuto.frame = self.view.frame;
    
    _pageTutoriels = @[page1, page2, page2];
    _images = @[@"tutorial-panel-1", @"tutorial-panel-2", @"tutorial-panel-2"];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self initPageController];
    
}

@end
