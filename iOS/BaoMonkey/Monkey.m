//
//  Character.m
//  iosGame
//
//  Created by Jeremy Peltier on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "Monkey.h"
#import "PreloadData.h"
#import "BaoSize.h"

@implementation Monkey

@synthesize sprite;
@synthesize weapon;

-(id)initWithPosition:(CGPoint)position {
    self = [super init];
    if (self) {
        // Init the sprites of the Monkey
        sprite = [SKSpriteNode spriteNodeWithTexture:[PreloadData getDataWithKey:DATA_MONKEY_WAITING] size:[BaoSize monkey]];
        sprite.position = position;
        
        direction = FRONT;

        [self loadWalkingSprites];
        [self loadWalkingCoconutSprites];
        [self loadLaunchSprites];
        [self loadDeadSprites];

        // Init the notification for dropping the weapon
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(launchWeapon) name:NOTIFICATION_DROP_MONKEY_ITEM object:nil];
    }
    return self;
}

#pragma mark - Update Sprite Functions

- (void) moveMonkey:(CGFloat)acceleration {
    CGPoint position;
    float maxX = [UIScreen mainScreen].bounds.size.width + (sprite.size.width / 2);
    float minX = -(sprite.size.width / 2);
    
    if (sprite.position.x > maxX) {
        position = CGPointMake(minX, sprite.position.y);
        sprite.position = position;
    } else if (sprite.position.x < minX) {
        position = CGPointMake(maxX, sprite.position.y);
        sprite.position = CGPointMake(maxX, sprite.position.y);
    } else {
        position = CGPointMake(sprite.position.x + acceleration, sprite.position.y);
        sprite.position = position;
    }
    weapon.node.position = position;
}

-(void)updateMonkeyPosition:(float)acceleration {
    static CGFloat oldAcceleration = 0;
    
    NSLog(@"current direction %d", direction);
    
    if (acceleration == 0) {
        [sprite removeAllChildren];
        [sprite setTexture:[PreloadData getDataWithKey:DATA_MONKEY_WAITING]];
        sprite.xScale = 1.0;
        oldAcceleration = 0;
        [sprite removeAllActions];
        return ;
    }
    else if (acceleration < 0) {
        if (oldAcceleration >= 0)
            [sprite runAction:[SKAction
                               repeatActionForever:[SKAction
                                                    animateWithTextures:walkingFrames timePerFrame:0.1]]];
        oldAcceleration = -1;
        sprite.xScale = -1.0;
    }
    else if (acceleration > 0) {
        if (oldAcceleration <= 0)
            [sprite runAction:[SKAction
                               repeatActionForever:[SKAction
                                                    animateWithTextures:walkingFrames timePerFrame:0.1]]];
        oldAcceleration = 1;
        sprite.xScale = 1.0;
    }
    [self moveMonkey:acceleration];
    oldAcceleration = acceleration;
}

-(void)loadWalkingSprites {
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    SKTextureAtlas *monkeyWalkingAtlas = [PreloadData getDataWithKey:DATA_MONKEY_WALKING_ATLAS];
    NSUInteger numberOfFrames = monkeyWalkingAtlas.textureNames.count;
    
    for (int i = 1; i <= numberOfFrames; i++) {
        NSString *textureName = [NSString stringWithFormat:@"monkey-walking-%d", i];
        SKTexture *tmp = [monkeyWalkingAtlas textureNamed:textureName];
        [frames addObject:tmp];
    }

    walkingFrames = [[NSArray alloc] initWithArray:frames];
}

-(void)loadWalkingCoconutSprites {
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    SKTextureAtlas *monkeyWalkingCoconutAtlas = [PreloadData getDataWithKey:DATA_MONKEY_WALKING_COCONUT_ATLAS];
    NSUInteger numberOfFrames = monkeyWalkingCoconutAtlas.textureNames.count;
    
    for (int i = 1; i <= numberOfFrames; i++) {
        NSString *textureName = [NSString stringWithFormat:@"monkey-walking-coconut-%d", i];
        SKTexture *tmp = [monkeyWalkingCoconutAtlas textureNamed:textureName];
        [frames addObject:tmp];
    }
    
    walkingCoconutFrames = [[NSArray alloc] init];
    walkingCoconutFrames = frames;
}


-(void)loadLaunchSprites {
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    SKTextureAtlas *atlas = [PreloadData getDataWithKey:DATA_MONKEY_LAUNCH_ATLAS];
    NSUInteger numberOfFrames = atlas.textureNames.count;
    
    for (int i = 1; i <= numberOfFrames; i++) {
        NSString *textureName = [NSString stringWithFormat:@"monkey-launch-%d", i];
        SKTexture *tmp = [atlas textureNamed:textureName];
        [frames addObject:tmp];
    }
    
    launchFrames = [[NSArray alloc] init];
    launchFrames = frames;
}

-(void)loadDeadSprites {
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    SKTextureAtlas *atlas = [PreloadData getDataWithKey:DATA_MONKEY_DEAD_ATLAS];
    NSUInteger numberOfFrames = atlas.textureNames.count;
    
    for (int i = 1; i <= numberOfFrames; i++) {
        NSString *textureName = [NSString stringWithFormat:@"monkey-dead-%d", i];
        SKTexture *tmp = [atlas textureNamed:textureName];
        [frames addObject:tmp];
    }
    
    deadFrames = [[NSArray alloc] init];
    deadFrames = frames;
}

#pragma mark - Checking the item receive

-(void)catchItem:(id)item{
    if ([item isKindOfClass:[Weapon class]]){
        if (weapon == nil) {
            weapon = [[Item alloc] init];
            weapon = item;
            [weapon.node removeAllActions];
            weapon.isTaken = YES;
            weapon.node.hidden = YES;
            [(Item *)item launchAction];
        }
        else
            return ;
    }
    if (((Item *)item).isTaken == NO)
        [(Item *)item launchAction];
}

#pragma mark - Launch a weapon

-(void)launchWeapon{
    if (weapon != nil && ![GameData isPause]) {
        weapon.node.hidden = FALSE;
        weapon.node.position = CGPointMake(sprite.position.x, weapon.node.position.y);
        [Action dropWeapon:weapon];
    }
    weapon = nil;
}

@end
