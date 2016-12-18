//
//  Feedback.h
//  MyWVU
//
//  Created by Thomas Diffendal on 1/4/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <StartApp/StartApp.h>

@interface Feedback : UIViewController <MFMailComposeViewControllerDelegate , UIAlertViewDelegate>

{
    BOOL areAdsRemoved;
    BOOL bannerIsVisible;
    STABannerView *bannerView;
    
    IBOutlet UILabel *lblFeedback;
    IBOutlet UIButton *btnComments;
    IBOutlet UIButton *btnShare;
    IBOutlet UIButton *btnRate;
    IBOutlet UIButton *btnFollow;
    IBOutlet UIButton *btnFacebook;
    IBOutlet UIButton *btnInstagram;
    IBOutlet UIButton *btnWebsite;
}

- (IBAction)shareMYWVU:(id)sender;
- (IBAction)rateMYWVU:(id)sender;
- (IBAction)followTwitter:(id)sender;
- (IBAction)likeFacebook:(id)sender;
- (IBAction)followInstagram:(id)sender;
- (IBAction)openWebsite:(id)sender;

@end
