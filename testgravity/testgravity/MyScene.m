//
//  MyScene.m
//  testgravity
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        
//        self.physicsBody =  [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        _node = [[SKSpriteNode alloc] initWithColor:[SKColor redColor] size:CGSizeMake(50, 50)];
        
        SKPhysicsBody *b = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50, 50)];
        
        _node.physicsBody.affectedByGravity = YES;
        _node.position = CGPointMake(100, 400);
        
        _node.physicsBody = b;

    
        SKSpriteNode *f = [[SKSpriteNode alloc] initWithColor:[SKColor blackColor] size:CGSizeMake(200, 200)];
        
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:f.frame];
        

//        self.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(f.position.x, f.position.y) toPoint:CGPointMake(f.position.x + 200, f.position.y + 200)];

        [self addChild:_node];
        [self addChild:f];
        
    }
    return self;
}

@end
