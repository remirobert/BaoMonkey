//
//  Hunter.m
//  BaoMonkey
//
//  Created by Rémi Hillairet on 08/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "Hunter.h"
#import "Define.h"
#import "GameData.h"
#import "BaoSize.h"

@interface Hunter ()
@property (nonatomic) CGFloat timeAction;
@end

@implementation Hunter

-(id)initWithFloor:(NSInteger)nbFloor slot:(NSInteger)slotFloor {
    CGRect screen = [UIScreen mainScreen].bounds;
    CGPoint position;
    SKAction *actionMove;
    
    self = [super init];
    if (self) {
        self.direction = ((nbFloor) % 2) == 0 ? LEFT : RIGHT;
        self.type = EnemyTypeHunter;
        self.node.zPosition = 10;
        self.floor = (int)nbFloor;
        
        self.node = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"chasseur-1"]];
        
        self.node.size = CGSizeMake(self.node.size.width / 4, self.node.size.height / 4);
        
        _slot = slotFloor -1;
        _timeAction = 0.0;
        
        if (self.direction == LEFT)
        {
            node.xScale = -1;
            position.x = screen.size.width + (node.size.width / 2);
            actionMove = [SKAction moveToX:[UIScreen mainScreen].bounds.size.width -
                          ((FLOOR_WIDTH) / 4 * slotFloor - (self.node.size.width / 2)) duration:2.0];
        }
        else
        {
            node.xScale = 1;
            position.x = - (node.size.width / 2);
            actionMove = [SKAction moveToX:(FLOOR_WIDTH) / 4 * slotFloor - (self.node.size.width / 2) duration:2.0];
        }

        node.name = ENEMY_NODE_NAME;
        position.y = MIN_POSY_FLOOR + (SPACE_BETWEEN * (nbFloor - 1)) + [BaoSize plateform].height - 20;
        [node setPosition:position];
        _isMoving = YES;
        
        CGFloat randomWait = 0.5 + (float)(rand()) / (float) (RAND_MAX/(2.0 - 1.0));
        
        SKAction *sequence = [SKAction sequence:@[[SKAction waitForDuration:randomWait], actionMove]];
        
        [self startWalking];
        
        [node runAction:sequence completion:^{
            _isMoving = NO;
            [self stopWalking];
        }];
    }
    return self;
}

- (SKSpriteNode *) shootMonkey :(CFTimeInterval)currentTime :(CGPoint)positionMonkey {    
    int positionX;
    SKAction *moveShoot;
    
    if (currentTime < _timeAction)
        return (nil);
    
    _timeAction = currentTime + 2.0;
    if (self.direction == RIGHT)
        positionX = (rand() % (int)positionMonkey.x + 50) + positionMonkey.x - 50;
    else
        positionX = (rand() % (int)positionMonkey.x - 50) + positionMonkey.x - 50;
    
    SKSpriteNode *shoot = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"munition-explosive"]];
    shoot.size = CGSizeMake(shoot.size.width / 3, shoot.size.height / 3);
    
    moveShoot = [SKAction moveTo:CGPointMake(positionX, [UIScreen mainScreen].bounds.size.height)
                        duration:2.0 - (float)([GameData getLevel] / 10.0)];

    shoot.name = SHOOT_NODE_NAME;
    shoot.position = self.node.position;
    [shoot runAction:moveShoot completion:^{
        [shoot removeFromParent];
    }];
    return (shoot);
}

-(void)startWalking {
    
    
    [node  runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[[SKTexture textureWithImageNamed:@"chasseur-0b"],
                                                                                   [SKTexture textureWithImageNamed:@"chasseur-1b"],
                                                                                   [SKTexture textureWithImageNamed:@"chasseur-2b"],
                                                                                   [SKTexture textureWithImageNamed:@"chasseur-3b"],
                                                                                   [SKTexture textureWithImageNamed:@"chasseur-4b"],
                                                                                   [SKTexture textureWithImageNamed:@"chasseur-5b"]] timePerFrame:0.2]]
             withKey:SKACTION_HUNTER_WALKING];
}

-(void)stopWalking {
    [node removeActionForKey:SKACTION_HUNTER_WALKING];
}

-(void)startDead {
    if (![node actionForKey:SKACTION_HUNTER_DEAD]) {
        [node  runAction:[SKAction animateWithTextures:@[[SKTexture textureWithImageNamed:@"chasseur-4"],
                                                                                       [SKTexture textureWithImageNamed:@"chasseur-5"]] timePerFrame:0.1]
                 completion:^{
                     [node removeAllActions];
                     [node runAction:[SKAction waitForDuration:0.5] completion:^{
                         [node removeFromParent];
                     }];
                 }];
    }
}

@end
