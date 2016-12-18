//
//  HowToUse.h
//  MyWVU
//
//  Created by Thomas Diffendal on 1/4/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StartApp/StartApp.h>

@interface HowToUse : UIViewController

{
    
    BOOL areAdsRemoved;
    BOOL bannerIsVisible;
    STABannerView *bannerView;
    
    IBOutlet UILabel *lblHowToUse;
    IBOutlet UIImageView *imgRefresh;
    IBOutlet UILabel *lblRefresh;
    IBOutlet UIImageView *imgBack;
    IBOutlet UILabel *lblBack;
    IBOutlet UIImageView *imgWVULogo;
    IBOutlet UILabel *lblWVULogo;
    IBOutlet UIImageView *imgForward;
    IBOutlet UILabel *lblForward;
    IBOutlet UIImageView *imgClose;
    IBOutlet UILabel *lblClose;


    
    
    
    
}

@end
