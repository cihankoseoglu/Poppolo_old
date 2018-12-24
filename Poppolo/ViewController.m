//
//  ViewController.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/4/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"

#import "MainMenu.h"

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"hideAd" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"showAd" object:nil];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
    
    
    NSLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
    self.gadInterstitial = [self createAndLoadInterstitial];


    
    
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

//- (NSUInteger)supportedInterfaceOrientations
//{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//    } else {
//        return UIInterfaceOrientationMaskAll;
//    }
//}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - Admob Interstitial
-(void)interstitialDidReceiveAd:(GADInterstitial *)ad{
    [ad presentFromRootViewController:self];
    
}

-(GADInterstitial*)createAndLoadInterstitial{
    GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-2625695451857163/7046930530"];
    interstitial.delegate = self;
    [interstitial loadRequest:[GADRequest request]];
    return interstitial;

}


-(void)interstitialDidDismissScreen:(GADInterstitial *)interstitial{
    interstitial = [self createAndLoadInterstitial];
}


-(void)readyInterstitial{
    GADInterstitial* newInterstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-2625695451857163/7046930530"];
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[@"439f8ddf1a8d7601d5478939c3263326"];
    [newInterstitial loadRequest:request];
    
    if ([newInterstitial isReady]) {
        [newInterstitial presentFromRootViewController:self];
    }
}


#pragma mark - Handle Local notifications

-(void)handleNotification:(NSNotification*)notification{
    
    if ([notification.name isEqualToString:@"readyAd"]){
        
       // [self readyInterstitial];
        

    }else if([notification.name isEqualToString:@"showAd"]){
       self.gadInterstitial = [self createAndLoadInterstitial];
    }
}


@end
