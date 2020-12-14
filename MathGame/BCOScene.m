//
//  BCOScene.m
//  MathGame
//
//  Created by Bogdan Coticopol on 26.04.2014.
//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import "BCOScene.h"

@implementation BCOScene

+(void)presentScene:(Class)scene inView:(SKView *)view withDebug:(BOOL)debug
{
    if(debug) {
        view.showsFPS = YES;
        view.showsNodeCount = YES;
    }
    
    SKScene *myScene = [scene sceneWithSize:view.bounds.size];
    myScene.scaleMode = SKSceneScaleModeAspectFill;
    
    [view presentScene:myScene];
}

+(void)setSceneBackground:(SKScene *)scene
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:backgroundName];
    background.position = CGPointMake(CGRectGetMidX(scene.frame), CGRectGetMidY(scene.frame));
    background.size = scene.frame.size;
    background.zPosition = -10;
    [scene addChild:background];
}


@end
