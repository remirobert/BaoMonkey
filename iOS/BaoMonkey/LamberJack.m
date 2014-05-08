//
//  LamberJack.m
//  BaoMonkey
//
//  Created by Rémi Hillairet on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "LamberJack.h"
#import "Define.h"

@implementation LamberJack

@synthesize isChooping;

-(id)initWithDirection:(EnemyDirection)_direction {
    CGRect screen = [UIScreen mainScreen].bounds;
    CGPoint position;
    
    self = [super init];
    if (self) {
        self.direction = _direction;
        self.type = EnemyTypeLamberJack;
        self.node.zPosition = 1;
        
        if (self.direction == LEFT)
        {
            node = [SKSpriteNode spriteNodeWithImageNamed:@"lamberjack-left"];
            position.x = screen.size.width + (node.size.width / 2);
        }
        else
        {
            node = [SKSpriteNode spriteNodeWithImageNamed:@"lamberjack-right"];
            position.x = -(node.size.width / 2);
        }
        node.name = ENEMY_NODE_NAME;
        position.y = node.size.height / 2;
        [node setPosition:position];
    }
    return self;
}

-(void)startChopping {
    isChooping = TRUE;
}

-(void)updatePosition:(NSArray*)choppingSlots{
    if (!isChooping && [self reachedTheMiddle:choppingSlots]) {
        [self startChopping];
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
    }
}

-(NSString*)directionKey {
    if (self.direction == LEFT)
        return @"LEFT";
    else if (self.direction == RIGHT)
        return @"RIGHT";
    return @"NONE";
}

-(int)findFreeSlot:(NSArray*)choppingSlots {
    int i = 0;
    NSString *directionKey = [self directionKey];
    
    for (NSMutableDictionary *slot in choppingSlots) {
        if ([[slot objectForKey:directionKey] isEqualToString:@"FREE"]) {
            if ((MAX_LUMBERJACK / 4) == i)
                self.node.zPosition = 2;
            else
                self.node.zPosition = 1;
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
