//
//  ProductListTableViewCell.h
//  RenAiJianYan
//
//  Created by Sylar on 15/11/15.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductListTableViewCell : UITableViewCell

@property (retain, nonatomic) UIImageView *productPicture;
@property (retain, nonatomic) UITextView *productName;
@property (retain, nonatomic) UITextView *productPrice;
@property (retain, nonatomic) UIButton *addShoppingCartButton;

@end
