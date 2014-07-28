//
//  LevelSelect.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/23/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "LevelSelect.h"

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


@interface LevelSelect(){
    
    NSMutableArray *levelData;
}

@end

@implementation LevelSelect

-(void)didMoveToView:(SKView *)view{
    
    
    levelData = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i++) {
        NSString* levelString = [NSString stringWithFormat:@"%i",i];
        [levelData addObject:levelString];
    }
 
    
    self.levelPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,162,320,self.size.height)];
    self.levelPickerView.alpha = 0.4;
    
    
    self.levelPickerView.dataSource = self;
    self.levelPickerView.delegate = self;
    
    self.levelPickerView.showsSelectionIndicator = NO;
    [self.view addSubview:self.levelPickerView];
    
}


-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor whiteColor];
   
        
        
        
        
    }
    return self;
}


-(void)removeNodeWithTimeInterval:(SKNode*)node :(NSTimeInterval)timeInterval{
    
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:node
                                   selector:@selector(removeFromParent)
                                   userInfo:nil
                                    repeats:NO];
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return levelData.count;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return levelData[row];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    [self changeLevelWithTimeInterval:1 withLevel:row+1];
    
    
}

-(void)changeLevel:(NSNumber*)levelNumber{
    
    int levelNum = [levelNumber intValue];
    NSString *level = [NSString stringWithFormat:@"%d",levelNum];
    
 
    
    // remove the levelSelect picker view
    
    [self.levelPickerView removeFromSuperview];
    
    
    SKSpriteNode *whiteOverlay = [SKSpriteNode spriteNodeWithImageNamed:@"WhiteOverlay.png"];
    whiteOverlay.alpha=0;
    
    SKAction *fadeIn = [SKAction fadeAlphaTo:1 duration:1.2];
    
    [whiteOverlay runAction:fadeIn];
    
    [self addChild:whiteOverlay];
    
    //label depicting next level
    SKLabelNode *levelLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    levelLabel.text = level;
    levelLabel.fontSize = 60;
    levelLabel.fontColor = levelPassColor;
    levelLabel.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2 );
    levelLabel.alpha = 0 ;
    
    [levelLabel runAction:fadeIn];
    [self addChild:levelLabel];
    

    // segue to level in other thread
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([level isEqualToString:@"7"]) {
            
            LevelSeven *newScene = [[LevelSeven alloc] initWithSize:self.scene.size];
            SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
            [self.view presentScene:newScene transition:transition];
            
        }
        
        else if ([level isEqualToString:@"8"]) {
            LevelEight *newScene = [[LevelEight alloc] initWithSize:self.scene.size];
            SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
            [self.view presentScene:newScene transition:transition];
            
        }
        else if ([level isEqualToString:@"9"]) {
            LevelNine *newScene = [[LevelNine alloc] initWithSize:self.scene.size];
            SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
            [self.view presentScene:newScene transition:transition];
            
        }
        
        else if ([level isEqualToString:@"10"]) {
            LevelTen *newScene = [[LevelTen alloc] initWithSize:self.scene.size];
            SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
            [self.view presentScene:newScene transition:transition];
            
        }
        
        else if ([level isEqualToString:@"11"]) {
            LevelEleven *newScene = [[LevelEleven alloc] initWithSize:self.scene.size];
            SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
            [self.view presentScene:newScene transition:transition];
            
        }
        
        else if ([level isEqualToString:@"12"]) {
            LevelTwelve *newScene = [[LevelTwelve alloc] initWithSize:self.scene.size];
            SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
            [self.view presentScene:newScene transition:transition];
            
        }else{
            
            
        }

    });
    
    
    
}

-(void)changeLevelWithTimeInterval:(NSTimeInterval)timeInterval withLevel:(NSUInteger)level{
    
    NSNumber *levelNumber = [NSNumber numberWithInt:(int)level];
    
    [self performSelector:@selector(changeLevel:) withObject:levelNumber afterDelay:timeInterval];
}



@end
