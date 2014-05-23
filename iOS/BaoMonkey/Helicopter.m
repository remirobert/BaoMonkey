//
//  Helicopter.m
//  BaoMonkey
//
//  Created by iPPLE on 23/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Helicopter.h"

@implementation Helicopter

- (void) initHelicopter {
    _node = [[SKSpriteNode alloc] initWithColor:[SKColor blackColor] size:CGSizeMake(30, 20)];
    
    if (_sens == 0)
        _node.position = CGPointMake((_node.size.width / 2),
                                     [UIScreen mainScreen].bounds.size.height - (_node.size.width / 2));
    else
        _node.position = CGPointMake([UIScreen mainScreen].bounds.size.width - (_node.size.width / 2),
                                     [UIScreen mainScreen].bounds.size.height - (_node.size.width / 2));
}

- (instancetype) init {
    self = [super init];
    
    if (self != nil) {
        _sens = rand() % 2;
        [self initHelicopter];
    }
    return (self);
}

- (void) mmove {
    if (_sens == 0) {
        _node.position = CGPointMake(_node.position.x + 1, _node.position.y);
    }
    else {
        _node.position = CGPointMake(_node.position.x - 1, _node.position.y);
    }
    
    if (_node.position.x + (_node.size.width / 2) >
        [UIScreen mainScreen].bounds.size.width) {
        _sens = 1;
    }
    else if (_node.position.x + (_node.size.width / 2) < 0) {
        _sens = 0;
    }
}

@end
