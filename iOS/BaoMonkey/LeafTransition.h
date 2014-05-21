//
//  LeafTransition.h
//  BaoMonkey
//
//  Created by Rémi Hillairet on 20/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface LeafTransition : NSObject {
    SKSpriteNode *upLeaf;
    SKSpriteNode *bottomLeaf;
    SKScene *scene;
    NSArray *pauseButton;
    NSArray *gameOverButton;
}

-(id)initWithScene:(SKScene*)_scene;
-(void)runPauseTransition;
-(void)runGameOverTransition;

@end
