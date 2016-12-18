//
//  Feedback.m
//  MyWVU
//
//  Created by Thomas Diffendal on 1/4/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "Feedback.h"

@interface Feedback ()

@end

@implementation Feedback

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
        {
            //IPHONE 6 PLUS
            
            [lblFeedback setFrame:CGRectMake(134, 20, 147, 42)];
            [btnComments setFrame:CGRectMake(67, 105, 280, 40)];
            [btnShare setFrame:CGRectMake(67, 175, 280, 40)];
            [btnRate setFrame:CGRectMake(67, 245, 280, 40)];
            [btnFollow setFrame:CGRectMake(67, 315, 280, 40)];
            [btnFacebook setFrame:CGRectMake(67, 385, 280, 40)];
            [btnInstagram setFrame:CGRectMake(67, 455, 280, 40)];
            [btnWebsite setFrame:CGRectMake(67, 525, 280, 40)];
        }
        
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            //IPHONE 5/5s/5c
            [lblFeedback setFrame:CGRectMake(100, 20, 121, 30)];
            [btnComments setFrame:CGRectMake(35, 75, 250, 40)];
            [btnShare setFrame:CGRectMake(35, 135, 250, 40)];
            [btnRate setFrame:CGRectMake(35, 195, 250, 40)];
            [btnFollow setFrame:CGRectMake(35, 255, 250, 40)];
            [btnFacebook setFrame:CGRectMake(35, 315, 250, 40)];
            [btnInstagram setFrame:CGRectMake(35, 375, 250, 40)];
            [btnWebsite setFrame:CGRectMake(35, 435, 250, 40)];
            
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
        {
            //IPHONE 4
            [lblFeedback setFrame:CGRectMake(87, 20, 142, 42)];
            [btnComments setFrame:CGRectMake(35, 80, 240, 30)];
            [btnShare setFrame:CGRectMake(35, 130, 240, 30)];
            [btnRate setFrame:CGRectMake(35, 180, 240, 30)];
            [btnFollow setFrame:CGRectMake(35, 230, 240, 30)];
            [btnFacebook setFrame:CGRectMake(35, 280, 240, 30)];
            [btnInstagram setFrame:CGRectMake(35, 330, 240, 30)];
            [btnWebsite setFrame:CGRectMake(35, 380, 240, 30)];
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
            [self.view addSubview:bannerView];
        }
        
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

- (IBAction)shareMYWVU:(id)sender
{
    NSString *shareText = @"Get connected to West Virginia University! Check out MyWVU. Get the App Here https://itunes.apple.com/us/app/mywvu/id1071012498?ls=1&mt=8";
    NSArray *itemsToShare = @[shareText];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)rateMYWVU:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/mywvu/id1071012498?ls=1&mt=8"]];
}

- (IBAction)followTwitter:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/ApaTapA_LLC"]];
}

- (IBAction)likeFacebook:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/apatapallc"]];
}

- (IBAction)openWebsite:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://apatapallc.wix.com/apatapa"]];
}

- (IBAction)followInstagram:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://instagram.com/apatapa_apps/"]];
}

-(IBAction)openEmail:(id)sender
{
    // Email Subject
    NSString *emailTitle = @" ";
    // Email Content
    NSString *messageBody = @" ";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"apatapallc@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (result == MFMailComposeResultCancelled) {
        UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"Suggestions & Comments" message:@"Message Canceled!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert1 show];
    }
    else if (result == MFMailComposeResultSaved) {
        UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:@"Suggestions & Comments" message:@"Message Saved!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert2 show];
    }
    else if (result == MFMailComposeResultSent) {
        UIAlertView *alert3 = [[UIAlertView alloc]initWithTitle:@"Suggestions & Comments" message:@"Message Sent!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert3 show];
    }
    else if (result == MFMailComposeResultFailed) {
        UIAlertView *alert4 = [[UIAlertView alloc]initWithTitle:@"Suggestions & Comments" message:@"Message Failed!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert4 show];
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
