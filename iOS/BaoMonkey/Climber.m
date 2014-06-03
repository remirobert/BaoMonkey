//
//  Climber.m
//  BaoMonkey
//
//  Created by iPPLE on 09/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Climber.h"
#import "Define.h"

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
            node = [SKSpriteNode spriteNodeWithImageNamed:@"gorille-1"];
            decalPosition = 40;
        }
        else {
            node = [SKSpriteNode spriteNodeWithImageNamed:@"commando-1"];
            decalPosition = 20;
        }
        
        node.size = CGSizeMake(node.size.width / 4, node.size.height / 4);
        
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
        position.y = node.size.height / 2;
        [node setPosition:position];
        _isClimb = NO;
        _isOnPlateform = NO;
    }
    return (self);
}

- (void) moveAnimation {
    if (self.kind == MONKEY)
        [node runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[[SKTexture textureWithImageNamed:@"gorille-1"],
                                                                                      [SKTexture textureWithImageNamed:@"gorille-2"]] timePerFrame:0.2]]];
    else
        [node runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[[SKTexture textureWithImageNamed:@"commando-1"],
                                                                                      [SKTexture textureWithImageNamed:@"commando-2"]] timePerFrame:0.2]]];
}

- (void) moveTrunk {
    if (self.kind == MONKEY) {
        if (self.direction == RIGHT)
            self.node.xScale = 1.0;
        else
            self.node.xScale = -1.0;

        [node runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[[SKTexture textureWithImageNamed:@"gorille-arbre-1"],
                                                                                      [SKTexture textureWithImageNamed:@"gorille-arbre-2"]] timePerFrame:0.2]]];
    }
    else
        [node runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[[SKTexture textureWithImageNamed:@"commando-arbre1"],
                                                                                      [SKTexture textureWithImageNamed:@"commando-arbre2"]] timePerFrame:0.2]]];
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
            texturesTree = @[[SKTexture textureWithImageNamed:@"gorille-arbre-3"],
                         [SKTexture textureWithImageNamed:@"gorille-arbre-4"]];
        }
        else {
            texturesTree = @[[SKTexture textureWithImageNamed:@"commando-arbre3"],
                         [SKTexture textureWithImageNamed:@"commando-arbre4"]];
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
            texturesGrass = @[[SKTexture textureWithImageNamed:@"gorille-3"],
                             [SKTexture textureWithImageNamed:@"gorille-4"]];
        }
        else {
            texturesGrass = @[[SKTexture textureWithImageNamed:@"commando-3"],
                             [SKTexture textureWithImageNamed:@"commando-4"]];
        }
        
        [climber.node runAction:[SKAction animateWithTextures:texturesGrass timePerFrame:0.2] completion:^{
            [climber.node removeFromParent];
            [enemiesTab removeObject:climber];
        }];
    }
}

@end
