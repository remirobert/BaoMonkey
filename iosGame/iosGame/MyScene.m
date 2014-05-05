//
//  MyScene.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "MyScene.h"
#import "MyScene+GeneratorWave.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor colorWithRed:0.15
                                               green:0.15
                                                blue:0.3
                                               alpha:1.0];
        
        NSLog(@"%f", ([UIScreen mainScreen].bounds.size.width - (25 * 10)) / 10);

        [self performSelector:@selector(addWave) withObject:nil afterDelay:1.0];
    }
    return self;
}

- (void) addWave {
    [self addNewWave];
    [self performSelector:@selector(addWave) withObject:nil afterDelay:1.0];
}

-(void)update:(CFTimeInterval)currentTime {
    [self moveWave];
}

@end
