//
//  BCOGameGlobal.m
//  MathGame
//
//  Created by Bogdan Coticopol on 26.04.2014.
//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import "BCOGameGlobal.h"

@implementation BCOGameGlobal

#pragma mark Singleton

+(instancetype)sharedInstance
{
    static BCOGameGlobal *singleton = nil; //singleton class instance
    static dispatch_once_t onceToken; //executes only once in lifetime of app

    dispatch_once(&onceToken, ^{
        singleton = [[self alloc]init];
    });
    return singleton;
}

-(id)init {
    if(self = [super init]) {
        self.score = 0;
        self.firstStart = YES;
        [self playMusic:@"sound"];
    }
    return self;
}

-(void)playMusic:(NSString *)filename
{
    NSError *error;
    NSURL *musicURL = [[NSBundle mainBundle] URLForResource:filename withExtension:@"wav"];
    self.musicPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:&error];
    self.musicPlayer.numberOfLoops = -1;
    self.musicPlayer.volume = 0.40f;
    [self.musicPlayer prepareToPlay];
    [self.musicPlayer play];
}

@end
