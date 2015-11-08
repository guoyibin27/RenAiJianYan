//
//  ReservationExpertTableViewCell.h
//  RenAiJianYan
//
//  Created by Sylar on 8/24/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceExpertTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *expertName;

@property (weak, nonatomic) IBOutlet UILabel *expertLevel;

@property (weak, nonatomic) IBOutlet UILabel *expertDescription;

@property (weak, nonatomic) IBOutlet UIImageView *stateIcon;
@end
