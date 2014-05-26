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
        self.node = [SKSpriteNode spriteNodeWithTexture:[PreloadData getDataWithKey:DATA_HUNTER_WAITING] size:CGSizeMake(30, 48)];
        
        _slot = slotFloor -1;
        _timeAction = 0.0;
        
        if (self.direction == LEFT)
        {
            node.xScale = -1;
            position.x = screen.size.width + (node.size.width / 2);
            actionMove = [SKAction moveToX:[UIScreen mainScreen].bounds.size.width - ((FLOOR_WIDTH) / 4 * slotFloor - (self.node.size.width / 2)) duration:2.0];
        }
        else
        {
            node.xScale = 1;
            position.x = - (node.size.width / 2);
            actionMove = [SKAction moveToX:(FLOOR_WIDTH) / 4 * slotFloor - (self.node.size.width / 2) duration:2.0];
        }
        
        [self loadWalkingSprites];
        [self loadDeadSprites];
        
        node.name = ENEMY_NODE_NAME;
        position.y = MIN_POSY_FLOOR + (SPACE_BETWEEN * (nbFloor)) - (self.node.size.height / 2) - 10;
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
    
    
    SKSpriteNode *shoot = [[SKSpriteNode alloc] initWithColor:[SKColor blackColor] size:CGSizeMake(10, 10)];
    
    moveShoot = [SKAction moveTo:CGPointMake(positionX, [UIScreen mainScreen].bounds.size.height)
                        duration:2.0 - (float)([GameData getLevel] / 10.0)];

    shoot.name = SHOOT_NODE_NAME;
    shoot.position = self.node.position;
    [shoot runAction:moveShoot completion:^{
        [shoot removeFromParent];
    }];
    return (shoot);
}

-(void)loadWalkingSprites {
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    SKTextureAtlas *hunterWalkingAtlas = [PreloadData getDataWithKey:DATA_HUNTER_WALKING_ATLAS];
    NSUInteger numberOfFrames = hunterWalkingAtlas.textureNames.count;
    
    for (int i = 1; i <= numberOfFrames; i++) {
        NSString *textureName = [NSString stringWithFormat:@"hunter-walking-%d", i];
        SKTexture *tmp = [hunterWalkingAtlas textureNamed:textureName];
        [frames addObject:tmp];
    }
    
    walkingFrames = [[NSArray alloc] init];
    walkingFrames = frames;
}

-(void)loadDeadSprites {
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    SKTextureAtlas *hunterDeadAtlas = [PreloadData getDataWithKey:DATA_HUNTER_DEAD_ATLAS];
    NSUInteger numberOfFrames = hunterDeadAtlas.textureNames.count;
    
    for (int i = 1; i <= numberOfFrames; i++) {
        NSString *textureName = [NSString stringWithFormat:@"hunter-dead-%d", i];
        SKTexture *tmp = [hunterDeadAtlas textureNamed:textureName];
        [frames addObject:tmp];
    }
    
    deadFrames = [[NSArray alloc] init];
    deadFrames = frames;
}

-(void)startWalking {
    if (![node actionForKey:SKACTION_HUNTER_WALKING]) {
        [node runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:walkingFrames
                                                                       timePerFrame:0.1f
                                                                             resize:YES
                                                                            restore:YES]]
                withKey:SKACTION_HUNTER_WALKING];
    }
}

-(void)stopWalking {
    [node removeActionForKey:SKACTION_HUNTER_WALKING];
    if (self.direction == RIGHT) {
        node.xScale = -1;
    } else {
        node.xScale = 1;
    }
}

-(void)startDead {
    if (![node actionForKey:SKACTION_HUNTER_DEAD]) {
        [node runAction:[SKAction repeatAction:[SKAction animateWithTextures:deadFrames
                                                                timePerFrame:0.1f
                                                                      resize:YES
                                                                     restore:YES]
                                         count:1]
         withKey:SKACTION_HUNTER_DEAD];
    }
}

-(void)stopDead {
    [node removeActionForKey:SKACTION_HUNTER_DEAD];
}

@end
