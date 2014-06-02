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

@implementation Monkey {
    NSArray *walkingFrames;
    NSArray *walkingCoconutFrames;
    NSArray *deadFrames;
    NSArray *launchFrames;
    NSArray *stopFrames;
    NSArray *stopCocoframes;
}

@synthesize sprite;
@synthesize weapon;

- (void) updateCollisionMask {
    _collisionMask.position = CGPointMake(sprite.position.x - 5, sprite.position.y - 10);
}

- (void) initCollisionMask {
    _collisionMask = [[SKSpriteNode alloc] initWithColor:[SKColor colorWithRed:0 green:0 blue:0 alpha:0] size:CGSizeMake(sprite.size.width / 2, sprite.size.height - 10)];
    [self updateCollisionMask];
}

-(id)initWithPosition:(CGPoint)position {
    self = [super init];
    if (self) {
        // Init the sprites of the Monkey
        sprite = [SKSpriteNode spriteNodeWithTexture:[PreloadData getDataWithKey:DATA_MONKEY_WAITING]
                                                size:[BaoSize monkey]];
        sprite.position = position;
        
        [self loadWalkingSprites];
        [self loadWalkingCoconutSprites];
        [self loadLaunchSprites];
        [self loadDeadSprites];
        [self loadWaitframes];
        [self initCollisionMask];
        
        [self waitMonkey];
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
    [self updateCollisionMask];
}

#pragma mark - Action animation monkey

- (void) moveActionWalking {
    NSLog(@"update move");
    if ([sprite actionForKey:@"lanchAction"] != nil ||
        [sprite actionForKey:@"deadMonkey"] != nil) {
        return ;
    }
    
    NSArray *framesWalking;
    
    if (weapon == nil)
        framesWalking = walkingFrames;
    else
        framesWalking = walkingCoconutFrames;
    
    [sprite runAction:[SKAction
                       repeatActionForever:[SKAction
                                            animateWithTextures:framesWalking timePerFrame:0.1]] withKey:@"runactionwalk"];
}

- (void) waitMonkey {
    if ([sprite actionForKey:@"lanchAction"] != nil ||
        [sprite actionForKey:@"deadMonkey"] != nil) {
        return ;
    }

    [sprite removeAllActions];
    if (weapon == nil) {
        [sprite runAction:[SKAction
                           repeatActionForever:[SKAction animateWithTextures:stopFrames
                                                                         timePerFrame:0.1 resize:YES restore:NO]]];
    }
    else {
        [sprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:stopCocoframes timePerFrame:0.1 resize:YES restore:NO]]];
    }
}

#pragma mark - Update monkey position

-(void)updateMonkeyPosition:(float)acceleration {
    static CGFloat oldAcceleration = 0;
    static BOOL isAction = NO;

    if ([sprite actionForKey:@"lanchAction"] != nil) {
        isAction = YES;
    }

    if (isAction == YES && [sprite actionForKey:@"lanchAction"] != nil) {
        oldAcceleration = 0;
        isAction = NO;
    }
    
    if (acceleration == 0) {
        if (oldAcceleration == 0)
            return;
        [self waitMonkey];
        oldAcceleration = 0;
        return ;
    }
    else if (acceleration < 0) {
        if (oldAcceleration >= 0) {
            [self moveActionWalking];
        }
        oldAcceleration = -1;
        sprite.xScale = -1.0;
    }
    else if (acceleration > 0) {
        if (oldAcceleration <= 0) {
            [self moveActionWalking];
        }
        oldAcceleration = 1;
        sprite.xScale = 1.0;
    }
    [self moveMonkey:acceleration];
    oldAcceleration = acceleration;
}

#pragma mark - Load texture

- (void) loadWaitframes {
    stopFrames = @[[SKTexture textureWithImageNamed:@"monkey-waiting"], [SKTexture textureWithImageNamed:@"monkey-waiting"]];
    stopCocoframes = @[[SKTexture textureWithImageNamed:@"monkey-waiting-coconut"], [SKTexture textureWithImageNamed:@"monkey-waiting-coconut"]];
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
            [self waitMonkey];
        }
        else
            return ;
    }
    if (((Item *)item).isTaken == NO)
        [(Item *)item launchAction];
}

#pragma mark - Launch a weapon

-(void)launchWeapon {
    if (weapon != nil && ![GameData isPause]) {
        weapon.node.hidden = FALSE;
        weapon.node.position = CGPointMake(sprite.position.x, weapon.node.position.y);
        [Action dropWeapon:weapon];

        [sprite removeAllActions];
        SKAction *actionLaunch = [SKAction animateWithTextures:launchFrames
                                                  timePerFrame:0.1 resize:YES restore:NO];
        [sprite runAction:actionLaunch withKey:@"lanchAction"];
    }
    weapon = nil;
}

#pragma mark - Launch a weapon

- (void) deadMonkey {
    [sprite removeAllActions];

    [sprite runAction:[SKAction animateWithTextures:deadFrames
                                       timePerFrame:0.1 resize:YES restore:NO]
              withKey:@"deadMonkey"];
}

@end
