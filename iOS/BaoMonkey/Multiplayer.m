//
//  Multiplayer.m
//  BaoMonkey
//
//  Created by iPPLE on 11/06/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Multiplayer.h"
#import "MultiplayerData.h"

@interface Multiplayer ()
@property (nonatomic, strong) SKScene *parentScene;
@property (nonatomic, strong) SKLabelNode *backButton;
@property (nonatomic, strong) SKLabelNode *findPlayer;
@property (nonatomic, strong) SKLabelNode *connect;
@end

@implementation Multiplayer

- (void) initButton {
    _backButton = [[SKLabelNode alloc] init];
    
    _backButton.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2,
                                       [UIScreen mainScreen].bounds.size.height / 2);
    _backButton.name = _backButton.text = @"back";
    [self addChild:_backButton];
    
    _findPlayer = [[SKLabelNode alloc] init];
    _findPlayer.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2,
                                       [UIScreen mainScreen].bounds.size.height / 2 + 100);
    _findPlayer.name = _findPlayer.text = @"find";
    [self addChild:_findPlayer];
}

- (instancetype) initWithSize:(CGSize)size :(SKScene *)parentScene {
    self = [super initWithSize:size];
    
    if (self != nil) {
        [self initButton];
        _parentScene = parentScene;
        
        _connect = [[SKLabelNode alloc] init];
        _connect.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 0);
        [self addChild:_connect];
    }
    return (self);
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"back"]) {
        [self.view presentScene:_parentScene transition:[SKTransition pushWithDirection:SKTransitionDirectionUp duration:2.0]];
    }
    else if ([node.name isEqualToString:@"find"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"find_player" object:nil];
    }
}

- (void) update:(NSTimeInterval)currentTime {
    if ([MultiplayerData data].isConnected == YES) {
            if ([MultiplayerData data].match != nil) {
                if ([MultiplayerData data].status == HOST)
                    _connect.text = @"HOST";
                else
                    _connect.text = @"GUEST";
            }
            else
                _connect.text= @"Error text";
    }
    else {
        _connect.text= @"Not conected";
    }
}

@end
