//
//  LevelSeven.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/22/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

// Level 7 is a Timed Level .
// Same as Level 4 but timed to 10 seconds.



#import "LevelSeven.h"
#import "LevelEight.h"

@interface LevelSeven(){
    
    NSMutableArray *suitBallsOnScreen;
    NSUInteger ballTouchCounter;
    NSUInteger remainingBallsInASuit;
    NSString *newSuitColor;
    NSDate *firstTime;
    NSUInteger ballCount;
    
    BOOL firstTouch;
    
    
}

@end

@implementation LevelSeven

- (void)addBall {
    
    
    BallNode* ballSprite = [[BallNode alloc] init];
    
    ballSprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ballSprite.frame.size.width/2];
    ballSprite.physicsBody.friction = 0;
    ballSprite.physicsBody.restitution = 0.7;
    ballSprite.physicsBody.linearDamping = 0;
    ballSprite.position = [self randomPointOnScreen:self.scene.size forViewSize:ballSprite.size];
    
    
    if([ballSprite.ballColor isEqualToString:newSuitColor]){
        [suitBallsOnScreen addObject:ballSprite];
        remainingBallsInASuit++;
    }
    
    
    [self addChild:ballSprite];
    
    [ballSprite.physicsBody applyForce:CGVectorMake(20, 20)];
    
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

//Level 4 random vector is not that big
-(CGVector) randomVector{
    
    CGVector finalVector;
    
    CGFloat x = arc4random() %30;
    CGFloat y = arc4random() %30;
    
    finalVector = CGVectorMake(x, y);
    
    
    return finalVector;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.userInteractionEnabled = NO;
        firstTouch = NO;
        
        self.backgroundColor = [SKColor whiteColor];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            SKSpriteNode *whiteOverlay = [SKSpriteNode spriteNodeWithImageNamed:@"WhiteOverlay.png"];
            whiteOverlay.alpha = 1;
            whiteOverlay.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2);
            
            [self addChild:whiteOverlay];
            
            
            SKAction *fadeOut = [SKAction fadeAlphaTo:0 duration:2];
            
            [whiteOverlay runAction:fadeOut];
            [self removeNodeWithTimeInterval:whiteOverlay :4];
            [self userInteractionInTimeInterval:4.1];
            
            
        });
        ballTouchCounter = 0;
        ballCount=0;
        
        
        //add timer to the scene
        
        SKLabelNode* countdown = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        
        // countdown start
        __block int timeRemaining = 10;
        
        countdown.text = [NSString stringWithFormat:@"%d" , timeRemaining];
        countdown.fontSize = 24;
        countdown.color = instructionColor;
        countdown.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2+180);
        countdown.alpha = 1;
        
        for (int i = 0; i < timeRemaining; i++) {
            SKAction* wait = [SKAction waitForDuration:1.0];
            SKAction* run = [SKAction runBlock:^{
                
                timeRemaining--;
                countdown.text = [NSString stringWithFormat:@"%d",timeRemaining];
                
            }];
            [countdown runAction:[SKAction sequence:@[wait, run]]];
            
        }

        
      
        // add the balls to the scene
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
    
    firstTouch = YES;
    
    if(touchedNode != self){
        // if it's a new suit
        if(ballTouchCounter == 0){
            
            // get that suit color
            newSuitColor = touchedNode.ballColor;
            
            remainingBallsInASuit = 0;
            
            //get how many balls you have on screen of that particular color
            
            for (BallNode *ball in self.children) {
                
                if ([ball.ballColor isEqualToString:newSuitColor]) {
                    [suitBallsOnScreen addObject:ball];
                    ballTouchCounter++;
                }
                
            }
            
            [touchedNode removeFromParent];
            ballTouchCounter--;
            ballCount--;
            
            //        BallNode *ball = [BallNode new];
            //        ball.position = [self randomPointOnScreen:self.scene.size forViewSize:ball.size];
            //        [self addChild:ball];
            
            
        }else{
            
            if ([touchedNode.ballColor isEqualToString:newSuitColor]) {
                
                [touchedNode removeFromParent];
                ballTouchCounter--;
                ballCount--;
                
                
                
            }else {
                
                NSLog(@"Touched node is not the same color as the suit");
                // Do nothing but make a little animation of some sort later
            }
            
            
        }
        if(ballCount ==0){
            
            NSLog(@"Entered");
            
            self.userInteractionEnabled = NO;
            
            SKSpriteNode *whiteOverlay = [SKSpriteNode spriteNodeWithImageNamed:@"WhiteOverlay.png"];
            whiteOverlay.alpha=0;
            
            SKAction *fadeIn = [SKAction fadeAlphaTo:1 duration:0.5];
            
            [whiteOverlay runAction:fadeIn];
            
            [self addChild:whiteOverlay];
            
            //label depicting next level
            SKLabelNode *levelLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
            levelLabel.text = [NSString stringWithFormat:@"5"];
            levelLabel.fontSize = 60;
            levelLabel.fontColor = levelPassColor;
            levelLabel.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2 );
            levelLabel.alpha = 0 ;
            
            [levelLabel runAction:fadeIn];
            [self addChild:levelLabel];
            
            [self segueInTimeInterval:2];
            
        }
        
        
        
    }
    
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
   
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


-(void)segueToNextLevel{
    
    // remove the passed level from memory.
    // self.scene = nil;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        LevelEight *newScene = [[LevelEight alloc] initWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
        [self.view presentScene:newScene transition:transition];
    });
    
    
    
}

-(void)gameOver{
    
    
}

-(SKLabelNode*)timerLabel{
    
    SKLabelNode *timer;
    
    
    return timer;
    
}

-(void)segueInTimeInterval:(NSTimeInterval)timeInterval{
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:self
                                   selector:@selector(segueToNextLevel)
                                   userInfo:nil
                                    repeats:NO];
    
}

-(void)userInteractionInTimeInterval:(NSTimeInterval)timeInterval{
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:self
                                   selector:@selector(enableTouches)
                                   userInfo:nil
                                    repeats:NO];
    
}

-(void)gameOverInTimeInterval:(NSTimeInterval)timeInterval{
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:self
                                   selector:@selector(gameOver)
                                   userInfo:nil
                                    repeats:NO];
    
    
}

@end
