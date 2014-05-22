//
//  BaoButton.m
//  BaoMonkey
//
//  Created by Rémi Hillairet on 22/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "BaoButton.h"
#import "Define.h"
#import "PreloadData.h"

@implementation BaoButton

+(SKSpriteNode*)buttonPlay {
    SKSpriteNode *playNode = [SKSpriteNode spriteNodeWithTexture:[PreloadData getDataWithKey:DATA_BUTTON_PLAY]];
    
    playNode.name = RESUME_NODE_NAME;
}

+(SKSpriteNode*)buttonPause {
    
}

+(SKSpriteNode*)buttonReplay {
    
}

+(SKSpriteNode*)buttonHome {
    
}

+(SKSpriteNode*)buttonSettings {
    
}

@end
