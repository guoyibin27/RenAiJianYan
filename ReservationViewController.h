//
//  AppointmentViewController.h
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class ServiceModel;
@class ServicerServiceModel;
@class AvailableReservationModel;

@interface ReservationViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSMutableArray *data;
@property (retain, nonatomic) ServiceModel *selectedService;
@property (retain, nonatomic) ServicerServiceModel *selectedExpert;
@property (retain, nonatomic) AvailableReservationModel *selectedReservation;

- (IBAction)makeAnAppointment:(id)sender;

@end
