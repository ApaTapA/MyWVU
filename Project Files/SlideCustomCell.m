//
//  SlideCustomCell.m
//  MyWVU
//
//  Created by Thomas Diffendal on 8/15/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "SlideCustomCell.h"

@implementation SlideCustomCell

@synthesize iconImage = _iconImage, categoryLabel = _categoryLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
