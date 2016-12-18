//
//  AcademicVC.m
//  MyWVU
//
//  Created by Thomas Diffendal on 8/15/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "AcademicVC.h"
#import "LinksWebview.h"
#import "SWRevealViewController.h"

@interface AcademicVC ()

@end

@implementation AcademicVC

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
    
    [self showAcademicButtons];
}

-(void)showAcademicButtons
{
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Academic" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"WVU"];

int positionX = 13;

for (int i = 0; i < [buttonsArray count] ; i++) {
    
    AcademicVC *wvuAcademic = [buttonsArray objectAtIndex:i];
    
    UIButton *wvuAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [wvuAcademicButton setImage:[UIImage imageNamed:wvuAcademic] forState:UIControlStateNormal];
    [wvuAcademicButton setTag:i];
    [wvuAcademicButton addTarget:self action:@selector(openAcademicLinks:) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    [self.academicScroll addSubview:wvuAcademicButton];
    
    if (areAdsRemoved) {
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                [_academicScroll setContentSize:CGSizeMake(320, positionX + 30)];
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                [_academicScroll setContentSize:CGSizeMake(320, positionX + 115)];
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4
                [_academicScroll setContentSize:CGSizeMake(320, positionX + 200)];
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 PLUS
                [_academicScroll setContentSize:CGSizeMake(320, positionX + 5)];
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
                [_academicScroll setContentSize:CGSizeMake(320, positionX + 75)];
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                [_academicScroll setContentSize:CGSizeMake(320, positionX + 163)];
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4
                [_academicScroll setContentSize:CGSizeMake(320, positionX + 245)];
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //Iphone 6 Plus
                [_academicScroll setContentSize:CGSizeMake(375, positionX + 50)];
            }
        }
    }
}
}

-(void)openAcademicLinks:(id)sender
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
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LinksWebview *webView = [segue destinationViewController];
    
    UIButton *button = sender;
    
    
    if (button.tag == 0) {
        webView.loadUrl = @"https://ecampus.wvu.edu/webapps/login/";
        webView.categoryType = @"Academic";
    }
    else if (button.tag ==1) {
        webView.loadUrl = @"https://mix.wvu.edu/gmail/GoogleRedirect.jsp";
        webView.categoryType = @"Academic";
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
        webView.loadUrl = @"http://www.students.wvu.edu/";
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
        webView.loadUrl = @"https://libwvu.worldcat.org/wcpa/secure?postAuth=https%3A%2F%2Flibwvu.worldcat.org%2F";
    }
    else if (button.tag == 18) {
        webView.loadUrl = @"https://lib.wvu.edu/services/computers/availableComputers/";
    }
    else if (button.tag == 19) {
        webView.loadUrl = @"https://myprinting.wvu.edu/myprintcenter/";
    }
    else if (button.tag == 20) {
        webView.loadUrl = @"http://undergraduate.wvu.edu/";
    }
    else if (button.tag == 21) {
        webView.loadUrl = @"http://careerservices.wvu.edu/";
    }
    else if (button.tag == 22) {
        webView.loadUrl = @"https://directory.wvu.edu/";
    }
    else if (button.tag == 23) {
        webView.loadUrl = @"http://retention.wvu.edu/tutoring";
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
