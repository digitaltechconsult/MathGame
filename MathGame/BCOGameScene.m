//
//  BCOMyScene.m
//  MathGame
//
//  Created by Bogdan Coticopol on 21.04.2014.
//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import "BCOGameScene.h"

#define ROUND_TIME 30
#define COMBO_MULTIPLIER 1

@interface BCOGameScene ()

/**
 Keep track of the combo score
 */
-(BOOL)calculateCombo;

/**
 Start new game. If there is already an instance of self.game, that will be deleted
 */
-(void)newGame;

/**
 End game. Clear game variables
 */
-(void)endGame;
@end

@implementation BCOGameScene

#pragma - Scene Functions
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        //background setup
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        [BCOScene setSceneBackground:self];
        
        //game timer initialisation
        self.gameTimer = [[BCOGameTimer alloc]init];
        self.gameTimer.timeLeft = ROUND_TIME;
        self.gameTimer.delegate = self;
        
        //game initialisation
        self.combo = 0;
        self.comboMultiplier = COMBO_MULTIPLIER;
        self.globalGame = [BCOGameGlobal sharedInstance];
        self.globalGame.score = 0;
        self.globalGame.firstStart = NO;
        self.globalGame.colorIndex = 0;
        
        //HUD init
        [self timeHUD];
        [self scoreHUD];
        
        //game & timer start
        [self newGame];
        [self.gameTimer startTimer];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        if([node isKindOfClass:[SKLabelNode class]]) { //am dat tap pe un numar si nu pe un spatiu gol
            SKLabelNode *numberNode = (SKLabelNode *)node;
            if(numberNode && [self.game isCorrect:[numberNode.text intValue]]) {
                if(!self.found) {
                    self.gameTimer.pauseTimer = YES;
                    self.found = YES;
                    int t = arc4random_uniform(5);
                    if(t > 3) {
                        self.gameTimer.timeLeft+=t;
                        [self animateTime];
                    }
                    [self answerIsCorrect:YES];
                }
                break;
            } else {
                [self answerIsCorrect:NO];
            }
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if(self.gameTimer.gameOver) {
        [BCOScene presentScene:[BCOGameOver class] inView:self.view withDebug:NO];
    } else {
        self.timeLabel.text = [NSString stringWithFormat:@"%d",self.gameTimer.timeLeft];
    }
}

#pragma mark HUD
-(void)timeHUD
{
    self.timeLabel = [[SKLabelNode alloc]initWithFontNamed:hudFont];
    self.timeLabel.name = @"GameHud";
    self.timeLabel.text = @"0";
    self.timeLabel.fontSize = 18;
    self.timeLabel.position = CGPointMake(self.size.width * 0.1, self.size.height * 0.9);
    [self addChild:self.timeLabel];
    
    SKLabelNode *time = [[SKLabelNode alloc]initWithFontNamed:hudFont];
    time.name = @"GameHud";
    time.text = @"Time";
    time.fontSize = 14;
    time.position = CGPointMake((self.timeLabel.position.x),
                                self.timeLabel.position.y + self.timeLabel.frame.size.height);
    [self addChild:time];
}

-(void)scoreHUD
{
    self.scoreLabel = [[SKLabelNode alloc]initWithFontNamed:hudFont];
    self.scoreLabel.name = @"GameHud";
    self.scoreLabel.text = @"0";
    self.scoreLabel.fontSize = 18;
    self.scoreLabel.position = CGPointMake(self.size.width * 0.9, self.size.height * 0.9);
    [self addChild:self.scoreLabel];
    
    SKLabelNode *score = [[SKLabelNode alloc]initWithFontNamed:hudFont];
    score.name = @"GameHud";
    score.text = @"Score";
    score.fontSize = 14;
    score.position = CGPointMake((self.scoreLabel.position.x),
                                 self.scoreLabel.position.y + self.scoreLabel.frame.size.height);
    [self addChild:score];
}

#pragma mark protocol

-(void)onTimerTick
{
    //controls if game is over or not
    if(!self.gameTimer.gameOver) {
        self.timeLabel.text = [NSString stringWithFormat:@"%d",self.gameTimer.timeLeft];
    }
}

-(void)onTimerEnd
{
    [BCOScene presentScene:[BCOGameOver class] inView:self.view withDebug:debugMode];
}

#pragma - Game Functions

-(BOOL)calculateCombo
{
    if(self.comboMultiplier == 1) {
        self.comboMultiplier++;
    } else {
        if(self.combo%(int)(pow(self.comboMultiplier,3)) == 0) {
            self.globalGame.score += self.combo / 3;
            int t = arc4random_uniform(5);
            self.gameTimer.timeLeft+= t;
            self.comboMultiplier++;
            self.globalGame.colorIndex++;
            return YES;
        }
    }
    return NO;
}

-(void)animateTime
{
    SKAction *green = [BCOAnimations colorizeLabel:self.timeLabel withColor:[SKColor greenColor]];
    SKAction *white = [BCOAnimations colorizeLabel:self.timeLabel withColor:[SKColor whiteColor]];
    SKAction *comboSound = [BCOAnimations playSound:@"combo.wav"];
    SKAction *animate = [SKAction sequence:@[green, comboSound, white]];
    [self.timeLabel runAction:animate];
}

-(void)answerIsCorrect:(BOOL)c
{
    if(c) {
        self.globalGame.score++;
        self.combo++;
        self.scoreLabel.text = [NSString stringWithFormat:@"%d",self.globalGame.score];
        
        SKAction *green = [BCOAnimations colorizeLabel:self.scoreLabel withColor:[SKColor greenColor]];
        SKAction *white = [BCOAnimations colorizeLabel:self.scoreLabel withColor:[SKColor whiteColor]];
        SKAction *resumeGame = [SKAction runBlock:^{
            if([self calculateCombo]) {
                [self animateTime];
            }
            [self newGame];
            self.gameTimer.pauseTimer = NO;
        }];
        SKAction *animation = [SKAction sequence:@[green,[BCOAnimations playSound:@"correct.wav"],white,resumeGame]];
        //self.scoreLabel.fontColor = [SKColor greenColor];
        [self.scoreLabel runAction:animation];
        
    } else {
        self.globalGame.colorIndex = 0;
        self.gameTimer.timeLeft = self.gameTimer.timeLeft <= 0 ? 0 : --self.gameTimer.timeLeft;
        self.combo = 0;
        self.comboMultiplier = COMBO_MULTIPLIER;
        
        SKAction *red = [BCOAnimations colorizeLabel:self.timeLabel withColor:[SKColor redColor]];
        SKAction *white = [BCOAnimations colorizeLabel:self.timeLabel withColor:[SKColor whiteColor]];
        SKAction *animation = [SKAction sequence:@[red,[BCOAnimations playSound:@"wrong.mp3"],white]];
        [self.timeLabel runAction:animation];
    }
    
}

-(void)newGame
{
    [self endGame];
    self.found = NO;
    
    self.pointValidator = [[BCOPoint alloc]initWithSize:self.size];
    self.pointValidator.positions = [[NSMutableArray alloc]initWithCapacity:10];
    self.game = [BCOGameLogic new];
    
    for(NSNumber *n in [self.game choices]) {
        BCONumber *number = [[BCONumber alloc]initWithNumber:n];
        number.name = @"GameNode";
        CGPoint point = [self.pointValidator randomPoint];
        
        while(![self.pointValidator canDrawPoint:point]) {
            point = [self.pointValidator randomPoint];
        }
        
        [self.pointValidator.positions addObject:[NSValue valueWithCGPoint:point]];
        number.position = point;
        [self addChild:number];
    }
    
#pragma - question label
    SKLabelNode *question = [[SKLabelNode alloc]initWithFontNamed:hudFont];
    question.name = @"GameNode";
    question.text = [NSString stringWithFormat:@"%d x %d = ?", self.game.x, self.game.y];
    question.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    
    CGPoint questionPosition = CGPointMake((self.size.width - question.frame.size.width) * 0.5, self.size.height * 0.9);
    
    question.position = questionPosition;
    [self addChild:question];
    
#pragma - time label
    self.timeLabel.text = [NSString stringWithFormat:@"%d",self.gameTimer.timeLeft];
    
#pragma - score label
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",self.globalGame.score];
}

-(void)endGame
{
    if(self.game) {
        [self enumerateChildNodesWithName:@"GameNode" usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
        self.pointValidator = nil;
        self.game = nil;
    }
}


@end
