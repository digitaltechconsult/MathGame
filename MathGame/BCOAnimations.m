//
//  BCOAnimations.m
//  MathGame
//
//  Created by Bogdan Coticopol on 26.04.2014.
//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import "BCOAnimations.h"

@implementation BCOAnimations

+(SKColor *)generateRandomColorWithRedFixedValue:(BOOL)red AndGreenFixedValue:(BOOL)green AndBlueFixedValue: (BOOL)blue
{
    CGFloat redValue = red ? 1 : arc4random_uniform(255)/255.0;
    CGFloat greenValue = green ? 1 : arc4random_uniform(255)/255.0;
    CGFloat blueValue = blue ? 1 : arc4random_uniform(255)/255.0;
    return [SKColor colorWithRed:redValue green:greenValue blue:blueValue alpha:1.0];
}

+(SKAction *)pulse
{
    SKAction *increase = [SKAction scaleTo:1.5f duration:0.75];
    SKAction *decrease = [SKAction scaleTo:1.0f duration:0.75];
    SKAction *animation = [SKAction sequence:@[increase,decrease]];
    return [SKAction repeatActionForever:animation];
}

+(SKAction *)fade
{
    SKAction *fadeOut = [SKAction fadeAlphaTo:0.0 duration:0.25];
    SKAction *fadeIn = [SKAction fadeAlphaTo:1.0 duration:0.45];
    SKAction *fade = [SKAction sequence:@[fadeOut,fadeIn]];
    return [SKAction repeatActionForever:fade];
}

+(SKAction *)colorizeWithColor:(UIColor *)color
{
    SKAction *setActionColor = [SKAction colorizeWithColor:color colorBlendFactor:1.0 duration:0.5];
    SKAction *setDefaultColor = [SKAction colorizeWithColor:[UIColor whiteColor] colorBlendFactor:1.0 duration:0.5];
    SKAction *colorize = [SKAction sequence:@[setActionColor, setDefaultColor]];
    return [SKAction repeatAction:colorize count:2];
}

+(SKAction *)playSound:(NSString *)filename
{
    SKAction *soundAction = [SKAction playSoundFileNamed:filename waitForCompletion:YES];
    return soundAction;
}

+(SKAction *)colorizeLabel:(SKLabelNode *)label withColor:(UIColor *)color
{
    SKAction *colorize = [SKAction runBlock:^{
        label.fontColor = color;
    }];
    return colorize;
}

@end
