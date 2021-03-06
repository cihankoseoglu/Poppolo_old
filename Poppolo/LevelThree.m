//
//  LevelThree.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/21/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "LevelThree.h"
#import "LevelFour.h"



@interface LevelThree(){
    
    
    NSMutableArray *suitBallsOnScreen;
    NSUInteger ballTouchCounter;
    NSUInteger remainingBallsInASuit;
    NSString *newSuitColor;
    NSDate *firstTime;
    NSUInteger ballCount;
    NSUInteger i;
    
    
}

@end


@implementation LevelThree

- (void)addBallwithPosition:(CGPoint)position ofColor:(NSString*)ballColor {
    
    BallNode* ballSprite = [[BallNode alloc] init];
    
    ballSprite.texture = [SKTexture textureWithImageNamed:ballColor];
    ballSprite.ballColor = ballColor;
    
    ballSprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ballSprite.frame.size.width/2];
    ballSprite.physicsBody.friction = 0;
    ballSprite.physicsBody.restitution = 0;
    ballSprite.physicsBody.linearDamping = 0;
    ballSprite.position = position;
    
    ballCount++;
    
    
    SKAction *shrink = [SKAction scaleTo:0 duration:0];
    SKAction *magnify = [SKAction scaleTo:1 duration:POPANIMATIONDURATION];
    
    SKAction *sequence = [SKAction sequence:@[shrink,magnify]];
    
    
    [self addChild:ballSprite];
    
    [ballSprite runAction:sequence];
}

// returns an SKLabelNode with chosen text, color and a height offset.
// used for presenting rules to the gamer.

- (SKLabelNode *)gameLabelWithText:(NSString*)text ofColor:(UIColor*)color withHeightOffset:(NSInteger)offset{
    SKLabelNode *gameRuleLabel = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
    gameRuleLabel.text = text;
    gameRuleLabel.fontSize = 24;
    gameRuleLabel.fontColor = color;
    gameRuleLabel.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2 -180 - offset);
    gameRuleLabel.alpha = 0;
    
    SKAction *fadeIn = [SKAction fadeInWithDuration:1.2];
    SKAction *moveUpwards = [SKAction moveToY:self.scene.size.height/2-136 - offset duration:0.6];
    SKAction *group2 = [SKAction group:@[fadeIn,moveUpwards]];
    
    [gameRuleLabel runAction:group2];
    return gameRuleLabel;
    
}




-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.userInteractionEnabled = NO;
        self.backgroundColor = [SKColor whiteColor];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        
            [self userInteractionInTimeInterval:2.2];
            
     
        
        ballCount = 0;
        i=0;
        // Level two
        // Create 4 balls , two of same color and two of other same color.
        
        CGPoint center = CGPointMake(self.scene.size.width/2, self.scene.size.height/2);
        
        for (int i = -1 ; i < 2; i++) {
            for(int j = -1 ; j < 2 ; j++){
                
                CGPoint position = CGPointMake(center.x - 90*i, center.y - 90*j);
                if (j == -1) {
                    [self addBallwithPosition:position ofColor:GreenBall];
                }else if(j == 0)
                {
                    [self addBallwithPosition:position ofColor:BlueBall];
                }else{
                    [self addBallwithPosition:position ofColor:PurpleBall];
                }
                
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
    
    BallNode *touchedNode = (BallNode*)[self nodeAtPoint:location];
    
    

        if(![touchedNode isKindOfClass:[SKScene class]]){
        
        // if it's a new suit
        if(ballTouchCounter == 0){
            
            // get that suit color
            newSuitColor = touchedNode.ballColor;
            
            remainingBallsInASuit = 0;
            
            //get how many balls you have on screen of that particular color
            
            for (BallNode *ball in self.children) {
                
                if ([ball.ballColor isEqualToString:newSuitColor]) {

                    ballTouchCounter++;
                }
                
            }
            //animate and remove
            //animate and remove
            if ([touchedNode isKindOfClass:[BallNode class]]) {
                [self popBall:touchedNode];
                
                
            }
            
            ballCount--;
            ballTouchCounter--;
            
            //        BallNode *ball = [BallNode new];
            //        ball.position = [self randomPointOnScreen:self.scene.size forViewSize:ball.size];
            //        [self addChild:ball];
            
            
        }else{
            
            if ([touchedNode.ballColor isEqualToString:newSuitColor]) {
                //animate and remove
                //animate and remove
                if ([touchedNode isKindOfClass:[BallNode class]]) {
                    [self popBall:touchedNode];
                    
                    
                }
                
                ballTouchCounter--;
                ballCount--;
                
                
                
                
            }else {
            
//                NSString *warningText = [NSString stringWithFormat:@"you need to finish off"];
//                NSString *warningColorText;
//                
//                if ([newSuitColor isEqualToString:GreenBall]) {
//                    warningColorText = [NSString stringWithFormat:@"green balls first."];
//
//                }else if([newSuitColor isEqualToString:BlueBall]){
//                    warningColorText = [NSString stringWithFormat:@"blue balls first."];
//                }else{
//                    warningColorText = [NSString stringWithFormat:@"purple balls first."];
//                }
//                
//                SKLabelNode *warning = [self gameLabelWithText:warningText ofColor:warningColor withHeightOffset:60];
//                SKLabelNode *colorWarning = [self gameLabelWithText:warningColorText ofColor:warningColor withHeightOffset:90];
//                
//                SKAction *fadeOut = [SKAction fadeOutWithDuration:1.0];
//              
//                
//                [self addChild:warning];
//                [self addChild:colorWarning];
//                
//                
//                [warning runAction:fadeOut];
//                [colorWarning runAction:fadeOut];
//                
//                
//                [self deleteInTimeInterval:3 node:warning];
//                [self deleteInTimeInterval:3 node:colorWarning];
                NSLog(@"Touched node is not the same color as the suit");
                // Do nothing but make a little animation of some sort later
                i++;
                if (i==1) {
                    
                    SKLabelNode *gameRuleLabel = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
                    gameRuleLabel.text = @"follow the suit, or lose.";
                    gameRuleLabel.fontSize = 24;
                    gameRuleLabel.fontColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
                    gameRuleLabel.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2 -120);
                    gameRuleLabel.alpha = 0 ;
                    
                    SKAction *fadeIn = [SKAction fadeInWithDuration:1.0];
                    SKAction *moveUpwards = [SKAction moveToY:self.scene.size.height/2-176 duration:1.3];
                    
                    SKAction *group = [SKAction group:@[fadeIn,moveUpwards]];
                    
                    [gameRuleLabel runAction:group];
                    
                    [self addChild:gameRuleLabel];
                }
            }
            
            
        }
        
        if(ballCount == 0){
            
            
            NSLog(@"Entered");
            
                        self.userInteractionEnabled = NO;
            
            SKSpriteNode *whiteOverlay = [SKSpriteNode spriteNodeWithImageNamed:@"WhiteOverlay.png"];
            whiteOverlay.alpha=0;
            
            SKAction *fadeIn = [SKAction fadeAlphaTo:1 duration:0.5];
            
            [whiteOverlay runAction:fadeIn];
            
            [self addChild:whiteOverlay];
            
            //label depicting next level
            SKLabelNode *levelLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
            levelLabel.text = [NSString stringWithFormat:@"3"];
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




-(void)deleteInTimeInterval:(NSTimeInterval)timeInterval{
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:self
                                   selector:@selector(removeFromParent)
                                   userInfo:nil
                                    repeats:NO];
    
    
}

-(void)segueInTimeInterval:(NSTimeInterval)timeInterval{
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:self
                                   selector:@selector(segueToNextLevel)
                                   userInfo:nil
                                    repeats:NO];
    
}

-(void)deleteInTimeInterval:(NSTimeInterval)timeInterval node:(SKNode*)node{
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:node
                                   selector:@selector(removeFromParent)
                                   userInfo:nil
                                    repeats:NO];
    
    
}


-(void)segueToNextLevel{
    
    // remove the passed level from memory.
    // self.scene = nil;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        LevelFour *newScene = [[LevelFour alloc] initWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
        [self.view presentScene:newScene transition:transition];
    });
    
    
    
}


-(void)userInteractionInTimeInterval:(NSTimeInterval)timeInterval{
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:self
                                   selector:@selector(enableTouches)
                                   userInfo:nil
                                    repeats:NO];
    
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


@end
