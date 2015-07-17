//
//  MainMenu.m
//  Poppolo
//
//  Created by Cihan Köseoğlu on 7/23/14.
//  Copyright (c) 2014 Cihan Koseoglu. All rights reserved.
//

#import "MainMenu.h"
#import "GameData.h"
#import "SKButton.h"
#import "LevelOne.h"
#import "LevelSelect.h"
#import "EndlessLevel.h"

@implementation MainMenu

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor whiteColor];
        
        
        // remove ads button
        
        // duzelt burayi
        
//        SKButton *removeAdsButton = [[SKButton alloc] initWithImageNamedNormal:@"WhiteOverlay" selected:@"TransparentButton"];
//        [removeAdsButton setPosition:CGPointMake(self.scene.size.width/2, self.scene.size.height/2-200)];
//        [removeAdsButton.title setText:@"remove ads"];
//        [removeAdsButton.title setFontName:@"Helvetica"];
//        [removeAdsButton.title setFontSize:20.0];
//        [removeAdsButton.title setFontColor:levelPassColor];
//        [removeAdsButton setTouchUpInsideTarget:self action:@selector(removeAds)];
//        [self addChild:removeAdsButton];
        

        
        SKSpriteNode *logoNode = [SKSpriteNode spriteNodeWithImageNamed:@"PoppoloLogo"];
        logoNode.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2+70);
        
        [self addChild:logoNode];
        
        SKAction *fadeIn = [SKAction fadeInWithDuration:2];
        [logoNode runAction:fadeIn];
        
       
       
        
        // play button
        
        SKButton *backButton = [[SKButton alloc] initWithImageNamedNormal:@"TransparentButton" selected:@"TransparentButton"];
        [backButton setPosition:CGPointMake(self.scene.size.width/2, self.scene.size.height/2-40)];
        [backButton.title setText:@"play"];
        [backButton.title setFontName:@"Helvetica"];
        [backButton.title setFontSize:20.0];
        [backButton.title setFontColor:instructionColor];
        [backButton setTouchUpInsideTarget:self action:@selector(resumeLevel)];
        [self addChild:backButton];
        
        // set the ad counter
        
        [GameData sharedGameData].adShowCount = 0;
        
        SKLabelNode *gameRuleLabel2 = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
        gameRuleLabel2.text = @"this is a simple game.";
        gameRuleLabel2.fontSize = 24;
        gameRuleLabel2.fontColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1.0];
        gameRuleLabel2.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2 -90);
        gameRuleLabel2.alpha = 0 ;
        
        SKAction *fadeIn2 = [SKAction fadeInWithDuration:1.8];
        SKAction *moveUpwards2 = [SKAction moveToY:self.scene.size.height/2-126 duration:1.4];
        
        SKAction *group2 = [SKAction group:@[fadeIn2,moveUpwards2]];
        
        [gameRuleLabel2 runAction:group2];
        
        
        [self addChild:gameRuleLabel2];

        
        
        
        SKLabelNode *gameRuleLabel = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
        gameRuleLabel.text = @"follow the suit, or lose.";
        gameRuleLabel.fontSize = 24;
        gameRuleLabel.fontColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1.0];
        gameRuleLabel.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2 -120);
        gameRuleLabel.alpha = 0 ;
        
        SKAction *fadeIn3 = [SKAction fadeInWithDuration:1.8];
        SKAction *moveUpwards3 = [SKAction moveToY:self.scene.size.height/2-156 duration:1.4];
        
        SKAction *group3 = [SKAction group:@[fadeIn3,moveUpwards3]];
        
        [gameRuleLabel runAction:group3];
        
        [self addChild:gameRuleLabel];
        
        
        SKLabelNode *gameRuleLabel4 = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
        gameRuleLabel4.text = [NSString stringWithFormat:@"high score: %li", [GameData sharedGameData].highScore];
        gameRuleLabel4.fontSize = 24;
        gameRuleLabel4.fontColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1.0];
        gameRuleLabel4.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2 +180);
        gameRuleLabel4.alpha = 0 ;
        
        SKAction *fadeIn4 = [SKAction fadeInWithDuration:1.8];
        SKAction *group4 = [SKAction group:@[fadeIn4]];
        [gameRuleLabel4 runAction:group4];
        
        [self addChild:gameRuleLabel4];
      
        SKSpriteNode *whiteOverlay = [SKSpriteNode spriteNodeWithImageNamed:@"WhiteOverlay.png"];
        whiteOverlay.alpha = 1;
        whiteOverlay.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2);
        
        [self addChild:whiteOverlay];
        
        
        SKAction *fadeOut = [SKAction fadeAlphaTo:0 duration:1];
        
        [whiteOverlay runAction:fadeOut];
        
        [self removeNodeWithTimeInterval:whiteOverlay :1.4];
        
    }
    return self;
}

-(void)resumeLevel{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        EndlessLevel *newScene = [[EndlessLevel alloc] initWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
        [self.view presentScene:newScene transition:transition];
    });
    
    
    
    
}

-(void)selectLevel{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        LevelOne *newScene = [[LevelOne alloc] initWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
        [self.view presentScene:newScene transition:transition];
    });
    
    
    
    
}

-(void)segueToEndlessLevel{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        EndlessLevel *newScene = [[EndlessLevel alloc] initWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithColor:[UIColor whiteColor] duration:2];
        [self.view presentScene:newScene transition:transition];
    });
    
    
    
    
}

-(void)removeNodeWithTimeInterval:(SKNode*)node :(NSTimeInterval)timeInterval{
    
    [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                     target:node
                                   selector:@selector(removeFromParent)
                                   userInfo:nil
                                    repeats:NO];
}


#pragma mark - remove ads


-(void)removeAds{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"InApp" withExtension:@"plist"];
    NSArray *productIdentifiers =[NSArray arrayWithContentsOfURL:url];
    
    NSLog(@"remove ads button pressed");
    [self validateProductIdentifiers:productIdentifiers];
    
}

-(void)validateProductIdentifiers:(NSArray *)productIdentifiers{

    SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithArray:productIdentifiers]];
    productsRequest.delegate = self;
    [productsRequest start];

}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSArray *products = response.products;
    SKProduct *product = [products objectAtIndex:0];
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
    payment.quantity = 1;
    
    
    [[SKPaymentQueue defaultQueue] addPayment:payment];

    
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
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Transaction failed" message:@"Your payment did not go through" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
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
    
    
}


@end
