//
//  BCOGameTimer.m
//  MathGame
//
//  Created by Bogdan Coticopol on 26.04.2014.
//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import "BCOGameTimer.h"

@interface BCOGameTimer ()

/**
 Tick operations
 */
-(void)tick;

@end


@implementation BCOGameTimer

-(void)startTimer
{
    if(!self.gameTimer) {
        self.gameOver = NO;
        self.pauseTimer = NO;
        self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    }
}

-(void)tick
{
    if(!self.pauseTimer) {
        if((self.timeLeft >= 1)) {
            self.timeLeft--;
            [self.delegate onTimerTick];
        }
        else {
            [self endTimer];
        }
    }
}

-(void)endTimer
{
    self.gameOver = YES;
    if(self.gameTimer) {
        [self.gameTimer invalidate];
    }
    [self.delegate onTimerEnd];
}


@end
