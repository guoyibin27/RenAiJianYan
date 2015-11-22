//
//  ProductDetailsInfoTableViewCell.h
//  RenAiJianYan
//
//  Created by Sylar on 15/11/17.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailsInfoTableViewCell : UITableViewCell

@property (retain, nonatomic) UIImageView *primaryPicture;
@property (retain, nonatomic) UILabel *productName;
@property (retain, nonatomic) UILabel *supplierName;
@property (retain, nonatomic) UILabel *productDesc;
@property (retain, nonatomic) UILabel *productPrice;
@property (retain, nonatomic) UILabel *productStorage;

@end
