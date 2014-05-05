//
//  MyScene.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "MyScene.h"

# define kPlayerSpeed 10

# define IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

@implementation MyScene

@synthesize motionManager;

+ (SKSpriteNode *)spriteNodeWithImageNamed:(NSString *)name {
    if (IPAD) {
        name = [NSString stringWithFormat:@"ipad-%@", name];
    } else {
        name = [NSString stringWithFormat:@"iphone-%@", name];
    }
    return [SKSpriteNode spriteNodeWithImageNamed:name];
}

-(void)initMonkey{
    monkey = [SKSpriteNode spriteNodeWithImageNamed:@"monkey.png"];
    monkey.size = CGSizeMake(70, 84);
    monkey.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 140);
    [self addChild:monkey];
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor colorWithRed:52/255.0f green:152/255.0f blue:219/255.0f alpha:1];
        
        SKSpriteNode *trunk = [SKSpriteNode spriteNodeWithImageNamed:@"trunk.png"];
        trunk.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - 370);
        [self addChild:trunk];
        
        SKSpriteNode *back_leaf = [SKSpriteNode spriteNodeWithImageNamed:@"back-leaf.png"];
        back_leaf.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - 124);
        [self addChild:back_leaf];
        
        SKSpriteNode *tree_branch = [SKSpriteNode spriteNodeWithImageNamed:@"tree-branch.png"];
        tree_branch.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - 180);
        [self addChild:tree_branch];
        
        [self initMonkey];
        
        SKSpriteNode *front_leaf = [SKSpriteNode spriteNodeWithImageNamed:@"front-leaf.png"];
        front_leaf.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - 89);
        [self addChild:front_leaf];

        motionManager = [[CMMotionManager alloc] init];
        
        [self startTheGame];
    }
    return self;
}

- (void)startTheGame
{
    //setup to handle accelerometer readings using CoreMotion Framework
    [self startMonitoringAcceleration];
    
}

- (void)startMonitoringAcceleration
{
    if (motionManager.accelerometerAvailable) {
        [motionManager startAccelerometerUpdates];
        NSLog(@"accelerometer updates on...");
    }
}

- (void)stopMonitoringAcceleration
{
    if (motionManager.accelerometerAvailable && motionManager.accelerometerActive) {
        [motionManager stopAccelerometerUpdates];
        NSLog(@"accelerometer updates off...");
    }
}

- (void)updateMonkeyPositionFromMotionManager
{
    CMAccelerometerData *data = motionManager.accelerometerData;
    if (fabs(data.acceleration.x) > 0.2) {
        if (monkey.position.x > 360.0f)
            monkey.position = CGPointMake(-40.0f, monkey.position.y);
        else if (monkey.position.x < -40.0f)
            monkey.position = CGPointMake(360.0f, monkey.position.y);
        else
            monkey.position = CGPointMake(monkey.position.x + (data.acceleration.x * kPlayerSpeed), monkey.position.y);
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [self updateMonkeyPositionFromMotionManager];
}

@end
