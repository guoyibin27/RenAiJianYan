//
//  ProductPayResultErrorViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 15/12/3.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "ProductPayResultErrorViewController.h"
#import "WxPayData.h"
#import "AvailableReservationModel.h"
#import "ProductPayResultSuccessViewController.h"

@interface ProductPayResultErrorViewController ()
@property (retain, nonatomic) UIButton *refreshResultButton;
@property (retain, nonatomic) UIImageView *icon;
@property (retain, nonatomic) UILabel *textLabel;
@end

@implementation ProductPayResultErrorViewController

-(void)loadView{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.title = @"支付结果未知";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 210) / 2, 100, 210, 30)];
    
    self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.icon.image = [UIImage imageNamed:@"ExclamationIcon"];
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.icon.frame) + 20, 0, 160, 30)];
    self.textLabel.text = @"暂未收到订单支付结果";
    self.textLabel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
    self.textLabel.textColor = Hex2UIColor(0xfe7222);
    
    [view addSubview:self.icon];
    [view addSubview:self.textLabel];
    
    self.refreshResultButton = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(view.frame) + 40, CGRectGetWidth(self.view.frame) - 20, 44)];
    self.refreshResultButton.layer.cornerRadius = 4;
    self.refreshResultButton.layer.masksToBounds = YES;
    [self.refreshResultButton setTitle:@"刷新支付结果" forState:UIControlStateNormal];
    [self.refreshResultButton setBackgroundColor:Hex2UIColor(0x2987EA)];
    [self.refreshResultButton addTarget:self action:@selector(refreshResult) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:view];
    [self.view addSubview:self.refreshResultButton];
}

-(void)refreshResult{
    [self showProgress:nil];
    [WxPayData queryPayStateWithReceipt:self.receiptNumber block:^(BOOL success) {
        [self dismissProgress];
        if(success){
            ProductPayResultSuccessViewController *successVC = [[ProductPayResultSuccessViewController alloc] init];
            successVC.productList = _productList;
            [self showViewController:successVC sender:nil];
        }
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem.title = @"";
    [self.navigationItem setHidesBackButton:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
