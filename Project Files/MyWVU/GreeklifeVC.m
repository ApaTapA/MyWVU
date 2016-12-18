//
//  GreeklifeVC.m
//  MyWVU
//
//  Created by Thomas Diffendal on 11/21/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "GreeklifeVC.h"
#import "SWRevealViewController.h"
#import "LinksWebview.h"

@interface GreeklifeVC ()

@end

@implementation GreeklifeVC

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
    
    [self showGreeklifeButtons];
}

-(void)showGreeklifeButtons
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Greeklife" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"WVU"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        GreeklifeVC *wvuGreeklife = [buttonsArray objectAtIndex:i];
        
        UIButton *wvuGreeklifeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wvuGreeklifeButton setImage:[UIImage imageNamed:wvuGreeklife] forState:UIControlStateNormal];
        [wvuGreeklifeButton setTag:i];
        [wvuGreeklifeButton addTarget:self action:@selector(openGreeklifeLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.greeklifeScroll addSubview:wvuGreeklifeButton];
        
        if (wvuGreeklifeButton.tag == 0) {
            wvuGreeklifeButton.adjustsImageWhenHighlighted = NO;
        }
        else if (wvuGreeklifeButton.tag == 20) {
            wvuGreeklifeButton.adjustsImageWhenHighlighted = NO;
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                wvuGreeklifeButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                wvuGreeklifeButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                wvuGreeklifeButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                wvuGreeklifeButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.greeklifeScroll addSubview:wvuGreeklifeButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_greeklifeScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_greeklifeScroll setContentSize:CGSizeMake(320, positionX + 115)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_greeklifeScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_greeklifeScroll setContentSize:CGSizeMake(320, positionX + 5)];
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
                    [_greeklifeScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_greeklifeScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_greeklifeScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_greeklifeScroll setContentSize:CGSizeMake(375, positionX + 50)];
                }
            }
        }
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LinksWebview *webView = [segue destinationViewController];
    
    UIButton *button = sender;
    
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
        webView.loadUrl = @"http://www.kappaalphapsi1911.com/";
    }
    else if (button.tag == 8) {
        webView.loadUrl = @"http://www.oppf.org/";
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
        webView.loadUrl = @"http://www.sigep.org/";
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
        webView.loadUrl = @"http://wvu.alphaomicronpi.org/";
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
        webView.loadUrl = @"http://www.wvu.kappa.org/";
    }
    else if (button.tag == 29) {
        webView.loadUrl = @"https://www.pibetaphi.org/pibetaphi/wvu/";
    }
    else if (button.tag == 30) {
        webView.loadUrl = @"http://wvu.sigmakappa.org/";
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
