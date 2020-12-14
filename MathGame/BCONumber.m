//
//  BCONumber.m
//  Math Game
//
//  Created by Bogdan Coticopol on 21.04.2014.
//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import "BCONumber.h"

#pragma - private interface
@interface BCONumber()

/**
 (Private Method) Draws the random number used for this game. Position on the screen is not specified here, only value, color and animation.
 @code
 [self drawNumber];
 @endcode
 */
-(void)drawNumber;
-(void)mapColors;

@end


@implementation BCONumber

-(instancetype)initWithNumber:(NSNumber *)number
{
    if(self = [super init]) {
        self.number = number;
        [self drawNumber];
    }
    return self;
}

-(void)mapColors
{
    self.colors = @[ //R    G    B
                    @[@YES,@YES,@YES],
                    @[@NO, @YES, @YES],
                    @[@NO, @YES, @NO],
                    @[@YES,@YES, @NO],
                    @[@NO,@NO,@YES],
                    @[@YES,@NO,@NO],
                    @[@YES,@NO,@YES]
                    ];
}

-(void)drawNumber
{
    SKLabelNode *numberText = [[SKLabelNode alloc]initWithFontNamed:fontName];
    
    numberText.text = [self.number stringValue];
    numberText.name = @"GameNode";
    numberText.fontSize = 28;
    
    //draw numbers based on color map
    [self mapColors];
    BCOGameGlobal *globalGame = [BCOGameGlobal sharedInstance];
    globalGame.colorIndex = globalGame.colorIndex > 6 ? 6 : globalGame.colorIndex;
    NSArray *colorMap = [NSArray arrayWithArray:[self.colors objectAtIndex:globalGame.colorIndex]];
    
    
    numberText.fontColor = [BCOAnimations generateRandomColorWithRedFixedValue:[[colorMap objectAtIndex:0] boolValue]
                                                            AndGreenFixedValue:[[colorMap objectAtIndex:1] boolValue]
                                                             AndBlueFixedValue:[[colorMap objectAtIndex:2] boolValue]];
    
    [numberText runAction:[BCOAnimations pulse]];
    
    [self addChild:numberText];
}

@end
