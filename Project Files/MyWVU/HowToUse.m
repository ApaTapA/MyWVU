//
//  HowToUse.m
//  MyWVU
//
//  Created by Thomas Diffendal on 1/4/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "HowToUse.h"

@interface HowToUse ()

@end

@implementation HowToUse

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
        {
            //IPHONE 6 PLUS
            
            [lblHowToUse setFrame:CGRectMake(74, 20, 267, 50)];
            [imgRefresh setFrame:CGRectMake(74, 81, 105, 105)];
            [lblRefresh setFrame:CGRectMake(235, 109, 118, 50)];
            [imgBack setFrame:CGRectMake(74, 181, 105, 105)];
            [lblBack setFrame:CGRectMake(235, 209, 118, 50)];
            [imgWVULogo setFrame:CGRectMake(0, 281, 191, 105)];
            [lblWVULogo setFrame:CGRectMake(235, 309, 153, 50)];
            [imgForward setFrame:CGRectMake(74, 381, 105, 105)];
            [lblForward setFrame:CGRectMake(235, 409, 153, 50)];
            [imgClose setFrame:CGRectMake(74, 481, 105, 105)];
            [lblClose setFrame:CGRectMake(235, 509, 153, 50)];
        }
        
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            //IPHONE 5/5s/5c
            [lblHowToUse setFrame:CGRectMake(70, 11, 180, 50)];
            [imgRefresh setFrame:CGRectMake(20, 90, 75, 75)];
            [lblRefresh setFrame:CGRectMake(182, 103, 118, 50)];
            [imgBack setFrame:CGRectMake(20, 175, 75, 75)];
            [lblBack setFrame:CGRectMake(182, 194, 108, 50)];
            [imgWVULogo setFrame:CGRectMake(10, 260, 130, 75)];
            [lblWVULogo setFrame:CGRectMake(182, 273, 153, 50)];
            [imgForward setFrame:CGRectMake(20, 345, 75, 75)];
            [lblForward setFrame:CGRectMake(182, 358, 153, 50)];
            [imgClose setFrame:CGRectMake(20, 430, 75, 75)];
            [lblClose setFrame:CGRectMake(182, 444, 133, 50)];
            
            [lblHowToUse setFont:[UIFont fontWithName:@"Hoefler Text" size:30]];
            [lblRefresh setFont:[UIFont fontWithName:@"Hoefler Text" size:22]];
            [lblBack setFont:[UIFont fontWithName:@"Hoefler Text" size:22]];
            [lblWVULogo setFont:[UIFont fontWithName:@"Hoefler Text" size:22]];
            [lblForward setFont:[UIFont fontWithName:@"Hoefler Text" size:22]];
            [lblClose setFont:[UIFont fontWithName:@"Hoefler Text" size:22]];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
        {
            //IPHONE 4s
            [lblHowToUse setFrame:CGRectMake(56, 11, 208, 50)];
            [imgRefresh setFrame:CGRectMake(56, 85, 50, 50)];
            [lblRefresh setFrame:CGRectMake(182, 85, 118, 50)];
            [imgBack setFrame:CGRectMake(56, 150, 50, 50)];
            [lblBack setFrame:CGRectMake(182, 150, 108, 50)];
            [imgWVULogo setFrame:CGRectMake(25, 225, 120, 50)];
            [lblWVULogo setFrame:CGRectMake(182, 225, 153, 50)];
            [imgForward setFrame:CGRectMake(56, 300, 50, 50)];
            [lblForward setFrame:CGRectMake(182, 300, 153, 50)];
            [imgClose setFrame:CGRectMake(56, 375, 50, 50)];
            [lblClose setFrame:CGRectMake(182, 375, 153, 50)];
            
            [lblHowToUse setFont:[UIFont fontWithName:@"Hoefler Text" size:26]];
            [lblRefresh setFont:[UIFont fontWithName:@"Hoefler Text" size:22]];
            [lblBack setFont:[UIFont fontWithName:@"Hoefler Text" size:22]];
            [lblWVULogo setFont:[UIFont fontWithName:@"Hoefler Text" size:22]];
            [lblForward setFont:[UIFont fontWithName:@"Hoefler Text" size:22]];
            [lblClose setFont:[UIFont fontWithName:@"Hoefler Text" size:22]];
        }
    }
}

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
