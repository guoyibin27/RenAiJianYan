//
//  ReportListViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 8/29/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ReportListViewController.h"
#import "ExaminationReportModel.h"
#import "ReportListTableViewCell.h"
#import "ExaminationResultReportViewController.h"
#import "ExaminationReportManager.h"
#import "AppDelegate.h"
#import "UserModel.h"
#import "ExaminationReportManager.h"

@interface ReportListViewController ()
@property (retain, nonatomic) NSMutableArray *datasource;
@end

@implementation ReportListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureTableView];
    
    [[ExaminationReportManager manager] fetchReportsWithUserId:[AppDelegate getCurrentLogonUser].userId block:^(NSError *error, NSMutableArray *array) {
        if(error){
            [self showToastWithError:error.localizedDescription];
        }else{
            _datasource = array;
            [_tableView reloadData];
        }
    }];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) configureTableView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
    titleView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = titleView;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showReportDetail"]){
        ExaminationResultReportViewController *controller = [segue destinationViewController];
        controller.resultReport = sender;
        controller.showCollectButton = NO;
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReportListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    ExaminationReportModel *model = _datasource[indexPath.row];
    cell.reportName.text = model.reportName;
    cell.reportDate.text = model.reportDate;
    cell.libraryName.text = model.libraryName;    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ExaminationReportModel *model = _datasource[indexPath.row];
    [self performSegueWithIdentifier:@"showReportDetail" sender:model];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [tableView setEditing:NO animated:YES];
        ExaminationReportModel *model = _datasource[indexPath.row];
        [[ExaminationReportManager manager] removeReportWithUserId:[AppDelegate getCurrentLogonUser].userId reportId:model.reportId block:^(NSError *error, NSMutableArray *array) {
            if(error){
                [self showToastWithError:error.localizedDescription];
            }else{
                _datasource = array;
                [_tableView reloadData];
            }
        }];
    }
}


@end
