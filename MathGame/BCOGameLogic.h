//
//  BCOGame.h
//  MathGame
//
//  Created by Bogdan Coticopol on 21.04.2014.
//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCOGameLogic : NSObject

@property int x;
@property int y;
@property int result;
@property (strong, nonatomic) NSMutableArray *choices;

/**
 Check if the selected value is the correct answer
 @param n int number to check
 @return @c YES if the answer is correct
 */
-(BOOL)isCorrect:(int)n;

@end
