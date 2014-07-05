//
//  BallNode.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/6/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "BallNode.h"

@implementation BallNode

- (id) init {
    if (self = [super init]) {
        
        
        NSArray *balls = [NSArray arrayWithObjects:@"BlueBall", @"YellowBall", @"PinkBall" , @"PurpleBall" , @"GreenBall" ,nil];
        
        uint32_t rnd = arc4random_uniform([balls count]);
        
        NSString *ballColor = [balls objectAtIndex:rnd];
        self.ballColor = ballColor;

        
        self = [BallNode spriteNodeWithImageNamed:ballColor];
        [self setBallDetails];


    }
    return self;
}

-(void) setBallDetails{
    
   
    self.name = @"BallNode";
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.frame.size.width/2];

   

}


@end
