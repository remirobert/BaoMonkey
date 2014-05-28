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

# define FLOOR_HEIGHT 24

@implementation LamberJack

@synthesize isChooping;

-(id)initWithDirection:(Direction)_direction {
    CGRect screen = [UIScreen mainScreen].bounds;
    CGPoint position;
    
    self = [super init];
    if (self) {
        self.direction = _direction;
        self.type = EnemyTypeLamberJack;
        self.node.zPosition = 10;
        self.node = [SKSpriteNode spriteNodeWithTexture:[PreloadData getDataWithKey:DATA_LAMBERJACK_WAITING] size:[BaoSize lamberJack]];
        if (self.direction == LEFT)
        {
            node.xScale = -1;
            position.x = screen.size.width + (node.size.width / 2);
        }
        else
        {
            node.xScale = 1;
            position.x = -(node.size.width / 2);
        }
        node.name = ENEMY_NODE_NAME;
        position.y = node.size.height / 2 + FLOOR_HEIGHT;
        [node setPosition:position];
        [self loadWalkingSprites];
        [self loadCuttingSprites];
        [self loadDeadSprites];
    }
    return self;
}

-(void)updatePosition:(NSArray*)choppingSlots{
    if (!isChooping && [self reachedTheMiddle:choppingSlots]) {
        [self startChopping];
        [self stopWalking];
    }
    if (!isChooping){
        if (self.direction == LEFT)
        {
            [node setPosition:CGPointMake(node.position.x - speed, node.position.y)];
        }
        else if (self.direction == RIGHT)
        {
            [node setPosition:CGPointMake(node.position.x + speed, node.position.y)];
        }
        [self startWalking];
    }
}

-(void)loadWalkingSprites {
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    SKTextureAtlas *lamberJackWalkingAtlas = [PreloadData getDataWithKey:DATA_LAMBERJACK_WALKING_ATLAS];
    NSUInteger numberOfFrames = lamberJackWalkingAtlas.textureNames.count;
    
    for (int i = 1; i <= numberOfFrames; i++) {
        NSString *textureName = [NSString stringWithFormat:@"lamber-jack-walking-%d", i];
        SKTexture *tmp = [lamberJackWalkingAtlas textureNamed:textureName];
        [frames addObject:tmp];
    }
    
    walkingFrames = [[NSArray alloc] init];
    walkingFrames = frames;
}

-(void)loadCuttingSprites {
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    SKTextureAtlas *lamberJackCuttingAtlas = [PreloadData getDataWithKey:DATA_LAMBERJACK_CUTTING_ATLAS];
    NSUInteger numberOfFrames = lamberJackCuttingAtlas.textureNames.count;
    
    for (int i = 1; i <= numberOfFrames; i++) {
        NSString *textureName = [NSString stringWithFormat:@"lamber-jack-cutting-%d", i];
        SKTexture *tmp = [lamberJackCuttingAtlas textureNamed:textureName];
        [frames addObject:tmp];
    }
    
    cuttingFrames = [[NSArray alloc] init];
    cuttingFrames = frames;
}

-(void)loadDeadSprites {
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    SKTextureAtlas *lamberJackDeadAtlas = [PreloadData getDataWithKey:DATA_LAMBERJACK_DEAD_ATLAS];
    NSUInteger numberOfFrames = lamberJackDeadAtlas.textureNames.count;
    
    for (int i = 1; i <= numberOfFrames; i++) {
        NSString *textureName = [NSString stringWithFormat:@"lamber-jack-dead-%d", i];
        SKTexture *tmp = [lamberJackDeadAtlas textureNamed:textureName];
        [frames addObject:tmp];
    }
    
    deadFrames = [[NSArray alloc] init];
    deadFrames = frames;
}

-(void)startWalking {
    if (![node actionForKey:SKACTION_LAMBERJACK_WALKING]) {
        [node runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:walkingFrames
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
        [node runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:cuttingFrames
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
            [node runAction:[SKAction repeatAction:[SKAction animateWithTextures:deadFrames
                                                                    timePerFrame:0.1f
                                                                          resize:YES
                                                                         restore:NO]
                                             count:1]
             withKey:SKACTION_LAMBERJACK_DEAD];
        }
    }
}

-(void)stopDead {
    [node removeActionForKey:SKACTION_LAMBERJACK_DEAD];
}

-(int)findFreeSlot:(NSArray*)choppingSlots {
    int i = 0;
    NSString *directionKey = [self directionKey];
    
    for (NSMutableDictionary *slot in choppingSlots) {
        if ([[slot objectForKey:directionKey] isEqualToString:@"FREE"]) {
            if ((MAX_LUMBERJACK / 4) == i)
                self.node.zPosition = 20;
            else
                self.node.zPosition = 10;
            return i;
        }
        i++;
    }
    return -1;
}

-(void)freeTheSlot:(NSArray*)choppingSlots {
    NSString *directionKey = [self directionKey];
    
    [[choppingSlots objectAtIndex:self.slotTaken] setObject:@"FREE" forKey:directionKey];
}

-(BOOL)reachedTheMiddle:(NSArray*)choppingSlots {
    NSString *directionKey = [self directionKey];
    CGRect screen = [UIScreen mainScreen].bounds;
    int freeSlot = 0;
    float spaceSlot = 0;
    
    freeSlot = [self findFreeSlot:choppingSlots];
    if (freeSlot != -1)
        spaceSlot = [[[choppingSlots objectAtIndex:freeSlot] objectForKey:@"posX"] floatValue];
    
    if (self.direction == LEFT && ((self.node.position.x - spaceSlot) > (screen.size.width / 2)))
        return FALSE;
    else if (self.direction == RIGHT && ((self.node.position.x + spaceSlot) < (screen.size.width / 2)))
        return FALSE;
    [[choppingSlots objectAtIndex:freeSlot] setObject:@"TAKEN" forKey:directionKey];
    self.slotTaken = freeSlot;
    return TRUE;
}

@end
