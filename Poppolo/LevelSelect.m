//
//  LevelSelect.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/23/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "LevelSelect.h"

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

-(void)changeLevelWithTimeInterval:(NSTimeInterval)timeInterval withLevel:(NSUInteger)level{
    
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:self
                                   selector:@selector(changeLevel:)
                                   userInfo:nil
                                    repeats:NO];
}

-(void)changeLevel:(NSUInteger)level{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        LevelSelect *newScene = [[LevelSelect alloc] initWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
        [self.view presentScene:newScene transition:transition];
    });
    
    
    
}

@end
