//
//  LamberJack.m
//  BaoMonkey
//
//  Created by Rémi Hillairet on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "LamberJack.h"
#import "Define.h"
#import "BaoSize.h"
#import "PreloadData.h"

@implementation LamberJack

@synthesize isChooping;

-(id)initWithDirection:(Direction)_direction {
    self = [super init];
    CGRect screen = [UIScreen mainScreen].bounds;
    CGPoint position;
    CGFloat middleScreen;

    if (self) {
        self.direction = _direction;
        self.type = EnemyTypeLamberJack;
        self.node.zPosition = 10;
        
        self.node = [[SKSpriteNode alloc] initWithTexture:[PreloadData getDataWithKey:@"lamber-jack-walking-1"]];
                
        if (self.direction == LEFT)
        {
            node.xScale = -1;
            position.x = screen.size.width + (node.size.width / 2);
            middleScreen = (SCREEN_WIDTH / 2) + (node.size.width / 2) + (IPAD ? 15 : 0);
        }
        else
        {
            node.xScale = 1;
            position.x = -(node.size.width / 2);
            middleScreen = (SCREEN_WIDTH / 2) - (node.size.width / 2) - (IPAD ? 15 : 0);
        }
        node.name = ENEMY_NODE_NAME;
        position.y = node.size.height / 2 + FLOOR_HEIGHT;
        node.position = position;
        [self startWalking];
        node.zPosition = 10;
        SKAction *walking = [SKAction moveToX:middleScreen duration:4.0];
        [node runAction:walking completion:^{
            [self startChopping];
            [self stopWalking];
        }];
    }
    return self;
}

-(void)startWalking {
    if (![node actionForKey:SKACTION_LAMBERJACK_WALKING]) {
        
        [node runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[[PreloadData getDataWithKey:@"lamber-jack-walking-1"],
                                                                                      [PreloadData getDataWithKey:@"lamber-jack-walking-2"],
                                                                                      [PreloadData getDataWithKey:@"lamber-jack-walking-3"],
                                                                                      [PreloadData getDataWithKey:@"lamber-jack-walking-4"],
                                                                                      [PreloadData getDataWithKey:@"lamber-jack-walking-5"],
                                                                                      [PreloadData getDataWithKey:@"lamber-jack-walking-6"]]
                                                                            timePerFrame:0.1f
                                                                               resize:NO
                                                                              restore:NO]]
                  withKey:SKACTION_LAMBERJACK_WALKING];
    }
}

-(void)stopWalking {
    [node removeActionForKey:SKACTION_LAMBERJACK_WALKING];
    if (self.direction == LEFT) {
        node.xScale = -1;
    } else {
        node.xScale = 1;
    }
}

-(void)startChopping {
    isChooping = TRUE;
    if (![node actionForKey:SKACTION_LAMBERJACK_CUTTING]) {
        [node runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[[PreloadData getDataWithKey:@"lamber-jack-chopping-1"],
                                                                                      [PreloadData getDataWithKey:@"lamber-jack-chopping-2"],
                                                                                      [PreloadData getDataWithKey:@"lamber-jack-chopping-3"]]
                                                                       timePerFrame:0.1f
                                                                             resize:NO
                                                                            restore:NO]]
                withKey:SKACTION_LAMBERJACK_CUTTING];
    }
}

-(void)stopChopping {
    isChooping = FALSE;
    [node removeActionForKey:SKACTION_LAMBERJACK_CUTTING];
    if (self.direction == LEFT) {
        node.xScale = -1;
    } else {
        node.xScale = 1;
    }
}

-(void)startDead {
    if (!isChooping) {
        if (![node actionForKey:SKACTION_LAMBERJACK_DEAD]) {
            [node runAction:[SKAction animateWithTextures:@[[PreloadData getDataWithKey:@"lamber-jack-dead-1"],
                                                            [PreloadData getDataWithKey:@"lamber-jack-dead-2"]]
                                                                    timePerFrame:0.1f
                                                                          resize:NO
                                                                         restore:NO] completion:^{
                [node removeAllActions];
                [node runAction:[SKAction waitForDuration:0.5] completion:^{
                    [node removeFromParent];
                }];
            }];
        }
    }
}

@end
