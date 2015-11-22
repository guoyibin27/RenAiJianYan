//
//  AddressListViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 15/11/21.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "AddressListViewController.h"
#import "AddressModel.h"
#import "AddressManager.h"
#import "Constants.h"
#import "AddressTableViewCell.h"
#import "UserModel.h"
#import "AppDelegate.h"
#import "CreateAddressViewController.h"

@interface AddressListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) NSMutableArray *datasource;
@end

@implementation AddressListViewController

- (void)loadView{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];

    [self.view addSubview:_tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"我的地址"];
    [self configureTableView];
    [self showNavigationRightButton:@"添加地址" selector:@selector(createAddress)];
    
    _datasource = [NSMutableArray array];
    [self showProgress:nil];
    [[AddressManager manager] fetchAddressList:[AppDelegate getCurrentLogonUser].userId  block:^(NSError *error, NSMutableArray *array) {
        [self dismissProgress];
        if(error){
            [self showToastWithError:error.localizedDescription];
        }else{
            [_datasource removeAllObjects];
            [_datasource addObjectsFromArray:array];
            [_tableView reloadData];
        }
    }];
}

- (void)loadData{
    [self showProgress:nil];
    [[AddressManager manager] fetchAddressList:[AppDelegate getCurrentLogonUser].userId  block:^(NSError *error, NSMutableArray *array) {
        [self dismissProgress];
        if(error){
            [self showToastWithError:error.localizedDescription];
        }else{
            [_datasource removeAllObjects];
            [_datasource addObjectsFromArray:array];
            [_tableView reloadData];
        }
    }];
}

- (void) createAddress{
    CreateAddressViewController *vc = [[CreateAddressViewController alloc] init];
    vc.callback = ^(BOOL needReloadData){
        if(needReloadData){
            [self loadData];
        }
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) configureTableView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 0)];
    titleView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = titleView;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.allowsMultipleSelection = YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[AddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(_displayMode == AddressModeNone){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    AddressModel *a = _datasource[indexPath.row];
    cell.contact.text = a.contact;
    cell.tel.text = a.tel;
    cell.address.text = a.address;
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 77;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AddressModel *am = _datasource[indexPath.row];
        [self showProgress:nil];
        [[AddressManager manager] deleteAddress:am.addressId userId:am.userId block:^(BOOL success) {
            [self dismissProgress];
            if(success){
                [self.datasource removeObjectAtIndex:indexPath.row];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//                [self loadData];
            }else{
                [self showToastWithError:@"删除地址失败"];
            }
        }];
    }

}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_displayMode == AddressModeSelected && _callback){
        _callback(_datasource[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
