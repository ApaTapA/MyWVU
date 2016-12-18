//
//  MainMenu.h
//  MyWVU
//
//  Created by Thomas Diffendal on 1/1/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StartApp/StartApp.h>

@interface MainMenu : UIViewController
{
    BOOL areAdsRemoved;
    BOOL bannerIsVisible;
    STABannerView *bannerView;
    
    IBOutlet UIButton *btnSettings;
    IBOutlet UIButton *btnCloseSettings;
    IBOutlet UIButton *btnCloseDropDownMenu;
    IBOutlet UIButton *btnInformation;
    IBOutlet UIButton *btnFeedback;
    IBOutlet UIButton *btnHowToUse;
    IBOutlet UIButton *btnRemoveAds;
    IBOutlet UIButton *btnRestorePurchase;

    IBOutlet UIView *iapLoading;
    IBOutlet UIActivityIndicatorView *iap;
    
    IBOutlet UIImageView *academicIcon;
    IBOutlet UIImageView *diningIcon;
    IBOutlet UIImageView *newsIcon;
    IBOutlet UIImageView *policeIcon;
    IBOutlet UIImageView *greeklifeIcon;
    IBOutlet UIImageView *nightlifeIcon;
    IBOutlet UIImageView *parkingIcon;
    IBOutlet UIImageView *sportsIcon;
    IBOutlet UIImageView *informationIcon;
    IBOutlet UIImageView *studentHealthIcon;
    IBOutlet UIImageView *mainMenuBackground;
    IBOutlet UIImageView *categorySelectorBackground;
    
    IBOutlet UIImageView *divider1;
    IBOutlet UIImageView *divider2;
    IBOutlet UIImageView *divider3;
    IBOutlet UIImageView *divider4;
    IBOutlet UIImageView *settingsBackgroundImage;
    
    IBOutlet UIImageView *firstTimeMessage;
    
    IBOutlet UIImageView *categoryImageView;
    IBOutlet UIImageView *myWVULogo;
    
    IBOutlet UILabel *schoolLabel;
}

//In-App Purchases


- (IBAction)purchase;
- (IBAction)restore;
- (IBAction)tapsRemoveAds;

//Category Buttons
@property (strong, nonatomic) IBOutlet UIButton *btnAcademic;
@property (strong, nonatomic) IBOutlet UIButton *btnCampusDining;
@property (strong, nonatomic) IBOutlet UIButton *btnCampusInformation;
@property (strong, nonatomic) IBOutlet UIButton *btnCampusNewsAndEvents;
@property (strong, nonatomic) IBOutlet UIButton *btnCampusPolice;
@property (strong, nonatomic) IBOutlet UIButton *btnGreekLife;
@property (strong, nonatomic) IBOutlet UIButton *btnNightlife;
@property (strong, nonatomic) IBOutlet UIButton *btnParkingAndTransportation;
@property (strong, nonatomic) IBOutlet UIButton *btnSportsAndFitness;
@property (strong, nonatomic) IBOutlet UIButton *btnStudentHealth;

@property (strong, nonatomic) NSString *loadUrl;

@property (strong, nonatomic) IBOutlet UIScrollView *mainMenuScroll;

@property (strong, nonatomic) IBOutlet UIButton *btnSelectCategory;

@property (strong, nonatomic) IBOutlet UIImageView *categoryIcon;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UIView *categoryView;


@property (strong, nonatomic) IBOutlet UIView *settingsView;



@end
