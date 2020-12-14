//
//  BCOPoint.h
//  MathGame
//
//  Created by Bogdan Coticopol on 26.04.2014.
//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TOP_MARGIN 0.75
#define BOTTOM_MARGIN 0.10
#define LEFT_MARGIN 0.10
#define RIGHT_MARGIN 0.90
#define POINT_DISTANCE 75

@interface BCOPoint : NSObject
@property (assign) CGSize size;
@property (strong, nonatomic) NSMutableArray *positions;

/**
 Calculate distance between two points
 @param a Point A
 @param b Point B
 @return Distance between point A and B
 */
+(float)calculateDistanceFromPointA:(CGPoint)a toPointB:(CGPoint)b;

/**
 Init with size of the rectangle (for boundaries calculation)
 @param size size of the rectangle
 @return @c BCOPoint*
 */
-(id)initWithSize:(CGSize)size;

/**
 Check if the point can pe drawn
 @see -(BOOL)marginTopAndBottom:(CGPoint)point; -(BOOL)marginLeftAndRight:(CGPoint)point; -(BOOL)isHotSpot:(CGPoint)point;
 @param point point to check
 @return YES if the point can pe drawn, NO if it can't
 */
-(BOOL)canDrawPoint:(CGPoint)point;

/**
 Draw random position point in boundaries of the size
 @return point point position
 */
-(CGPoint)randomPoint;
@end
