//
//  MainMenu.h
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/23/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <StoreKit/StoreKit.h>

@interface MainMenu : SKScene <SKProductsRequestDelegate, SKPaymentTransactionObserver, SKRequestDelegate,UIAlertViewDelegate>


-(void) completeTransaction: (SKPaymentTransaction *)transaction;
-(void) restoreTransaction: (SKPaymentTransaction *)transaction;
-(void) failedTransaction: (SKPaymentTransaction *)transaction;
-(void) recordTransaction: (SKPaymentTransaction *)transaction;
-(void) provideContent: (NSString *)contentId;
-(void) makePurchase;
-(void) requestProductData;

@end
