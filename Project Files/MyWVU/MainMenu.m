//
//  MainMenu.m
//  MyWVU
//
//  Created by Thomas Diffendal on 1/1/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "MainMenu.h"
#import "Webview.h"
#import <StoreKit/StoreKit.h>

@interface MainMenu () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@end

@implementation MainMenu

#define kRemoveAdsProductIdentifier @"com.thomasdiffendal.mywvu.removeads"

- (IBAction)tapsRemoveAds{
    self.settingsView.hidden = YES;
    //    NSLog(@"User requests to remove ads");
    
    if([SKPaymentQueue canMakePayments]){
        //        NSLog(@"User can make payments");
        iapLoading.hidden = NO;
        [iap startAnimating];
        
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kRemoveAdsProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
        //        NSLog(@"User cannot make payments due to parental controls");
        //this is called the user cannot make payments, most likely due to parental controls
    }
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    SKProduct *validProduct = nil;
    int count = [response.products count];
    if(count > 0){
        validProduct = [response.products objectAtIndex:0];
        //        NSLog(@"Products Available!");
        [self purchase:validProduct];
    }
    else if(!validProduct){
        //        NSLog(@"No products available");
        //this is called if your product id is not valid, this shouldn't be called unless that happens.
    }
}

- (IBAction)purchase:(SKProduct *)product{
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (IBAction) restore{
    //this is called when the user restores purchases, you should hook this up to a button
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    self.settingsView.hidden = YES;
}

- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    //    NSLog(@"received restored transactions: %i", queue.transactions.count);
    for(SKPaymentTransaction *transaction in queue.transactions){
        if(transaction.transactionState == SKPaymentTransactionStateRestored){
            //called when the user successfully restores a purchase
            //            NSLog(@"Transaction state -> Restored");
            
            iapLoading.hidden = YES;
            [iap stopAnimating];
            
            [self doRemoveAds];
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            break;
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for(SKPaymentTransaction *transaction in transactions){
        switch(transaction.transactionState){
            case SKPaymentTransactionStatePurchasing: NSLog(@"Transaction state -> Purchasing");
                //called when the user is in the process of purchasing, do not add any of your own code here.
                break;
            case SKPaymentTransactionStatePurchased:
                //this is called when the user has successfully purchased the package (Cha-Ching!)
                [self doRemoveAds]; //you can add your code for what you want to happen when the user buys the purchase here, for this tutorial we use removing ads
                iapLoading.hidden = YES;
                [iap stopAnimating];
                [self showAcademicButtons];
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                //                NSLog(@"Transaction state -> Purchased");
                break;
            case SKPaymentTransactionStateRestored:
                //                NSLog(@"Transaction state -> Restored");
                [self doRemoveAds];
                iapLoading.hidden = YES;
                [iap stopAnimating];
                [self showAcademicButtons];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                //called when the transaction does not finish
                if(transaction.error.code == SKErrorPaymentCancelled){
                    //                    NSLog(@"Transaction state -> Cancelled");
                    iapLoading.hidden = YES;
                    [iap stopAnimating];
                    //the user cancelled the payment ;(
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
        }
    }
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    iapLoading.layer.cornerRadius = 5;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            //IPHONE 5/5s/5c
            [schoolLabel setFrame:CGRectMake(3, -2, 118,31)];
            [myWVULogo setFrame:CGRectMake(105, 5, 110, 33)];
            [mainMenuBackground setFrame:CGRectMake(0, 0, 320, 568)];
            [categorySelectorBackground setFrame:CGRectMake(0, 0, 320, 80)];
            [self.btnSelectCategory setFrame:CGRectMake(46, 39, 228, 31)];
            [btnCloseDropDownMenu setFrame:CGRectMake(46, 39, 228, 31)];
            [btnSettings setFrame:CGRectMake(280, -6, 40, 40)];
            [btnCloseSettings setFrame:CGRectMake(280, -6, 40, 40)];
            [self.categoryIcon setFrame:CGRectMake(54, 42, 25, 25)];
            [self.categoryLabel setFrame:CGRectMake(91, 42, 183, 25)];
            [_mainMenuScroll setFrame:CGRectMake(0, 80, 320, 601)];
            [self.categoryView setFrame:CGRectMake(46, 71, 228, 396)];
            [categoryImageView setFrame:CGRectMake(0, 0, 228, 396)];
            [self.btnAcademic setFrame:CGRectMake(45, 6, 174, 35)];
            [self.btnCampusDining setFrame:CGRectMake(45, 36, 192, 54)];
            [self.btnCampusInformation setFrame:CGRectMake(45, 89, 192, 30)];
            [self.btnCampusNewsAndEvents setFrame:CGRectMake(45, 128, 209, 30)];
            [self.btnCampusPolice setFrame:CGRectMake(45, 167, 129, 30)];
            [self.btnGreekLife setFrame:CGRectMake(45, 204, 110, 30)];
            [self.btnNightlife setFrame:CGRectMake(45, 243, 103, 30)];
            [self.btnParkingAndTransportation setFrame:CGRectMake(45, 282, 197, 30)];
            [self.btnSportsAndFitness setFrame:CGRectMake(45, 321, 159, 30)];
            [self.btnStudentHealth setFrame:CGRectMake(45, 355, 179, 40)];
            [academicIcon setFrame:CGRectMake(8, 11, 25, 25)];
            [diningIcon setFrame:CGRectMake(8.5, 50, 25, 25)];
            [informationIcon setFrame:CGRectMake(6, 89, 25, 25)];
            [newsIcon setFrame:CGRectMake(6, 128, 25, 25)];
            [policeIcon setFrame:CGRectMake(6, 167, 25, 25)];
            [greeklifeIcon setFrame:CGRectMake(6, 206, 25, 25)];
            [nightlifeIcon setFrame:CGRectMake(6, 245, 25, 25)];
            [parkingIcon setFrame:CGRectMake(6, 284, 25, 25)];
            [sportsIcon setFrame:CGRectMake(6, 323, 25, 25)];
            [studentHealthIcon setFrame:CGRectMake(6, 362, 25, 25)];
            [self.settingsView setFrame:CGRectMake(190, 28, 124, 200)];
            [settingsBackgroundImage setFrame:CGRectMake(0, 0, 124, 200)];
            [btnInformation setFrame:CGRectMake(5, 5, 140, 31)];
            [btnFeedback setFrame:CGRectMake(5, 45, 140, 30)];
            [btnHowToUse setFrame:CGRectMake(5, 85, 140, 30)];
            [btnRemoveAds setFrame:CGRectMake(5, 125, 140, 30)];
            [btnRestorePurchase setFrame:CGRectMake(5, 165, 140, 30)];
            
            [firstTimeMessage setFrame:CGRectMake(0, 0, 320, 442)];
            
            [divider1 setFrame:CGRectMake(5, 38, 110, 1)];
            [divider2 setFrame:CGRectMake(5, 80, 110, 1)];
            [divider3 setFrame:CGRectMake(5, 118, 110, 1)];
            [divider4 setFrame:CGRectMake(5, 160, 110, 1)];
            
            [iapLoading setFrame:CGRectMake(95, 219, 130, 130)];
            
            [schoolLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:9]];
            
            [btnInformation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            [btnFeedback.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            [btnHowToUse.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            [btnRemoveAds.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            [btnRestorePurchase.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            
            [self.categoryLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnAcademic.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnCampusDining.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnCampusInformation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnCampusNewsAndEvents.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnCampusPolice.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnGreekLife.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnNightlife.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnParkingAndTransportation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnSportsAndFitness.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnStudentHealth.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
        {
            [schoolLabel setFrame:CGRectMake(3, 0, 118,31)];
            [mainMenuBackground setFrame:CGRectMake(0, 0, 320, 515)];
            [myWVULogo setFrame:CGRectMake(110, 3, 100, 37)];
            [categorySelectorBackground setFrame:CGRectMake(0, 0, 320, 75)];
            [self.btnSelectCategory setFrame:CGRectMake(50, 40, 220, 30)];
            [btnCloseDropDownMenu setFrame:CGRectMake(50, 40, 220, 30)];
            [btnSettings setFrame:CGRectMake(280, -6, 40, 40)];
            [btnCloseSettings setFrame:CGRectMake(280, -6, 40, 40)];
            [self.categoryIcon setFrame:CGRectMake(60, 45, 20, 20)];
            [self.categoryLabel setFrame:CGRectMake(93, 43, 199, 25)];
            [_mainMenuScroll setFrame:CGRectMake(0, 76, 320, 601)];
            [self.categoryView setFrame:CGRectMake(50, 71, 220, 350)];
            [categoryImageView setFrame:CGRectMake(0, 0, 220, 350)];
            [self.btnAcademic setFrame:CGRectMake(43, 3, 208, 35)];
            [self.btnCampusDining setFrame:CGRectMake(43, 28, 192, 54)];
            [self.btnCampusInformation setFrame:CGRectMake(43, 74, 209, 30)];
            [self.btnCampusNewsAndEvents setFrame:CGRectMake(43, 108, 209, 30)];
            [self.btnCampusPolice setFrame:CGRectMake(43, 142, 199, 30)];
            [self.btnGreekLife setFrame:CGRectMake(43, 176, 192, 30)];
            [self.btnNightlife setFrame:CGRectMake(43, 210, 103, 30)];
            [self.btnParkingAndTransportation setFrame:CGRectMake(43, 244, 197, 30)];
            [self.btnSportsAndFitness setFrame:CGRectMake(43, 278, 199, 30)];
            [self.btnStudentHealth setFrame:CGRectMake(43, 307, 199, 40)];
            [academicIcon setFrame:CGRectMake(10, 11, 20, 20)];
            [diningIcon setFrame:CGRectMake(10, 45, 20, 20)];
            [informationIcon setFrame:CGRectMake(10, 79, 20, 20)];
            [newsIcon setFrame:CGRectMake(10, 113, 20, 20)];
            [policeIcon setFrame:CGRectMake(10, 147, 20, 20)];
            [greeklifeIcon setFrame:CGRectMake(10, 181, 20, 20)];
            [nightlifeIcon setFrame:CGRectMake(10, 215, 20, 20)];
            [parkingIcon setFrame:CGRectMake(10, 249, 20, 20)];
            [sportsIcon setFrame:CGRectMake(10, 283, 20, 20)];
            [studentHealthIcon setFrame:CGRectMake(10, 317, 20, 20)];
            [self.settingsView setFrame:CGRectMake(190, 28, 122, 198)];
            [settingsBackgroundImage setFrame:CGRectMake(0, 0, 122, 198)];
            [btnInformation setFrame:CGRectMake(5, 5, 140, 31)];
            [btnFeedback setFrame:CGRectMake(5, 46, 140, 30)];
            [btnHowToUse setFrame:CGRectMake(5, 87, 140, 30)];
            [btnRemoveAds setFrame:CGRectMake(5, 128, 140, 30)];
            [btnRestorePurchase setFrame:CGRectMake(5, 165, 134, 30)];
            
            [divider1 setFrame:CGRectMake(3, 38, 115, 1)];
            [divider2 setFrame:CGRectMake(3, 80, 115, 1)];
            [divider3 setFrame:CGRectMake(3, 118, 115, 1)];
            [divider4 setFrame:CGRectMake(3, 156, 115, 1)];
            
            [firstTimeMessage setFrame:CGRectMake(0, 0, 320, 361)];
            
            [iapLoading setFrame:CGRectMake(95, 175, 130, 130)];
            
            [schoolLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:9]];
            
            [btnInformation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            [btnFeedback.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            [btnHowToUse.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            [btnRemoveAds.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            [btnRestorePurchase.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            
            [self.categoryLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnAcademic.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnCampusDining.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnCampusInformation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnCampusNewsAndEvents.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnCampusPolice.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnGreekLife.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnNightlife.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnParkingAndTransportation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnSportsAndFitness.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnStudentHealth.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
        {
            [schoolLabel setFrame:CGRectMake(7, 0, 118,31)];
            [myWVULogo setFrame:CGRectMake(147, 6, 120, 42)];
            [mainMenuBackground setFrame:CGRectMake(0, 0, 414, 736)];
            [categorySelectorBackground setFrame:CGRectMake(0, 0, 414, 95)];
            [self.btnSelectCategory setFrame:CGRectMake(66, 46, 283, 37)];
            [btnCloseDropDownMenu setFrame:CGRectMake(66, 46, 283, 37)];
            [btnSettings setFrame:CGRectMake(370, -7, 45, 45)];
            [btnCloseSettings setFrame:CGRectMake(370, -7, 45, 45)];
            [self.categoryIcon setFrame:CGRectMake(80, 50, 30, 30)];
            [self.categoryLabel setFrame:CGRectMake(125, 46, 199, 37)];
            [_mainMenuScroll setFrame:CGRectMake(0, 95, 414, 645)];
            [self.categoryView setFrame:CGRectMake(66, 84, 283, 460)];
            [self.btnAcademic setFrame:CGRectMake(60, 8, 208, 35)];
            [self.btnCampusDining setFrame:CGRectMake(60, 44, 192, 54)];
            [self.btnCampusInformation setFrame:CGRectMake(60, 101, 209, 30)];
            [self.btnCampusNewsAndEvents setFrame:CGRectMake(60, 146, 209, 30)];
            [self.btnCampusPolice setFrame:CGRectMake(60, 191, 199, 30)];
            [self.btnGreekLife setFrame:CGRectMake(60, 236, 192, 30)];
            [self.btnNightlife setFrame:CGRectMake(60, 281, 190, 30)];
            [self.btnParkingAndTransportation setFrame:CGRectMake(60, 325, 197, 30)];
            [self.btnSportsAndFitness setFrame:CGRectMake(60, 371, 199, 30)];
            [self.btnStudentHealth setFrame:CGRectMake(60, 412, 199, 40)];
            [academicIcon setFrame:CGRectMake(14, 11, 30, 30)];
            [diningIcon setFrame:CGRectMake(14, 56, 30, 30)];
            [informationIcon setFrame:CGRectMake(14, 101, 30, 30)];
            [newsIcon setFrame:CGRectMake(14, 146, 30, 30)];
            [policeIcon setFrame:CGRectMake(14, 191, 30, 30)];
            [greeklifeIcon setFrame:CGRectMake(14, 236, 30, 30)];
            [nightlifeIcon setFrame:CGRectMake(14, 281, 30, 30)];
            [parkingIcon setFrame:CGRectMake(14, 325, 30, 30)];
            [sportsIcon setFrame:CGRectMake(14, 370, 30, 30)];
            [studentHealthIcon setFrame:CGRectMake(14, 415, 30, 30)];
            [self.settingsView setFrame:CGRectMake(255, 28, 150, 163)];
            [btnInformation setFrame:CGRectMake(5, 5, 140, 30)];
            [btnFeedback setFrame:CGRectMake(5, 45, 140, 30)];
            [btnHowToUse setFrame:CGRectMake(5, 85, 140, 30)];
            [btnRemoveAds setFrame:CGRectMake(5, 125, 140, 30)];
            [btnRestorePurchase setFrame:CGRectMake(5, 165, 134, 30)];
            
            [divider1 setFrame:CGRectMake(3, 38, 145, 1)];
            [divider2 setFrame:CGRectMake(3, 80, 145, 1)];
            [divider3 setFrame:CGRectMake(3, 118, 145, 1)];
            
            [firstTimeMessage setFrame:CGRectMake(0, 0, 414, 593)];
            
            [iapLoading setFrame:CGRectMake(142, 303, 130, 130)];
            
            [btnInformation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17]];
            [btnFeedback.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17]];
            [btnRemoveAds.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17]];
            [btnRestorePurchase.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17]];
            
            [self.categoryLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnAcademic.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnCampusDining.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnCampusInformation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnCampusNewsAndEvents.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnCampusPolice.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnGreekLife.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnNightlife.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnParkingAndTransportation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnSportsAndFitness.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnStudentHealth.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            
        }
    }

    
    self.categoryView.hidden = YES;
    btnCloseDropDownMenu.hidden = YES;
    self.settingsView.hidden = YES;
    btnCloseSettings.hidden = YES;
    btnSettings.hidden = NO;
    iapLoading.hidden = YES;
    
    areAdsRemoved = [[NSUserDefaults standardUserDefaults] boolForKey:@"areAdsRemoved"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self doRemoveAds];
    
    if (!areAdsRemoved) {
        if (bannerView == nil) {
            
            bannerView = [[STABannerView alloc] initWithSize:STA_AutoAdSize autoOrigin:STAAdOrigin_Bottom
                                                    withView:self.view withDelegate:nil];
            [self.view addSubview:bannerView];
        }
    }
    
    else if (areAdsRemoved) {
        [self doRemoveAds];
    }
}

-(void)doRemoveAds
{
    self.settingsView.hidden = YES;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
        {
            [self.settingsView setFrame:CGRectMake(210, 28, 100, 119)];
            [settingsBackgroundImage setFrame:CGRectMake(0, 0, 100, 119)];
            [btnInformation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:13]];
            [btnFeedback.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:13]];
            [btnHowToUse.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:13]];
            
            [divider1 setFrame:CGRectMake(5, 38, 90, 1)];
            [divider2 setFrame:CGRectMake(5, 80, 90, 1)];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            [self.settingsView setFrame:CGRectMake(210, 28, 100, 119)];
            [settingsBackgroundImage setFrame:CGRectMake(0, 0, 100, 119)];
            [btnInformation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:13]];
            [btnFeedback.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:13]];
            [btnHowToUse.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:13]];
            
            [divider1 setFrame:CGRectMake(5, 38, 90, 1)];
            [divider2 setFrame:CGRectMake(5, 80, 90, 1)];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
        {
            self.settingsView.frame = CGRectMake(217, 28, 150, 119);
            settingsBackgroundImage.frame = CGRectMake(0, 0, 150, 119);
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
        {
            self.settingsView.frame = CGRectMake(255, 28, 150, 120);
            settingsBackgroundImage.frame = CGRectMake(0, 0, 150, 120);
        }
    }
    
    
    divider3.hidden = YES;
    divider4.hidden = YES;
    areAdsRemoved = YES;
    bannerView.hidden = YES;
    btnRemoveAds.hidden = YES;
    btnRemoveAds.enabled = NO;
    btnRestorePurchase.hidden = YES;
    btnRestorePurchase.enabled = NO;
    [[NSUserDefaults standardUserDefaults] setBool:areAdsRemoved forKey:@"areAdsRemoved"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    iapLoading.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self loadCategory];
    
    if ([self.categoryLabel.text isEqualToString:@""]) {
        self.categoryLabel.text = @"Academics";
    }
    
    if ([self.categoryLabel.text isEqualToString:@"Academics"]) {
        [self showAcademicButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Campus Dining"]) {
        [self showCampusDiningButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Campus Information"]) {
        [self showCampusInformationButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Campus News & Events"]) {
        [self showCampusNewsAndEventsButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Campus Police"]) {
        [self showCampusPoliceButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Greeklife"]) {
        [self showGreeklifeButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Nightlife"]) {
        [self showNightlifeButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Parking & Transportation"]) {
        [self showParkingAndTransportationButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Sports & Fitness"]) {
        [self showSportsAndFitnessButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Student Health"]) {
        [self showStudentHealth];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self saveCategory];
}

-(IBAction)selectCategory:(id)sender
{
    self.categoryView.hidden = NO;
    btnCloseDropDownMenu.hidden = NO;
    self.btnSelectCategory.hidden = YES;
    self.settingsView.hidden = YES;
}

-(IBAction)closeDropDown:(id)sender
{
    self.btnSelectCategory.hidden = NO;
    btnCloseDropDownMenu.hidden = YES;
    self.categoryView.hidden = YES;
    self.settingsView.hidden = YES;
}

-(IBAction)openSettings:(id)sender
{
    self.settingsView.hidden = NO;
    self.categoryView.hidden = YES;
    btnCloseSettings.hidden = NO;
    btnSettings.hidden = YES;
}

-(IBAction)closeSettings:(id)sender
{
    btnCloseSettings.hidden = YES;
    btnSettings.hidden = NO;
    self.settingsView.hidden = YES;
}

-(IBAction)informationSetting:(id)sender
{
    self.settingsView.hidden = YES;
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"information"];
    [self presentViewController:vc animated:YES completion:nil];
}

-(IBAction)feedbackSetting:(id)sender
{
    self.settingsView.hidden = YES;
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"feedback"];
    [self presentViewController:vc animated:YES completion:nil];
}

-(IBAction)howtouseSetting:(id)sender
{
    self.settingsView.hidden = YES;
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"howtouse"];
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)saveCategory
{
    NSString *saveCategory = self.categoryLabel.text;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:saveCategory forKey:@"categoryChoice"];
    [defaults synchronize];
}

-(void)loadCategory
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loadString = [defaults objectForKey:@"categoryChoice"];
    [self.categoryLabel setText:loadString];
}

- (IBAction)categoryAcademic:(id)sender
{
    [self showAcademicButtons];
    [self saveCategory];
}

- (IBAction)categoryCampusDining:(id)sender
{
    [self showCampusDiningButtons];
    [self saveCategory];
}

-(IBAction)categoryCampusInformation:(id)sender
{
    [self showCampusInformationButtons];
    [self saveCategory];
}

-(IBAction)categoryCampusNewsAndEvents:(id)sender
{
    [self showCampusNewsAndEventsButtons];
    [self saveCategory];
}

-(IBAction)categoryCampusPolice:(id)sender
{
    [self showCampusPoliceButtons];
    [self saveCategory];
}

-(IBAction)categoryGreeklife:(id)sender
{
    [self showGreeklifeButtons];
    [self saveCategory];
}

-(IBAction)categoryNightlife:(id)sender
{
    [self showNightlifeButtons];
    [self saveCategory];
}

-(IBAction)categoryParkingAndTransportation:(id)sender
{
    [self showParkingAndTransportationButtons];
    [self saveCategory];
}

-(IBAction)categorySportsAndFitness:(id)sender
{
    [self showSportsAndFitnessButtons];
    [self saveCategory];
}

-(IBAction)categoryStudentHealth:(id)sender
{
    [self showStudentHealth];
    [self saveCategory];
}

-(void)showAcademicButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    self.btnSelectCategory.hidden = NO;
    btnCloseDropDownMenu.hidden = YES;
    self.categoryView.hidden = YES;

    
    self.categoryLabel.text = @"Academics";
    self.categoryIcon.image = [UIImage imageNamed:@"academic_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Academic" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"WVU"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *wvuAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *wvuAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wvuAcademicButton setImage:[UIImage imageNamed:wvuAcademic] forState:UIControlStateNormal];
        [wvuAcademicButton setTag:i];
        [wvuAcademicButton addTarget:self action:@selector(openLinks:) forControlEvents:UIControlEventTouchUpInside];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                wvuAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                wvuAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
        }
        
        [self.mainMenuScroll addSubview:wvuAcademicButton];
        
        if (areAdsRemoved) {
        
        
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                //IPHONE 6
                [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                //IPHONE 5/5s/5c
                [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 115)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                //IPHONE 4
                [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                //IPHONE 6 PLUS
                [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 5)];
                }
            }
        }
        
        else {
            //ADS ARE NOT REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 50)];
                }
            }
        }
    }
}

-(void)showCampusDiningButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    self.btnSelectCategory.hidden = NO;
    self.categoryView.hidden = YES;
    btnCloseDropDownMenu.hidden = YES;

    
    self.categoryLabel.text = @"Campus Dining";
    self.categoryIcon.image = [UIImage imageNamed:@"campus_dining_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CampusDining" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"WVU"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *wvuAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *wvuAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wvuAcademicButton setImage:[UIImage imageNamed:wvuAcademic] forState:UIControlStateNormal];
        [wvuAcademicButton setTag:i];
        [wvuAcademicButton addTarget:self action:@selector(openLinks:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.mainMenuScroll addSubview:wvuAcademicButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                wvuAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                wvuAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:wvuAcademicButton];
        
            
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 115)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 5)];
                }
            }
            
        }
        else {
            //ADS ARE NOT REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 50)];
                }
            }
        }
    }
}

-(void)showCampusInformationButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    self.btnSelectCategory.hidden = NO;
    self.categoryView.hidden = YES;
    btnCloseDropDownMenu.hidden = YES;

    self.categoryLabel.text = @"Campus Information";
    self.categoryIcon.image = [UIImage imageNamed:@"campus_information_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CampusInformation" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"WVU"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *wvuAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *wvuAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wvuAcademicButton setImage:[UIImage imageNamed:wvuAcademic] forState:UIControlStateNormal];
        [wvuAcademicButton setTag:i];
        [wvuAcademicButton addTarget:self action:@selector(openLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainMenuScroll addSubview:wvuAcademicButton];

        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                wvuAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                wvuAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:wvuAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 110)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 5)];
                }
                
            }
            
        }
        else {
            //ADS ARE NOT REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 50)];
                }
            }
        }
        
    }
}

-(void)showCampusNewsAndEventsButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    self.btnSelectCategory.hidden = NO;
    self.categoryView.hidden = YES;
    btnCloseDropDownMenu.hidden = YES;

    self.categoryLabel.text = @"Campus News & Events";
    self.categoryIcon.image = [UIImage imageNamed:@"campus_news_and_events_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CampusNewsAndEvents" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"WVU"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *wvuAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *wvuAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wvuAcademicButton setImage:[UIImage imageNamed:wvuAcademic] forState:UIControlStateNormal];
        [wvuAcademicButton setTag:i];
        [wvuAcademicButton addTarget:self action:@selector(openLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainMenuScroll addSubview:wvuAcademicButton];

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                wvuAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                wvuAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:wvuAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 110)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 5)];
                }
                
            }
            
        }
        else {
            //ADS ARE NOT REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 50)];
                }
            }
        }
        
    }
}

-(void)showCampusPoliceButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    self.btnSelectCategory.hidden = NO;
    self.categoryView.hidden = YES;
    btnCloseDropDownMenu.hidden = YES;

    self.categoryLabel.text = @"Campus Police";
    self.categoryIcon.image = [UIImage imageNamed:@"campus_police_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CampusPolice" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"WVU"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *wvuAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *wvuAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wvuAcademicButton setImage:[UIImage imageNamed:wvuAcademic] forState:UIControlStateNormal];
        [wvuAcademicButton setTag:i];
        [wvuAcademicButton addTarget:self action:@selector(openCampusPoliceLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainMenuScroll addSubview:wvuAcademicButton];

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                wvuAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                wvuAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:wvuAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 110)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 5)];
                }
                
            }
            
        }
        else {
            //ADS ARE NOT REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 50)];
                }
            }
        }
        

        
    }
}

-(void)showGreeklifeButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    self.btnSelectCategory.hidden = NO;
    self.categoryView.hidden = YES;
    btnCloseDropDownMenu.hidden = YES;

    self.categoryLabel.text = @"Greeklife";
    self.categoryIcon.image = [UIImage imageNamed:@"greek_life_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Greeklife" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"WVU"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *wvuAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *wvuAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wvuAcademicButton setImage:[UIImage imageNamed:wvuAcademic] forState:UIControlStateNormal];
        [wvuAcademicButton setTag:i];
        [wvuAcademicButton addTarget:self action:@selector(openGreeklifeLinks:) forControlEvents:UIControlEventTouchUpInside];
                [self.mainMenuScroll addSubview:wvuAcademicButton];

        if (wvuAcademicButton.tag == 0) {
            wvuAcademicButton.adjustsImageWhenHighlighted = NO;
        }
        else if (wvuAcademicButton.tag == 20) {
            wvuAcademicButton.adjustsImageWhenHighlighted = NO;
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                wvuAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                wvuAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:wvuAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 115)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 5)];
                }
                
            }
            
        }
        else {
            //ADS ARE NOT REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 50)];
                }
            }
        }
    }
}

-(void)showNightlifeButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    self.btnSelectCategory.hidden = NO;
    self.categoryView.hidden = YES;
    btnCloseDropDownMenu.hidden = YES;

    self.categoryLabel.text = @"Nightlife";
    self.categoryIcon.image = [UIImage imageNamed:@"nightlife_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Nightlife" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"WVU"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *wvuAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *wvuAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wvuAcademicButton setImage:[UIImage imageNamed:wvuAcademic] forState:UIControlStateNormal];
        [wvuAcademicButton setTag:i];
        [wvuAcademicButton addTarget:self action:@selector(openLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainMenuScroll addSubview:wvuAcademicButton];

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                wvuAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                wvuAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:wvuAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 115)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 5)];
                }
                
            }
            
        }
        else {
            //ADS ARE NOT REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 50)];
                }
            }
        }
    }
}

-(void)showParkingAndTransportationButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    self.btnSelectCategory.hidden = NO;
    self.categoryView.hidden = YES;
    btnCloseDropDownMenu.hidden = YES;

    self.categoryLabel.text = @"Parking & Transportation";
    self.categoryIcon.image = [UIImage imageNamed:@"parking_and_transportation_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ParkingAndTransportation" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"WVU"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *wvuAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *wvuAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wvuAcademicButton setImage:[UIImage imageNamed:wvuAcademic] forState:UIControlStateNormal];
        [wvuAcademicButton setTag:i];
        [wvuAcademicButton addTarget:self action:@selector(openParkingTransportationLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainMenuScroll addSubview:wvuAcademicButton];

        if (wvuAcademicButton.tag == 0) {
            wvuAcademicButton.adjustsImageWhenHighlighted = NO;
        }
        else if (wvuAcademicButton.tag == 5) {
            wvuAcademicButton.adjustsImageWhenHighlighted = NO;
        }
        else if (wvuAcademicButton.tag == 24) {
            wvuAcademicButton.adjustsImageWhenHighlighted = NO;
        }
        else if (wvuAcademicButton.tag == 29) {
            wvuAcademicButton.adjustsImageWhenHighlighted = NO;
        }
        else if (wvuAcademicButton.tag == 35) {
            wvuAcademicButton.adjustsImageWhenHighlighted = NO;
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                wvuAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                wvuAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:wvuAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 115)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 5)];
                }
                
            }
            
        }
        else {
            //ADS ARE NOT REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 50)];
                }
            }
        }
    }
}

-(void)showSportsAndFitnessButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    self.btnSelectCategory.hidden = NO;
    self.categoryView.hidden = YES;
    btnCloseDropDownMenu.hidden = YES;

    self.categoryLabel.text = @"Sports & Fitness";
    self.categoryIcon.image = [UIImage imageNamed:@"sports_and_fitness_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SportsAndFitness" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"WVU"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *wvuAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *wvuAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wvuAcademicButton setImage:[UIImage imageNamed:wvuAcademic] forState:UIControlStateNormal];
        [wvuAcademicButton setTag:i];
        [wvuAcademicButton addTarget:self action:@selector(openLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainMenuScroll addSubview:wvuAcademicButton];

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                wvuAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                wvuAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:wvuAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 110)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 5)];
                }
                
            }
            
        }
        else {
            //ADS ARE NOT REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 50)];
                }
            }
        }
        
    }
}

-(void)showStudentHealth
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    self.btnSelectCategory.hidden = NO;
    self.categoryView.hidden = YES;
    btnCloseDropDownMenu.hidden = YES;

    self.categoryLabel.text = @"Student Health";
    self.categoryIcon.image = [UIImage imageNamed:@"student_health_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StudentHealth" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"WVU"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *wvuAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *wvuAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wvuAcademicButton setImage:[UIImage imageNamed:wvuAcademic] forState:UIControlStateNormal];
        [wvuAcademicButton setTag:i];
        [wvuAcademicButton addTarget:self action:@selector(openStudentHealthLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainMenuScroll addSubview:wvuAcademicButton];

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                wvuAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                wvuAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                wvuAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:wvuAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 110)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 5)];
                }
                
            }
            
        }
        else {
            //ADS ARE NOT REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 50)];
                }
            }
        }        
    }
}


-(void)openLinks:(id)sender
{
    UIButton *button=sender;
    
    if (button.tag ==0) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==1) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==2) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==3) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==4) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==5) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==6) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==7) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==8) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==9) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==10) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==11) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==12) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==13) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==14) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==15) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==16) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==17) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==18) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==19) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==20) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==21) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==22) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==23) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==24) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==25) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==26) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==27) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==28) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==29) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==30) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==31) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==32) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==33) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==34) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==35) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==36) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==37) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==38) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==39) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==40) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
}

-(void)openCampusPoliceLinks:(id)sender
{
    UIButton *button=sender;
    
    if (button.tag ==0) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:3042932677"]];
    }
    else if (button.tag ==2) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==3) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==4) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==5) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==6) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
}

-(void)openGreeklifeLinks:(id)sender
{
    UIButton *button=sender;
    if  (button.tag ==0) {
        button.adjustsImageWhenHighlighted = NO;
    }
    else if  (button.tag ==1) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==2) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==3) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==4) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==5) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==6) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==7) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==8) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==9) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==10) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==11) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==12) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==13) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==14) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==15) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==16) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==17) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==18) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==19) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==21) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==22) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==23) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==24) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==25) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==26) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==27) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==28) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==29) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==30) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
}

-(void)openParkingTransportationLinks:(id)sender
{
    UIButton *button=sender;
    
    if      (button.tag ==1) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==2) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==3) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==4) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==5) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==7) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==8) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==9) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==10) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==11) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==12) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==13) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==14) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==15) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==16) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==17) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==18) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==19) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==20) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==21) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==22) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==23) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==24) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==26) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==27) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==28) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==29) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==31) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==32) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==33) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==34) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==35) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:3042935502"]];
    }
    else if (button.tag ==37) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:3042927441"]];
    }
    else if (button.tag ==38) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:3042918294"]];
    }
}

-(void)openStudentHealthLinks:(id)sender
{
    UIButton *button=sender;

    if (button.tag ==0) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==1) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:3042935054"]];
    }
    else if (button.tag ==3) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==4) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:3045984000"]];
    }
    else if (button.tag ==5) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    Webview *webView = [segue destinationViewController];
    
    UIButton *button = sender;
    
    if ([self.categoryLabel.text isEqualToString:@"Academics"]) {
        
        if (button.tag == 0) {
            webView.loadUrl = @"https://ecampus.wvu.edu/webapps/login/";
        }
        else if (button.tag ==1) {
            webView.loadUrl = @"https://mix.wvu.edu/gmail/GoogleRedirect.jsp";
        }
        else if (button.tag == 2) {
            webView.loadUrl = @"https://mix.wvu.edu/cp/home/loginf";
        }
        else if (button.tag == 3) {
            webView.loadUrl = @"https://star.wvu.edu/pls/starprod/twbkwbis.P_WWWLogin";
        }
        else if (button.tag == 4) {
            webView.loadUrl = @"https://sole.hsc.wvu.edu/login?ReturnUrl=/";
        }
        else if (button.tag == 5) {
            webView.loadUrl = @"https://mymountaineercard.wvu.edu/login/ldap.php";
        }
        else if (button.tag == 6) {
            webView.loadUrl = @"http://wvucard.wvu.edu/debit_plans";
        }

        else if (button.tag == 7) {
            webView.loadUrl = @"https://star.wvu.edu/pls/starprod/bwckschd.p_disp_dyn_sched";
        }
        else if (button.tag == 8) {
            webView.loadUrl = @"http://www.wvu.edu/";
        }
        else if (button.tag == 9) {
            webView.loadUrl = @"http://online.wvu.edu/";
        }
        else if (button.tag == 10) {
            webView.loadUrl = @"http://provost.wvu.edu/academic_calendar";
        }
        else if (button.tag == 11) {
            webView.loadUrl = @"http://m.wvu.edu/hours/?category=computer";
        }
        else if (button.tag == 12) {
            webView.loadUrl = @"https://lib.wvu.edu/hours/index.php?library=1";
        }
        else if (button.tag == 13) {
            webView.loadUrl = @"https://lib.wvu.edu/hours/index.php?library=2";
        }
        else if (button.tag == 14) {
            webView.loadUrl = @"https://lib.wvu.edu/hours/index.php?library=3";
        }
        else if (button.tag == 15) {
            webView.loadUrl = @"https://lib.wvu.edu/hours/index.php?library=4";
        }
        else if (button.tag == 16) {
            webView.loadUrl = @"https://lib.wvu.edu/databases/";
        }
        else if (button.tag == 17) {
            webView.loadUrl = @"https://mountainlynx.lib.wvu.edu/vwebv/login";
        }
        else if (button.tag == 18) {
            webView.loadUrl = @"https://lib.wvu.edu/services/computers/availableComputers/";
        }
        else if (button.tag == 19) {
            webView.loadUrl = @"https://myprinting.wvu.edu/";
        }
        else if (button.tag == 20) {
            webView.loadUrl = @"http://ucadvising.wvu.edu/";
        }
        else if (button.tag == 21) {
            webView.loadUrl = @"http://careerservices.wvu.edu/";
        }
        else if (button.tag == 22) {
            webView.loadUrl = @"http://www.hsc.wvu.edu/cbtc/";
        }
        else if (button.tag == 23) {
            webView.loadUrl = @"https://directory.wvu.edu/";
        }
        else if (button.tag == 24) {
            webView.loadUrl = @"http://retention.wvu.edu/tutoring";
        }
    }
    else if ([self.categoryLabel.text isEqualToString:@"Campus Dining"])
    {
        if (button.tag == 0) {
            webView.loadUrl = @"https://mymountaineercard.wvu.edu/login/ldap.php";
        }
        else if (button.tag == 1) {
            webView.loadUrl = @"http://diningservices.wvu.edu/locations/dining-halls/arnold-s-diner";
        }
        else if (button.tag == 2) {
            webView.loadUrl = @"http://diningservices.wvu.edu/locations/dining-halls/boreman-bistro";
        }
        else if (button.tag == 3) {
            webView.loadUrl = @"http://diningservices.wvu.edu/locations/dining-halls/cafe-evansdale";
        }
        else if (button.tag == 4) {
            webView.loadUrl = @"http://diningservices.wvu.edu/locations/dining-halls/summit-cafe";
        }
        else if (button.tag == 5) {
            webView.loadUrl = @"http://diningservices.wvu.edu/locations/dining-halls/terrace-room";
        }
        else if (button.tag == 6) {
            webView.loadUrl = @"http://diningservices.wvu.edu/locations/mountainlair";
        }
        else if (button.tag == 7) {
            webView.loadUrl = @"http://diningservices.wvu.edu/locations/coffee-shops";
        }
        else if (button.tag == 8) {
            webView.loadUrl = @"http://diningservices.wvu.edu/locations/quick-service/bits-and-bytes";
        }
        else if (button.tag == 9) {
            webView.loadUrl = @"http://diningservices.wvu.edu/locations/quick-service/brew-n-gold-cafe";
        }
        else if (button.tag == 10) {
            webView.loadUrl = @"http://diningservices.wvu.edu/locations/quick-service/the-greenhouse";
        }
        else if (button.tag == 11) {
            webView.loadUrl = @"http://diningservices.wvu.edu/locations/quick-service/lyons-den";
        }
        else if (button.tag == 12) {
            webView.loadUrl = @"http://diningservices.wvu.edu/locations/quick-service/summit-grab-n-go";
        }
        else if (button.tag == 13) {
            webView.loadUrl = @"http://diningservices.wvu.edu/locations/quick-service/waterfront-cafe";
        }
        else if (button.tag == 14) {
            webView.loadUrl = @"http://www.wvucrossing.com/";
        }
    }
    
    else if ([self.categoryLabel.text isEqualToString:@"Campus Information"])
    {
        if (button.tag == 0) {
            webView.loadUrl = @"http://www.wvu.edu/";
        }
        else if (button.tag == 1) {
            webView.loadUrl = @"https://campusmap.wvu.edu/";
        }
        else if (button.tag == 2) {
            webView.loadUrl = @"http://studentengagement.wvu.edu/organization_listing";
        }
        else if (button.tag == 3) {
            webView.loadUrl = @"http://it.wvu.edu/home";
        }
        else if (button.tag == 4) {
            webView.loadUrl = @"http://it.wvu.edu/services";
        }
        else if (button.tag == 5) {
            webView.loadUrl = @"http://wvu.bncollege.com/webapp/wcs/stores/servlet/BNCBHomePage?storeId=15062&catalogId=10001&langId=-1";
        }
        else if (button.tag == 6) {
            webView.loadUrl = @"http://housing.wvu.edu/";
        }
        else if (button.tag == 7) {
            webView.loadUrl = @"http://campuslife.wvu.edu/off_campus_housing";
        }
        else if (button.tag == 8) {
            webView.loadUrl = @"http://housing.wvu.edu/r/download/213496";
        }
        else if (button.tag == 9) {
            webView.loadUrl = @"http://housing.wvu.edu/r/download/179693";
        }
    }
    else if ([self.categoryLabel.text isEqualToString:@"Campus News & Events"])
    {
        if (button.tag == 0) {
            webView.loadUrl = @"https://cal.wvu.edu/CalendarNOW.aspx?fromdate=12/1/2015&todate=12/31/2015&display=Month&more=1/1/0001";
        }
        else if (button.tag == 1) {
            webView.loadUrl = @"http://www.events.wvu.edu/";
        }
        else if (button.tag == 2) {
            webView.loadUrl = @"http://wvutoday.wvu.edu/#&panel1-1";
        }
        else if (button.tag == 3) {
            webView.loadUrl = @"http://mediacollegenewscast.wvu.edu/";
        }
        else if (button.tag == 4) {
            webView.loadUrl = @"http://www.thedaonline.com/";
        }
        else if (button.tag == 5) {
            webView.loadUrl = @"https://weather.com/weather/today/l/39.63,-79.96";
        }
    }
    
    else if ([self.categoryLabel.text isEqualToString:@"Campus Police"])
    {
        if (button.tag == 0) {
            webView.loadUrl = @"http://police.wvu.edu/";
        }
        else if (button.tag == 2) {
            webView.loadUrl = @"http://police.wvu.edu/special-notices/threat-assessment";
        }
        else if (button.tag == 3) {
            webView.loadUrl = @"http://police.wvu.edu/campus-safety/campus-safety";
        }
        else if (button.tag == 4) {
            webView.loadUrl = @"http://emergency.wvu.edu/important_wvu_telephone_numbers";
        }
        else if (button.tag == 5) {
            webView.loadUrl = @"http://emergency.wvu.edu/alert";
        }
        else if (button.tag == 6) {
            webView.loadUrl = @"https://emergency.wvu.edu/";
        }
    }
    else if ([self.categoryLabel.text isEqualToString:@"Greeklife"])
    {
        if (button.tag == 1) {
            webView.loadUrl = @"http://www.aepi.org/";
        }
        else if (button.tag == 2) {
            webView.loadUrl = @"https://www.alphagammarho.org/";
        }
        else if (button.tag == 3) {
            webView.loadUrl = @"http://www.alphaphialpha.studentorgs.wvu.edu/";
        }
        else if (button.tag == 4) {
            webView.loadUrl = @"http://alphasigmaphi.org/";
        }
        else if (button.tag == 5) {
            webView.loadUrl = @"http://wvudelts.studentorgs.wvu.edu/";
        }
        else if (button.tag == 6) {
            webView.loadUrl = @"http://www.kappaalphaorder.org/";
        }
        else if (button.tag == 7) {
            webView.loadUrl = @"http://wvunupes.wix.com/exkappas";
        }
        else if (button.tag == 8) {
            webView.loadUrl = @"http://wvuques.weebly.com/";
        }
        else if (button.tag == 9) {
            webView.loadUrl = @"http://www.phideltatheta.org/";
        }
        else if (button.tag == 10) {
            webView.loadUrl = @"http://www.phigam.org/";
        }
        else if (button.tag == 11) {
            webView.loadUrl = @"http://www.wvuphisigs.com/";
        }
        else if (button.tag == 12) {
            webView.loadUrl = @"https://www.pikes.org/";
        }
        else if (button.tag == 13) {
            webView.loadUrl = @"http://www.sae.net/";
        }
        else if (button.tag == 14) {
            webView.loadUrl = @"http://wvusammy.webs.com/";
        }
        else if (button.tag == 15) {
            webView.loadUrl = @"http://www.sigmachi.org/";
        }
        else if (button.tag == 16) {
            webView.loadUrl = @"http://sigmanuwvu.wix.com/gammapi";
        }
        else if (button.tag == 17) {
            webView.loadUrl = @"http://www.wvusigep.com/";
        }
        else if (button.tag == 18) {
            webView.loadUrl = @"http://www.tke.org/";
        }
        else if (button.tag == 19) {
            webView.loadUrl = @"http://theta-chi.studentorgs.wvu.edu/";
        }
        else if (button.tag == 21) {
            webView.loadUrl = @"http://www.aka1908.com/";
        }
        else if (button.tag == 22) {
            webView.loadUrl = @"http://www.aoiiwvu.com/";
        }
        else if (button.tag == 23) {
            webView.loadUrl = @"https://www.alphaphi.org/Home";
        }
        else if (button.tag == 24) {
            webView.loadUrl = @"http://www.alphaxidelta.org/";
        }
        else if (button.tag == 25) {
            webView.loadUrl = @"http://www.chiomega.com/Home";
        }
        else if (button.tag == 26) {
            webView.loadUrl = @"http://wvu.deltagamma.org/";
        }
        else if (button.tag == 27) {
            webView.loadUrl = @"http://www.deltasigmatheta.org/";
        }
        else if (button.tag == 28) {
            webView.loadUrl = @"http://chapters.kappakappagamma.org/betaupsilon/pages/welcome.php";
        }
        else if (button.tag == 29) {
            webView.loadUrl = @"https://www.pibetaphi.org/pibetaphi/wvu/";
        }
        else if (button.tag == 30) {
            webView.loadUrl = @"http://wvu.sigmakappa.org/";
        }
    }
    else if ([self.categoryLabel.text isEqualToString:@"Nightlife"])
    {
        if (button.tag == 0) {
            webView.loadUrl = @"http://www.yelp.com/search?cflt=restaurants&find_loc=Morgantown%2C+WV";
        }
        else if (button.tag == 1) {
            webView.loadUrl = @"http://www.mountainlair.com/Entertainment/BarsClubs/";
        }
        else if (button.tag == 2) {
            webView.loadUrl = @"http://www.mountainlair.com/BarClubSpecial/";
        }
        else if (button.tag == 3) {
            webView.loadUrl = @"http://www.mountainlair.com/Entertainment/AdultRecreation/";
        }
        else if (button.tag == 4) {
            webView.loadUrl = @"http://mountainlair.wvu.edu/wvupallnight";
        }
        else if (button.tag == 5) {
            webView.loadUrl = @"http://www.morgantownmall.com/";
        }
        else if (button.tag == 6) {
            webView.loadUrl = @"http://www.regmovies.com/Theatres/Theatre-Folder/Regal-Morgantown-Stadium-12-8002";
        }
        else if (button.tag == 7) {
            webView.loadUrl = @"http://www.carmike.com/ShowTimes/city/Morgantown/WV";
        }
        else if (button.tag == 8) {
            webView.loadUrl = @"http://www.mtpocketstheatre.com/";
        }
        else if (button.tag == 9) {
            webView.loadUrl = @"http://diyoutdoors.wvu.edu/";
        }
        else if (button.tag == 10) {
            webView.loadUrl = @"http://sunsetbeach-marina.com/rental/";
        }
        else if (button.tag == 11) {
            webView.loadUrl = @"http://www.yelp.com/biz/suburban-lanes-bowling-center-morgantown";
        }
    }
    else if ([self.categoryLabel.text isEqualToString:@"Parking & Transportation"])
    {
        if (button.tag == 1) {
            webView.loadUrl = @"http://www.busride.org/";
        }
        else if (button.tag == 2) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes";
        }
        else if (button.tag == 3) {
            webView.loadUrl = @"http://www.busride.org/Rider-Guide/Rider-Tools/Wheres-My-Bus";
        }
        else if (button.tag == 4) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/WVU-Campus-Services";
        }
        else if (button.tag == 5) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/WVU-Football-Shuttle-Service";
        }
        else if (button.tag == 7) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/1-Campus-PM";
        }
        else if (button.tag == 8) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/2-DT-Mall-PM";
        }
        else if (button.tag == 9) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/3-Green-Line";
        }
        else if (button.tag == 10) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/4-Orange-Line";
        }
        else if (button.tag == 11) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/6-Gold-Line";
        }
        else if (button.tag == 12) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/7-Red-Line";
        }
        else if (button.tag == 13) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/8-Tyrone";
        }
        else if (button.tag == 14) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/9-Purple-Line";
        }
        else if (button.tag == 15) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/11-Cassville";
        }
        else if (button.tag == 16) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/12-Blue-Line";
        }
        else if (button.tag == 17) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/13-Crown";
        }
        else if (button.tag == 18) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/14-Mountain-Heights";
        }
        else if (button.tag == 19) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/15-Grafton-Road";
        }
        else if (button.tag == 20) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/16-Pink-Line";
        }
        else if (button.tag == 21) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/29-Grey-Line";
        }
        else if (button.tag == 22) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/30-West-Run";
        }
        else if (button.tag == 23) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/38-Blue-Gold-Connector";
        }
        else if (button.tag == 24) {
            webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/44-Valley-View";
        }
        else if (button.tag == 26) {
            webView.loadUrl = @"http://transportation.wvu.edu/prt";
        }
        else if (button.tag == 27) {
            webView.loadUrl = @"http://transportation.wvu.edu/prt/schedule";
        }
        else if (button.tag == 28) {
            webView.loadUrl = @"http://m.wvu.edu/hours/?category=prt";
        }
        else if (button.tag == 29) {
            webView.loadUrl = @"http://transportation.wvu.edu/prt/station-map";
        }
        else if (button.tag == 31) {
            webView.loadUrl = @"http://transportation.wvu.edu/parking/parking-options";
        }
        else if (button.tag == 32) {
            webView.loadUrl = @"http://transportation.wvu.edu/parking/athletic-parking";
        }
        else if (button.tag == 33) {
            webView.loadUrl = @"http://transportation.wvu.edu/parking/parking-maps";
        }
        else if (button.tag == 34) {
            webView.loadUrl = @"http://transportation.wvu.edu/parking/permits";
        }
    }
    else if ([self.categoryLabel.text isEqualToString:@"Sports & Fitness"])
    {
        if (button.tag == 0) {
            webView.loadUrl = @"https://www.ticketreturn.com/WVU/SignIn.aspx";
        }
        else if (button.tag == 1) {
            webView.loadUrl = @"http://www.wvusports.com/";
        }
        else if (button.tag == 2) {
            webView.loadUrl = @"http://www.wvusports.com/calendar/";
        }
        else if (button.tag == 3) {
            webView.loadUrl = @"http://studentreccenter.wvu.edu/about_the_rec_center/student-rec-center-facilities";
        }
        else if (button.tag == 4) {
            webView.loadUrl = @"http://studentreccenter.wvu.edu/about_the_rec_center/student-rec-center-facilities/facility_information";
        }
        else if (button.tag == 5) {
            webView.loadUrl = @"http://adventureclimbing.wvu.edu/";
        }
        else if (button.tag == 6) {
            webView.loadUrl = @"http://www.imleagues.com/spa/club/3e719d31bfb249718f5a7c61c8f92846/home";
        }
        else if (button.tag == 7) {
            webView.loadUrl = @"http://www.imleagues.com/spa/intramural/3e719d31bfb249718f5a7c61c8f92846/home";
        }
    }
    else if ([self.categoryLabel.text isEqualToString:@"Student Health"])
    {
        if  (button.tag == 0){
            webView.loadUrl = @"http://wvumedicine.org/";
        }
        else if (button.tag == 1) {
            webView.loadUrl = @"http://www.well.wvu.edu/";
        }
        else if (button.tag == 3) {
            webView.loadUrl = @"http://wvumedicine.org/ruby-memorial-hospital/";
        }
        else if (button.tag == 5) {
            webView.loadUrl = @"http://m.wvu.edu/hours/?category=health";
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
