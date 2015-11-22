//
//  QueryReportViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "QueryReportViewController.h"
#import "ExaminationReportModel.h"
#import "ExaminationResultReportViewController.h"
#import "ProgressHUD/ProgressHUD.h"
#import "ExaminationReportManager.h"

@interface QueryReportViewController ()

@end

@implementation QueryReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBarTitle:@"查询"];
    [self dismissKeyboard:self.view];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showResultReport"]){
        ExaminationResultReportViewController *controller = [segue destinationViewController];
        controller.resultReport = sender;
        controller.showCollectButton = YES;
    }
}

- (IBAction)queryReport:(id)sender {
    if([self isStringNilOrEmpty:self.examinationNumberField.text]){
        [self showToastWithError:@"请输入采样包条码"];
        return;
    }
    
    [self showProgress:nil];
    [[ExaminationReportManager manager] queryExaminationReport:self.examinationNumberField.text block:^(NSError *error, id object) {
        [self dismissProgress];
        if(error){
            [self showToastWithError:error.localizedDescription];
        }else{
            [self performSegueWithIdentifier:@"showResultReport" sender:object];
        }
        
    }];
}
@end
