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
        
        self.node = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"bucheron-1"]];
        
        self.node.size = CGSizeMake(self.node.size.width / 4, self.node.size.height / 4);
        
//        self.node = [SKSpriteNode spriteNodeWithTexture:[PreloadData getDataWithKey:DATA_LAMBERJACK_WAITING] size:[BaoSize lamberJack]];
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

-(void)startWalking {
    if (![node actionForKey:SKACTION_LAMBERJACK_WALKING]) {
        
        [node runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[[SKTexture textureWithImageNamed:@"bucheron-2"],
                                                                                      [SKTexture textureWithImageNamed:@"bucheron-3"]]
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
        [node runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[[SKTexture textureWithImageNamed:@"bucheron-4"],
                                                                                      [SKTexture textureWithImageNamed:@"bucheron-5"],
                                                                                      [SKTexture textureWithImageNamed:@"bucheron-6"]]
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
            [node runAction:[SKAction animateWithTextures:@[[SKTexture textureWithImageNamed:@"bucheron-7"],
                                                                                   [SKTexture textureWithImageNamed:@"bucheron-8"]]
                                                                    timePerFrame:0.1f
                                                                          resize:NO
                                                                         restore:NO] completion:^{
                [node removeFromParent];
            }];
        }
    }
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
