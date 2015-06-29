//
//  AppDelegate.h
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/4/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreHelper.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    
    StoreHelper *storeManager;
}

@property (strong, nonatomic) UIWindow *window;

-(void)unlockEndlessMode;

@end
