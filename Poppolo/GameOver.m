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

#import "LevelSeven.h"
#import "LevelEight.h"
#import "LevelNine.h"
#import "LevelTen.h"

#import "LevelEleven.h"
#import "LevelTwelve.h"
#import "LevelThirteen.h"
#import "LevelFourteen.h"
#import "LevelFifteen.h"
#import "LevelSixteen.h"
#import "LevelSeventeen.h"
#import "LevelEighteen.h"
#import "LevelNineteen.h"
#import "LevelTwenty.h"

@interface GameOver(){
    
}

@end

@implementation GameOver


-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
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
        
//        // level select button
//        
//        SKButton *levelSelectButton = [[SKButton alloc] initWithImageNamedNormal:@"TransparentButton" selected:@"TransparentButton"];
//        [levelSelectButton setPosition:CGPointMake(self.scene.size.width/2, self.scene.size.height/2-120)];
//        [levelSelectButton.title setText:@"level select"];
//        [levelSelectButton.title setFontName:@"Helvetica"];
//        [levelSelectButton.title setFontSize:20.0];
//        [levelSelectButton.title setFontColor:instructionColor];
//        [levelSelectButton setTouchUpInsideTarget:self action:@selector(segueToLevelSelect)];
//        [self addChild:levelSelectButton];
        
        
        
        
        
        
    }
    return self;
}

// I hate myself for typing out such a method.

-(void)restartLevel{
    
    EndlessLevel *newScene = [[EndlessLevel alloc] initWithSize:self.scene.size];
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
