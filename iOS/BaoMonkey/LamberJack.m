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

-(float)findFreeSlot:(EnemyDirection)_direction inSlots:(NSArray*)choppingSlots {
    NSString *directionKey;
    
    if (_direction == LEFT)
        directionKey = @"LEFT";
    else if (_direction == RIGHT)
        directionKey = @"RIGHT";
    
    for (NSMutableDictionary *slot in choppingSlots) {
        if ([[slot objectForKey:directionKey] isEqualToString:@"FREE"]) {
            return [[slot objectForKey:@"posX"] floatValue];
        }
    }
    return 0;
}

-(void)takeTheSlot:(float)freeSlot direction:(EnemyDirection)_direction slots:choppingSlots {
    NSString *directionKey;
    
    if (_direction == LEFT)
        directionKey = @"LEFT";
    else if (_direction == RIGHT)
        directionKey = @"RIGHT";
    
    for (NSMutableDictionary *slot in choppingSlots) {
        if ([[slot objectForKey:@"posX"] floatValue] == freeSlot) {
            [slot setObject:@"TAKEN" forKey:directionKey];
        }
    }
}

-(void)freeTheSlot:(float)freeSlot direction:(EnemyDirection)_direction slots:choppingSlots {
    NSString *directionKey;
    
    if (_direction == LEFT)
        directionKey = @"LEFT";
    else if (_direction == RIGHT)
        directionKey = @"RIGHT";
    
    for (NSMutableDictionary *slot in choppingSlots) {
        if ([[slot objectForKey:@"posX"] floatValue] == freeSlot) {
            [slot setObject:@"FREE" forKey:directionKey];
        }
    }
}

-(BOOL)reachedTheMiddle:(NSArray*)choppingSlots {
    CGRect screen = [UIScreen mainScreen].bounds;
    
    float freeSlot = [self findFreeSlot:self.direction inSlots:choppingSlots];
    
    if (self.direction == LEFT && ((self.node.position.x - freeSlot) > (screen.size.width / 2)))
        return FALSE;
    else if (self.direction == RIGHT && ((self.node.position.x + freeSlot) < (screen.size.width / 2)))
        return FALSE;
    [self takeTheSlot:freeSlot direction:self.direction slots:choppingSlots];
    self.slotTaken = freeSlot;
    return TRUE;
}

@end
