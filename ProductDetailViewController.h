//
//  ProductDetailViewController.h
//  RenAiJianYan
//
//  Created by Sylar on 15/11/16.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class ProductModel;
@interface ProductDetailViewController : BaseViewController

@property (retain, nonatomic) ProductModel *product;

@end
