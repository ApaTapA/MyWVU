
//
//  SlideOutVC.m
//  MyWVU
//
//  Created by Thomas Diffendal on 8/15/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "SlideOutVC.h"
#import "SlideCustomCell.h"
#import "SWRevealViewController.h"
#import <StoreKit/StoreKit.h>

@interface SlideOutVC () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (nonatomic, strong)NSArray *categoriesArray;
@property (nonatomic, strong)NSDictionary *category;

@end

NSArray *categories;

@implementation SlideOutVC

@synthesize categoriesArray, category;

#define kRemoveAdsProductIdentifier @"com.thomasdiffendal.mywvu.removeads"

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"SlideOut" ofType:@"plist"];
    categoriesArray = [NSArray arrayWithContentsOfFile:path];
    
    [slideOutTableView setDelegate:self];
    [slideOutTableView setDataSource:self];
    
    //Register Custom Table Cell
    
    [slideOutTableView registerNib:[UINib nibWithNibName:NSStringFromClass([SlideCustomCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SlideCustomCell class])];
    
    categories = @[@"academic",@"campusDining",@"campusInformation",@"newsEvents",@"campusPolice",@"greeklife",@"nightlife",@"parkingTransportation",@"sportsFitness",@"studentHealth",@"removeAds",@"restorePurchase",@"feedback",@"help",@"about"];

}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [categoriesArray count];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!areAdsRemoved)
    {
        if (indexPath.row == 10)
        {
            cell.backgroundColor = [UIColor whiteColor];
        }
        else if (indexPath.row == 13)
        {
            cell.backgroundColor = [UIColor whiteColor];
        }
        else
        {
            cell.backgroundColor = [UIColor whiteColor];
        }
    }
    else if (areAdsRemoved)
    {
        if (indexPath.row == 10)
        {
            cell.backgroundColor = [UIColor whiteColor];
        }
        else
        {
            cell.backgroundColor = [UIColor whiteColor];
            
        }
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SlideCustomCell *customCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SlideCustomCell class])
                                                                  forIndexPath:indexPath];
    
    //Configure the Cell...
    
    category = categoriesArray[indexPath.row];
    
    NSString *categoryLabel = category[@"categoryLabel"];
    NSString *categoryIcon  = category[@"categoryIcon"];
    
    UIImage *image = [UIImage imageNamed:categoryIcon];
    
    customCell.categoryLabel.text = categoryLabel;
    customCell.iconImage.image = image;
    
    if (!areAdsRemoved)
    {
        if (indexPath.row == 10 || indexPath.row == 13)
        {
            customCell.userInteractionEnabled = NO;
        }
        else
        {
            customCell.backgroundColor = [UIColor whiteColor];
            customCell.userInteractionEnabled = YES;
        }
    }
    
    else if (areAdsRemoved)
    {
        if (indexPath.row == 11 || indexPath.row == 12 || indexPath.row == 13)
        {
            customCell.hidden = YES;
            customCell.userInteractionEnabled = NO;
        }
        else if (indexPath.row == 10)
        {
            customCell.userInteractionEnabled = NO;
        }
        else if (indexPath.row == 14)
        {
            customCell.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:4.0/255.0 blue:68.0/255.0 alpha:1.0];
            customCell.userInteractionEnabled = YES;
        }
    }
    
    return customCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"academic"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"campusDining"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if (indexPath.row == 2)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"campusInformation"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if (indexPath.row == 3)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"newsEvents"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if (indexPath.row == 4)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"campusPolice"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if (indexPath.row == 5)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"greeklife"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if (indexPath.row == 6)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"nightlife"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if (indexPath.row == 7)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"parkingTransportation"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if (indexPath.row == 8)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"sportsFitness"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if (indexPath.row == 9)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"studentHealth"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    
    else if (indexPath.row == 11)
    {
        {
            NSLog(@"User requests to remove ads");
            
            if([SKPaymentQueue canMakePayments])
            {
                NSLog(@"User can make payments");
                
                SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kRemoveAdsProductIdentifier]];
                productsRequest.delegate = self;
                [productsRequest start];
                
            }
            else
            {
                NSLog(@"User cannot make payments due to parental controls");
                //this is called the user cannot make payments, most likely due to parental controls
            }
        }
    }
    else if (indexPath.row == 12)
    {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    }
    else if (indexPath.row == 14)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"feedback"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if (indexPath.row == 15)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"help"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if (indexPath.row == 16)
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"aboutUs"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    
    
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    SKProduct *validProduct = nil;
    int count = [response.products count];
    if(count > 0){
        validProduct = [response.products objectAtIndex:0];
        NSLog(@"Products Available!");
        [self purchase:validProduct];
    }
    else if(!validProduct){
        NSLog(@"No products available");
        //this is called if your product id is not valid, this shouldn't be called unless that happens.
    }
}

- (IBAction)purchase:(SKProduct *)product{
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}


- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    //    NSLog(@"received restored transactions: %i", queue.transactions.count);
    for(SKPaymentTransaction *transaction in queue.transactions){
        if(transaction.transactionState == SKPaymentTransactionStateRestored){
            //called when the user successfully restores a purchase
            //            NSLog(@"Transaction state -> Restored");
            
            //            iapLoading.hidden = YES;
            //            [iap stopAnimating];
            
            [self doRemoveAds];
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            break;
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"academic"];
    
    for(SKPaymentTransaction *transaction in transactions)
    {
        switch(transaction.transactionState){
            case SKPaymentTransactionStatePurchasing: NSLog(@"Transaction state -> Purchasing");
                //called when the user is in the process of purchasing, do not add any of your own code here.
                break;
            case SKPaymentTransactionStatePurchased:
                
                //this is called when the user has successfully purchased the package (Cha-Ching!)
                [self doRemoveAds];
                
                NSLog(@"SAVED INTO NSUSER");
                
                //                iapLoading.hidden = YES;
                //                [iap stopAnimating];
                //                [self showAcademicButtons];
                
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                NSLog(@"Transaction state -> Purchased");
                
                [self.revealViewController pushFrontViewController:vc animated:YES];
                
                
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Transaction state -> Restored");
                [self doRemoveAds];
                
                [self.revealViewController pushFrontViewController:vc animated:YES];
                
                //                iapLoading.hidden = YES;
                //                [iap stopAnimating];
                //                [self showAcademicButtons];
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateFailed:
                
                if(transaction.error.code == SKErrorPaymentCancelled)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase Cancelled"
                                                                    message:@"Your purchase was cancelled. Please try again."
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
        }
    }
}

-(void)doRemoveAds
{
    areAdsRemoved = YES;
    [[NSUserDefaults standardUserDefaults] setBool:areAdsRemoved forKey:@"areAdsRemoved"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!areAdsRemoved)
    {
        if (indexPath.row == 10 || indexPath.row == 13)
        {
            return 1;
        }
        else
        {
            return 45;
        }
    }
    else
    {
        if (indexPath.row == 10)
        {
            return 1;
        }
        else if (indexPath.row == 11 || indexPath.row == 12 || indexPath.row ==  13)
        {
            
            return 0;
        }
        else if (indexPath.row == 14)
        {
            return 45;
        }
        else
        {
            return 45;
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
