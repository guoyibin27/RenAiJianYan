//
//  ExaminationReportModel.h
//  RenAiJianYan
//
//  Created by Sylar on 8/26/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExaminationReportModel : NSObject

@property (retain, nonatomic) NSNumber *reportId;
//报告编号
@property (retain, nonatomic) NSString *examinationNumber;
//检查结果
@property (retain, nonatomic) NSString *examinationResult;

//报告名称
@property (retain, nonatomic) NSString *reportName;

//送检方式
@property (retain, nonatomic) NSString *receiveMethod;

//样本类型
@property (retain, nonatomic) NSString *specimenType;

//检测方式
@property (retain, nonatomic) NSString *examinationMethod;

//检测机构
@property (retain, nonatomic) NSString *libraryName;

//检测人
@property (retain, nonatomic) NSString *tester;

//复核者
@property (retain, nonatomic) NSString *reviewer;

//收样日期  年
@property (retain, nonatomic) NSString *receiveYear;

//收样日期  月
@property (retain, nonatomic) NSString *receiveMonth;

//收样日期  日
@property (retain, nonatomic) NSString *receiveDay;

//报告日期  年
@property (retain, nonatomic) NSString *testYear;

//报告日期  月
@property (retain, nonatomic) NSString *testMonth;

//报告日期  日
@property (retain, nonatomic) NSString *testDate;

//备注
@property (retain, nonatomic) NSString *comment;

//检查项目1
@property (retain, nonatomic) NSString *methodResult1;

//检查项目2
@property (retain, nonatomic) NSString *methodResult2;

//检查项目3
@property (retain, nonatomic) NSString *methodResult3;

//检查项目4
@property (retain, nonatomic) NSString *methodResult4;

//检查项目5
@property (retain, nonatomic) NSString *methodResult5;

//报告时间
@property (retain, nonatomic) NSString *reportDate;

- (instancetype)parseModel:(NSDictionary *)reportDict;

@end
