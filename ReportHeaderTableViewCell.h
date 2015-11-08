//
//  ReportHeaderTableViewCell.h
//  RenAiJianYan
//
//  Created by Sylar on 8/27/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *reportNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *reprtDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *libraryNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *examinationNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *specimenTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *examinationMethodLabel;

@property (weak, nonatomic) IBOutlet UILabel *receiveMethodLabel;



@end
