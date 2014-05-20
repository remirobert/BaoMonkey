//
//  PauseTransition.h
//  BaoMonkey
//
//  Created by Rémi Hillairet on 20/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface PauseTransition : NSObject {
    SKSpriteNode *upLeaf;
    SKSpriteNode *bottomLeaf;
    SKScene *scene;
    NSArray *pauseButton;
}

-(id)init;
-(void)runTransition:(SKScene*)_scene;

@end
