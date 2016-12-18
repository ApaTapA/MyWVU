//
//  Webview.h
//  MyWVU
//
//  Created by Thomas Diffendal on 1/1/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <StartApp/StartApp.h>

@interface Webview : UIViewController <UIWebViewDelegate, UIAlertViewDelegate>
{
    BOOL areAdsRemoved;
    BOOL bannerIsVisible;
    STABannerView *bannerView;
    
    IBOutlet UIWebView *webview;
    IBOutlet UIToolbar *webviewToolbar;
    
    IBOutlet UIImageView *logoImage;
    
    IBOutlet UIView *webViewLoadIndicator;
    
    IBOutlet UIImageView *backgroundImage;
}


@property (strong, nonatomic) NSString *loadUrl;

//Activity Indicator Properties
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *activityIndicatorView;

-(IBAction)goHomePage:(id)sender;

@end
