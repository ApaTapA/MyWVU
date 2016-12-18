//
//  LinksWebview.h
//  MyWVU
//
//  Created by Thomas Diffendal on 11/22/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StartApp/StartApp.h>

@interface LinksWebview : UIViewController <UIWebViewDelegate,UIAlertViewDelegate,UIScrollViewDelegate>

{
    BOOL bannerIsVisible;
    STABannerView *bannerView;
    BOOL *areAdsRemoved;
    
    IBOutlet UIWebView *webview;
    IBOutlet UINavigationBar *webviewNavBar;
    
    IBOutlet UIView *webViewLoadIndicator;
    IBOutlet UIImageView *logoImage;
    
    IBOutlet UIButton *logoImageButton;
    
    IBOutlet UIBarButtonItem *goToReveal;
    IBOutlet UIBarButtonItem *btnBack;
    IBOutlet UIBarButtonItem *btnForward;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) NSString *loadUrl;
@property (strong, nonatomic) NSString *categoryType;

@end
