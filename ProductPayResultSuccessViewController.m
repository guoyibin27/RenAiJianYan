//
//  ProductPayResultSuccessViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 15/12/3.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "ProductPayResultSuccessViewController.h"

@interface ProductPayResultSuccessViewController ()

@property (retain, nonatomic) UIButton *refreshResultButton;
@property (retain, nonatomic) UIImageView *icon;
@property (retain, nonatomic) UILabel *textLabel;

@end

@implementation ProductPayResultSuccessViewController

-(void)loadView{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.title = @"支付成功";
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 210) / 2, 100, 210, 30)];
    
    self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.icon.image = [UIImage imageNamed:@"checked"];
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.icon.frame) + 20, 0, 160, 30)];
    self.textLabel.text = @"订单支付成功";
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
    self.textLabel.textColor = Hex2UIColor(0xfe7222);
    
    [view addSubview:self.icon];
    [view addSubview:self.textLabel];
    
    self.refreshResultButton = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(view.frame) + 40, CGRectGetWidth(self.view.frame) - 20, 44)];
    self.refreshResultButton.layer.cornerRadius = 4;
    self.refreshResultButton.layer.masksToBounds = YES;
    [self.refreshResultButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.refreshResultButton setBackgroundColor:Hex2UIColor(0x2987EA)];
    [self.refreshResultButton addTarget:self action:@selector(finishToMain) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:view];
    [self.view addSubview:self.refreshResultButton];
}

-(void)finishToMain{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
