//
//  BCOScene.h
//  MathGame
//
//  Created by Bogdan Coticopol on 26.04.2014.
//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BCOScene : SKScene

/**
 Display selected scene
 @param scene scene class to be displayed
 @param view the view where the scene will be displayed
 @param debug display debug info
 */
+(void)presentScene:(Class)scene inView:(SKView *)view withDebug:(BOOL)debug;

+(void)setSceneBackground:(SKScene *)scene;

@end
