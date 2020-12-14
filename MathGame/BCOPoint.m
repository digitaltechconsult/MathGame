//
//  BCOPoint.m
//  MathGame
//
//  Created by Bogdan Coticopol on 26.04.2014.
//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import "BCOPoint.h"

@interface BCOPoint ()

/**
 (Private Method) Check the top and bottom bondaries for drawing point
 @param point point to draw
 @return YES if the point can be drawn, NO if not
 */
-(BOOL)marginTopAndBottom:(CGPoint)point;

/**
 (Private Method) Check the left and right bondaries for drawing point
 @param point point to draw
 @return YES if the point can be drawn, NO if not
 */
-(BOOL)marginLeftAndRight:(CGPoint)point;

/**
 (Private Method) Check if distance between the point and the rest of the points already drawn is acceptable
 @param point point to draw
 @return YES if the point can be drawn, NO if not
 */
-(BOOL)isHotSpot:(CGPoint)point;
@end


@implementation BCOPoint

-(id)initWithSize:(CGSize)size
{
    if(self = [super init]) {
        self.size = size;
    }
    return self;
}

-(BOOL)canDrawPoint:(CGPoint)point
{
    if([self marginLeftAndRight:point] && [self marginTopAndBottom:point])
        return [self isHotSpot:point];
    return false;
}

-(BOOL)marginTopAndBottom:(CGPoint)point
{
    return ((point.y < self.size.height * TOP_MARGIN) && (point.y > self.size.height * BOTTOM_MARGIN));
}

-(BOOL)marginLeftAndRight:(CGPoint)point
{
    return ((point.x < self.size.width * RIGHT_MARGIN) && (point.x > self.size.width * LEFT_MARGIN));
}

-(BOOL)isHotSpot:(CGPoint)point
{
    for (NSValue *p in self.positions) {
        CGPoint referencePoint = [p CGPointValue];
        float distance = [[self class] calculateDistanceFromPointA:point toPointB:referencePoint];
        if(distance < POINT_DISTANCE)
            return false;
    }
    return true;
}

+(float)calculateDistanceFromPointA:(CGPoint)a toPointB:(CGPoint)b
{
    CGFloat dx = b.x - a.x;
    CGFloat dy = b.y - a.y;
    float distance = sqrt(pow(dx,2) + pow(dy,2));
    return distance;
}

-(CGPoint)randomPoint
{
    CGPoint point = CGPointMake(arc4random_uniform(self.size.width),arc4random_uniform(self.size.height));
    return point;
}

@end
