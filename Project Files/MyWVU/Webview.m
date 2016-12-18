//
//  Webview.m
//  MyWVU
//
//  Created by Thomas Diffendal on 1/1/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "Webview.h"

@interface Webview ()

@end

@implementation Webview

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            //IPHONE 5/5s/5c
            [webview setFrame:CGRectMake(0, 44, 320, 530)];
            [self.activityIndicatorView setFrame:CGRectMake(120, 244, 80, 80)];
            [logoImage setFrame:CGRectMake(107, -5, 106, 54)];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
        {
            //IPHONE 4s
            [webview setFrame:CGRectMake(0, 44, 320, 386)];
            [self.activityIndicatorView setFrame:CGRectMake(120, 200, 80, 80)];
            [logoImage setFrame:CGRectMake(108, -5, 104, 54)];
            
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
        {
            //IPHONE 6 PLUS
            [webview setFrame:CGRectMake(0, 44, 414, 638)];
            [self.activityIndicatorView setFrame:CGRectMake(167, 328, 80, 80)];
            [logoImage setFrame:CGRectMake(142, -10, 130, 64)];
            [webviewToolbar setFrame:CGRectMake(0, 0, 414, 44)];
            [backgroundImage setFrame:CGRectMake(0, 0, 414, 736)];
            
        }
    }
    
    self.activityIndicatorView.layer.cornerRadius = 5;
    
    //Set the Webview Delegate to "SELF"
    webview.delegate = self;
    
    webview.scalesPageToFit = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
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

    //URL Request Object
    NSURLRequest *requestUrl = [NSURLRequest requestWithURL:[NSURL URLWithString:_loadUrl]];
    
    //Load the Request in the UIWebview
    [webview loadRequest:requestUrl];
}

-(void)doRemoveAds
{
        bannerView.hidden = YES;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                [webview setFrame:CGRectMake(0, 44, 320, 525)];
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                [webview setFrame:CGRectMake(0, 44, 375, 623)];
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4
                [webview setFrame:CGRectMake(0, 44, 320, 436)];
            }
            else if ((int) [[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 PLUS
                [webview setFrame:CGRectMake(0, 44, 414, 692)];
                
            }
        }
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    webView.scrollView.scrollEnabled = NO;
    self.activityIndicatorView.hidden = NO;
    [self.activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *javaScript = @"function myFunction(){return 1+1;}";
    [webView stringByEvaluatingJavaScriptFromString:javaScript];
    
    self.activityIndicatorView.hidden = YES;
    [self.activityIndicator stopAnimating];
    webView.scrollView.scrollEnabled = YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.activityIndicatorView.hidden = YES;
    [self.activityIndicator stopAnimating];
    
    if ([error code] == NSURLErrorCancelled) return; {
        
        UIAlertView *webViewFailAlert = [[UIAlertView alloc] initWithTitle:@"Failed to Load" message:@"Please check internet connection" delegate:self cancelButtonTitle:@"Go Back" otherButtonTitles:@"Try Again", nil];
        [webViewFailAlert setTag:1];
        
        [webViewFailAlert show];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ((alertView.tag =1)) {
        if (buttonIndex == 0){
            NSString * storyboardName = @"Main";
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"mainMenu"];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
}

-(IBAction)goHomePage:(id)sender
{
    //URL Request Object
    NSURLRequest *requestUrl = [NSURLRequest requestWithURL:[NSURL URLWithString:_loadUrl]];
    
    //Load the Request in the UIWebview
    [webview loadRequest:requestUrl];
    
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
