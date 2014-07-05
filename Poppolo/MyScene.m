//
//  MyScene.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/4/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "MyScene.h"
#import "BallNode.h"

@interface MyScene(){
    
}

@end

@implementation MyScene

- (BallNode *)addBall {
    
    BallNode *ball = [BallNode init];
    return ball;
    
    }

-(CGPoint) randomPointOnScreen:(CGSize)containerSize forViewSize:(CGSize)size
{
    //CGPoint randomPoint = CGPointMake(arc4random()%self.frame.size.width, arc4random()%self.frame.size.height);
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
                
                SKSpriteNode *ballSprite;
                ballSprite = [self addBall];
                //blueBallSprite.userInteractionEnabled = YES;

                ballSprite.position = [self randomPointOnScreen:self.scene.size forViewSize:ballSprite.size];

                
                [self addChild:ballSprite];

                CGVector myVector = CGVectorMake(10,5);

                
                [ballSprite.physicsBody applyImpulse:myVector];
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
        
        SKSpriteNode* ball = [self addBall];
        ball.position = [self randomPointOnScreen:self.scene.size forViewSize:ball.size];
        
        [self addChild:ball];
        
        [ball.physicsBody applyImpulse:CGVectorMake(10, 40)];
        
        
        
    }
    
    
    
    
    
        
        
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
