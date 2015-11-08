//
//  SelectProductViewController.h
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class ServiceModel;

typedef void(^SelectServiceCallback)(ServiceModel *selectModel,NSString *subType);

@interface ServiceListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) ServiceModel *serviceModel;
@property (copy,nonatomic) SelectServiceCallback callback;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain,nonatomic) NSMutableArray *servicesArray;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)onSegmentValueChanged:(id)sender;

@end
