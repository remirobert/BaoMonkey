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
        self.node.zPosition = 1;
        self.floor = nbFloor;
        
        _slot = slotFloor -1;
        _timeAction = 0.0;
        
        if (self.direction == LEFT)
        {
            node = [SKSpriteNode spriteNodeWithImageNamed:@"hunter-left"];
            position.x = screen.size.width + (node.size.width / 2);
            actionMove = [SKAction moveToX:[UIScreen mainScreen].bounds.size.width - ((FLOOR_WIDTH) / 4 * slotFloor - (self.node.size.width / 2)) duration:2.0];
        }
        else
        {
            node = [SKSpriteNode spriteNodeWithImageNamed:@"hunter-right"];
            position.x = - (node.size.width / 2);
            
            actionMove = [SKAction moveToX:(FLOOR_WIDTH) / 4 * slotFloor - (self.node.size.width / 2) duration:2.0];
        }
        
        node.name = ENEMY_NODE_NAME;
        position.y = MIN_POSY_FLOOR + (SPACE_BETWEEN * (nbFloor)) - (self.node.size.height / 2) - 10;
        [node setPosition:position];
        [node runAction:actionMove];
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
    
    moveShoot = [SKAction moveTo:CGPointMake(positionX, [UIScreen mainScreen].bounds.size.height) duration:2.0 - (float)([GameData getLevel] - 1 / 10.0)];

    shoot.name = SHOOT_NODE_NAME;
    shoot.position = self.node.position;
    [shoot runAction:moveShoot completion:^{
        [shoot removeFromParent];
    }];
    return (shoot);
}

@end
