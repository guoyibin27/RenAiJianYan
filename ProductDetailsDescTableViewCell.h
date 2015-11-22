//
//  ProductDetalisDescTableViewCell.h
//  RenAiJianYan
//
//  Created by Sylar on 15/11/17.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductModel;
@interface ProductDetailsDescTableViewCell : UITableViewCell

@property (retain, nonatomic) UISegmentedControl *segmentedContrl;
@property (retain, nonatomic) UILabel *desc;

-(void)setProductData:(ProductModel *)product;
@end
