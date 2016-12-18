//
//  SlideOutVC.h
//  MyWVU
//
//  Created by Thomas Diffendal on 8/15/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideOutVC : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *slideOutTableView;
    
    BOOL areAdsRemoved;
}


@end
