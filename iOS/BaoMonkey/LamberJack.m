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
    NSLog(@"Start Chooping");
}

-(void)updatePosition {
    if (!isChooping && [self reachedTheMiddle]) {
        [self startChopping];
    } else if (!isChooping){
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

-(BOOL)reachedTheMiddle {
    CGRect screen = [UIScreen mainScreen].bounds;
    
    if ((self.node.position.x - self.node.size.width) > (screen.size.width / 2))
        return FALSE;
    else if ((self.node.position.x + self.node.size.width) < (screen.size.width / 2))
        return FALSE;
    return TRUE;
}

@end
