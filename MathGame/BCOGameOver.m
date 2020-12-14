//
//  BCOGameOver.m
//  MathGame
//
//  Created by Bogdan Coticopol on 26.04.2014.
//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import "BCOGameOver.h"

@implementation BCOGameOver
-(id)initWithSize:(CGSize)size
{
    if(self = [super initWithSize:size]) {
        
        BCOGameGlobal *globalGame = [BCOGameGlobal sharedInstance];
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.3 blue:0.15 alpha:1.0];
        [BCOScene setSceneBackground:self];
        
        SKLabelNode *gameOver;
        if(!globalGame.firstStart) {
            gameOver = [[SKLabelNode alloc]initWithFontNamed:hudFont];
            gameOver.text = [NSString stringWithFormat:@"Game Over! Your score was: %d",globalGame.score];
            gameOver.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
            gameOver.fontSize = 22;
            gameOver.position = CGPointMake((size.width - gameOver.frame.size.width) * 0.5 , size.height * 0.65);
            [self addChild:gameOver];
        }
        
        SKLabelNode *tapAgain = [[SKLabelNode alloc]initWithFontNamed:hudFont];
        tapAgain.text = @"Tap to start the game!";
        tapAgain.name = @"StartGame";
        tapAgain.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        tapAgain.fontSize = 20;
        tapAgain.position = CGPointMake((size.width - tapAgain.frame.size.width) * 0.5, (gameOver ? (gameOver.position.y - gameOver.frame.size.height) - 0.1 * size.height : size.height * 0.65));
        [self addChild:tapAgain];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for ( UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        if([node.name isEqual:@"StartGame"]) {
            [BCOScene presentScene:[BCOGameScene class] inView:self.view withDebug:debugMode];
        }
        
    }
}

@end
