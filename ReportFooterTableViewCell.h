//
//  ReportFooterTableViewCell.h
//  RenAiJianYan
//
//  Created by Sylar on 8/27/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportFooterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *testerLabel;

@property (weak, nonatomic) IBOutlet UILabel *reviewerLabel;

@property (weak, nonatomic) IBOutlet UILabel *receiveDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *testDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (nonatomic) float screenWidth;
@end
