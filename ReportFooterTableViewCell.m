//
//  ReportFooterTableViewCell.m
//  ;;
//
//  Created by Sylar on 8/27/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ReportFooterTableViewCell.h"

@implementation ReportFooterTableViewCell

- (void)awakeFromNib {
    // Initialization code
   self.screenWidth = [[UIScreen mainScreen] applicationFrame].size.width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
