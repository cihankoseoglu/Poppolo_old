
//
//  CodeSnippets.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/21/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "CodeSnippets.h"

@implementation CodeSnippets

/* CODE SNIPPET FOR CREATING BALLS IN A DOUBLE FOUR LOOP GIVEN A POINT */

//CGPoint centerMinus40 = CGPointMake(self.scene.size.width/2-40, self.scene.size.height/2-40);
//
//for (int i = 0 ; i < 2; i++) {
//    
//    for (int j = 0; j < 2; j++) {
//        BallNode* ballSprite = [[BallNode alloc] init];
//        
//        ballSprite.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ballSprite.frame.size.width/2];
//        ballSprite.physicsBody.friction = 0;
//        ballSprite.physicsBody.restitution = 0;
//        ballSprite.physicsBody.linearDamping = 0;
//        ballSprite.position = centerMinus40;
//        
//        [self addChild:ballSprite];
//        ballCount++;
//        
//        centerMinus40.y += 80;
//        
//    }
//    
//    centerMinus40.x += 80;
//    centerMinus40.y -= 160;
//    
//}






// Level two touches began



 
 //-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
 /* Called when a touch begins */

/*

UITouch *touch = [touches anyObject];
CGPoint location = [touch locationInNode:self];

SKAction *fadeOut = [SKAction fadeOutWithDuration:0.5];
SKAction *goDown = [SKAction moveByX:0 y:-10 duration:0.5];
SKAction *group = [SKAction group:@[fadeOut,goDown]];

NSLog(@"touchLocation x: %f and y: %f", location.x, location.y);
BallNode *touchedNode = (BallNode*)[self nodeAtPoint:location];

if(touchedNode != self){
    // if it's a new suit
    
    
    // If the user pops a yellow ball
    if ([touchedNode.ballColor isEqualToString:YellowBall]) {
        
        for (SKLabelNode *label in self.children) {
            
            if([label isKindOfClass:[SKLabelNode class]]){
                [label runAction:group];
                
                [self deleteInTimeInterval:2 node:label];
                
                
            }
            
        }
        
        ballCount--;
        
        // get that suit color ( which is yellow this level )
        newSuitColor = touchedNode.ballColor;
        
        // 1 yellow left
        remainingBallsInASuit = 1;
        
        [touchedNode removeFromParent];
        
        if (clickedYellow == NO) {
            
            SKLabelNode *gameRuleLabel;
            gameRuleLabel = [self gameLabelWithText:@"now try a pink one" ofColor:instructionColor withHeightOffset:0];
            
            clickedYellow = YES;
            
            [self addChild:gameRuleLabel];
            
            
        }else{
            
            
            for (SKLabelNode *label in self.children) {
                
                if([label isKindOfClass:[SKLabelNode class]]){
                    [label runAction:group];
                    
                    [self deleteInTimeInterval:2 node:label];
                    
                }
                
            }
            
            
            
            SKLabelNode *finishPinks;
            
            finishPinks = [self gameLabelWithText:@"finish off the pinks" ofColor:instructionColor withHeightOffset:0];
            
            clickedYellow = YES;
            
            [self addChild:finishPinks];
            remainingBallsInASuit = 0;
            newSuitColor = PinkBall;
            
        }
        
        
        
    }else{
        
        //user tries to pop a pink ball
        if (ballCount == 2) {
            
            [self removeFromParent];
            
            
        }else{
            for (SKLabelNode *label in self.children) {
                
                if([label isKindOfClass:[SKLabelNode class]]){
                    [label runAction:group];
                    
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
        
        
        SKSpriteNode *whiteOverlay = [SKSpriteNode spriteNodeWithImageNamed:@"WhiteOverlay.png"];
        whiteOverlay.alpha=0;
        
        SKAction *fadeIn = [SKAction fadeAlphaTo:1 duration:0.5];
        
        [whiteOverlay runAction:fadeIn];
        
        [self addChild:whiteOverlay];
        
        [self segueInTimeInterval:2];
        
        
        
        
        
    }
    
    
    
    
    
    
    
    //        BallNode *ball = [BallNode new];
    //        ball.position = [self randomPointOnScreen:self.scene.size forViewSize:ball.size];
    //        [self addChild:ball];
    
    
}else {
    
    NSLog(@"Touched node is not the same color as the suit");
    // Do nothing but make a little animation of some sort later
}






}


 */

@end
