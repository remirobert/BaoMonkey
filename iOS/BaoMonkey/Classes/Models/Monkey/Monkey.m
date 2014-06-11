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
#import "GameData.h"

@implementation Monkey {
    NSArray *walkingFrames;
    NSArray *walkingCoconutFrames;
    NSArray *launchFrames;
    NSArray *stopFrames;
    NSArray *stopCocoframes;
}

@synthesize sprite;
@synthesize shield;
@synthesize weapon;
@synthesize isShield;

- (void) updateCollisionMask {
    _collisionMask.position = CGPointMake(sprite.position.x - 5, sprite.position.y - 10);
}

- (void) initCollisionMask {
    _collisionMask = [[SKSpriteNode alloc] initWithColor:[SKColor colorWithWhite:0 alpha:0]
                                                    size:CGSizeMake(sprite.size.width / 2, sprite.size.height - 25)];
    [self updateCollisionMask];
}

-(id)initWithPosition:(CGPoint)position {
    self = [super init];
    if (self) {
        // Init the sprites of the Monkey
        sprite = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"waiting"]];
        sprite.position = position;
        isShield = FALSE;
        
        [self loadWalkingSprites];
        [self loadWalkingCoconutSprites];
        [self loadLaunchSprites];
        [self loadWaitframes];
        [self initCollisionMask];
        [self waitMonkey];
    }
    return self;
}

#pragma mark - Update Sprite Functions

- (void) moveMonkey:(CGFloat)acceleration {
    CGPoint position;
    float maxX = SCREEN_WIDTH + (sprite.size.width / 2);
    float minX = -(sprite.size.width / 2);
    
    if (sprite.position.x > maxX) {
        position = CGPointMake(minX, sprite.position.y);
    } else if (sprite.position.x < minX) {
        position = CGPointMake(maxX, sprite.position.y);
    } else {
        position = CGPointMake(sprite.position.x + acceleration, sprite.position.y);
    }
    
    sprite.position = position;
    shield.position = position;
    weapon.node.position = position;
    
    [self updateCollisionMask];
}

#pragma mark - Action animation monkey

- (void) moveActionWalking {
    if ([GameData isGameOver] == YES ||
        [sprite actionForKey:@"lanchAction"] != nil ||
        [sprite actionForKey:@"deadMonkey"] != nil) {
        return ;
    }
    
    NSArray *framesWalking;
    
    if (weapon == nil)
        framesWalking = walkingFrames;
    else
        framesWalking = walkingCoconutFrames;
    
    [sprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:framesWalking
                                                                     timePerFrame:0.1
                                                                           resize:NO
                                                                          restore:NO]] withKey:@"runactionwalk"];
}

- (void) waitMonkey {
    if ([GameData isGameOver] == YES ||
        [sprite actionForKey:@"lanchAction"] != nil ||
        [sprite actionForKey:@"deadMonkey"] != nil) {
        return ;
    }

    [sprite removeAllActions];
    if (weapon == nil) {
        [sprite runAction:[SKAction
                           repeatActionForever:[SKAction animateWithTextures:stopFrames
                                                                         timePerFrame:0.1 resize:NO restore:NO]]];
    }
    else {
        [sprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:stopCocoframes timePerFrame:0.1 resize:NO restore:NO]]];
    }
}

#pragma mark - Update monkey position

-(void)updateMonkeyPosition:(float)acceleration {
    static CGFloat oldAcceleration = 0;
    static BOOL isAction = NO;
    
    if ([GameData isGameOver] == YES)
        return ;
    
    if ([sprite actionForKey:@"lanchAction"] != nil) {
        isAction = YES;
    }
    
    if (isAction == YES && [sprite actionForKey:@"lanchAction"] == nil) {
        isAction = NO;
        [self moveActionWalking];
        
        if (acceleration < 0) {
                [self moveActionWalking];
            oldAcceleration = -1;
            sprite.xScale = -1.0;
        }
        else if (acceleration > 0) {
                [self moveActionWalking];
            oldAcceleration = 1;
            sprite.xScale = 1.0;
        }
        [self moveMonkey:acceleration];
    }
    
    if (acceleration == 0) {
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
}

#pragma mark - Load texture

- (void) loadWaitframes {
    stopFrames = @[[PreloadData getDataWithKey:@"monkey-waiting"], [PreloadData getDataWithKey:@"monkey-waiting"]];
    stopCocoframes = @[[PreloadData getDataWithKey:@"monkey-waiting-coconut"], [PreloadData getDataWithKey:@"monkey-waiting-coconut"]];
}

-(void)loadWalkingSprites {
    walkingFrames = @[[PreloadData getDataWithKey:@"monkey-walking-1"],
                      [PreloadData getDataWithKey:@"monkey-walking-2"],
                      [PreloadData getDataWithKey:@"monkey-walking-3"],
                      [PreloadData getDataWithKey:@"monkey-walking-4"],
                      [PreloadData getDataWithKey:@"monkey-walking-5"],
                      [PreloadData getDataWithKey:@"monkey-walking-6"]];
}

-(void)loadWalkingCoconutSprites {
    walkingCoconutFrames = @[[PreloadData getDataWithKey:@"monkey-walking-coconut-1"],
                             [PreloadData getDataWithKey:@"monkey-walking-coconut-2"],
                             [PreloadData getDataWithKey:@"monkey-walking-coconut-3"],
                             [PreloadData getDataWithKey:@"monkey-walking-coconut-4"],
                             [PreloadData getDataWithKey:@"monkey-walking-coconut-5"],
                             [PreloadData getDataWithKey:@"monkey-walking-coconut-6"]];
}


-(void)loadLaunchSprites {
    launchFrames = @[[PreloadData getDataWithKey:@"monkey-launch"],
                     [PreloadData getDataWithKey:@"monkey-launch"],
                     [PreloadData getDataWithKey:@"monkey-launch"]];
}

#pragma mark - Manage Shield

-(void)manageShield:(CFTimeInterval)currentTime andScene:(SKScene *)scene{
    static CGFloat timeNext = 0.0;
    static BOOL isCarry = FALSE;
    
    if (isShield == FALSE) {
        isCarry = FALSE;
        return ;
    }

    if (timeNext == 0 || isCarry == FALSE) {
        timeNext = currentTime + 10.0;
    }
    
    isCarry = TRUE;
    
    if (currentTime < timeNext) {
        return ;
    }
    
    [shield removeFromParent];
    isShield = FALSE;
}

- (void) addShield:(SKScene *)scene {
    SKShapeNode* tile = [SKShapeNode node];
    [tile setPath:CGPathCreateWithRoundedRect(CGRectMake(-sprite.size.width / 2, -sprite.size.height / 2, sprite.size.width, sprite.size.height),
                                              sprite.size.width / 2,
                                              sprite.size.height / 2,
                                              nil)];
    tile.strokeColor = tile.fillColor = [UIColor colorWithRed:163/255.0f green:226/255.0f blue:229/255.0f alpha:0.5f];
    
    shield = [SKSpriteNode node];
    shield.position = sprite.position;
    shield.zPosition = 150;
    shield.name = @"NODE_SHIELD";
    [shield addChild:tile];
    isShield = TRUE;
    [scene addChild:shield];
}

#pragma mark - Checking the item receive

-(void)catchItem:(id)item :(SKScene *)scene {
    if ([GameData isGameOver] == YES)
        return ;
    
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
    } else if ([item isKindOfClass:[Shield class]]) {
        ((Item *)item).node.hidden = YES;
        if (isShield == FALSE)
            [self addShield:scene];
    }
    if (((Item *)item).isTaken == NO)
        [(Item *)item launchAction];
    [self moveActionWalking];
}

#pragma mark - Launch a weapon

-(void)launchWeapon {
    if ([GameData isGameOver] == YES)
        return ;
    
    if (weapon != nil && ![GameData isPause]) {
        weapon.node.hidden = FALSE;
        weapon.node.position = CGPointMake(sprite.position.x, weapon.node.position.y);
        [Action dropWeapon:weapon];

        [sprite removeAllActions];
        SKAction *actionLaunch = [SKAction animateWithTextures:launchFrames
                                                  timePerFrame:0.1 resize:NO restore:NO];
        [sprite runAction:actionLaunch withKey:@"lanchAction"];
    }
    weapon = nil;
}

#pragma mark - Launch a weapon

- (void) deadMonkey {
    if ([GameData isGameOver])
        return ;
    [sprite removeAllActions];

    [sprite runAction:[SKAction animateWithTextures:@[[SKTexture textureWithImageNamed:@"monkey-dead-1"],
                                                      [SKTexture textureWithImageNamed:@"monkey-dead-2"],
                                                      [SKTexture textureWithImageNamed:@"monkey-dead-3"],
                                                      [SKTexture textureWithImageNamed:@"monkey-dead-4"]]
                                       timePerFrame:0.05 resize:NO restore:NO]
              completion:^{
                  [sprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[[SKTexture textureWithImageNamed:@"monkey-dead-4"]]
                                                                                   timePerFrame:0.1]]];
              }];
}

@end
