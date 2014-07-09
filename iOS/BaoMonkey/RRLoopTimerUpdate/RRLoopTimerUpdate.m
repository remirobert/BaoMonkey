//
//  RRTimerUpdate.m
//  timer
//
//  Created by Remi Robert on 04/07/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

#import "RRLoopTimerUpdate.h"

@interface RRLoopTimerUpdate ()
@property (nonatomic, strong) NSDate *timerInterval;
@end

@implementation RRLoopTimerUpdate

- (instancetype) init :(NSTimeInterval)currentTime {
    self = [super init];
    
    if (self != nil) {
        _rangeTimer = 0;
    }
    return (self);
}

- (void) freezeTimer {
    _timerInterval = [NSDate date];
}

- (void) restartTimer {
    _rangeTimer += [_timerInterval timeIntervalSinceNow];
}

@end