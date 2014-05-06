//
//  MyScene.m
//  iosGame
//
//  Created by iPPLE on 05/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "MyScene.h"
#import "MyScene+GeneratorWave.h"

# define kPlayerSpeed 10

# define IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

@implementation MyScene

<<<<<<< HEAD
- (void) initScene {
    self.backgroundColor = [SKColor colorWithRed:0.15
                                           green:0.15
                                            blue:0.3
                                           alpha:1.0];
    
    _sizeBlock = (self.frame.size.width - (self.frame.size.width / 10)) / 10;
    _trunk = [[Trunk alloc] init];
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:_trunk.node.frame];
    
    [self addChild:_trunk.node];
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [self initScene];
        [self performSelector:@selector(addWave) withObject:nil afterDelay:1.5];
=======
@synthesize motionManager;

+ (SKSpriteNode *)spriteNodeWithImageNamed:(NSString *)name {
    if (IPAD) {
        name = [NSString stringWithFormat:@"ipad-%@", name];
    } else {
        name = [NSString stringWithFormat:@"iphone-%@", name];
>>>>>>> c82e9e1d61387d22549462d3fe939d70e2f95bab
    }
    return [SKSpriteNode spriteNodeWithImageNamed:name];
}

<<<<<<< HEAD
- (void) addWave {
    [self addNewWave];
    [self performSelector:@selector(addWave) withObject:nil afterDelay:rand() % 3 + 2];
}

-(void)update:(CFTimeInterval)currentTime {
=======
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
        
        monkey = [[Monkey alloc] initWithPosition:CGPointMake(self.frame.size.width/2, tree_branch.position.y + 10)];
        [self addChild:monkey.sprite];
        
        SKSpriteNode *front_leaf = [SKSpriteNode spriteNodeWithImageNamed:@"front-leaf.png"];
        front_leaf.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - 89);
        [self addChild:front_leaf];
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [monkey updatePosition];
>>>>>>> c82e9e1d61387d22549462d3fe939d70e2f95bab
}

@end
