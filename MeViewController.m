//
//  MeViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "MeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "CellModel.h"
#import "SectionModel.h"
#import "BasicTableViewCell.h"
#import "Constants.h"
#import "LeanChatLib.h"
#import "ShoppingCartViewController.h"
#import "AddressListViewController.h"
#import "MyReceiptsViewController.h"

@interface MeViewController ()

@end

static NSString *cellIdentifier = @"meCell";

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureTableView];
    [self initDataSource];
}

- (void) initDataSource{
    CellModel *s0r0 = [CellModel makeCellWith:@"购物车" image:@"ShoppingCartIcon" selector:@"showShoppingCart" ];
    CellModel *s0r1 = [CellModel makeCellWith:@"历史订单" image:@"OrderIcon" selector:@"showHistoryOrder"];
    CellModel *s0r2 = [CellModel makeCellWith:@"检测报告" image:@"ReportIcon" selector:@"showExaminationResultReport"];
    
    CellModel *s1r0 = [CellModel makeCellWith:@"修改密码" image:@"ResetPasswordIcon" selector:@"showResetPassword"];
    
    CellModel *s1r1 = [CellModel makeCellWith:@"我的地址" image:@"AddressIcon" selector:@"showAddress"];
    
    SectionModel *s0 = [SectionModel initWithTitle:nil cells:@[s0r0,s0r1,s0r2]];
    SectionModel *s1 = [SectionModel initWithTitle:nil cells:@[s1r0,s1r1]];
    _data = [NSMutableArray arrayWithArray:@[s0,s1]];
}

- (void) showShoppingCart{
//    [self performSegueWithIdentifier:@"showShoppingCart" sender:nil];
    ShoppingCartViewController *vc = [[ShoppingCartViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) showHistoryOrder{
    MyReceiptsViewController *vc = [[MyReceiptsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) showExaminationResultReport{
     [self performSegueWithIdentifier:@"showExaminationResultReport" sender:nil];
}

- (void) showResetPassword{
     [self performSegueWithIdentifier:@"showResetPassword" sender:nil];
}

- (void) showAddress{
     [self performSegueWithIdentifier:@"showAddress" sender:nil];
//    [self forwardToUnavailableController];
}

- (void) configureTableView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
    titleView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = titleView;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBarTitle:@"我"];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showAddress"]){
        AddressListViewController *vc = segue.destinationViewController;
        vc.displayMode = AddressModeNone;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SectionModel *sectionModel = _data[section];
    return sectionModel.cells.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[BasicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    SectionModel *sectionModel = _data[indexPath.section];
    CellModel *cellModel = sectionModel.cells[indexPath.row];
    cell.title.text = cellModel.title;
    cell.image.image = [UIImage imageNamed:cellModel.image];
    cell.badge.text = cellModel.badgeTitle;
    if([self isStringNilOrEmpty:cellModel.badgeTitle] ||
       [cellModel.badgeTitle isEqualToString:@"0"]){
        cell.badge.hidden = YES;
    }else{
        cell.badge.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SectionModel *sectionModel = _data[indexPath.section];
    CellModel *cellModel = sectionModel.cells[indexPath.row];
    cellModel.badgeTitle = @"";
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    SEL selector = NSSelectorFromString(cellModel.selectorName);
    if([self respondsToSelector:selector]){
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self, selector);
    }
}


- (IBAction)logoff:(id)sender {
    [[CDChatManager manager] closeWithCallback:^(BOOL succeeded, NSError *error) {
        [AppDelegate removeUserFromNSUserDefaults];
        LoginViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginView];
        navigationController.navigationBar.barTintColor = Hex2UIColor(0x174C80);
        navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [self presentViewController:navigationController animated:YES completion:nil];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


@end
