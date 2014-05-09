//
//  GameOver.h
//  BaoMonkey
//
//  Created by Jeremy Peltier on 09/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Define.h"

@interface GameOver : NSObject {
    SKSpriteNode *cloud;
}

-(SKSpriteNode *)launchGameOverView;

@end
