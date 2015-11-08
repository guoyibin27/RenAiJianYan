//
//  ReservationHistoryViewController.h
//  RenAiJianYan
//
//  Created by Sylar on 8/30/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "BaseViewController.h"

@interface ReservationHistoryViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) UISegmentedControl *segmentedControl;
@property (retain, nonatomic) UITableView *tableView;

@end
