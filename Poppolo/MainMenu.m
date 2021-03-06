//
//  MainMenu.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/23/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "MainMenu.h"
#import "GameData.h"
#import "SKButton.h"
#import "LevelSelect.h"
#import "EndlessLevel.h"

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
        
       
       
        
        // play button
        
        SKButton *backButton = [[SKButton alloc] initWithImageNamedNormal:@"TransparentButton" selected:@"TransparentButton"];
        [backButton setPosition:CGPointMake(self.scene.size.width/2, self.scene.size.height/2-40)];
        [backButton.title setText:@"play"];
        [backButton.title setFontName:@"Helvetica"];
        [backButton.title setFontSize:20.0];
        [backButton.title setFontColor:instructionColor];
        [backButton setTouchUpInsideTarget:self action:@selector(resumeLevel)];
        [self addChild:backButton];
        
        // set the ad counter
        
        [GameData sharedGameData].adShowCount = 0;
        
        SKLabelNode *gameRuleLabel2 = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
        gameRuleLabel2.text = @"pop a ball";
        gameRuleLabel2.fontSize = 20;
        gameRuleLabel2.fontColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1.0];
        gameRuleLabel2.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2 -90);
        gameRuleLabel2.alpha = 0 ;
        
        SKAction *fadeIn2 = [SKAction fadeInWithDuration:1.8];
        SKAction *moveUpwards2 = [SKAction moveToY:self.scene.size.height/2-126 duration:1.4];
        
        SKAction *group2 = [SKAction group:@[fadeIn2,moveUpwards2]];
        
        [gameRuleLabel2 runAction:group2];
        
        
        [self addChild:gameRuleLabel2];

        
        
        
        SKLabelNode *gameRuleLabel = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
        gameRuleLabel.text = @"follow the same color";
        gameRuleLabel.fontSize = 20;
        gameRuleLabel.fontColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1.0];
        gameRuleLabel.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2 -120);
        gameRuleLabel.alpha = 0 ;
        
        SKAction *fadeIn3 = [SKAction fadeInWithDuration:1.8];
        SKAction *moveUpwards3 = [SKAction moveToY:self.scene.size.height/2-156 duration:1.4];
        
        SKAction *group3 = [SKAction group:@[fadeIn3,moveUpwards3]];
        
        [gameRuleLabel runAction:group3];
        
        [self addChild:gameRuleLabel];
        
        
        
        
        SKLabelNode *gameRuleLabel5 = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
        gameRuleLabel5.text = @"when one color is done, pop another ball";
        gameRuleLabel5.fontSize = 20;
        gameRuleLabel5.fontColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1.0];
        gameRuleLabel5.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2 -120);
        gameRuleLabel5.alpha = 0 ;
        
        SKAction *fadeIn5 = [SKAction fadeInWithDuration:1.8];
        SKAction *moveUpwards5 = [SKAction moveToY:self.scene.size.height/2-186 duration:1.4];
        
        SKAction *group5 = [SKAction group:@[fadeIn5,moveUpwards5]];
        
        [gameRuleLabel5 runAction:group5];
        
        [self addChild:gameRuleLabel5];
        
        
        SKLabelNode *gameRuleLabel4 = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
        gameRuleLabel4.text = [NSString stringWithFormat:@"high score: %li", [GameData sharedGameData].highScore];
        gameRuleLabel4.fontSize = 20;
        gameRuleLabel4.fontColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1.0];
        gameRuleLabel4.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2 +180);
        gameRuleLabel4.alpha = 0 ;
        
        SKAction *fadeIn4 = [SKAction fadeInWithDuration:1.8];
        SKAction *group4 = [SKAction group:@[fadeIn4]];
        [gameRuleLabel4 runAction:group4];
        
        [self addChild:gameRuleLabel4];
      
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
        EndlessLevel *newScene = [[EndlessLevel alloc] initWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
        [self.view presentScene:newScene transition:transition];
    });
    
    
    
    
}


-(void)segueToEndlessLevel{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        EndlessLevel *newScene = [[EndlessLevel alloc] initWithSize:self.scene.size];
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


#pragma mark - remove ads


-(void)provideContent:(NSString *)contentId{
    
    // unlock endless mode
    
    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:contentId];
    
    
}


@end
