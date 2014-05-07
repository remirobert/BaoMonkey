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
        // Init the sprites of the Monkey
        sprite = [SKSpriteNode spriteNodeWithImageNamed:kSpriteImageName];
        sprite.position = position;

        [self loadWalkingSprites];

        // Init the notification for dropping the weapon
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(launchWeapon) name:NOTIFICATION_DROP_MONKEY_ITEM object:nil];
    }
    return self;
}

#pragma mark - Update Sprite Functions

-(void)updateMonkeyPosition:(float)acceleration {
    float multiplierForDirection = 0;
    float maxX = [UIScreen mainScreen].bounds.size.width + (sprite.size.width / 2);
    float minX = -(sprite.size.width / 2);
    
    if (sprite.position.x > maxX) {
        sprite.position = CGPointMake(minX, sprite.position.y);
    } else if (sprite.position.x < minX) {
        sprite.position = CGPointMake(maxX, sprite.position.y);
    } else {
        sprite.position = CGPointMake(sprite.position.x + acceleration, sprite.position.y);
    }
    
    if (acceleration < 0.0f) {
        multiplierForDirection = 1.0f;
    } else if (acceleration > 0.0f) {
        multiplierForDirection = -1.0f;
    } else {
        multiplierForDirection = 0.0f;
    }
    
    if (multiplierForDirection != 0.0f) {
        sprite.xScale = fabs(sprite.xScale) * multiplierForDirection;
        [self startWalking];
    } else {
        [self stopWalking];
    }
}

-(void)loadWalkingSprites {
    NSMutableArray *walkFrames = [[NSMutableArray alloc] init];
    SKTextureAtlas *monkeyWalkingAtlas = [SKTextureAtlas atlasNamed:@"MonkeyWalking"];
    int numberOfFrames = monkeyWalkingAtlas.textureNames.count;
    
    for (int i = 1; i <= numberOfFrames; i++) {
        NSString *textureName = [NSString stringWithFormat:@"monkey-walking-%d", i];
        SKTexture *tmp = [monkeyWalkingAtlas textureNamed:textureName];
        [walkFrames addObject:tmp];
    }

    walkingFrames = [[NSArray alloc] init];
    walkingFrames = walkFrames;
}

-(void)startWalking {
    if (![sprite actionForKey:SKACTION_MONKEY_WALKING]) {
            [sprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:walkingFrames
                                                                         timePerFrame:0.1f
                                                                               resize:YES
                                                                              restore:YES]] withKey:SKACTION_MONKEY_WALKING];
    }
}

-(void)stopWalking {
    [sprite removeActionForKey:SKACTION_MONKEY_WALKING];
}

-(void)wait {
    SKTexture *texture = [SKTexture textureWithImage:[UIImage imageNamed:@"monkey"]];
    [sprite setTexture:texture];
}

#pragma mark - Checking the item receive

-(void)catchItem:(id)item{
    if ([item isKindOfClass:[Weapon class]]){
        if (weapon == nil) {
            weapon = [[Item alloc] init];
            weapon = item;
            weapon.isTaken = YES;
            [(Item *)item launchAction];
        }
    }
    else
        [(Item *)item launchAction];
}

#pragma mark - Launch a weapon

-(void)launchWeapon{
    if (weapon != nil) {
        [Action dropWeapon:weapon];
        weapon = nil;
    }
}

@end
