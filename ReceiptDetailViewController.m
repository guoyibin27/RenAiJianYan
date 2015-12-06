//
//  OrderDetailsViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 15/11/22.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "ReceiptDetailViewController.h"
#import "AddressModel.h"
#import "ReceiptAddressTableViewCell.h"
#import "ReceiptProductTableViewCell.h"
#import "ProductModel.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "Constants.h"
#import "AddressListViewController.h"
#import "SectionModel.h"
#import "ProductManager.h"
#import "UserModel.h"
#import "AppDelegate.h"
#import "ProductPayDetailsViewController.h"


@interface ReceiptDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) UIButton *payButton;
@property (retain, nonatomic) UIButton *cancelOrderButton;
@property (retain, nonatomic) AddressModel *selectedAddress;
@property (retain, nonatomic) NSMutableArray *datasource;
@end

@implementation ReceiptDetailViewController

- (void)loadView{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 44) style:UITableViewStyleGrouped];
    
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 44, CGRectGetWidth(self.view.frame), 44)];
    buttomView.backgroundColor = [UIColor whiteColor];
    
    _payButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 90, 7, 80, 30)];
    [_payButton setTitle:@"去支付" forState:UIControlStateNormal];
    [_payButton setBackgroundColor:[UIColor redColor]];
    [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _payButton.layer.masksToBounds = YES;
    _payButton.layer.cornerRadius = 4;
    _payButton.titleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
    [_payButton addTarget:self action:@selector(createOrder) forControlEvents:UIControlEventTouchUpInside];
    
    _cancelOrderButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(_payButton.frame) - 100, 7, 80, 30)];
    [_cancelOrderButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelOrderButton setBackgroundColor:[UIColor whiteColor]];
    [_cancelOrderButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _cancelOrderButton.layer.masksToBounds = YES;
    _cancelOrderButton.layer.cornerRadius = 4;
    _cancelOrderButton.layer.borderColor = [UIColor grayColor].CGColor;
    _cancelOrderButton.layer.borderWidth = 1;
    _cancelOrderButton.titleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
    [_cancelOrderButton addTarget:self action:@selector(cancelOrder) forControlEvents:UIControlEventTouchUpInside];

    [buttomView addSubview:_payButton];
    [buttomView addSubview:_cancelOrderButton];
    [self.view addSubview:_tableView];
    [self.view addSubview:buttomView];
}

- (void)createOrder{
    if(!_selectedAddress || _selectedAddress.addressId <= 0){
        [self showToastWithError:@"请选择配送地址"];
        return;
    }
    [self showProgress:nil];
    [[ProductManager manager] receiptTotal:_productArray uid:[AppDelegate getCurrentLogonUser].userId address:_selectedAddress.addressId block:^(NSError *error, id object) {
        [self dismissProgress];
        ProductPayDetailsViewController *vc = [[ProductPayDetailsViewController alloc] init];
        vc.productList = _productArray;
        vc.addressId = _selectedAddress.addressId;
        vc.receiptTotal = object;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)cancelOrder{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定取消订单?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) configureTableView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
    titleView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = titleView;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"填写订单"];
    _selectedAddress = [[AddressModel alloc] init];
    
    SectionModel *s0 = [SectionModel initWithTitle:nil cells:@[_selectedAddress]];
    SectionModel *s1 = [SectionModel initWithTitle:nil cells:_productArray];
    _datasource = [NSMutableArray arrayWithArray:@[s0,s1]];
    [self configureTableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320,5)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SectionModel *s = _datasource[section];
    return s.cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *addCellId = @"addcell";
    NSString *emtpyCellId = @"emptyAddressCell";
    NSString *productCell = @"productCell";
    
    SectionModel *s = _datasource[indexPath.section];
    id cellModel = s.cells[indexPath.row];
    if([cellModel isKindOfClass:[AddressModel class]]){
        if(self.selectedAddress.addressId){
            ReceiptAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addCellId];
            if(!cell){
                cell = [[ReceiptAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addCellId];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.addressLabel.text = _selectedAddress.address;
            cell.contact.text = _selectedAddress.contact;
            cell.tel.text = _selectedAddress.tel;
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:emtpyCellId];
            if(!cell){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:emtpyCellId];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.textLabel.text = @"请选择配送地址";
            return cell;
        }
    }else{
        ReceiptProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:productCell];
        if(!cell){
            cell = [[ReceiptProductTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCell];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        ProductModel *product = (ProductModel *)cellModel;
        cell.productName.text = product.productName;
        cell.productPrice.text = [NSString stringWithFormat:@"¥ %0.2f",[product calculateProductAmount]];
        cell.buyCount.text = [NSString stringWithFormat:@"x %@",product.buyCount.stringValue];
        [cell.productPicture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_SERVER_HOST,product.primaryPicture]] placeholderImage:[UIImage imageNamed:@"PhotoNotAvailable"]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SectionModel *s = _datasource[indexPath.section];
    id cellModel = s.cells[indexPath.row];
    if([cellModel isKindOfClass:[AddressModel class]]){
        if(_selectedAddress.addressId){
            return 77;
        }else{
            return 44;
        }
    }else{
        return 98;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SectionModel *s = _datasource[indexPath.section];
    id cellModel = s.cells[indexPath.row];
    if([cellModel isKindOfClass:[AddressModel class]]){
        AddressListViewController *vc = [[AddressListViewController alloc] init];
        vc.displayMode = AddressModeSelected;
        vc.callback = ^(AddressModel *addressModel){
            _selectedAddress = addressModel;
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
