//
//  EndlessLevel.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/22/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "EndlessLevel.h"

@interface EndlessLevel(){
    
    NSMutableArray *suitBallsOnScreen;
    NSUInteger ballTouchCounter;
    NSUInteger remainingBallsInASuit;
    NSString *newSuitColor;
    NSString *lastSpawnedBallColor;
    NSDate *firstTime;
    NSUInteger ballCount;
    SKLabelNode *score;
    SKLabelNode *timer;
    int scoreCount;
    float chaoticConstant;
    
}

@end

@implementation EndlessLevel

- (void)addBall {
    
    
    BallNode* ballSprite = [[BallNode alloc] init];
    
    ballSprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ballSprite.frame.size.width/2];
    ballSprite.physicsBody.friction = 0;
    ballSprite.physicsBody.restitution = 1;
    ballSprite.physicsBody.linearDamping = 0;
    ballSprite.position = [self randomPointOnScreen:self.scene.size forViewSize:ballSprite.size];
    
    
    if([ballSprite.ballColor isEqualToString:newSuitColor]){
        [suitBallsOnScreen addObject:ballSprite];
        remainingBallsInASuit++;
    }
    
    lastSpawnedBallColor = ballSprite.ballColor;
    
    
    [self addChild:ballSprite];
    
    [ballSprite.physicsBody applyImpulse:[self randomVector]];
    
}
- (void)addBallWithAnimation {
    
    
    BallNode* ballSprite = [[BallNode alloc] init];
    
    ballSprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ballSprite.frame.size.width/2];
    ballSprite.physicsBody.friction = 0;
    ballSprite.physicsBody.restitution = 1;
    ballSprite.physicsBody.linearDamping = 0;
    ballSprite.position = [self randomPointOnScreen:self.scene.size forViewSize:ballSprite.size];
    ballSprite.alpha = 0;
    
    if([ballSprite.ballColor isEqualToString:newSuitColor]){
        [suitBallsOnScreen addObject:ballSprite];
        remainingBallsInASuit++;
    }
    
    lastSpawnedBallColor = ballSprite.ballColor;

    [self addChild:ballSprite];
    
  
    SKAction *fadeIn = [SKAction fadeAlphaTo:1 duration:1];
  //  SKAction *group = [SKAction group:@[playSound,fadeIn]];
    [ballSprite runAction:fadeIn];
//    [ballSprite runAction:group];
    
    
                       
    [ballSprite.physicsBody applyImpulse:[self randomVector]];
    
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

//Endless Level vector
-(CGVector) randomVector{
    
    CGVector finalVector;
    
    CGFloat x = arc4random() %50;
    CGFloat y = arc4random() %50;
    
    finalVector = CGVectorMake(x, y);
    
    
    return finalVector;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.userInteractionEnabled = NO;
        self.backgroundColor = [SKColor whiteColor];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        scoreCount = 0;
        score = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        score.text = [NSString stringWithFormat:@"%i", scoreCount];
        score.fontSize = 24;
        score.fontColor = instructionColor;
        score.position = CGPointMake(self.scene.size.width/2, self.scene.size.height - 40);
        score.alpha = 1;
        score.userInteractionEnabled = NO;
        [self addChild:score];
        
        chaoticConstant = 20;
        
      
        
        // ready ad
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"readyAd" object:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            SKSpriteNode *whiteOverlay = [SKSpriteNode spriteNodeWithImageNamed:@"WhiteOverlay.png"];
            whiteOverlay.alpha = 1;
            whiteOverlay.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2);
            whiteOverlay.userInteractionEnabled = NO;
            
            [self addChild:whiteOverlay];
            
            
            SKAction *fadeOut = [SKAction fadeAlphaTo:0 duration:2];
            
            [whiteOverlay runAction:fadeOut];
            [self removeNodeWithTimeInterval:whiteOverlay :2.2];
            [self userInteractionInTimeInterval:2.8];
            
            
        });
        ballTouchCounter = 0;
        ballCount=0;
        
        // add balls
        for (int i = 0 ; i <10; i++) {
        
            [self addBall];
            
            ballCount++;
        }
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    NSLog(@"touchLocation x: %f and y: %f", location.x, location.y);
    
    BallNode *touchedNode = (BallNode*)[self nodeAtPoint:location];
    
    
    
    
    if(touchedNode != self){
        

        // if it's a new suit
        
        // make this right sometime
//        if(ballTouchCounter == 0 && ![newSuitColor isEqualToString:lastSpawnedBallColor]){
        
        if (ballTouchCounter == 0) {
            
        

            // get that suit color
            newSuitColor = touchedNode.ballColor;
            
            remainingBallsInASuit = 0;
            
            //get how many balls you have on screen of that particular color
            
            for (BallNode *ball in self.children) {
                
                if ([ball isKindOfClass:[BallNode class]]) {
                    
                    if ([ball.ballColor isEqualToString:newSuitColor]) {
                        [suitBallsOnScreen addObject:ball];
                        ballTouchCounter++;
                    }
                }
                
                
            }
            
            [touchedNode removeFromParent];
            scoreCount++;
            [GameData sharedGameData].score +=1;
            ballTouchCounter--;
            ballCount--;
            
            
            
            // add ball everytime.
            
            [self addBallWithAnimation];
            
        }else{
            
            if ([touchedNode.ballColor isEqualToString:newSuitColor]) {
                
                [touchedNode removeFromParent];
                scoreCount++;
                [GameData sharedGameData].score +=1;
                ballTouchCounter--;
                ballCount--;
                
                // I CHANGED HERE
                SKAction *playSound = [SKAction playSoundFileNamed:@"poppoloballpop.mp3" waitForCompletion:NO];
                [touchedNode runAction:playSound];
                //
                
                // add ball everytime.
                [self addBallWithAnimation];
                
            }else {
                
                NSLog(@"Touched node is not the same color as the suit");
                // You lose the game if you don't follow the suit
                [GameData sharedGameData].score = scoreCount;

               
                [GameData sharedGameData].highScore = MAX([GameData sharedGameData].score, [GameData sharedGameData].highScore);
                 [[GameData sharedGameData] save];
                [self gameOver];
                
            }
            
            
        }
        
       
        
        
        
    }
    
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    score.text = [NSString stringWithFormat:@"%i", scoreCount];
    

    if (currentTime == chaoticConstant) {
        
        for (BallNode *ball in self.children) {
            [ball.physicsBody applyImpulse:[self randomVector]];
            NSLog(@"applied vector");

        }
    }

}


-(void)spawnBallWithTimeInterval:(NSTimeInterval)timeInterval{
    
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:self
                                   selector:@selector(addBall)
                                   userInfo:nil
                                    repeats:YES];
}


-(void)removeNodeWithTimeInterval:(SKNode*)node :(NSTimeInterval)timeInterval{
    
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:node
                                   selector:@selector(removeFromParent)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)enableTouches{
    
    self.userInteractionEnabled = YES;
    
}




-(void)userInteractionInTimeInterval:(NSTimeInterval)timeInterval{
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:self
                                   selector:@selector(enableTouches)
                                   userInfo:nil
                                    repeats:NO];
    
}


-(void)gameOver{
    
    NSLog(@"Entered game over state");
    // Need to get a sound for game over
    self.userInteractionEnabled = NO;
    
    SKSpriteNode *whiteOverlay = [SKSpriteNode spriteNodeWithImageNamed:@"WhiteOverlay.png"];
    whiteOverlay.alpha=0;
    
    // TO DO
    // save the score if it's the best score.
    
    
    SKAction *fadeIn = [SKAction fadeAlphaTo:1 duration:0.5];
    
    [whiteOverlay runAction:fadeIn];
    
    [self addChild:whiteOverlay];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        GameOver *gameOver = [[GameOver alloc] initWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
        
        
        [self.view presentScene:gameOver transition:transition];
    });
    
    
    
}

@end
