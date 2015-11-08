//
//  ReportListViewController.h
//  RenAiJianYan
//
//  Created by Sylar on 8/29/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "BaseViewController.h"

@interface ReportListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
