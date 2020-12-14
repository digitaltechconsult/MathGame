//
//  BCOGame.m
//  MathGame
//
//  Created by Bogdan Coticopol on 21.04.2014.
//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import "BCOGameLogic.h"

@interface BCOGameLogic()

/**
 Generate random number different than 0 or n
 @param n random number must be different from n
 @return random number < 10
 */
-(int)randomNumberDifferentThanNumber:(int)n;

/**
 Generates the pair of number used in calculation and the result of multiplication.
 Numbers are > 1
 */
-(void)generateRandomPair;

/**
 Populate @c NSMutableArray* @c choices with the correct and random answers
 */
-(void)generateRandomResults;
@end

@implementation BCOGameLogic

-(id)init {
    if(self = [super init]) {
        [self generateRandomPair];
        [self generateRandomResults];
    }
    return self;
}

-(BOOL)isCorrect:(int)n
{
    return n == self.result;
}

-(int)randomNumberDifferentThanNumber:(int)n
{
    int x = 0;
    while(x == 0 || x == n) {
        x = arc4random_uniform(10);
    }
    return x;
}

-(void)generateRandomPair
{
    self.x = [self randomNumberDifferentThanNumber:1];
    self.y = [self randomNumberDifferentThanNumber:1];
    self.result = self.x * self.y;
}

-(void)generateRandomResults
{
    self.choices = [[NSMutableArray alloc]initWithCapacity:10];
    [self.choices addObject:[NSNumber numberWithInt:self.result]];
    
    for(int i = 0; i < 9; i++) {
        int x = 0, y = 0;
        while(x == 0 || y == 0 || [self.choices containsObject:[NSNumber numberWithInt:x*y]]) {
            x = [self randomNumberDifferentThanNumber:0];
            y = [self randomNumberDifferentThanNumber:0];
        }
        [self.choices addObject:[NSNumber numberWithInt:x*y]];
    }
}




@end
