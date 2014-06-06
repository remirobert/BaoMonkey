//
//  Size.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 22/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "BaoSize.h"
#import "Define.h"

@implementation BaoSize

+(CGSize)monkey {
    IPAD ? NSLog(@"IPAD") : NSLog(@"IPHONE");
    return IPAD ? CGSizeMake(120, 140) : CGSizeMake(60, 70);
}

+(CGSize)lamberJack {
    return IPAD ? CGSizeMake(50, 96) : CGSizeMake(25, 48);
}

+(CGSize)hunter {
    return IPAD ? CGSizeMake(0, 0) : CGSizeMake(0, 0);
}

+(CGSize)ball {
    return IPAD ? CGSizeMake(0, 0) : CGSizeMake(0, 0);
}

+(CGSize)plateform {
    return IPAD ? CGSizeMake(300, 116) : CGSizeMake(150, 58);
}

+(CGSize)climber {
    return IPAD ? CGSizeMake(0, 0) : CGSizeMake(0, 0);
}

+(CGSize)trunk {
    return IPAD ? CGSizeMake(0, 0) : CGSizeMake(0, 0);
}

+(CGSize)treeBranch {
    return IPAD ? CGSizeMake(0, 0) : CGSizeMake(0, 0);
}

+(CGSize)backLeaf {
    return IPAD ? CGSizeMake(0, 0) : CGSizeMake(0, 0);
}

+(CGSize)frontLeaf {
    return IPAD ? CGSizeMake(0, 0) : CGSizeMake(0, 0);
}

+(CGSize)upLeaf {
    return IPAD ? CGSizeMake(0, 0) : CGSizeMake(0, 0);
}

+(CGSize)bottomLeaf {
    return IPAD ? CGSizeMake(0, 0) : CGSizeMake(0, 0);
}

+(CGSize)banana {
    return IPAD ? CGSizeMake(0, 0) : CGSizeMake(0, 0);
}

+(CGSize)coconut {
    return IPAD ? CGSizeMake(0, 0) : CGSizeMake(0, 0);
}

+(CGSize)plum {
    return IPAD ? CGSizeMake(0, 0) : CGSizeMake(0, 0);
}

+(CGSize)play {
    return IPAD ? CGSizeMake(0, 0) : CGSizeMake(0, 0);
}

+(CGSize)pause {
    return IPAD ? CGSizeMake(0, 0) : CGSizeMake(0, 0);
}

+(CGSize)retry {
    return IPAD ? CGSizeMake(0, 0) : CGSizeMake(0, 0);
}

+(CGSize)home {
    return IPAD ? CGSizeMake(0, 0) : CGSizeMake(0, 0);
}

+(CGSize)settings {
    return IPAD ? CGSizeMake(0, 0) : CGSizeMake(0, 0);
}

@end
