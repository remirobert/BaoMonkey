//
//  Multiplayer.m
//  BaoMonkey
//
//  Created by iPPLE on 11/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Multiplayer.h"

@interface Multiplayer ()
@property (nonatomic, strong) SKScene *parentScene;
@property (nonatomic, strong) SKLabelNode *backButton;
@end

@implementation Multiplayer

- (void) initButton {
    _backButton = [[SKLabelNode alloc] init];
    
    _backButton.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    _backButton.name = _backButton.text = @"back";
    [self addChild:_backButton];
}

- (instancetype) initWithSize:(CGSize)size :(SKScene *)parentScene{
    self = [super initWithSize:size];
    
    if (self != nil) {
        _parentScene = parentScene;
    }
    return (self);
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKNode *node = [self nodeAtPoint:[[touches anyObject] position]];
    
    if ([node.name isEqualToString:@"back"]) {
        [self.view presentScene:_parentScene transition:[SKTransition pushWithDirection:SKTransitionDirectionUp duration:2.0]];
    }
}

@end
