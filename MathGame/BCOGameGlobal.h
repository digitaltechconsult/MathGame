//
//  BCOGameGlobal.h
//  MathGame
//
//  Created by Bogdan Coticopol on 26.04.2014.
//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface BCOGameGlobal : NSObject

@property (assign) int score;
@property (assign) int colorIndex;
@property (assign) BOOL firstStart;
@property (strong, nonatomic) AVAudioPlayer *musicPlayer;

/**
 Singleton class for global variables required for game (e.g. score)
 @return @c BCOGameGlobal* singleton instance
 */
+(instancetype)sharedInstance;

@end
