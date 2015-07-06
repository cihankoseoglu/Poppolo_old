//
//  ViewController.h
//  Poppolo
//

//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
@import GoogleMobileAds;



@interface ViewController : UIViewController  <GADInterstitialDelegate>



@property (nonatomic, strong) GADInterstitial *gadInterstitial;


//@property (weak,nonatomic) IBOutlet UIPickerView *levelPickerView;

@end
