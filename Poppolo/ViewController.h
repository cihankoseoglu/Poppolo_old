//
//  ViewController.h
//  Poppolo
//

//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
@import GoogleMobileAds;


@interface ViewController : UIViewController  <UIPickerViewDataSource , UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;



//@property (weak,nonatomic) IBOutlet UIPickerView *levelPickerView;

@end
