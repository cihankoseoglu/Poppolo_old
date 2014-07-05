//
//  BallNode.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/6/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "BallNode.h"

@implementation BallNode

-(id)init{
    
    if(self = [super init]){
        
        
       return self;
    }
    
    
    NSArray *balls = [NSArray arrayWithObjects:@"BlueBall", @"YellowBall", @"PinkBall" , @"PurpleBall" , @"GreenBall" ,nil];
    
    uint32_t rnd = arc4random_uniform([balls count]);
    
    NSString *randomBall = [balls objectAtIndex:rnd];
    
    self.ballColor = randomBall;
    
    
    
    SKSpriteNode* ballSprite = [SKSpriteNode spriteNodeWithImageNamed:randomBall];
    ballSprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ballSprite.frame.size.width/2];
    ballSprite.physicsBody.friction = 0;
    ballSprite.physicsBody.restitution = 0;
    ballSprite.physicsBody.linearDamping = 0;
    
    return ballSprite;
    

    
    
    
}

@end
