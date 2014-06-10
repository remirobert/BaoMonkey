//
//  Credit.m
//  BaoMonkey
//
//  Created by iPPLE on 10/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Credit.h"

@implementation Credit

- (void) initBackground {
    SKSpriteNode *bg = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"credits-background"]];
    
    bg.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2,
                              [UIScreen mainScreen].bounds.size.height / 2);
    [self addChild:bg];
}

- (void) createName:(NSString *)name :(NSInteger)positionY {
    SKLabelNode *nameNode = [[SKLabelNode alloc] init];
    nameNode.text = name;
    nameNode.fontSize = 11.0;
    nameNode.zPosition = 50;
    nameNode.position = CGPointMake(100, positionY);
    nameNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    [self addChild:nameNode];
}

- (void) initLabel {
    NSArray *name = @[@"Brieuc Delafouchardiere", @"Remi Hillairet",
                      @"Remi Robert", @"Jeremy Peltier", @"Romain Combe"];
    
    SKLabelNode *title = [[SKLabelNode alloc] init];
    title.text = @"Developer :";
    title.fontSize = 12.0;
    title.zPosition = 50;
    title.position = CGPointMake(100, 250);
    title.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;

    NSInteger positionY = 220;
    for (NSString *currentName in name) {
        [self createName:currentName :positionY];
        positionY -= 20;
    }
    
    SKLabelNode *title2 = [[SKLabelNode alloc] init];
    title2.text = @"Graphism :";
    title2.fontSize = 12.0;
    title2.zPosition = 50;
    title2.position = CGPointMake(100, 90);
    title2.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;

    [self createName:@"Alexandre Quintin" :60];
    
    [self addChild:title2];
    [self addChild:title];
}

- (instancetype) initWithSize:(CGSize)size andParentScene:(SKScene *)parentScene {
    self = [super initWithSize:size];
    
    if (self != nil) {
        [self initBackground];
        [self initLabel];
    }
    return (self);
}

- (void) popBubble:(NSTimeInterval)currentTime {
    static NSTimeInterval timer = 0;
    NSArray *tabImage = @[@"big-bubble", @"medium-bubble", @"small-bubble"];
    
    if (timer == 0) {
        timer = rand() % 2 + 1 + currentTime;
    }
    
    if (currentTime >= timer) {
        SKSpriteNode *bubble = [SKSpriteNode spriteNodeWithImageNamed:[tabImage objectAtIndex:rand() % 3]];
        
        bubble.position = CGPointMake(rand() % 250 + (bubble.size.width / 2), 0);
        if (rand() % 2 == 0)
            bubble.zPosition = 25;
        else
            bubble.zPosition = 100;
        
        [self addChild:bubble];
        if (bubble.position.x <= [UIScreen mainScreen].bounds.size.width / 2) {
            [bubble runAction:[SKAction moveToY:200 duration:2.0]];
            [bubble runAction:[SKAction fadeOutWithDuration:2.0]];
        }
        else {
            [bubble runAction:[SKAction moveToY:150 duration:1.5]];
            [bubble runAction:[SKAction fadeOutWithDuration:1.5]];
        }
        timer = 1 + currentTime;
    }
}

- (void) update:(NSTimeInterval)currentTime {
    [self popBubble:currentTime];
}

@end
