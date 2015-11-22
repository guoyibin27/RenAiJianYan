//
//  ShoppingCartTableViewCell.h
//  RenAiJianYan
//
//  Created by Sylar on 15/11/18.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartTableViewCell : UITableViewCell
@property (retain, nonatomic) UIImageView *productPicture;
@property (retain, nonatomic) UILabel *productName;
@property (retain, nonatomic) UILabel *productPrice;
@property (retain, nonatomic) UIImageView *checkedImage;
@property (retain, nonatomic) UIButton *addButton;
@property (retain, nonatomic) UIButton *subButton;
@property (retain, nonatomic) UITextField *totalCount;
@end
