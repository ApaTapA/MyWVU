//
//  ParkingTransportationVC.m
//  MyWVU
//
//  Created by Thomas Diffendal on 11/21/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "ParkingTransportationVC.h"
#import "SWRevealViewController.h"
#import "LinksWebview.h"

@interface ParkingTransportationVC ()

@end

@implementation ParkingTransportationVC

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
    
    [self showParkingAndTransportationButtons];
}

-(void)showParkingAndTransportationButtons
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ParkingAndTransportation" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"WVU"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        ParkingTransportationVC *wvuParkingTransportation = [buttonsArray objectAtIndex:i];
        
        UIButton *wvuParkingTransportationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [wvuParkingTransportationButton setImage:[UIImage imageNamed:wvuParkingTransportation] forState:UIControlStateNormal];
        [wvuParkingTransportationButton setTag:i];
        [wvuParkingTransportationButton addTarget:self action:@selector(openParkingTransportationLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.parkingScroll addSubview:wvuParkingTransportationButton];
        
        if (wvuParkingTransportationButton.tag == 0) {
            wvuParkingTransportationButton.adjustsImageWhenHighlighted = NO;
        }
        else if (wvuParkingTransportationButton.tag == 5) {
            wvuParkingTransportationButton.adjustsImageWhenHighlighted = NO;
        }
        else if (wvuParkingTransportationButton.tag == 24) {
            wvuParkingTransportationButton.adjustsImageWhenHighlighted = NO;
        }
        else if (wvuParkingTransportationButton.tag == 29) {
            wvuParkingTransportationButton.adjustsImageWhenHighlighted = NO;
        }
        else if (wvuParkingTransportationButton.tag == 35) {
            wvuParkingTransportationButton.adjustsImageWhenHighlighted = NO;
        }
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                wvuParkingTransportationButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                wvuParkingTransportationButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                wvuParkingTransportationButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                wvuParkingTransportationButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.parkingScroll addSubview:wvuParkingTransportationButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_parkingScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_parkingScroll setContentSize:CGSizeMake(320, positionX + 115)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_parkingScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_parkingScroll setContentSize:CGSizeMake(320, positionX + 5)];
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
                    [_parkingScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_parkingScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_parkingScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_parkingScroll setContentSize:CGSizeMake(375, positionX + 50)];
                }
            }
        }
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
    else if (button.tag ==25) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==26) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==27) {
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
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:3042935502"]];
    }
    else if (button.tag ==40) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:3042927441"]];
    }
    else if (button.tag ==41) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:3042918294"]];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LinksWebview *webView = [segue destinationViewController];
    
    UIButton *button = sender;
    
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
        webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/4-Orange-Line-Tripper-Exp";
    }
    else if (button.tag == 12) {
        webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/6-Gold-Line";
    }
    else if (button.tag == 13) {
        webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/7-Red-Line";
    }
    else if (button.tag == 14) {
        webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/8-Tyrone";
    }
    else if (button.tag == 15) {
        webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/9-Purple-Line";
    }
    else if (button.tag == 16) {
        webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/11-Cassville";
    }
    else if (button.tag == 17) {
        webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/12-Blue-Line";
    }
    else if (button.tag == 18) {
        webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/13-Crown";
    }
    else if (button.tag == 19) {
        webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/14-Mountain-Heights";
    }
    else if (button.tag == 20) {
        webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/15-Grafton-Road";
    }
    else if (button.tag == 21) {
        webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/16-Pink-Line";
    }
    else if (button.tag == 22) {
        webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/29-Grey-Line";
    }
    else if (button.tag == 23) {
        webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/30-West-Run";
    }
    else if (button.tag == 24) {
        webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/38-Blue-Gold-Connector";
    }
    else if (button.tag == 25) {
        webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/39-Beechurst-Express";
    }
    else if (button.tag == 26) {
        webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/43-Westover-Park-Ride";
    }
    else if (button.tag == 27) {
        webView.loadUrl = @"http://www.busride.org/Maps-Schedules/Routes/44-Valley-View";
    }
    else if (button.tag == 29) {
        webView.loadUrl = @"http://transportation.wvu.edu/prt";
    }
    else if (button.tag == 30) {
        webView.loadUrl = @"http://transportation.wvu.edu/prt/schedule";
    }
    else if (button.tag == 31) {
        webView.loadUrl = @"http://m.wvu.edu/hours/?category=prt";
    }
    else if (button.tag == 32) {
        webView.loadUrl = @"http://transportation.wvu.edu/prt/station-map";
    }
    else if (button.tag == 34) {
        webView.loadUrl = @"http://transportation.wvu.edu/parking/parking-options";
    }
    else if (button.tag == 35) {
        webView.loadUrl = @"http://transportation.wvu.edu/parking/athletic-parking";
    }
    else if (button.tag == 36) {
        webView.loadUrl = @"http://transportation.wvu.edu/parking/parking-maps";
    }
    else if (button.tag == 37) {
        webView.loadUrl = @"http://transportation.wvu.edu/parking/permits";
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
