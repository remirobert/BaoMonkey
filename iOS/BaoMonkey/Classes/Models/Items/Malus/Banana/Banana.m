//
//  Banana.m
//  iosGame
//
//  Created by iPPLE on 06/05/2014.
//  Copyright (c) 2014 iPPLE. All rights reserved.
//

#import "Banana.h"
#import "PreloadData.h"
#import "Action.h"

@implementation Banana

- (instancetype) initWithPosition:(CGPoint)position {
    if ((self = [super initWithPosition:position]) != nil) {
        [self.node setTexture:[PreloadData getDataWithKey:DATA_BANANA_TEXTURE]];
        self.action = @selector(actionBanana);
        self.node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.node.size.width / 3];
        self.node.size = CGSizeMake(self.node.size.width / 2, self.node.size.height / 2);
        self.node.physicsBody.mass = 10;
    }
    return (self);
}

- (void) actionBanana {
    self.node.hidden = YES;
    [Action increaseMove];
    //[[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_DROP_MONKEY_ITEM object:nil];
}

@end
