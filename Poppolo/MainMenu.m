//
//  MainMenu.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/23/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "MainMenu.h"
#import "SKButton.h"
#import "LevelOne.h"
#import "LevelSelect.h"

@implementation MainMenu

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor whiteColor];
        
        
        

        
        SKSpriteNode *logoNode = [SKSpriteNode spriteNodeWithImageNamed:@"PoppoloLogo"];
        logoNode.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2+70);
        
        [self addChild:logoNode];
        
        SKAction *fadeIn = [SKAction fadeInWithDuration:2];
        [logoNode runAction:fadeIn];
        
        // restart button
        
        SKButton *backButton = [[SKButton alloc] initWithImageNamedNormal:@"TransparentButton" selected:@"TransparentButton"];
        [backButton setPosition:CGPointMake(self.scene.size.width/2, self.scene.size.height/2-40)];
        [backButton.title setText:@"play"];
        [backButton.title setFontName:@"Helvetica"];
        [backButton.title setFontSize:20.0];
        [backButton.title setFontColor:instructionColor];
        [backButton setTouchUpInsideTarget:self action:@selector(resumeLevel)];
        [self addChild:backButton];
        
        // level select button
        
        SKButton *levelSelectButton = [[SKButton alloc] initWithImageNamedNormal:@"TransparentButton" selected:@"TransparentButton"];
        [levelSelectButton setPosition:CGPointMake(self.scene.size.width/2, self.scene.size.height/2-120)];
        [levelSelectButton.title setText:@"level select"];
        [levelSelectButton.title setFontName:@"Helvetica"];
        [levelSelectButton.title setFontSize:20.0];
        [levelSelectButton.title setFontColor:instructionColor];
        [levelSelectButton setTouchUpInsideTarget:self action:@selector(selectLevel)];
        [self addChild:levelSelectButton];
        
        
        SKSpriteNode *whiteOverlay = [SKSpriteNode spriteNodeWithImageNamed:@"WhiteOverlay.png"];
        whiteOverlay.alpha = 1;
        whiteOverlay.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2);
        
        [self addChild:whiteOverlay];
        
        
        SKAction *fadeOut = [SKAction fadeAlphaTo:0 duration:1];
        
        [whiteOverlay runAction:fadeOut];
        
        [self removeNodeWithTimeInterval:whiteOverlay :1.4];
        
    }
    return self;
}

-(void)resumeLevel{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        LevelOne *newScene = [[LevelOne alloc] initWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
        [self.view presentScene:newScene transition:transition];
    });
    
    
    
    
}

-(void)selectLevel{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        LevelSelect *newScene = [[LevelSelect alloc] initWithSize:self.scene.size];
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


@end
