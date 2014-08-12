//
//  LevelTwo.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/21/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "LevelTwo.h"
#import "LevelThree.h"


@interface LevelTwo(){
    

    NSMutableArray *suitBallsOnScreen;
    NSUInteger ballTouchCounter;
    NSUInteger remainingBallsInASuit;
    NSString *newSuitColor;
    NSDate *firstTime;
    NSUInteger ballCount;
    
    BOOL clickedYellow;
    BOOL clickedPink;
    
    
    
}

@end

@implementation LevelTwo


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
    
    
    
    [self addChild:ballSprite];
    
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor whiteColor];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        remainingBallsInASuit = 0;
        ballCount = 0;
        
        clickedPink = NO;
        clickedYellow = NO;
        
        
        // Level two
        // Create 4 balls , two of same color and two of other same color.
        
        CGPoint centerMinus60 = CGPointMake(self.scene.size.width/2-60, self.scene.size.height/2-60);
        CGPoint centerPlus60 = CGPointMake(self.scene.size.width/2+60, self.scene.size.height/2-60);
        CGPoint centerSMinus60 = CGPointMake(self.scene.size.width/2-60, self.scene.size.height/2+60);
        CGPoint centerSPlus60 = CGPointMake(self.scene.size.width/2+60, self.scene.size.height/2+60);
        
        [self addBallwithPosition:centerSMinus60 ofColor:YellowBall];
        [self addBallwithPosition:centerSPlus60 ofColor:YellowBall];
        [self addBallwithPosition:centerMinus60 ofColor:PinkBall];
        [self addBallwithPosition:centerPlus60 ofColor:PinkBall];
        
        
        
        SKLabelNode *gameRuleLabel = [self gameLabelWithText:@"pop a yellow ball" ofColor:instructionColor withHeightOffset:0];
        
        [self addChild:gameRuleLabel];
        
        
    }
    return self;
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
    SKAction *moveUpwards = [SKAction moveToY:self.scene.size.height/2-136 - offset duration:1.2];
    SKAction *group2 = [SKAction group:@[fadeIn,moveUpwards]];
    
    [gameRuleLabel runAction:group2];
    return gameRuleLabel;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    
    
    NSLog(@"touchLocation x: %f and y: %f", location.x, location.y);
    BallNode *touchedNode = (BallNode*)[self nodeAtPoint:location];
    
    if(touchedNode != self){
        // if it's a new suit
        
        for (SKLabelNode *label in self.children) {
            
            if([label isKindOfClass:[SKLabelNode class]]){
          
                [self deleteInTimeInterval:0.3 node:label];
                
            }
            
        }

        
        
        // If the user pops a yellow ball
        if ([touchedNode.ballColor isEqualToString:YellowBall]) {
            
            for (SKLabelNode *label in self.children) {
                
                if([label isKindOfClass:[SKLabelNode class]]){
                    
                    SKAction *fadeOut = [SKAction fadeOutWithDuration:0.2];
                    [label runAction:fadeOut];
                    [self deleteInTimeInterval:2 node:label];
                    
                }
                
            }
            

            
            // get that suit color ( which is yellow this level )
            newSuitColor = touchedNode.ballColor;
            
            // 1 yellow left
            remainingBallsInASuit = 1;
            
            
            
            
            if (clickedYellow == NO) {
                
                SKLabelNode *gameRuleLabel;
                gameRuleLabel = [self gameLabelWithText:@"now try a pink one" ofColor:instructionColor withHeightOffset:0];
                
                clickedYellow = YES;
                            ballCount--;
                [self addChild:gameRuleLabel];
                
                //animate and remove
                if ([touchedNode isKindOfClass:[BallNode class]]) {
                    [self popBall:touchedNode];
                    
                    
                }
                
                
                
            }else{
                //this is the second time we're clicking the yellow after popping the first one
                
                for (SKLabelNode *label in self.children) {
                    
                    if([label isKindOfClass:[SKLabelNode class]]){
                        
                        SKAction *fadeOut = [SKAction fadeOutWithDuration:0.2];
                        
                        [label runAction:fadeOut];
                        
                        [self deleteInTimeInterval:2 node:label];
                        
                    }
                    
                }
                

                SKLabelNode *finishPinks = [self gameLabelWithText:@"finish off the pinks" ofColor:instructionColor withHeightOffset:30];
                //animate and remove
                if ([touchedNode isKindOfClass:[BallNode class]]) {
                    [self popBall:touchedNode];
                    
                    
                }
                
                ballCount--;
                
                [self addChild:finishPinks];
                remainingBallsInASuit = 0;
                newSuitColor = PinkBall;
                
            }
            
            
            
        }else{
            
            //user tries to pop a pink ball
            if (ballCount <= 2) {
                
                //animate and remove
                if ([touchedNode isKindOfClass:[BallNode class]]) {
                    [self popBall:touchedNode];
                    
                    
                }
                
                ballCount--;
                
            }else{
            for (SKLabelNode *label in self.children) {
                
                if([label isKindOfClass:[SKLabelNode class]]){
                    
                    
                    SKAction *fadeOut = [SKAction fadeOutWithDuration:0.2];
                    
                    [label runAction:fadeOut];
                    
                    [self deleteInTimeInterval:2 node:label];
                   
                }
                
            }
             
            
            if (clickedYellow == NO) {
                SKLabelNode *rebel1 = [self gameLabelWithText:@"you rebel" ofColor:warningColor withHeightOffset:0];
                [self addChild:rebel1];
                
                SKLabelNode *rebel2 = [self gameLabelWithText:@"pop a yellow ball" ofColor:warningColor withHeightOffset:30];
                
                [self addChild:rebel2];
                
                
                
                
                
            }else{
                
                SKLabelNode *rebel1 =[self gameLabelWithText:@"oops. you need to" ofColor:warningColor withHeightOffset:0];
                
                [self addChild:rebel1];
                
                
                SKLabelNode *rebel2 = [self gameLabelWithText:@"finish popping yellows first" ofColor:warningColor withHeightOffset:30];
                [self addChild:rebel2];
                
                
            }
        }
        
        }
        
        
        
        
        // Level completed
        if (ballCount ==0) {
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
        
        
        
    }else {
        
        NSLog(@"Touched node is not the same color as the suit");
        // Do nothing but make a little animation of some sort later
    }
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    
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
        LevelThree *newScene = [[LevelThree alloc] initWithSize:self.scene.size];
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



@end
