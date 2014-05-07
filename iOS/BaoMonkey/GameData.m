//
//  GameData.m
//  BaoMonkey
//
//  Created by Jeremy Peltier on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import "GameData.h"

@implementation GameData

static GameData *singleton;

+(id)singleton {
    if (!singleton) {
        singleton = [[GameData alloc] init];
    }
    return singleton;
}

#pragma mark - Init

+(void)initGameData {
    [[GameData singleton] initGameData];
}

-(void)initGameData {
    score = 0;
    trunkLife = 100;
}

#pragma mark - Score Functions

+(NSInteger)getScore {
    return [[GameData singleton] getScore];
}

-(NSInteger)getScore {
    return score;
}

+(void)addPointToScore:(NSInteger)point {
    [[GameData singleton] addPointToScore:point];
}

-(void)addPointToScore:(NSInteger)point {
    score += point;
}

+(void)substractPointToScore:(NSInteger)point {
    [[GameData singleton] substractPointToScore:point];
}

-(void)substractPointToScore:(NSInteger)point {
    score -= point;
}

+(void)multiplyPointToScore:(NSInteger)point {
    [[GameData singleton] multiplyPointToScore:point];
}

-(void)multiplyPointToScore:(NSInteger)point {
    score *= point;
}

+(void)dividePointToScore:(NSInteger)point {
    [[GameData singleton] dividePointToScore:point];
}

-(void)dividePointToScore:(NSInteger)point {
    score /= point;
}

#pragma mark - TrunkLife Functions

+(CGFloat)getTrunkLife {
    return [[GameData singleton] getTrunkLife];
}

-(CGFloat)getTrunkLife {
    return trunkLife;
}

+(void)addLifeToTrunkLife:(CGFloat)life {
    [[GameData singleton] addLifeToTrunkLife:life];
}

-(void)addLifeToTrunkLife:(CGFloat)life {
    trunkLife += life;
}

+(void)substractLifeToTrunkLife:(CGFloat)life {
    [[GameData singleton] substractLifeToTrunkLife:life];
}

-(void)substractLifeToTrunkLife:(CGFloat)life {
    trunkLife -= life;
}

+(void)multiplyLifeToTrunkLife:(CGFloat)life {
    [[GameData singleton] multiplyLifeToTrunkLife:life];
}

-(void)multiplyLifeToTrunkLife:(CGFloat)life {
    trunkLife *= life;
}

+(void)divideLifeToTrunkLife:(CGFloat)life {
    [[GameData singleton] divideLifeToTrunkLife:life];
}

-(void)divideLifeToTrunkLife:(CGFloat)life {
    trunkLife /= life;
}

+(void)regenerateTrunkLife {
    [[GameData singleton] regenerateTrunkLife];
}

-(void)regenerateTrunkLife {
    if (trunkLife < 100) {
        trunkLife += 0.1f;
    }
}

@end
