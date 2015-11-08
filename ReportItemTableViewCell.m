//
//  ReportItemTableViewCell.m
//  RenAiJianYan
//
//  Created by Sylar on 8/27/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ReportItemTableViewCell.h"

@implementation ReportItemTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    float screenWidth = [UIScreen mainScreen].applicationFrame.size.width;
//    float itemWidth = (screenWidth - 20) / 3;
//    float originX = 10;
//    float height = self.itemNameLabel.frame.size.height;
//    float originY = (self.frame.size.height - height )/ 2;
//    int firstItemX = originX;
//    int secondItemX = firstItemX + itemWidth;
//    int thirdItemX= secondItemX + itemWidth;
//    
//    [self.itemNameLabel setFrame:CGRectMake(firstItemX, originY, itemWidth, height)];
//    [self.itemResultLabel setFrame:CGRectMake(secondItemX, originY, itemWidth, height)];
//    [self.itemBaseLabel setFrame:CGRectMake(thirdItemX, originY, itemWidth, height)];
//    
//    [self addSubview:self.itemBaseLabel];
//    [self addSubview:self.itemNameLabel];
//    [self addSubview:self.itemResultLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void) layoutSubviews{
    [super layoutSubviews];
}

@end
