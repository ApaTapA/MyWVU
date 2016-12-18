//
//  AcademicVC.h
//  MyWVU
//
//  Created by Thomas Diffendal on 8/15/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StartApp/StartApp.h>

@interface AcademicVC : UIViewController
{
        BOOL areAdsRemoved;
        BOOL bannerIsVisible;
        STABannerView *bannerView;
}

@property (nonatomic, weak) IBOutlet UIBarButtonItem *openSlideOut;

@property (nonatomic, weak) IBOutlet UIScrollView *academicScroll;


@end
