//
//  Character.m
//  iosGame
//
//  Created by Jeremy Peltier on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "Monkey.h"

@implementation Monkey

@synthesize sprite;
@synthesize weapon;

-(id)initWithPosition:(CGPoint)position {
    self = [super init];
    if (self) {
        // Init the sprite of the Monkey
        sprite = [SKSpriteNode spriteNodeWithImageNamed:kSpriteImageName];
        sprite.position = position;
        
        // Listen if the gesture is tapped
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(launchWeapon) name:NOTIFICATION_DROP_MONKEY_ITEM object:nil];
    }
    return self;
}

#pragma mark - Update Sprite Functions

-(void)updateMonkeyPosition:(float)acceleration
{
    float maxX = [UIScreen mainScreen].bounds.size.width + (sprite.size.width / 2);
    float minX = -(sprite.size.width / 2);
    
    if (sprite.position.x > maxX) {
        sprite.position = CGPointMake(minX, sprite.position.y);
    } else if (sprite.position.x < minX) {
        sprite.position = CGPointMake(maxX, sprite.position.y);
    } else {
        sprite.position = CGPointMake(sprite.position.x + acceleration, sprite.position.y);
    }
}

#pragma mark - Checking the item receive

-(BOOL)checkIsItemIsWeapon:(id)item{
    if ([item isKindOfClass:[Weapon class]]){
        if (weapon == nil) {
            weapon = [[Item alloc] init];
            weapon = item;
            return TRUE;
        }
        return FALSE;
    }
    return FALSE;
}

#pragma mark - Launch a weapon

-(void)launchWeapon{
    if (weapon != nil) {
        weapon = nil;
    }
}

@end
