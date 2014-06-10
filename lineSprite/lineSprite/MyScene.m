//
//  MyScene.m
//  lineSprite
//
//  Created by iPPLE on 10/06/2014.
//  Copyright (c) 2014 1. All rights reserved.
//

#import "MyScene.h"

@interface MyScene ()
@property (nonatomic, strong) SKSpriteNode *line;
@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        
        _line = [[SKSpriteNode alloc] initWithColor:[SKColor blueColor] size:CGSizeMake(100, 10)];
        
        _line.position = CGPointMake(100, [UIScreen mainScreen].bounds.size.height / 2);
        
        [self addChild:_line];
        

        SKSpriteNode *line2 = [[SKSpriteNode alloc] initWithColor:[SKColor greenColor] size:CGSizeMake(100, 10)];
        
        line2.position = CGPointMake([UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.height / 2);
        
        [self addChild:line2];

        
        line2.name = @"line";
        
        [_line runAction:[SKAction rotateByAngle:1.15 duration:0]];
        [line2 runAction:[SKAction rotateByAngle:-1.15 duration:0]];
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

-(void)update:(CFTimeInterval)currentTime {
    
    
    [self enumerateChildNodesWithName:@"line" usingBlock:^(SKNode *node, BOOL *stop) {
        if ([_line intersectsNode:node] == false)
            node.position = CGPointMake(node.position.x - 1, node.position.y);
    }];
}

@end
