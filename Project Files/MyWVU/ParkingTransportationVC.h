//
//  ParkingTransportationVC.h
//  MyWVU
//
//  Created by Thomas Diffendal on 11/21/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StartApp/StartApp.h>

@interface ParkingTransportationVC : UIViewController
{
    BOOL areAdsRemoved;
    BOOL bannerIsVisible;
    STABannerView *bannerView;
}

@property (nonatomic, weak) IBOutlet UIBarButtonItem *openSlideOut;

@property (nonatomic, weak) IBOutlet UIScrollView *parkingScroll;

@end
