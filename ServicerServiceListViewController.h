//
//  SelectExpertViewController.h
//  RenAiJianYan
//
//  Created by Sylar on 8/24/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "BaseViewController.h"

@class ServicerServiceModel;
@class ServiceModel;
typedef void(^SelectExpertCallback)(ServicerServiceModel *selectModel);

@interface ServicerServiceListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) ServicerServiceModel *selectedExpert;
@property (retain, nonatomic) ServiceModel *selectedService;
@property (copy,nonatomic) SelectExpertCallback callback;
@property (retain,nonatomic) NSMutableArray *dataArray;
@property (retain, nonatomic) NSString  *subType;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@end
