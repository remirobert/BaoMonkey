//
//  iAdController.m
//  BaoMonkey
//
//  Created by Rémi Hillairet on 27/06/14.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "iAdController.h"
#import "Define.h"

@implementation iAdController

static iAdController *singleton;

-(id)init {
    self = [super init];
    if (self) {
        iAdView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
        [iAdView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, iAdView.frame.size.height)];
        [iAdView setDelegate:self];
    }
    return self;
}

+(id)singleton {
    if (!singleton) {
        singleton = [[iAdController alloc] init];
    }
    return singleton;
}

#pragma mark - Show / Hide ADBanner

+ (void)showADBannerWithViewController:(UIViewController*)viewController {
    return [[iAdController singleton] showADBannerWithViewController:viewController];
}

- (void)showADBannerWithViewController:(UIViewController*)viewController {
    haveToShow = TRUE;
    viewControllerParent = viewController;
    if (iAdView.bannerLoaded) {
        [self runAnimation];
    }
}

- (void)runAnimation {
    [viewControllerParent.view addSubview:iAdView];
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        iAdView.frame = CGRectMake(0, SCREEN_HEIGHT - iAdView.frame.size.height, SCREEN_WIDTH, iAdView.frame.size.height);
    } completion:nil];
}

+ (void)hideADBanner {
    return [[iAdController singleton] hideADBanner];
}

- (void)hideADBanner {
    haveToShow = FALSE;
    [iAdView removeFromSuperview];
    [iAdView setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, iAdView.frame.size.height)];
}

#pragma mark - Delegate

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"Banner View fail !");
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if (haveToShow)
        [self runAnimation];
}

@end
