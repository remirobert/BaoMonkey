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

+(SKSpriteNode*)buttonPlay;
+(SKSpriteNode*)buttonPause;
+(SKSpriteNode*)buttonReplay;
+(SKSpriteNode*)buttonHome;
+(SKSpriteNode*)buttonSettings;

@end
