//
//  Climber.m
//  BaoMonkey
//
//  Created by iPPLE on 09/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Climber.h"
#import "Define.h"
#import "PreloadData.h"

@interface Climber ()
@property (nonatomic, assign) NSInteger climbPositionX;
@end

@implementation Climber

-(id)initWithDirection:(Direction)_direction {
    self = [super init];
    
    if (self) {
        CGPoint position;
        NSInteger decalPosition;
        
        self.direction = _direction;
        self.type = EnemyTypeClimber;
        self.node.zPosition = 10;
        self.kind = rand() % 2;
        
        if (self.kind == MONKEY) {
            node = [SKSpriteNode spriteNodeWithTexture:[PreloadData getDataWithKey:@"gorilla-walking-1"]];
            decalPosition = 35;
        }
        else {
            node = [SKSpriteNode spriteNodeWithTexture:[PreloadData getDataWithKey:@"commando-walking-1"]];
            decalPosition = 20;
        }
        
        if (self.direction == LEFT)
        {
            position.x = 0;
            _climbPositionX = ([UIScreen mainScreen].bounds.size.width / 2) - decalPosition;
        }
        else
        {
            node.xScale = -1.0;
            position.x = [UIScreen mainScreen].bounds.size.width + (node.size.width / 2);
            _climbPositionX = ([UIScreen mainScreen].bounds.size.width / 2) + decalPosition;
        }
        
        node.name = ENEMY_NODE_NAME;
        position.y = node.size.height / 2 + 22;
        [node setPosition:position];
        _isClimb = NO;
        _isOnPlateform = NO;
    }
    return (self);
}

- (void) moveAnimation {
    if (self.kind == MONKEY)
        [node runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[[PreloadData getDataWithKey:@"gorilla-walking-1"],
                                                                                      [PreloadData getDataWithKey:@"gorilla-walking-2"]] timePerFrame:0.2]]];
    else
        [node runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[[PreloadData getDataWithKey:@"commando-walking-1"],
                                                                                      [PreloadData getDataWithKey:@"commando-walking-2"],
                                                                                      [PreloadData getDataWithKey:@"commando-walking-3"],
                                                                                      [PreloadData getDataWithKey:@"commando-walking-4"],
                                                                                      [PreloadData getDataWithKey:@"commando-walking-5"],
                                                                                      [PreloadData getDataWithKey:@"commando-walking-6"]] timePerFrame:0.2]]];
}

- (void) moveTrunk {
    if (self.kind == MONKEY) {
        if (self.direction == RIGHT)
            self.node.xScale = 1.0;
        else
            self.node.xScale = -1.0;

        [node runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[[PreloadData getDataWithKey:@"gorilla-climbing-1"],
                                                                                      [PreloadData getDataWithKey:@"gorilla-climbing-2"]] timePerFrame:0.2]]];
    }
    else
        [node runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[[PreloadData getDataWithKey:@"commando-climbing-1"],
                                                                                      [PreloadData getDataWithKey:@"commando-climbing-2"]] timePerFrame:0.2]]];
}

- (void) actionClimber:(NSInteger)positionclimb {
    if (_isClimb == YES)
        return ;
    _isClimb = YES;
    _isClimbing = NO;
    SKAction *moveToTrunk = [SKAction moveToX:_climbPositionX
                                     duration:1.5];
    SKAction *waitClimb = [SKAction waitForDuration:0.25];
    SKAction *climb = [SKAction moveToY:positionclimb
                               duration:5.5];
    [self moveAnimation];
    
    [self.node runAction:waitClimb completion:^{
       [self.node runAction:moveToTrunk completion:^{
           [self moveTrunk];
           _isClimbing = YES;
           [self.node runAction:waitClimb completion:^{
               [self.node runAction:climb completion:^{
               _isOnPlateform = YES;
               node.name = SHOOT_NODE_NAME;
               }];
           }];
       }];
    }];
}

+ (void) startDead:(Climber *)climber :(NSMutableArray *)enemiesTab {

    if (climber.isClimbing == YES) {
        
        NSArray *texturesTree;
        
        if (climber.kind == MONKEY) {
            texturesTree = @[[PreloadData getDataWithKey:@"gorilla-climbing-dead-1"],
                             [PreloadData getDataWithKey:@"gorilla-climbing-dead-2"]];
        }
        else {
            texturesTree = @[[PreloadData getDataWithKey:@"commando-climing-dead-1"],
                             [PreloadData getDataWithKey:@"commando-climbing-dead-2"]];
        }

        
        [climber.node runAction:[SKAction animateWithTextures:texturesTree timePerFrame:0.2] completion:^{
                [climber.node runAction:[SKAction moveTo:CGPointMake(climber.node.position.x, 0) duration:0.5] completion:^{
                [climber.node removeFromParent];
                [enemiesTab removeObject:climber];
            }];
        }];
    }
    else {
        NSArray *texturesGrass;
        
        if (climber.kind == MONKEY) {
            texturesGrass = @[[PreloadData getDataWithKey:@"gorilla-walking-dead-1"],
                              [PreloadData getDataWithKey:@"gorilla-walking-dead-2"]];
        }
        else {
            texturesGrass = @[[PreloadData getDataWithKey:@"commando-walking-dead-1"],
                              [PreloadData getDataWithKey:@"commando-walking-dead-2"]];
        }
        
        [climber.node runAction:[SKAction animateWithTextures:texturesGrass timePerFrame:0.2] completion:^{
            [climber.node removeFromParent];
            [enemiesTab removeObject:climber];
        }];
    }
}

@end
