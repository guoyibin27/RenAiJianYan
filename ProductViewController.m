//
//  ProductViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ProductViewController.h"

@interface ProductViewController ()
@property (retain, nonatomic) UIImageView *imageView;
@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UnavailableBg"]];
    [self.imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.imageView.frame = CGRectMake(self.view.center.x - CGRectGetWidth(self.imageView.frame) / 2, self.view.center.y - CGRectGetHeight(self.imageView.frame) / 2, CGRectGetWidth(self.imageView.frame), CGRectGetHeight(self.imageView.frame));
    [self.view addSubview:self.imageView];
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBarTitle:@"敬请期待"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
