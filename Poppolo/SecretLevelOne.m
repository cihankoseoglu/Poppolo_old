//
//  SecretLevelOne.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/22/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "LevelEleven.h"
#import "SecretLevelOne.h"

@interface SecretLevelOne(){
    
    NSMutableArray *suitBallsOnScreen;
    NSUInteger ballTouchCounter;
    NSUInteger remainingBallsInASuit;
    NSString *newSuitColor;
    NSDate *firstTime;
    NSUInteger ballCount;
    int timeRemaining;
    BOOL firstTouch;
    
    
}

@end

@implementation SecretLevelOne

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
    
    SKAction *shrink = [SKAction scaleTo:0 duration:0];
    SKAction *magnify = [SKAction scaleTo:1 duration:POPANIMATIONDURATION];
    
    SKAction *sequence = [SKAction sequence:@[shrink,magnify]];
    
    
    [self addChild:ballSprite];
    
    [ballSprite runAction:sequence];    [ballSprite.physicsBody applyForce:[self randomVector]];
    
    
    
    
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

//Level 9 random vector is  bigbigbig
-(CGVector) randomVector{
    
    CGVector finalVector;
    
    CGFloat x = arc4random() %300;
    CGFloat y = arc4random() %300;
    
    finalVector = CGVectorMake(x, y);
    
    
    return finalVector;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
                self.userInteractionEnabled = NO;
        self.backgroundColor = secretLevelBackgroundColor;
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        //level 7
        
        
        
        
        // Timer for Level Secret Level 1
        timeRemaining = 30;
        
        SKLabelNode* countdown = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        
        
        countdown.text = [NSString stringWithFormat:@"%d", timeRemaining];
        countdown.fontSize = 48;
        countdown.fontColor = levelPassColor;
        countdown.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2+180);
        countdown.alpha = 1;
        countdown.userInteractionEnabled = NO;
        
        
        [self addChild:countdown];
        
        SKAction* wait = [SKAction waitForDuration:1.0];
        SKAction* run = [SKAction runBlock:^{
            
            if (timeRemaining >0) {
                
                timeRemaining--;
                countdown.text = [NSString stringWithFormat:@"%d",timeRemaining];
            }else{
                
                NSLog(@"Entered");
                
                self.userInteractionEnabled = NO;
                
                SKSpriteNode *whiteOverlay = [SKSpriteNode spriteNodeWithImageNamed:@"GrayOverlay.png"];
                whiteOverlay.alpha=0;
                
                SKAction *fadeIn = [SKAction fadeAlphaTo:1 duration:0.5];
                
                [whiteOverlay runAction:fadeIn];
                
                [self addChild:whiteOverlay];
                
                //label depicting next level
                SKLabelNode *levelLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
                levelLabel.text = [NSString stringWithFormat:@"11"];
                levelLabel.fontSize = 60;
                levelLabel.fontColor = levelPassColor;
                levelLabel.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2 );
                levelLabel.alpha = 0 ;
                
                [levelLabel runAction:fadeIn];
                [self addChild:levelLabel];
                
                [self segueInTimeInterval:2];

            }
            
        }];
        
        
        [countdown runAction:[SKAction repeatAction:[SKAction sequence:@[wait, run]] count:31]];
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            SKSpriteNode *grayOverlay = [SKSpriteNode spriteNodeWithImageNamed:@"GrayOverlay.png"];
            grayOverlay.alpha = 1;
            grayOverlay.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2);
            grayOverlay.userInteractionEnabled = NO;
            [self addChild:grayOverlay];
            
            
            SKAction *fadeOut = [SKAction fadeAlphaTo:0 duration:0.8];
            
            [grayOverlay runAction:fadeOut];
            [self removeNodeWithTimeInterval:grayOverlay :1.0];
            [self userInteractionInTimeInterval:1.2];
            
            
            
        });
        ballTouchCounter = 0;
        ballCount=0;
        
        // add the balls to the scene
        for (int i = 0 ; i <15; i++) {
            
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
        
        if ([touchedNode isKindOfClass:[BallNode class]]) {
            
            if(ballTouchCounter == 0){
                
                // get that suit color
                newSuitColor = touchedNode.ballColor;
                
                remainingBallsInASuit = 0;
                
                //get how many balls you have on screen of that particular color
                
                for (BallNode *ball in self.children) {
                    if ([ball isKindOfClass:[BallNode class]]) {
                        if ([ball.ballColor isEqualToString:newSuitColor]) {
                            ballTouchCounter++;
                        }
                        
                    }
                    
                }
                //animate and remove
                //animate and remove
                if ([touchedNode isKindOfClass:[BallNode class]]) {
                    [self popBall:touchedNode];
                    
                    
                }
                
                ballTouchCounter--;
                ballCount--;
                
            }else{
                
                if ([touchedNode.ballColor isEqualToString:newSuitColor]) {
                    //animate and remove
                    if ([touchedNode isKindOfClass:[BallNode class]]) {
                        [self popBall:touchedNode];
                        
                        
                    }
                    
                    ballTouchCounter--;
                    ballCount--;
                    
                    
                    
                }else {
                    
                    NSLog(@"Touched node is not the same color as the suit");
                    // Do nothing but make a little animation of some sort later
                }
                
                
            }
        }
        if(ballCount ==0){
            
            NSLog(@"Entered");
            
            self.userInteractionEnabled = NO;
            
            SKSpriteNode *whiteOverlay = [SKSpriteNode spriteNodeWithImageNamed:@"GrayOverlay.png"];
            whiteOverlay.alpha=0;
            
            SKAction *fadeIn = [SKAction fadeAlphaTo:1 duration:0.5];
            
            [whiteOverlay runAction:fadeIn];
            
            [self addChild:whiteOverlay];
            
            //label depicting next level
            SKLabelNode *levelLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
            levelLabel.text = [NSString stringWithFormat:@"11"];
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
    
    self.userInteractionEnabled = NO;
    
    SKSpriteNode *whiteOverlay = [SKSpriteNode spriteNodeWithImageNamed:@"WhiteOverlay.png"];
    whiteOverlay.alpha=0;
    
    SKAction *fadeIn = [SKAction fadeAlphaTo:1 duration:0.5];
    
    [whiteOverlay runAction:fadeIn];
    
    [self addChild:whiteOverlay];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        LevelEleven *newScene = [[LevelEleven alloc] initWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
        [self.view presentScene:newScene transition:transition];
    });
    
    
    
}
-(void)popBall:(BallNode*)ball{
    
    
    SKAction *shrink = [SKAction scaleTo:0.0 duration:POPANIMATIONDURATION];
    [ball runAction:shrink];
    
    [self removeFromParentInTimeInterval:ball interval:REMOVEANIMATIONDURATION];
    
    
    
    
    
    
}

-(void)removeFromParentInTimeInterval:(BallNode*)node interval:(NSTimeInterval)interval{
    
    [NSTimer scheduledTimerWithTimeInterval:interval
                                     target:node
                                   selector:@selector(removeFromParent)
                                   userInfo:nil
                                    repeats:NO];
    
    
}


-(void)gameOver{
    
    NSLog(@"Entered game over state");
    
    self.userInteractionEnabled = NO;
    
    SKSpriteNode *whiteOverlay = [SKSpriteNode spriteNodeWithImageNamed:@"WhiteOverlay.png"];
    whiteOverlay.alpha=0;
    
    SKAction *fadeIn = [SKAction fadeAlphaTo:1 duration:0.5];
    
    [whiteOverlay runAction:fadeIn];
    
    [self addChild:whiteOverlay];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        GameOver *gameOver = [[GameOver alloc] initWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
        [self.view presentScene:gameOver transition:transition];
    });
    
    
    
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
