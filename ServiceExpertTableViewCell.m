//
//  ReservationExpertTableViewCell.m
//  RenAiJianYan
//
//  Created by Sylar on 8/24/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ServiceExpertTableViewCell.h"

@implementation ServiceExpertTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected) {
        _stateIcon.hidden = NO;
    }else{
        _stateIcon.hidden = YES;
    }
}

@end
