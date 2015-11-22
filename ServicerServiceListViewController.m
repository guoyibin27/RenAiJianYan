//
//  SelectExpertViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 8/24/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ServicerServiceListViewController.h"
#import "ServiceExpertTableViewCell.h"
#import "ServicerServiceModel.h"
#import "ServiceModel.h"
#import "AdminUserModel.h"
#import "ReservationManager.h"

@interface ServicerServiceListViewController ()
@property (retain, nonatomic) NSArray *keyArray;
@end

@implementation ServicerServiceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureTableView];

    _dataArray = [[NSMutableArray alloc] init];

    [self showNavigationRightButton:@"完成" selector:@selector(finishSelected)];
    [self showProgress:nil];
    [[ReservationManager manager] fetchServicersWithServiceId:self.selectedService.serviceId subType:self.subType block:^(NSError *error, NSMutableArray *array) {
        [self dismissProgress];
        if(error){
            [self showToastWithError:error.localizedDescription];
        }else{
            _dataArray = array;
            [_tableView reloadData];
        }
    }];
}

- (void) configureTableView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
    titleView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = titleView;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
}


- (void) finishSelected {
    if(!_selectedExpert){
        [self showToastWithError:@"请选择一个专家"];
    }else{
        if(_callback){
            _callback(_selectedExpert);
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceExpertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ServicerServiceModel *m = _dataArray[indexPath.row];
    cell.expertName.text = m.adminUser.name;
    cell.expertLevel.text = [NSString stringWithFormat:@"%@ 级",m.level];
    cell.expertDescription.text = m.qualificationDescription;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedExpert = _dataArray[indexPath.row];
}


@end
