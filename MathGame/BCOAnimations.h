//
//  BCOAnimations.h
//  MathGame
//
//  Created by Bogdan Coticopol on 26.04.2014.
//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BCOAnimations : SKNode

/**
 Generates random color with the possibility of having one ore more color with fixed values @c YES.
 If all values are @c YES, then the resulted color will be white.
 @code
 SKLabelNode *node;
 node.fontColor = [BCONumber generateRandomColorWithRedFixedValue:NO AndGreenFixedValue:YES AndBlueFixedValue:NO];
 @endcode
 @param red YES if red color value will be 1.0
 @param green YES if green color value will be 1.0
 @param blue YES if blue color value will be 1.0
 @return the random generated color @c SKColor* / @c UIColor*
 */
+(SKColor *)generateRandomColorWithRedFixedValue:(BOOL)red AndGreenFixedValue:(BOOL)green AndBlueFixedValue: (BOOL)blue;

/**
 Generates a "pulse" animation that can be used with any @c SKNode.
 @code
 SKLabelNode *node;
 [node runAction:[BCONumber pulse]];
 @endcode
 @return @c SKAction with the animation
 */
+(SKAction *)pulse;

/**
 Generates a "fade" animation that can be used with any @c SKNode
 @return @c SKAction with the animation
 */
+(SKAction *)fade;

+(SKAction *)colorizeWithColor:(UIColor *)color;

+(SKAction *)playSound:(NSString *)filename;

+(SKAction *)colorizeLabel:(SKLabelNode *)label withColor:(UIColor *)color;
@end
