//
//  AvailableReservationListViewController.h
//  RenAiJianYan
//
//  Created by Sylar on 8/31/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "BaseViewController.h"
#import "FSCalendar.h"

@class ServicerServiceModel;
@class ServiceModel;
@class AvailableReservationModel;
typedef void(^SelectAvailableReservationCallback)(AvailableReservationModel *selectedReservation, NSString *selectedDate);

@interface AvailableReservationListViewController : BaseViewController<FSCalendarDataSource, FSCalendarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (copy, nonatomic) SelectAvailableReservationCallback callback;
@property (retain, nonatomic) ServiceModel *selectedService;
@property (retain, nonatomic) ServicerServiceModel *selectedServiceExpertModel;
@property (retain, nonatomic) AvailableReservationModel *selectedReservation;
@property (retain, nonatomic) NSMutableArray *dataArray;

@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) FSCalendar *calendarView;

@end
