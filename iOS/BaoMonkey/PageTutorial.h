//
//  PageTutorial.h
//  BaoMonkey
//
//  Created by iPPLE on 23/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageTutorial : UIViewController

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UIImageView *imageTuto;

+ (PageTutorial *) newPage:(NSInteger)index :(UIImage *)image;

@end
