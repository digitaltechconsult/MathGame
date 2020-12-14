//
//  BCOViewController.m
//  MathGame
//
//  Created by Bogdan Coticopol on 21.04.2014.
//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import "BCOViewController.h"
#import "BCOScene.h"
#import "BCOGameOver.h"


@implementation BCOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [BCOScene presentScene:[BCOGameOver class] inView:(SKView *)self.view withDebug:NO];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
