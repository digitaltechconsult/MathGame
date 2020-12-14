//
//  BCOGameTimer.h
//  MathGame
//
//  Created by Bogdan Coticopol on 26.04.2014.
//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BCOGameTimerProtocol;

@interface BCOGameTimer : NSObject
@property (strong, nonatomic) NSTimer *gameTimer;
@property (assign) BOOL gameOver;
@property (assign) int timeLeft;
@property (assign) BOOL pauseTimer;
@property (nonatomic, weak) id<BCOGameTimerProtocol> delegate;

/**
 Starts game timer
 */
-(void)startTimer;

/**
 Stops game timer
 */
-(void)endTimer;
@end


@protocol BCOGameTimerProtocol <NSObject>
@optional

/**
 Delegate method to be called each second. Not necessary, but just in case...i know, too good to be tru' :)
 */
-(void) onTimerTick;


-(void) onTimerEnd;
@end