//
//  Information.h
//  MyWVU
//
//  Created by Thomas Diffendal on 1/4/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StartApp/StartApp.h>

@interface Information : UIViewController

{
    BOOL areAdsRemoved;
    BOOL bannerIsVisible;
    STABannerView *bannerView;
    
    IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblDevelop;
    IBOutlet UILabel *lblProgram;
    IBOutlet UILabel *lblThomas;
    IBOutlet UILabel *lblGraphics;
    IBOutlet UILabel *lblScott;
    IBOutlet UILabel *lblDisclaimer;
    IBOutlet UILabel *lblDisclaimerText;
    IBOutlet UILabel *lblVersion;
    
    IBOutlet UIButton *btnCloseInformation;
}


@end
