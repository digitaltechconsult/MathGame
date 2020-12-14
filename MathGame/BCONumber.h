//
//  BCONumber.h
//  Math Game
//
//  Created by Bogdan Coticopol on 21.04.2014.
//  Copyright (c) 2014 Bogdan Coticopol. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BCOAnimations.h"
#import "BCOGameGlobal.h"

@interface BCONumber : SKSpriteNode

@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) NSArray *colors;

-(instancetype)initWithNumber:(NSNumber *)number;

@end
