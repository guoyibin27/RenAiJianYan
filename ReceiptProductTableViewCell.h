//
//  ReceiptProductTableViewCell.h
//  RenAiJianYan
//
//  Created by Sylar on 15/11/22.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiptProductTableViewCell : UITableViewCell

@property(retain, nonatomic) UIImageView *productPicture;
@property(retain, nonatomic) UILabel *productName;
@property(retain, nonatomic) UILabel *buyCount;
@property(retain, nonatomic) UILabel *productPrice;

@end
