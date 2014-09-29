//
//  MyScene+Tutorial.h
//  BaoMonkey
//
//  Created by Remi Robert on 27/06/14.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "MyScene.h"

@interface MyScene (Tutorial)

- (void) displayTutorial:(NSTimeInterval)currentTime;
- (void) initTimerTutorial;
- (void) timerDismissTutorial;
- (void) removeTimer;

@end
