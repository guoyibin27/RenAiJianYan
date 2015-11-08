//
//  AppoiontmentProductTableViewCell.h
//  RenAiJianYan
//
//  Created by Sylar on 8/22/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *expertNumber;
@property (weak, nonatomic) IBOutlet UIImageView *stateIcon;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
