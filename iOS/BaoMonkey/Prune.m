//
//  Prune.m
//  iosGame
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "Prune.h"
#import "UserData.h"
#import "PreloadData.h"
#import "Define.h"

@implementation Prune

- (instancetype) initWithPosition:(CGPoint)position {
    if ((self = [super initWithPosition:position]) != nil) {
        [self.node setTexture:[PreloadData getDataWithKey:DATA_PRUNE_TEXTURE]];
        self.action = @selector(actionPrune);
        self.node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.node.size.width / 3];
        self.node.physicsBody.mass = 10.0;
    }
    return (self);
}

- (void) actionPrune {
    SKAction *move = [SKAction moveTo:CGPointMake(self.node.position.x, 200) duration:0];
    SKAction *sound = (SKAction *)[PreloadData getDataWithKey:DATA_SPLASH_SOUND];
    
    SKAction *action = [SKAction resizeToWidth:640 height:512 duration:0.2];
    SKAction *wait = [SKAction waitForDuration:1.0];
    
    SKSpriteNode *secondSplash = [[SKSpriteNode alloc] initWithTexture:[PreloadData getDataWithKey:DATA_SPLASH_PLUMS2]];
    secondSplash.position = CGPointMake(rand() % (int)[UIScreen mainScreen].bounds.size.width, rand() % (int)[UIScreen mainScreen].bounds.size.height);

    SKSpriteNode *firstSplash = [[SKSpriteNode alloc] initWithTexture:[PreloadData getDataWithKey:DATA_SPLASH_PLUMS1]];
    firstSplash.position = CGPointMake(self.node.position.x, [UIScreen mainScreen].bounds.size.height / 2);

    
    [self.node removeAllActions];
    
    [UserData addPrune];

    [self.timerHide invalidate];
    self.timerHide = nil;
    self.isTaken = YES;
    self.node.physicsBody = nil;
    [self.node removeFromParent];
    
    SKAction *actionPrune = [SKAction group:@[move, sound, action, wait]];
    
    
    if (_parentScene != nil) {
        [_parentScene addChild:firstSplash];
        [_parentScene addChild:secondSplash];
    }
    
    secondSplash.zPosition = 500;
    firstSplash.zPosition = 500;
    
    [firstSplash runAction:actionPrune completion:^{
        self.isOver = YES;
        [firstSplash removeFromParent];
        [secondSplash runAction:[SKAction waitForDuration:0.75] completion:^{
            [secondSplash removeFromParent];
        }];
    }];
}

@end
