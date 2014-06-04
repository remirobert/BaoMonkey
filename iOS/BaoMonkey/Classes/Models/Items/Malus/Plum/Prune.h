//
//  Prune.h
//  iosGame
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "Malus.h"
#import "GameData.h"

@interface Prune : Malus

@property (nonatomic, strong) SKScene *parentScene;

- (instancetype) initWithPosition:(CGPoint)position;

@end
