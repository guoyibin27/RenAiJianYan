//
//  MeTableViewCell.h
//  RenAiJianYan
//
// Customer TableViewCell with style like: [icon  title       badge]
//  Created by Sylar on 8/30/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicTableViewCell : UITableViewCell

@property (retain, nonatomic) UILabel *title;
@property (retain, nonatomic) UILabel *badge;
@property (retain, nonatomic) UIImageView *image;

@end
