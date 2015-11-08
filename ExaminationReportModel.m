//
//  ExaminationReportModel.m
//  RenAiJianYan
//
//  Created by Sylar on 8/26/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ExaminationReportModel.h"

@implementation ExaminationReportModel


- (instancetype)parseModel:(NSDictionary *)reportDict {
    self.reportId = [reportDict objectForKey:@"Id"];
    self.examinationNumber = [reportDict objectForKey:@"Number"];
    self.examinationResult = [reportDict objectForKey:@"Result"];
    self.reportName = [reportDict objectForKey:@"ReportName"];
    self.reportDate = [reportDict objectForKey:@"ReportDate"];
    self.reportDate = [self.reportDate substringToIndex:[self.reportDate rangeOfString:@"T"].location];
    NSString *internalDataStr = [[[reportDict objectForKey:@"Data"] stringByReplacingOccurrencesOfString:@"\r\n" withString:@""]
                                    stringByReplacingOccurrencesOfString:@"\n" withString:@"#"];
    NSData *internalData = [internalDataStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSError *error = nil;
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:internalData options:NSJSONReadingAllowFragments error: &error];
    if(error){
        NSLog(@"ERROR %@" , error);
    }else{
        self.receiveMethod = [data objectForKey:@"ReceiveMethod"];
        self.specimenType = [data objectForKey:@"SpecimenType"];
        self.examinationMethod = [data objectForKey:@"ExaminationMethod"];
        self.libraryName = [data objectForKey:@"LibraryName"] ;
        self.tester = [data objectForKey:@"Tester"] ;
        self.reviewer = [data objectForKey:@"Reviewer"];
        self.receiveYear = [data objectForKey:@"ReceiveYear"];
        self.receiveMonth = [data objectForKey:@"ReceiveMonth"];
        self.receiveDay = [data objectForKey:@"ReceiveDay"];
        self.testYear = [data objectForKey:@"TestYear"];
        self.testMonth = [data objectForKey:@"TestMonth"];
        self.testDate = [data objectForKey:@"TestDate"];
        self.comment = [[data objectForKey:@"Comment"] stringByReplacingOccurrencesOfString:@"#" withString:@"\n"];
        self.methodResult1 = [data objectForKey:@"method_1_result"];
        self.methodResult2 = [data objectForKey:@"method_2_result"];
        self.methodResult3 = [data objectForKey:@"method_3_result"];
        self.methodResult4 = [data objectForKey:@"method_4_result"];
        self.methodResult5 = [data objectForKey:@"method_5_result"];
    }
    return self;
}

@end
