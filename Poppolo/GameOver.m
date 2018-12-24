//
//  GameOver.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/23/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "GameOver.h"
#import "LevelSelect.h"
#import "EndlessLevel.h"



@interface GameOver(){
    
}

@end

@implementation GameOver


-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        //self.userInteractionEnabled = NO;
        
        //shows ad at the end of each game session.
        
        [GameData sharedGameData].adShowCount += 1;
        
        if ([GameData sharedGameData].adShowCount %2 == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showAd" object:nil];
        }

        
        self.backgroundColor = [SKColor whiteColor];
        
        
        SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        gameOverLabel.text = [NSString stringWithFormat:@"game over"];
        gameOverLabel.fontSize = 48;
        gameOverLabel.fontColor = warningColor;
        gameOverLabel.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2 +60);
        gameOverLabel.alpha = 1 ;
        

        [self addChild:gameOverLabel];
        
        // restart button
        
        SKButton *backButton = [[SKButton alloc] initWithImageNamedNormal:@"TransparentButton" selected:@"TransparentButton"];
        [backButton setPosition:CGPointMake(self.scene.size.width/2, self.scene.size.height/2-40)];
        [backButton.title setText:@"restart"];
        [backButton.title setFontName:@"Helvetica"];
        [backButton.title setFontSize:20.0];
        [backButton.title setFontColor:instructionColor];
        [backButton setTouchUpInsideTarget:self action:@selector(restartLevel)];
        [self addChild:backButton];
        
        
        // main menu
        
        SKButton *mainMenuButton = [[SKButton alloc] initWithImageNamedNormal:@"TransparentButton" selected:@"TransparentButton"];
        [mainMenuButton setPosition:CGPointMake(self.scene.size.width/2, self.scene.size.height/2-100)];
        [mainMenuButton.title setText:@"main menu"];
        [mainMenuButton.title setFontName:@"Helvetica"];
        [mainMenuButton.title setFontSize:20.0];
        [mainMenuButton.title setFontColor:instructionColor];
        [mainMenuButton setTouchUpInsideTarget:self action:@selector(mainMenu)];
        [self addChild:mainMenuButton];
        
        // score label
        
        SKLabelNode *gameRuleLabel4 = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
        gameRuleLabel4.text = [NSString stringWithFormat:@"you scored: %li", [GameData sharedGameData].score];
        gameRuleLabel4.fontSize = 24;
        gameRuleLabel4.fontColor = instructionColor;
        gameRuleLabel4.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2 +180);
        gameRuleLabel4.alpha = 0 ;
        
        SKAction *fadeIn4 = [SKAction fadeInWithDuration:1.8];
        SKAction *group4 = [SKAction group:@[fadeIn4]];
        [gameRuleLabel4 runAction:group4];
        
        [self addChild:gameRuleLabel4];
        
        
        
        
    }
    return self;
}


-(void)restartLevel{
    
    EndlessLevel *newScene = [[EndlessLevel alloc] initWithSize:self.scene.size];
    SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
    [self.view presentScene:newScene transition:transition];

   


}


-(void)mainMenu{
    
    MainMenu *newScene = [[MainMenu alloc] initWithSize:self.scene.size];
    SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
    [self.view presentScene:newScene transition:transition];
    
    
    
    
}

-(void) segueToLevelSelect
{
    MainMenu *newScene = [[MainMenu alloc] initWithSize:self.scene.size];
    SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
    [self.view presentScene:newScene transition:transition];
   
    
}


@end
