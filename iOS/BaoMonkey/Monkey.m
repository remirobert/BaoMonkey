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

-(void)updateMonkeyPosition:(float)acceleration {
    
    
//    if (acceleration >= -0.1 && acceleration <= 0.1) {
//        if (weapon != nil) {
//            [self stopWalkingWithCoconut];
//        } else {
//            [self stopWalking];
//        }
//        return ;
//    }
    
    if (acceleration == 0) {
        direction = 2;
        
        [sprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:walkingCoconutFrames                                                                 timePerFrame:0.1f
                                                                                                              resize:NO
                                                                              restore:NO]]];
        
        
        [sprite runAction:[SKAction animateWithTextures:[PreloadData getDataWithKey:DATA_MONKEY_WAITING]
                                           timePerFrame:0.1f]];
        return ;
    }
    
    direction = 2;
    if (acceleration > 0)
        direction = 1.0;
    if (acceleration < 0)
        direction = -1.0;
    
    //[sprite removeAllActions];

    
    CGPoint position;
//    float multiplierForDirection = 0;
    float maxX = [UIScreen mainScreen].bounds.size.width + (sprite.size.width / 2);
    float minX = -(sprite.size.width / 2);
//    
//    //NSLog(@"acceleration = %f", acceleration);
//    
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
//    
    weapon.node.position = position;
//    
//    
//    
//    if (acceleration < 0) {
//        direction = LEFT;
//        multiplierForDirection = -1;
//    } else if (acceleration > 0) {
//        direction = RIGHT;
//        multiplierForDirection = 1;
//    } else {
//        direction = FRONT;
//        multiplierForDirection = 0;
//    }
//
    
    
    if (acceleration != 0) {
        /*if (direction == LEFT) {
            sprite.xScale = -1;
        } else if (direction == RIGHT) {
            sprite.xScale = 1;
        }*/
//        multiplierForDirection = 	direction;
//        
//        if (direction == 0)
//            multiplierForDirection = -1.0;
        
        
        if (acceleration > 0.01) {
            sprite.xScale = 1.0;
//            [sprite runAction: [SKAction scaleXTo:1.0 duration:0]];
        }
        if (acceleration < 0.01) {
            sprite.xScale = -1.0;
  //          [sprite runAction: [SKAction scaleXTo:-1.0 duration:0]];
        }
        


        [self startWalking];
        
//        sprite.xScale = multiplierForDirection;
    }
//    } else {
//        if (weapon != nil) {
//            [self stopWalkingWithCoconut];
//        } else {
//            [self stopWalking];
//        }
//    }
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

    walkingFrames = [[NSArray alloc] init];
    walkingFrames = frames;
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

-(void)startWalking {
//    NSLog(@"orientation walking : %f", sprite.xScale);
//    
//    
//    [sprite removeActionForKey:SKACTION_MONKEY_WALKING];
//    
//    if (direction == LEFT) {
//        sprite.xScale = -1;
//    } else if (direction == RIGHT) {
//        sprite.xScale = 1;
//    }
//    
//    [sprite runAction:[SKAction animateWithTextures:walkingCoconutFrames
//                                       timePerFrame:0.1f] withKey:SKACTION_MONKEY_WALKING];
    
//    if (![sprite actionForKey:SKACTION_MONKEY_WALKING]) {
        if (weapon != nil){
//            [sprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:walkingCoconutFrames
//                                                                             timePerFrame:0.1f
//                                                                                   resize:NO
//                                                                                  restore:NO]]
//                      withKey:SKACTION_MONKEY_WALKING];
            
            [sprite runAction:[SKAction animateWithTextures:walkingCoconutFrames
                                               timePerFrame:0.1f] withKey:SKACTION_MONKEY_WALKING];
//            
        } else {
//            [sprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:walkingFrames                                                                         timePerFrame:0.1f
//                                                                               resize:NO
//                                                                              restore:NO]]
//                      withKey:SKACTION_MONKEY_WALKING];
//
            [sprite runAction:[SKAction animateWithTextures:walkingFrames
                                               timePerFrame:0.1f] withKey:SKACTION_MONKEY_WALKING];
//            
        }
    //}
}

-(void)startWalkingWithCoconut {
    [self stopWalking];
    if (![sprite actionForKey:SKACTION_MONKEY_WALKING_COCONUT]) {
        [sprite runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:walkingCoconutFrames
                                                                         timePerFrame:0.1f
                                                                               resize:NO
                                                                              restore:NO]]
                  withKey:SKACTION_MONKEY_WALKING_COCONUT];
    }
}

-(void)stopWalking {
    [sprite removeActionForKey:SKACTION_MONKEY_WALKING];
    [self wait];
}

-(void)stopWalkingWithCoconut {
    [sprite removeActionForKey:SKACTION_MONKEY_WALKING_COCONUT];
    [self wait];
}

-(void)stopAnimation {
    [sprite removeAllActions];
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

-(void)startLaunch {
    //direction = FRONT;
    if (![sprite actionForKey:SKACTION_MONKEY_LAUNCH]) {
        [sprite runAction:[SKAction repeatAction:[SKAction animateWithTextures:launchFrames
                                                                  timePerFrame:0.1f
                                                                        resize:NO
                                                                       restore:NO]
                                           count:1]
                  withKey:SKACTION_MONKEY_LAUNCH];
    }
}

-(void)stopLaunch {
    [sprite removeActionForKey:SKACTION_MONKEY_LAUNCH];
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

-(void)startDead {
    /*if (direction == LEFT) {
        sprite.xScale = -1;
    } else if (direction == RIGHT) {
        sprite.xScale = 1;
    }*/
    if (![sprite actionForKey:SKACTION_MONKEY_DEAD]) {
        [sprite runAction:[SKAction repeatAction:[SKAction animateWithTextures:deadFrames
                                                                  timePerFrame:0.1f
                                                                        resize:NO
                                                                       restore:NO]
                                           count:1]
                  withKey:SKACTION_MONKEY_DEAD];
    }
}

-(void)stopDead {
    [sprite removeActionForKey:SKACTION_MONKEY_DEAD];
}

-(void)wait {
    //direction = FRONT;
    
    //[sprite removeAllActions];
    
    [sprite setSize:[BaoSize monkey]];
    if (weapon != nil) {
        [sprite setTexture:[PreloadData getDataWithKey:DATA_MONKEY_WAITING_COCONUT]];
    } else {
        [sprite setTexture:[PreloadData getDataWithKey:DATA_MONKEY_WAITING]];
    }
}

#pragma mark - Checking the item receive

-(void)catchItem:(id)item{
    if ([item isKindOfClass:[Weapon class]]){
        if (weapon == nil) {
            //[sprite setSize:[BaoSize monkey]];
            //[sprite setTexture:[PreloadData getDataWithKey:DATA_MONKEY_WAITING_COCONUT]];
            weapon = [[Item alloc] init];
            weapon = item;
            [weapon.node removeAllActions];
            weapon.isTaken = YES;
            weapon.node.hidden = YES;
            [(Item *)item launchAction];
            if (direction == LEFT || direction == RIGHT) {
                [self startWalkingWithCoconut];
            } else {
                [sprite setTexture:[PreloadData getDataWithKey:DATA_MONKEY_WAITING_COCONUT]];
            }
        }
        else
            return ;
    }
    if (((Item *)item).isTaken == NO)
        [(Item *)item launchAction];
}

#pragma mark - Launch a weapon

-(void)launchWeapon{
    [self stopWalking];
    [self startLaunch];
    if (weapon != nil && ![GameData isPause]) {
        weapon.node.hidden = FALSE;
        weapon.node.position = CGPointMake(sprite.position.x, weapon.node.position.y);
        [Action dropWeapon:weapon];
    }
    weapon = nil;
    if (direction == LEFT || direction == RIGHT) {
        [self startWalking];
    } else {
        [self wait];
    }
}

@end
