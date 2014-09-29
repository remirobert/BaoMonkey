//
//  iAdController.h
//  BaoMonkey
//
//  Created by Rémi Hillairet on 27/06/14.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iAd/iAd.h>

@interface iAdController : NSObject<ADBannerViewDelegate> {
    ADBannerView *iAdView;
    UIViewController *viewControllerParent;
    BOOL haveToShow;
}

+ (void)showADBannerWithViewController:(UIViewController*)viewController;
+ (void)hideADBanner;

@end
