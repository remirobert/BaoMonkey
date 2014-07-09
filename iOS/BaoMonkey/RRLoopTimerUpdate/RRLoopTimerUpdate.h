//
//  RRTimerUpdate.h
//  timer
//
//  Created by Remi Robert on 04/07/14.
//  Copyright (c) 2014 remirobert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRLoopTimerUpdate : NSObject

@property (nonatomic, assign) NSTimeInterval rangeTimer;

- (instancetype) init :(NSTimeInterval)currentTime;
- (void) freezeTimer;
- (void) restartTimer;

@end
