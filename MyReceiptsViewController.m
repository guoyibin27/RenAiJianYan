//
//  MyReceiptsViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 15/12/5.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "MyReceiptsViewController.h"
#import "HttpClient.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "UserModel.h"
#import "MyReceiptItemTableViewCell.h"
#import "ProductModel.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UserManager.h"
#import "ReceiptModel.h"

@interface MyReceiptsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(retain,nonatomic) UITableView *tableView;
@property(retain,nonatomic) NSMutableArray *datasource;


@end

@implementation MyReceiptsViewController

-(void)loadView{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    [self configureTableView];
    _datasource = [NSMutableArray array];
    [self showProgress:nil];
    [[UserManager manager] fetchReceiptWithUser:[AppDelegate getCurrentLogonUser].userId block:^(NSError *error, NSMutableArray *array) {
        [self dismissProgress];
        if(error){
            [self showToastWithError:error.localizedDescription];
        }else{
            _datasource = array;
            [_tableView reloadData];
        }
    }];
}

- (void) configureTableView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 10)];
    titleView.backgroundColor = Hex2UIColor(0xe6e6e6);
    _tableView.tableHeaderView = titleView;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.allowsMultipleSelection = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId= @"cellId";
    MyReceiptItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[MyReceiptItemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ReceiptModel *receipt = _datasource[indexPath.section];
    ProductModel *pm = receipt.receiptDetails[indexPath.row];;
    [cell.productPicture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_SERVER_HOST,pm.primaryPicture]] placeholderImage:[UIImage imageNamed:@"PhotoNotAvailable"]];
    cell.productName.text = pm.productName;
    cell.productPrice.text = [NSString stringWithFormat:@"¥ %0.2f",[pm calculateProductAmount]];
    cell.buyCount.text = [NSString stringWithFormat:@"x %@" , pm.buyCount];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ReceiptModel *receipt = _datasource[section];
    return receipt.receiptDetails.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 52)];
    headerView.backgroundColor = [UIColor whiteColor];
    ReceiptModel *receipt = _datasource[section];
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, CGRectGetWidth(self.view.frame) - 30, 22)];
    header.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
    header.text = [NSString stringWithFormat:@"订单号:%@",receipt.receiptNumber];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headerView.frame), CGRectGetWidth(self.view.frame), 1)];
    line.backgroundColor = Hex2UIColor(0xe6e6e6);
    [headerView addSubview:header];
    [headerView addSubview:line];
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    ReceiptModel *receipt = _datasource[section];
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, CGRectGetWidth(self.view.frame), 52)];
    footerView.backgroundColor = [UIColor whiteColor];
    UILabel *footer = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, CGRectGetWidth(self.view.frame) - 30, 22)];
    footer.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
    footer.textAlignment = NSTextAlignmentRight;
    footer.text = [NSString stringWithFormat:@"共计 %lu 件商品    合计 ¥%@",(unsigned long)receipt.receiptDetails.count,receipt.totalAmount];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 1)];
    line.backgroundColor = Hex2UIColor(0xe6e6e6);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(footerView.frame), CGRectGetWidth(footerView.frame), 20)];
    imageView.backgroundColor = Hex2UIColor(0xe6e6e6);
    
    [footerView addSubview:footer];
    [footerView addSubview:line];
    [footerView addSubview:imageView];
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 53;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 73;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
@end
