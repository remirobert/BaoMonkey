//
//  BaoButton.h
//  BaoMonkey
//
//  Created by Rémi Hillairet on 22/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface BaoButton : NSObject

+(SKSpriteNode*)play;
+(SKSpriteNode*)pause;
+(SKSpriteNode*)replay;
+(SKSpriteNode*)home;
+(SKSpriteNode*)settings;
+(SKLabelNode*)pauseLabel;

@end
