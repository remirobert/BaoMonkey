//
//  ProgressBar.h
//  BaoMonkey
//
//  Created by Jeremy Peltier on 07/05/2014.
//  Copyright (c) 2014 BaoMonkey. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>

@interface ProgressBar : NSObject

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *frontColor;
@property (nonatomic, strong) SKSpriteNode *background;
@property (nonatomic, strong) SKSpriteNode *front;

-(id)initWithPosition:(CGPoint)position andSize:(CGSize)size;

-(void)createBackground;
-(void)createFront;

-(void)updateProgression:(CGFloat)progress;

@end
