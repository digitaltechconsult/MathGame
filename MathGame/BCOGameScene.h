//
//  BCOMyScene.h
//  MathGame
//

//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BCOGameLogic.h"
#import "BCOGameTimer.h"
#import "BCONumber.h"
#import "BCOPoint.h"
#import "BCOScene.h"
#import "BCOGameOver.h"


@interface BCOGameScene : SKScene <BCOGameTimerProtocol>

#pragma - Game Prerequisites
@property (strong, nonatomic) BCOGameLogic *game;
@property (strong, nonatomic) BCOGameTimer *gameTimer;
@property (strong, nonatomic) BCOPoint *pointValidator;
@property (assign) BOOL found;

#pragma - Scene elements
@property (nonatomic, strong) SKLabelNode *timeLabel;
@property (strong, nonatomic) SKLabelNode *response;
@property (nonatomic, strong) SKLabelNode *scoreLabel;

#pragma - Game score
@property (assign) int combo;
@property (assign) int comboMultiplier;
@property (strong, nonatomic) BCOGameGlobal *globalGame;
@end
