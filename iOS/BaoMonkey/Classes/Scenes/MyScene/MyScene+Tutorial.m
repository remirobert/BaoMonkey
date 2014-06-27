//
//  MyScene+Tutorial.m
//  BaoMonkey
//
//  Created by Remi Robert on 27/06/14.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "MyScene+Tutorial.h"

NSTimeInterval timer;
NSInteger tutoStep;
NSTimer *timerDismiss;

@implementation MyScene (Tutorial)

-(SKSpriteNode *)tutorialStepWithText:(NSString *)text{
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:35/255.0f
                                                                           green:35/255.0f
                                                                            blue:35/255.0f
                                                                           alpha:0.5f]
                                                      size:CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH / 3)];
    
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Ravie"];
    label.text = text;
    label.fontSize = 12;
    label.color = [UIColor whiteColor];
    label.position = CGPointMake(0, 5);
    [node addChild:label];
    
    SKLabelNode *detail = [SKLabelNode labelNodeWithFontNamed:@"Ravie"];
    detail.text = @"Click to dismiss";
    detail.fontSize = 10;
    detail.color = [UIColor whiteColor];
    detail.position = CGPointMake(label.position.x, label.position.y - 25);
    [node addChild:detail];
    
    node.name = @"TUTORIAL_STEP";
    node.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
    node.zPosition = 55;
    
    return node;
}

- (void) initTimerTutorial {
    timer = 0;
    tutoStep = 0;
}

- (void) dismissTutorial {
    [[self childNodeWithName:@"TUTORIAL_STEP"] removeFromParent];
    [self resumeGame];
}

- (void) removeTimer {
    [timerDismiss invalidate];
}

- (void) timerDismissTutorial {
    timerDismiss = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                    target:self
                                                  selector:@selector(dismissTutorial)
                                                  userInfo:nil
                                                   repeats:NO];
}

- (void) displayTutorial:(NSTimeInterval)currentTime {
    static BOOL isPassed = YES;
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"first_launch"] == YES)
        return ;

    if (timer == 0) {
        timer = currentTime + 2;
        return ;
    }
    
    if (currentTime >= timer) {
        switch (tutoStep) {
            case 0: {
                static dispatch_once_t step1;
                dispatch_once(&step1, ^{
                    [self addChild:[self tutorialStepWithText:@"Tilt your phone to move Bao"]];
                    [self timerDismissTutorial];
                    [self pauseGameWithScene:NO];
                });
                break;
            }
            case 1: {
                static dispatch_once_t step2;
                dispatch_once(&step2, ^{
                    [[self childNodeWithName:@"TUTORIAL_STEP"] removeFromParent];
                    [self addChild:[self tutorialStepWithText:@"Catch coconut and tap to shoot"]];
                    [self timerDismissTutorial];
                    [self pauseGameWithScene:NO];
                });
                break;
            }
            case 2: {
                static dispatch_once_t step3;
                dispatch_once(&step3, ^{
                    [[self childNodeWithName:@"TUTORIAL_STEP"] removeFromParent];
                    [self addChild:[self tutorialStepWithText:@"Don't let ennemies destroy your tree"]];
                    [self timerDismissTutorial];
                    [self pauseGameWithScene:NO];
                });
                break;
            }
            case 3: {
                static dispatch_once_t step4;
                dispatch_once(&step4, ^{
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first_launch"];
                    [[self childNodeWithName:@"TUTORIAL_STEP"] removeFromParent];
                    [self resumeGame];
                });
                break;
            }
            default:
                break;
        }
        isPassed = NO;
        timer = currentTime + 4;
        tutoStep += 1;
        if (tutoStep == 4)
            timer = currentTime;
    }
}

@end
