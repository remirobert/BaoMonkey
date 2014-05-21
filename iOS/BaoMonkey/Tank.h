//
//  Tank.h
//  BaoMonkey
//
//  Created by iPPLE on 21/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

NS_ENUM(int, SENS_TANK){
    LEFT = 0,
    RIGHT = 1
};
@interface Tank : NSObject

@property (nonatomic, strong) SKSpriteNode *tankSprite;
@property (nonatomic, assign) enum SENS_TANK sens;

- (instancetype) init;
- (void) move;

@end