//
//  StoreHelper.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 8/23/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "StoreHelper.h"
#import "AppDelegate.h"
#define EndlessMode @"com.cihankoseoglu.poppolo.endlessmode"

@implementation StoreHelper

-(id)init{
    
    self = [super init];
    if (self) {
        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

-(void)makePurchase{
    
    SKPayment *payment = [SKPayment paymentWithProduct:currentPurchase];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

-(void)requestProductData{
    
    if ([SKPaymentQueue canMakePayments]) {
        
        NSLog(@"Presenting store menu");
    }else{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"In-App purchase disabled" message:@"Turn on in-app purchases in your device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertView show];
        return;
    }
    
    currentPurchase = EndlessMode;
    
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:currentPurchase]];
    request.delegate=self;
    [request start];
    
    
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSArray *products = response.products;
    SKProduct *endlessProduct = [products objectAtIndex:0];
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    [numFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numFormatter setLocale:endlessProduct.priceLocale];
    
    NSString *formattedNumberString = [numFormatter stringFromNumber:endlessProduct.price];
    currentPurchase = endlessProduct.productIdentifier;
    
    [self makePurchase];
    
    
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    
    for (SKPaymentTransaction *transaction in transactions){
        
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                // purchase completed
                [self completeTransaction:transaction];
                break;
                case SKPaymentTransactionStateFailed:
                // purchase failed
                [self failedTransaction:transaction];
                break;
                case SKPaymentTransactionStateRestored:
                //purchase restored
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    }
}

-(void)completeTransaction:(SKPaymentTransaction *)transaction{
    

    [self recordTransaction:transaction];
    [self provideContent:transaction.payment.productIdentifier];
    
    // remove the transaction from the payment queue
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
}

-(void)failedTransaction:(SKPaymentTransaction *)transaction{
    
    if (transaction.error.code != SKErrorPaymentCancelled) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Transaction failed" message:@"Your payment did not go throught" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)restoreTransaction:(SKPaymentTransaction *)transaction{
    
    [self recordTransaction:transaction];
    [self provideContent:transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
}

-(void)provideContent:(NSString *)contentId{
    
    // unlock endless mode
    
    [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:contentId];
    
    AppDelegate *appDelegateInstance = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    
    if ([contentId isEqualToString:EndlessMode]) {
        [appDelegateInstance unlockEndlessMode];
    }
    
}
@end
