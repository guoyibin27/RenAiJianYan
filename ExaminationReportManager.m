//
//  ExaminationReportManager.m
//  RenAiJianYan
//
//  Created by Sylar on 9/16/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ExaminationReportManager.h"
#import "HttpClient.h"
#import "ExaminationReportModel.h"

static ExaminationReportManager *instance;
@implementation ExaminationReportManager

+ (instancetype)manager {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[ExaminationReportManager alloc] init];
    });
    return instance;
}

- (void) queryExaminationReport:(NSString *)number block:(ObjectResultBlock)block{
    NSDictionary *param = @{@"number":number};
    
    [[HttpClient sharedClient] GET:QUERY_EXAMINATION_REPORT_URL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL _success = [[responseObject objectForKey:@"Success"] boolValue];
        if(_success){
            NSDictionary *reportDict = [responseObject objectForKey:@"Data"];
            block(nil,[[[ExaminationReportModel alloc] init] parseModel:reportDict]);
        }else{
            block([ExaminationReportManager errorWithText:[responseObject objectForKey:@"Message"]],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([ExaminationReportManager errorWithConnectionError],nil);
    }];
}

- (void) collectExaminationReportWithUserId:(NSNumber *)userId reportId:(NSNumber *)reportId reportNumber:(NSString *)reportNumber block:(ObjectResultBlock)block{
    NSDictionary *params = @{@"reportId":reportId,@"cid":userId
                             ,@"reportNumber":reportNumber};
    
    [[HttpClient sharedClient] GET:COLLECT_EXAMINATION_REPORT_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL _success = [[responseObject objectForKey:@"Success"] boolValue];
        if(_success){
            block(nil,nil);
        }else{
            block([ExaminationReportManager errorWithText:[responseObject objectForKey:@"Message"]],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([ExaminationReportManager errorWithConnectionError],nil);
    }];
}

- (void) fetchReportsWithUserId:(NSNumber *)userId block:(ArrayResultBlock)block{
    NSDictionary *param = @{@"cid":userId};
    
    [[HttpClient sharedClient] GET: FETCH_COLLECT_REPORTS_URL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL _success = [[responseObject objectForKey:@"Success"] boolValue];
        if(_success){
            NSArray *data = [responseObject objectForKey:@"Data"];
            if(data.count > 0){
                NSMutableArray *modelArray = [[NSMutableArray alloc] init];
                for(int i=0;i<data.count;i++){
                    NSDictionary *report = [data objectAtIndex:i];
                    ExaminationReportModel *model = [[[ExaminationReportModel alloc] init] parseModel:report];
                    [modelArray addObject:model];
                }
                block(nil,modelArray);
            }else{
                block([ExaminationReportManager errorWithNoData],nil);
            }
        }else{
            block([ExaminationReportManager errorWithNoData],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([ExaminationReportManager errorWithConnectionError],nil);
    }];
}

- (void) removeReportWithUserId:(NSNumber *)userId reportId:(NSNumber *)reportId block:(ArrayResultBlock)block{
    NSDictionary *param = @{@"cid":userId,@"reportId":reportId};
    
    [[HttpClient sharedClient] GET:REMOVE_REPORT_URL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL _success = [[responseObject objectForKey:@"Success"] boolValue];
        if(_success){
            NSArray *data = [responseObject objectForKey:@"Data"];
            if(data.count > 0){
                NSMutableArray *modelArray = [[NSMutableArray alloc] init];
                for(int i=0;i<data.count;i++){
                    NSDictionary *report = [data objectAtIndex:i];
                    ExaminationReportModel *model = [[[ExaminationReportModel alloc] init] parseModel:report];
                    [modelArray addObject:model];
                }
                block(nil,modelArray);
            }else{
                block(nil,nil);
            }
        }else{
            block([ExaminationReportManager errorWithText:[responseObject objectForKey:@"Message"]],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([ExaminationReportManager errorWithConnectionError],nil);
    }];
}

@end
