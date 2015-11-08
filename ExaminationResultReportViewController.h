//
//  ExaminationResultReportViewController.h
//  RenAiJianYan
//
//  Created by Sylar on 8/27/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "BaseViewController.h"

@class ExaminationReportModel;

@interface ExaminationResultReportViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) ExaminationReportModel *resultReport;
@property (nonatomic) BOOL showCollectButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) NSArray *dataSourceDict;
@property (weak, nonatomic) IBOutlet UIView *collectContainer;
@property (nonatomic) CGSize reportCommentSize;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectContainerViewHeightConstrant;

- (IBAction)collectReport:(id)sender;

@end
