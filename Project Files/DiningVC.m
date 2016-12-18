//
//  DiningVC.m
//  MyWVU
//
//  Created by Thomas Diffendal on 8/16/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "DiningVC.h"
#import "SWRevealViewController.h"
#import "LinksWebview.h"

@interface DiningVC ()

@end

@implementation DiningVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"areAdsRemoved"]) {
        if (bannerView == nil) {
            bannerView = [[STABannerView alloc] initWithSize:STA_AutoAdSize autoOrigin:STAAdOrigin_Bottom
                                                    withView:self.view withDelegate:nil];
            [self.view addSubview:bannerView];        }
        
    }
    else {
        [self doRemoveAds];
    }
}

-(void)doRemoveAds
{
    bannerView.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    areAdsRemoved = [[NSUserDefaults standardUserDefaults] boolForKey:@"areAdsRemoved"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UINavigationBar *academicNavBar = [self.navigationController navigationBar];
    [academicNavBar setBarTintColor:[UIColor colorWithRed:1.0/255.0 green:23.0/255.0 blue:46.0/255.0 alpha:1.0]];
    [academicNavBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Hoefler Text" size:18]}];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.openSlideOut setTarget: self.revealViewController];
        [self.openSlideOut setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self openCampusDiningButtons];
}

-(void)openCampusDiningButtons
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CampusDining" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"WVU"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        DiningVC *wvuCampusDining = [buttonsArray objectAtIndex:i];
        
        UIButton *wvuCampusDiningButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wvuCampusDiningButton setImage:[UIImage imageNamed:wvuCampusDining] forState:UIControlStateNormal];
        [wvuCampusDiningButton setTag:i];
        [wvuCampusDiningButton addTarget:self action:@selector(openCampusDiningLinks:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.diningScroll addSubview:wvuCampusDiningButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                wvuCampusDiningButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                wvuCampusDiningButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                wvuCampusDiningButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                wvuCampusDiningButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.diningScroll addSubview:wvuCampusDiningButton];
        
        
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_diningScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_diningScroll setContentSize:CGSizeMake(320, positionX + 115)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_diningScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_diningScroll setContentSize:CGSizeMake(375, positionX + 5)];
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
                    [_diningScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_diningScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_diningScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_diningScroll setContentSize:CGSizeMake(375, positionX + 50)];
                }
            }
        }
    }
}

-(void)openCampusDiningLinks:(id)sender
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
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LinksWebview *webView = [segue destinationViewController];
    
    UIButton *button = sender;
    
    if (button.tag == 0) {
        webView.loadUrl = @"https://mymountaineercard.wvu.edu/login/ldap.php";
        webView.categoryType = @"campusDining";
    }
    else if (button.tag == 1) {
        webView.loadUrl = @"http://diningservices.wvu.edu/locations/dining-halls/arnold-s-diner";
        webView.categoryType = @"campusDining";
    }
    else if (button.tag == 2) {
        webView.loadUrl = @"http://diningservices.wvu.edu/locations/dining-halls/boreman-bistro";
        webView.categoryType = @"campusDining";
    }
    else if (button.tag == 3) {
        webView.loadUrl = @"http://diningservices.wvu.edu/locations/dining-halls/cafe-evansdale";
        webView.categoryType = @"campusDining";
    }
    else if (button.tag == 4) {
        webView.loadUrl = @"http://diningservices.wvu.edu/about/locations/mountainlair/hatfields";
        webView.categoryType = @"campusDining";
    }
    else if (button.tag == 5) {
        webView.loadUrl = @"http://diningservices.wvu.edu/locations/dining-halls/summit-cafe";
        webView.categoryType = @"campusDining";
    }
    else if (button.tag == 6) {
        webView.loadUrl = @"http://diningservices.wvu.edu/locations/dining-halls/terrace-room";
        webView.categoryType = @"campusDining";
    }
    else if (button.tag == 7) {
        webView.loadUrl = @"http://diningservices.wvu.edu/locations/mountainlair";
        webView.categoryType = @"campusDining";
    }
    else if (button.tag == 8) {
        webView.loadUrl = @"http://diningservices.wvu.edu/locations/quick-service/bits-and-bytes";
        webView.categoryType = @"campusDining";
    }
    else if (button.tag == 9) {
        webView.loadUrl = @"http://diningservices.wvu.edu/locations/quick-service/brew-n-gold-cafe";
        webView.categoryType = @"campusDining";
    }
    else if (button.tag == 10) {
        webView.loadUrl = @"http://diningservices.wvu.edu/about/locations/coffee-shops";
        webView.categoryType = @"campusDining";
    }
    else if (button.tag == 11) {
        webView.loadUrl = @"http://diningservices.wvu.edu/locations/quick-service/the-greenhouse";
        webView.categoryType = @"campusDining";
    }
    else if (button.tag == 12) {
        webView.loadUrl = @"http://diningservices.wvu.edu/locations/quick-service/lyons-den";
        webView.categoryType = @"campusDining";
    }
    else if (button.tag == 13) {
        webView.loadUrl = @"http://diningservices.wvu.edu/locations/quick-service/summit-grab-n-go";
        webView.categoryType = @"campusDining";
    }
    else if (button.tag == 14) {
        webView.loadUrl = @"http://evansdalecrossing.wvu.edu/restaurants";
        webView.categoryType = @"campusDining";
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
