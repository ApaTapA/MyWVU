//
//  Information.m
//  MyWVU
//
//  Created by Thomas Diffendal on 1/4/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "Information.h"

@interface Information ()

@end

@implementation Information

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int) [[UIScreen mainScreen] bounds].size.height == 736)
        {
            //IPHONE 6 PLUS
            
            [lblTitle setFrame:CGRectMake(51, 11, 313, 50)];
            [lblDevelop setFrame:CGRectMake(117, 50, 180, 21)];
            [lblProgram setFrame:CGRectMake(125, 110, 164, 39)];
            [lblThomas setFrame:CGRectMake(125, 145, 164, 39)];
            [lblGraphics setFrame:CGRectMake(125, 215, 164, 39)];
            [lblScott setFrame:CGRectMake(125, 250, 164, 39)];
            [lblDisclaimer setFrame:CGRectMake(140, 320, 135, 50)];
            [lblDisclaimerText setFrame:CGRectMake(85, 342, 244, 111)];
            [lblVersion setFrame:CGRectMake(140, 686, 135, 50)];
        }
        
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            //IPHONE 5/5s/5c
            [lblTitle setFrame:CGRectMake(31, 11, 258, 50)];
            [lblTitle setFont:[UIFont fontWithName:@"Hoefler Text" size:30]];
            [lblDevelop setFrame:CGRectMake(70, 46, 181, 21)];
            [lblDevelop setFont:[UIFont fontWithName:@"Hoefler Text" size:13]];
            [lblProgram setFrame:CGRectMake(74, 88, 173, 39)];
            [lblThomas setFrame:CGRectMake(74, 118, 164, 39)];
            [lblGraphics setFrame:CGRectMake(78, 165, 164, 39)];
            [lblScott setFrame:CGRectMake(78, 195, 164, 39)];
            [lblDisclaimer setFrame:CGRectMake(93, 242, 135, 50)];
            [lblDisclaimerText setFrame:CGRectMake(38, 272, 244, 111)];
            [lblVersion setFrame:CGRectMake(93, 518, 135, 50)];
            
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
        {
            //IPHONE 4s
            [lblTitle setFrame:CGRectMake(31, 11, 258, 50)];
            [lblTitle setFont:[UIFont fontWithName:@"Hoefler Text" size:40]];
            [lblDevelop setFrame:CGRectMake(86, 50, 149, 21)];
            [lblDevelop setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            [lblProgram setFrame:CGRectMake(78, 87, 164, 39)];
            [lblProgram setFont:[UIFont fontWithName:@"Hoefler Text" size:20]];
            [lblThomas setFrame:CGRectMake(78, 111, 164, 39)];
            [lblThomas setFont:[UIFont fontWithName:@"Hoefler Text" size:13]];
            [lblGraphics setFrame:CGRectMake(78, 167, 164, 39)];
            [lblGraphics setFont:[UIFont fontWithName:@"Hoefler Text" size:20]];
            [lblScott setFrame:CGRectMake(78, 191, 164, 39)];
            [lblScott setFont:[UIFont fontWithName:@"Hoefler Text" size:13]];
            [lblDisclaimer setFrame:CGRectMake(93, 247, 135, 50)];
            [lblGraphics setFont:[UIFont fontWithName:@"Hoefler Text" size:20]];
            [lblDisclaimerText setFrame:CGRectMake(38, 271, 244, 111)];
             [lblVersion setFrame:CGRectMake(93, 430, 135, 50)];
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
