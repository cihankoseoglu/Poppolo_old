//
//  StoreHelper.h
//  Poppolo
//
//  Created by Cihan Köseoğlu on 8/23/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface StoreHelper : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver, SKRequestDelegate,UIAlertViewDelegate>{
    
    NSString *currentPurchase;
    UIAlertView *alert;
}

-(void) completeTransaction: (SKPaymentTransaction *)transaction;
-(void) restoreTransaction: (SKPaymentTransaction *)transaction;
-(void) failedTransaction: (SKPaymentTransaction *)transaction;
-(void) recordTransaction: (SKPaymentTransaction *)transaction;
-(void) provideContent: (NSString *)contentId;
-(void) makePurchase;
-(void) requestProductData;


@end
