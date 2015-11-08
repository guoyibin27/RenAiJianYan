//
//  ReservationHistoryViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 8/30/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ReservationHistoryViewController.h"
#import "Constants.h"
#import "AvailableReservationModel.h"
#import "ReservationHistoryTableViewCell.h"
#import "AdminUserModel.h"
#import "DateTools.h"
#import "LeanChatLib.h"
#import "AppDelegate.h"
#import "LeanCloudUserFactory.h"
#import "UserModel.h"
#import "ChattingRoomViewController.h"
#import "ReservationManager.h"

@interface ReservationHistoryViewController ()

@property (retain, nonatomic) NSDictionary *dataDict;
@property (retain, nonatomic) NSArray *keyArray;
@property (retain, nonatomic) NSMutableArray *dataSource;
@property (retain, nonatomic) NSDateFormatter *dateformatter;

@end

@implementation ReservationHistoryViewController



- (void) segmentedControlValueChanged:(id) sender
{
    UISegmentedControl *control = (UISegmentedControl *) sender;
    _dataSource = [_dataDict objectForKey:_keyArray[control.selectedSegmentIndex]];
    [self.tableView reloadData];
}

- (void) configureTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void) setupViews
{
    _keyArray = @[@"未完成",@"已完成"];
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:_keyArray];
    self.segmentedControl.frame = CGRectMake(20, 74, CGRectGetWidth(self.view.frame) - 40, 40);
    self.segmentedControl.selectedSegmentIndex = 0;
    
    [self.segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentedControl.frame) + 10, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.segmentedControl.frame) + 10)];
    if([self.tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([self.tableView respondsToSelector:@selector(setLayoutMargins:)]){
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad {
    [self setupViews];
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureTableView];
    _dateformatter = [[NSDateFormatter alloc] init];
    [_dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    _dataSource = [NSMutableArray new];
    _dataDict = @{_keyArray[0]:[[NSMutableArray alloc] init],_keyArray[1]:[[NSMutableArray alloc] init]};
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[ReservationManager manager] getReservedServices:[AppDelegate getCurrentLogonUser].userName block:^(NSError *error, NSMutableArray *array) {
        NSMutableArray * reservedArray = [_dataDict objectForKey:_keyArray[0]];
        NSMutableArray * closedArray = [_dataDict objectForKey:_keyArray[1]];
        [reservedArray removeAllObjects];
        [closedArray removeAllObjects];
        for(AvailableReservationModel *model in array){
            if([model.status isEqualToString:@"R"]){
                [reservedArray addObject:model];
            }else if([model.status isEqualToString:@"C"]){
                [closedArray addObject:model];
            }
        }
        [self segmentedControlValueChanged:self.segmentedControl];
    }];
}

- (void)viewDidLayoutSubviews{
    if([self.tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([self.tableView respondsToSelector:@selector(setLayoutMargins:)]){
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setLayoutMargins:)]){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer = @"cell";
    ReservationHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if(!cell)
    {
        cell = [[ReservationHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    AvailableReservationModel *m = _dataSource[indexPath.row];
    cell.reservationName.text = m.reservationDesc;
    cell.reserveBy.text = [NSString stringWithFormat:@"预定专家 : %@",m.serviceExpertModel.name];
    cell.reserveDate.text = [NSString stringWithFormat:@"咨询时间  : %@ %@ ~ %@",[m.start componentsSeparatedByString:@" "][0],m.startLabel,m.endLabel];
    if([m.reservationMethod isEqualToString:@"A"]){
        cell.reserveType.text = @"服务方式 : 手机App － 图文聊天系统";
        cell.entryRoom.hidden = NO;
    }else if([m.reservationMethod isEqualToString:@"P"]){
        cell.reserveType.text = [NSString stringWithFormat:@"服务方式 : 手机咨询 － 预留号码(%@)",m.reservationInfo];
        cell.entryRoom.hidden = YES;
    }else{
        cell.reserveType.text = [NSString stringWithFormat:@"服务方式 : "];
    }
    if([m.status isEqualToString:@"O"]){
        cell.reservationStatus.text = @"等待预约";
    }else if([m.status isEqualToString:@"R"]){
        cell.reservationStatus.text = @"已被预约";
    }else if([m.status isEqualToString:@"P"]){
        cell.reservationStatus.text = @"等待客户支付费用";
    }else if([m.status isEqualToString:@"C"]){
        cell.reservationStatus.text = @"已结束咨询";
    }
    cell.reservationStatus.text = [NSString stringWithFormat:@"预约状态 : %@",cell.reservationStatus.text];
    cell.amount.text = [NSString stringWithFormat:@"%@",m.amount];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AvailableReservationModel *m = _dataSource[indexPath.row];
    if([m.reservationMethod isEqualToString:@"P"]){
        return 159;
    }
    return 185;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AvailableReservationModel *model = _dataSource[indexPath.row];
    NSDate *startDate = [_dateformatter dateFromString:model.start];
    NSDate *endDate = [_dateformatter dateFromString:model.end];
    NSDate *now = [NSDate date];
    if([model.reservationMethod isEqualToString:@"P"]){
        [self showMessage:@"此预约是电话咨询，无法进行咨询室"];
        return;
    }

    if([model.status isEqualToString:@"C"]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"咨询已经结束，是否查看聊天信息?" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSString *owner = [NSString stringWithFormat:@"servicer_%@",model.serviceExpertId];
            [[CDChatManager manager] fetchConvWithOwner:owner callback:^(AVIMConversation *conversation, NSError *error) {
                if(error){
                    [self showMessage:@"无法进入咨询室，请稍后重试"];
                }else{
                    [self openConversation:conversation reservation:model needShowInputViews:NO];
                }
            }];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            [self popoverPresentationController];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    //进入聊天室
    if([model.status isEqualToString:@"R"] && [now isEarlierThan:endDate] && [now isLaterThan:startDate]){
        NSString *owner = [NSString stringWithFormat:@"servicer_%@",model.serviceExpertId];
        [[CDChatManager manager] fetchConvWithOwner:owner callback:^(AVIMConversation *conversation, NSError *error) {
            if(error){
                [self showMessage:@"无法进入咨询室，请稍后重试"];
            }else{
                [self joinConversation:conversation reservation:model];
            }
        }];
    }else{
        [self showMessage:@"还没到预约时间或预约时间已过"];
    }
}

- (void)joinConversation:(AVIMConversation *)conversation reservation:(AvailableReservationModel *)model{
    [[CDChatManager manager] joinConversation:conversation callback:^(BOOL succeeded, NSError *error) {
        if(error){
            [self showMessage:@"无法进入，请稍后重试"];
        }else{
            [self openConversation:conversation reservation:model needShowInputViews:YES];
        }
    }];
}

- (void)openConversation:(AVIMConversation *)conversation reservation:(AvailableReservationModel *)model needShowInputViews:(BOOL)needShowInputViews{
    NSString *owner = [NSString stringWithFormat:@"servicer_%@",model.serviceExpertId];
    [AppDelegate cacheChattingUser:owner username:model.serviceExpertModel.name];
    ChattingRoomViewController *chattingRoomVC = [self.storyboard instantiateViewControllerWithIdentifier:@"chattingRoomVC"];
    chattingRoomVC = [chattingRoomVC initWithConv:conversation showInputView:needShowInputViews];
    chattingRoomVC.currentReservation = model;
    [[self navigationController] pushViewController:chattingRoomVC animated:YES];
}
@end
