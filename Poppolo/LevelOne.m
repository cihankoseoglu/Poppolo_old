//
//  LevelOne.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/19/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "LevelOne.h"
#import "LevelThree.h"

@interface LevelOne(){
    
    NSArray *ballSuits;
    NSMutableArray *suitBallsOnScreen;
    NSUInteger ballTouchCounter;
    NSUInteger remainingBallsInASuit;
    NSString *newSuitColor;
    NSDate *firstTime;
    NSUInteger ballCount;

    
}

@end

@implementation LevelOne


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor whiteColor];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        
        SKSpriteNode *whiteOverlay = [SKSpriteNode spriteNodeWithImageNamed:@"WhiteOverlay.png"];
        whiteOverlay.alpha = 1;
        whiteOverlay.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2);
        
        [self addChild:whiteOverlay];
        
        
        SKAction *fadeOut = [SKAction fadeAlphaTo:0 duration:2];
        
        [whiteOverlay runAction:fadeOut];
        [self removeNodeWithTimeInterval:whiteOverlay :4];
        [self userInteractionInTimeInterval:2.1];

        
        
        
        ballTouchCounter = 0;
        ballCount = 0;
        
        BallNode* ballSprite = [[BallNode alloc] init];

        ballSprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ballSprite.frame.size.width/2];
        ballSprite.physicsBody.friction = 0;
        ballSprite.physicsBody.restitution = 0;
        ballSprite.physicsBody.linearDamping = 0;
        ballSprite.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2);
        
        [self addChild:ballSprite];
                ballCount++;
        
        SKLabelNode *gameRuleLabel = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
        gameRuleLabel.text = @"pop the ball.";
        gameRuleLabel.fontSize = 24;
        gameRuleLabel.fontColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        gameRuleLabel.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2 -120);
        gameRuleLabel.alpha = 0 ;
        
        SKAction *fadeIn = [SKAction fadeInWithDuration:2.4];
        SKAction *moveUpwards = [SKAction moveToY:self.scene.size.height/2-96 duration:3.0];
        
        SKAction *group = [SKAction group:@[fadeIn,moveUpwards]];
        
        [gameRuleLabel runAction:group];

        
    
        
        [self addChild:gameRuleLabel];

        
        SKLabelNode *gameRuleLabel2 = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
        gameRuleLabel2.text = @"this is a simple game.";
        gameRuleLabel2.fontSize = 24;
        gameRuleLabel2.fontColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
        gameRuleLabel2.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2 -120);
        gameRuleLabel2.alpha = 0 ;
        
        SKAction *fadeIn2 = [SKAction fadeInWithDuration:2.4];
        SKAction *moveUpwards2 = [SKAction moveToY:self.scene.size.height/2-66 duration:3.0];
        
        SKAction *group2 = [SKAction group:@[fadeIn2,moveUpwards2]];
        
        [gameRuleLabel2 runAction:group2];
        
        
        
        
        [self addChild:gameRuleLabel2];
        
        
        
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
        
        //animate and remove
        if ([touchedNode isKindOfClass:[BallNode class]]) {
            [self popBall:touchedNode];
            
            
        }
        
        
        SKAction *fadeOut = [SKAction fadeOutWithDuration:1];
        SKAction *goDown = [SKAction moveByX:0 y:-10 duration:1];
        SKAction *group = [SKAction group:@[fadeOut,goDown]];
        
        for (SKLabelNode *label in self.children) {
            if([label isKindOfClass:[SKLabelNode class]]){
                
                [label runAction:group];
                
                [self deleteInTimeInterval:3 node:label];
                
                ballCount--;
            }
            
            
        
            
            // Level completed
            if (ballCount ==0) {
                NSLog(@"Entered");
                
                
                //white overlay
                SKSpriteNode *whiteOverlay = [SKSpriteNode spriteNodeWithImageNamed:@"WhiteOverlay.png"];
                whiteOverlay.alpha=0;
                SKAction *fadeIn = [SKAction fadeAlphaTo:1 duration:0.5];
                [whiteOverlay runAction:fadeIn];
                
                //label depicting next level
                SKLabelNode *levelLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
                levelLabel.text = [NSString stringWithFormat:@"2"];
                levelLabel.fontSize = 60;
                levelLabel.fontColor = levelPassColor;
                levelLabel.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2 );
                levelLabel.alpha = 0 ;
                
                [levelLabel runAction:fadeIn];

            
                
                [self addChild:whiteOverlay];
                [self addChild:levelLabel];
                
                
                [self segueInTimeInterval:2];
                
            
               
                
                
            }
            
        
        }
            
        
        
        
            //        BallNode *ball = [BallNode new];
            //        ball.position = [self randomPointOnScreen:self.scene.size forViewSize:ball.size];
            //        [self addChild:ball];
            
            
        }else {
                
                NSLog(@"Touched node is not the same color as the suit");
                // Do nothing but make a little animation of some sort later
            }
            
    
    
    
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    
}

-(void)deleteInTimeInterval:(NSTimeInterval)timeInterval node:(SKNode*)node{
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
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

-(void)segueToNextLevel{
   
    // remove the passed level from memory.
    // self.scene = nil;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        LevelThree *newScene = [[LevelThree alloc] initWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
        [self.view presentScene:newScene transition:transition];
    });
    
   
    
}

-(void)removeNodeWithTimeInterval:(SKNode*)node :(NSTimeInterval)timeInterval{
    
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:node
                                   selector:@selector(removeFromParent)
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

-(void)enableTouches{
    
    self.userInteractionEnabled = YES;
    
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
