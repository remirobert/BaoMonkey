//
//  Hunter.h
//  BaoMonkey
//
//  Created by Rémi Hillairet on 08/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Enemy.h"

@interface Hunter : Enemy

@property (nonatomic, assign) NSInteger slot;
@property (nonatomic, assign) BOOL isMoving;

-(id)initWithFloor:(NSInteger)floor slot:(NSInteger)slotFloor;
- (SKSpriteNode *) shootMonkey :(CFTimeInterval)currentTime :(CGPoint)positionMonkey;

@end
