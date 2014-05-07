//
//  Banana.h
//  iosGame
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "Malus.h"

@interface Banana : Malus

- (instancetype) initWithPosition:(CGPoint)position;
- (void) launchAction;

@end
