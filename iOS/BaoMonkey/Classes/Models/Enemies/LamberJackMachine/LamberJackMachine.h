//
//  LamberJackMachine.h
//  BaoMonkey
//
//  Created by iPPLE on 22/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

# define LAMBER_JACK_MACHINE    @"lamber_JackMachine"

@interface LamberJackMachine : NSObject

@property (nonatomic, strong) SKSpriteNode *node;

- (instancetype) init;

@end
