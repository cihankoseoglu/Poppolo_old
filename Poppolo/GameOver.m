//
//  GameOver.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/23/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "GameOver.h"

@interface GameOver(){
    
    id level;
    
}

@end

@implementation GameOver


-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor whiteColor];
        
        // the level user failed
        
        level = [self.scene.userData objectForKey:@"level"];
        //label depicting next level
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
        
        // level select button
        
        SKButton *levelSelectButton = [[SKButton alloc] initWithImageNamedNormal:@"TransparentButton" selected:@"TransparentButton"];
        [levelSelectButton setPosition:CGPointMake(self.scene.size.width/2, self.scene.size.height/2-120)];
        [levelSelectButton.title setText:@"level select"];
        [levelSelectButton.title setFontName:@"Helvetica"];
        [levelSelectButton.title setFontSize:20.0];
        [levelSelectButton.title setFontColor:instructionColor];
        [levelSelectButton setTouchUpInsideTarget:self action:@selector(restartLevel)];
        [self addChild:levelSelectButton];
        
        
        
        
        
        
    }
    return self;
}

-(void)restartLevel{
    
    NSLog(@"restart the level %@", level );
}



@end
