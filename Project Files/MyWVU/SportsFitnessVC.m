//
//  SportsFitnessVC.m
//  MyWVU
//
//  Created by Thomas Diffendal on 11/21/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "SportsFitnessVC.h"
#import "SWRevealViewController.h"
#import "LinksWebview.h"

@interface SportsFitnessVC ()

@end

@implementation SportsFitnessVC

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
    
    [self showSportsAndFitnessButtons];
}

-(void)showSportsAndFitnessButtons
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SportsAndFitness" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"WVU"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        SportsFitnessVC *wvuSportsFitness = [buttonsArray objectAtIndex:i];
        
        UIButton *wvuSportsFitnessButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wvuSportsFitnessButton setImage:[UIImage imageNamed:wvuSportsFitness] forState:UIControlStateNormal];
        [wvuSportsFitnessButton setTag:i];
        [wvuSportsFitnessButton addTarget:self action:@selector(openSportsFitnessLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.sportsScroll addSubview:wvuSportsFitnessButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                wvuSportsFitnessButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                wvuSportsFitnessButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                wvuSportsFitnessButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                wvuSportsFitnessButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.sportsScroll addSubview:wvuSportsFitnessButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_sportsScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_sportsScroll setContentSize:CGSizeMake(320, positionX + 110)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_sportsScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_sportsScroll setContentSize:CGSizeMake(320, positionX + 5)];
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
                    [_sportsScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_sportsScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_sportsScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_sportsScroll setContentSize:CGSizeMake(375, positionX + 50)];
                }
            }
        }
        
    }
}

-(void)openSportsFitnessLinks:(id)sender
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
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LinksWebview *webView = [segue destinationViewController];
    
    UIButton *button = sender;
    
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
        webView.loadUrl = @"http://studentreccenter.wvu.edu/";
    }
    else if (button.tag == 4) {
        webView.loadUrl = @"http://studentreccenter.wvu.edu/facility/hours";
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
