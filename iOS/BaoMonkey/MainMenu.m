//
//  MainMenu.m
//  BaoMonkey
//
//  Created by iPPLE on 27/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "MainMenu.h"
#import "Define.h"

@interface MainMenu ()
@end

@implementation MainMenu

- (void) initbutton {
    SKLabelNode * play = [[SKLabelNode alloc] init];
    
    play.text = @"play";
    play.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    play.name = @"play";
    
    [self addChild:play];
    
    
    SKLabelNode * settings = [[SKLabelNode alloc] init];
    
    settings.text = @"settings";
    settings.position = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2 - 100);
    settings.name = @"settings";
    
    [self addChild:settings];
}

- (instancetype) initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    
    if (self != nil) {
        self.backgroundColor = [SKColor redColor];
        NSLog(@"Main Menu ok");
        [self initbutton];
    }
    return (self);
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"play"])
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_RETRY_GAME object:nil];
    if ([node.name isEqualToString:@"settings"])
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_GO_TO_SETTINGS object:nil];
}


@end
