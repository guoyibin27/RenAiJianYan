//
//  ExaminationReportManager.h
//  RenAiJianYan
//
//  Created by Sylar on 9/16/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "BaseManager.h"

@interface ExaminationReportManager : BaseManager

+ (instancetype)manager;

- (void) queryExaminationReport:(NSString *)number block:(ObjectResultBlock)block;

- (void) collectExaminationReportWithUserId:(NSNumber *)userId reportId:(NSNumber *)reportId reportNumber:(NSString *)reportNumber block:(ObjectResultBlock)block;

- (void) fetchReportsWithUserId:(NSNumber *)userId block:(ArrayResultBlock)block;

- (void) removeReportWithUserId:(NSNumber *)userId reportId:(NSNumber *)reportId block:(ArrayResultBlock)block;

@end
