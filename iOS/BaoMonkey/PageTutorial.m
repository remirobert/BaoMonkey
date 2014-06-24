//
//  PageTutorial.m
//  BaoMonkey
//
//  Created by iPPLE on 23/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "PageTutorial.h"
#import "Define.h"
#import "UserData.h"

@implementation PageTutorial

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void) startPlay {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"play-game-after-tutoriel" object:nil];
}

- (void) initStartButton {
    if (_index != 2)
        return ;
    UIButton *startbutton = [[UIButton alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 2,
                                                                       [UIScreen mainScreen].bounds.size.width, 100)];
    [startbutton setTitle:@"start play" forState:UIControlStateNormal];
    [startbutton addTarget:self action:@selector(startPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startbutton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:_imageTuto];
    [self initStartButton];
}

+ (PageTutorial *) newPage:(NSInteger)index :(UIImage *)image {
    PageTutorial *tuto = [[PageTutorial alloc] init];
    
    tuto.index = index;
    tuto.imageTuto = [[UIImageView alloc] initWithImage:image];
    return (tuto);
}

@end
