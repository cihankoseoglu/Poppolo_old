//
//  MyScene.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/4/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "MyScene.h"

@interface MyScene(){
    
    NSArray *balls;

}

@end

@implementation MyScene

- (SKSpriteNode *)addBall {
    
    
    balls = [NSArray arrayWithObjects:@"BlueBall", @"YellowBall", @"PinkBall" , @"PurpleBall" , @"GreenBall" ,nil];
    
    uint32_t rnd = arc4random_uniform([balls count]);
    
    NSString *randomBall = [balls objectAtIndex:rnd];
    
    SKSpriteNode* ballSprite = [SKSpriteNode spriteNodeWithImageNamed:randomBall];
    ballSprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ballSprite.frame.size.width/2];
    ballSprite.physicsBody.friction = 0;
    ballSprite.physicsBody.restitution = 0;
    ballSprite.physicsBody.linearDamping = 0;
    
    return ballSprite;
    }

// returns a random point on screen given the container size and the size of the sprite
-(CGPoint) randomPointOnScreen:(CGSize)containerSize forViewSize:(CGSize)size
{
    
    CGFloat xRange = containerSize.width - size.width;
    CGFloat yRange = containerSize.height - size.height;
    
    CGFloat minX = (containerSize.width - xRange) / 2;
    CGFloat minY = (containerSize.height - yRange) / 2;
    
    int randomX = (arc4random() % (int)floorf(xRange)) + minX;
    int randomY = (arc4random() % (int)floorf(yRange)) + minY;
    return CGPointMake(randomX, randomY);
    
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor whiteColor];
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        

        for (int i = 0 ; i <4; i++) {
            for (int j = 0; j < 4; j++) {
                

                BallNode* ball = [BallNode new];
                ball.position = [self randomPointOnScreen:self.scene.size forViewSize:ball.size];

                

                [self addChild:ball];
[ball.physicsBody applyForce:CGVectorMake(10, 5)];
            
            }
        }

        

    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    NSLog(@"touchLocation x: %f and y: %f", location.x, location.y);
    
    SKNode *touchedNode = [self nodeAtPoint:location];
    
    
    
    
    
    if(touchedNode != self){
        [touchedNode removeFromParent];
        
        
        
        BallNode *ball = [BallNode new];
        ball.position = [self randomPointOnScreen:self.scene.size forViewSize:ball.size];
        [self addChild:ball];
        
        [ball.physicsBody applyImpulse:CGVectorMake(10, 40)];
        
        
    }
    
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
