//
//  ViewController.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/4/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "ViewController.h"
#import "LevelOne.h"
#import "LevelEleven.h"
#import "LevelSeven.h"
#import "SecretLevelOne.h"
#import "LevelFive.h"
#import "LevelFour.h"
#import "LevelTwo.h"
#import "LevelTen.h"
#import "MyScene.h"
#import "LevelThree.h"
#import "MainMenu.h"
#import "LevelSix.h"
#import "GenericScene.h"
#import "EndlessLevel.h"



@interface ViewController(){
    
    NSMutableArray *levelData;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    NSLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
   
    
    // Create and configure the scene.
    
    // This is going to be main menu in the final but for debugging
    // Just load the level
    MainMenu * scene = [MainMenu sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}




@end
