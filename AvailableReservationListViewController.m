//
//  AvailableReservationListViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 8/31/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "AvailableReservationListViewController.h"
#import "AvailableReservationModel.h"
#import "ServiceModel.h"
#import "ServicerServiceModel.h"
#import "Constants.h"
#import "NSDate+FSExtension.h"
#import "ReservationTableViewCell.h"
#import "ReservationManager.h"
#import "AppDelegate.h"
#import "UserModel.h"

@interface AvailableReservationListViewController()

@property (retain, nonatomic) NSDateFormatter *dateFormatter;
@property (retain, nonatomic) NSMutableDictionary *cachedDataSource;
@property (retain, nonatomic) AvailableReservationModel *reservationModel;
@property (retain, nonatomic) NSDateFormatter *formatter;
@end

@implementation AvailableReservationListViewController

-(void)loadView{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.calendarView = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) / 2)];
    self.calendarView.backgroundColor = [UIColor whiteColor];
    self.calendarView.dataSource = self;
    self.calendarView.delegate = self;
    self.calendarView.scrollDirection = FSCalendarScrollDirectionVertical;
    [self.view addSubview:self.calendarView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.calendarView.frame) + 10, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.calendarView.frame) - 10)];
    if([self.tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([self.tableView respondsToSelector:@selector(setLayoutMargins:)]){
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.view addSubview:self.tableView];
}

- (void)refreshTableViewData:(NSDate *) date {
    [self.dataArray removeAllObjects];
    NSArray *data = [self.cachedDataSource objectForKey:[_dateFormatter stringFromDate:date]];
    [self.dataArray addObjectsFromArray:data];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureTableView];
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.cachedDataSource = [[NSMutableDictionary alloc] init];
    self.dataArray = [[NSMutableArray alloc] init];
    _reservationModel = [[AvailableReservationModel alloc] init];
    [self showNavigationRightButton:@"完成" selector:@selector(onSelectFinished)];
    [self reloadDateWithDate:[self firstDayOfMonth:[NSDate date]] end:[self lastDayOfMonth:[NSDate date]]];
}

- (void)reloadDateWithDate:(NSString *)start end:(NSString *)end
{
    [self showProgress:nil];
    [[ReservationManager manager] fetchAvailableReservations:[AppDelegate getCurrentLogonUser].userId expert:self.selectedServiceExpertModel.serviceExpertId service:self.selectedService.serviceId start:start end:end block:^(NSError *error, NSMutableArray *array) {
        [self dismissProgress];
        if(!error){
            [self.cachedDataSource removeAllObjects];
            for(AvailableReservationModel *arm in array){
                NSString *start = [_dateFormatter stringFromDate:[_formatter dateFromString:arm.start]];
                NSMutableArray *models = [self.cachedDataSource objectForKey:start];
                if(!models){
                    models = [[NSMutableArray alloc] init];
                    [self.cachedDataSource setObject:models forKey:start];
                }
                [models addObject:arm];
            }
        }
        [self refreshTableViewData:self.calendarView.selectedDate];
        [self.calendarView reloadData];
    }];
}

- (NSString *) lastDayOfMonth:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *beginDate= nil;
    double interval = 0;
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:date];
    return [_dateFormatter stringFromDate:[beginDate dateByAddingTimeInterval:interval-1]];
}

- (NSString *) firstDayOfMonth:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *beginDate= nil;
    double interval = 0;
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:date];
    return [_dateFormatter stringFromDate:[beginDate dateByAddingTimeInterval:1]];
}

- (void) onSelectFinished{
    if(!self.selectedReservation){
        [self showMessage:@"请选择预约时间"];
        return;
    }
    if(_callback){
        _callback(self.selectedReservation,[_dateFormatter stringFromDate:self.calendarView.selectedDate]);
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

- (void) configureTableView{
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
}

- (void)viewDidLayoutSubviews{
    if([self.tableView respondsToSelector:@selector(setSeparatorInset:)]){
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([self.tableView respondsToSelector:@selector(setLayoutMargins:)]){
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setLayoutMargins:)]){
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    ReservationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell =[[ReservationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    AvailableReservationModel *m = self.dataArray[indexPath.row];
    cell.reservationName.text = m.reservationDesc;
    
    cell.reserveDate.text = [NSString stringWithFormat:@"咨询时间 : %@ %@ ~ %@",[([m.start componentsSeparatedByString:@" "][0]) substringFromIndex:5],m.startLabel,m.endLabel];
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
//    cell.amount.text = [NSString stringWithFormat:@"%@",m.amount];
    if(m.isChecked){
        cell.isChecked.hidden = NO;
    }else{
        cell.isChecked.hidden = YES;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 104;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.selectedReservation){
        self.selectedReservation.isChecked = NO;
    }
    self.selectedReservation = self.dataArray[indexPath.row];
    AvailableReservationModel *m = self.dataArray[indexPath.row];
    m.isChecked = true;
    [_tableView reloadData];
}

#pragma FSCalendar

- (BOOL)calendar:(FSCalendar *)calendar hasEventForDate:(NSDate *)date{
    for(int i=0;i<self.cachedDataSource.allKeys.count;i++){
        if([date isEqualToDate:[_dateFormatter dateFromString:[self.cachedDataSource.allKeys objectAtIndex:i]]]){
            return YES;
        }
    }
    return NO;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date{
    [self refreshTableViewData:date];
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    [self reloadDateWithDate:[self firstDayOfMonth:calendar.currentPage] end:[self lastDayOfMonth:calendar.currentPage]];
}

@end
