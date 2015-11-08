//
//  QueryReportViewController.h
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class ExaminationReportModel;
@interface QueryReportViewController : BaseViewController

@property (retain, nonatomic) ExaminationReportModel *report;

@property (weak, nonatomic) IBOutlet UITextField *examinationNumberField;

- (IBAction)queryReport:(id)sender;

@end
