//
//  ReservationManager.m
//  RenAiJianYan
//
//  Created by Sylar on 9/16/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ReservationManager.h"
#import "HttpClient.h"
#import "AvailableReservationModel.h"
#import "BaseManager.h"
#import "ServiceModel.h"
#import "ServicerServiceModel.h"


static ReservationManager *instance;

@implementation ReservationManager

+ (instancetype)manager {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[ReservationManager alloc] init];
    });
    return instance;
}

- (void) fetchAvailableReservations:(NSNumber *)userId expert:(NSNumber *)expertId service:(NSNumber *)serviceId start:(NSString *)start end:(NSString *)end  block:(ArrayResultBlock)block
{
    NSDictionary *params = @{@"serviceId":serviceId,@"servicerId":expertId,@"cid":userId,@"endDate":end,@"startDate":start};
    
    [[HttpClient sharedClient] GET:FETCH_RESERVATIONS parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL _success = [[responseObject objectForKey:@"Success"] boolValue];
        if(_success)
        {
            NSArray *array = [responseObject objectForKey:@"Data"];
            NSMutableArray *result = [[NSMutableArray alloc] init];
            for(int i= 0 ;i< array.count ;i++)
            {
                AvailableReservationModel *m = [[AvailableReservationModel alloc] init];
                [result addObject:[m parse:[array objectAtIndex:i]]];
            }
            block(nil, result);
        }else{
            block([ReservationManager errorWithNoData],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([ReservationManager errorWithConnectionError],nil);
    }];
}

- (void) checkReservationForPay:(NSNumber *)userId block:(ObjectResultBlock)block{
    NSDictionary *params = @{@"cid":userId};
    
    [[HttpClient sharedClient] GET:CHECK_RESERVATION_FOR_PAY parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL _success = [[responseObject objectForKey:@"Success"] boolValue];
        if(_success){
            AvailableReservationModel *model = [[AvailableReservationModel alloc] init];
            block(nil,[model parse:[responseObject objectForKey:@"Data"]]);
        }else{
            block([ReservationManager errorWithNoData],nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([ReservationManager errorWithConnectionError],nil);
    }];
}

- (void) getReservedServices:(NSString *)username block:(ArrayResultBlock)block{
    NSDictionary *params = @{@"nickName":username};
    
    [[HttpClient sharedClient] GET:FETCH_RESERVED_SERVICE parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL _success = [[responseObject objectForKey:@"Success"] boolValue];
        if(_success)
        {
            NSArray *array = [responseObject objectForKey:@"Data"];
            NSMutableArray *result = [[NSMutableArray alloc] init];
            for(int i= 0 ;i< array.count ;i++)
            {
                AvailableReservationModel *m = [[AvailableReservationModel alloc] init];
                [result addObject:[m parse:[array objectAtIndex:i]]];
            }
            block(nil, result);
        }else{
            block([ReservationManager errorWithText:MESSAGE_NO_RESERVATION_RECORD], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([ReservationManager errorWithConnectionError], nil);
    }];
}

- (void) reserveWithUserId:(NSNumber *)userId reservationId:(NSNumber *)reservationId info:(NSString *)reservationInfo method:(NSString *)reservationMethod  block:(ObjectResultBlock)block{
    NSDictionary *params = @{@"cid":userId,@"reservationId":reservationId,@"reservationInfo":reservationInfo,@"reservationMethod":reservationMethod};
    [[HttpClient sharedClient] GET:RESERVE_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL _success = [[responseObject objectForKey:@"Success"] boolValue];
        if(_success){
            AvailableReservationModel *model = [[AvailableReservationModel alloc] init];
            block(nil,[model parse:[responseObject objectForKey:@"Data"]]);
        }else{
            block([ReservationManager errorWithText:@"预约失败"],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([ReservationManager errorWithConnectionError],nil);
    }];
}

- (void) commitReservationWithUserId:(NSNumber *)userId username:(NSString *)username block:(BooleanResultBlock)block{
    NSDictionary *params = @{@"cid":userId,@"username":username};
    [[HttpClient sharedClient] GET:COMMIT_RESERVATION_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block([[responseObject objectForKey:@"Success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(NO);
    }];
}

- (void)fetchServicesWithBlock:(ArrayResultBlock)block{
    [[HttpClient sharedClient] GET:FETCH_SERVICES parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL _success = [[responseObject objectForKey:@"Success"] boolValue];
        if(_success){
            NSArray *array = [responseObject objectForKey:@"Data"];
            NSMutableArray *result = [[NSMutableArray alloc] init];
            for(int i = 0; i < array.count; i++){
                [result addObject:[[[ServiceModel alloc] init] parse:[array objectAtIndex:i]]];
            }
            block(nil,result);
        }else{
            block([ReservationManager errorWithNoData],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([ReservationManager errorWithConnectionError],nil);
    }];
}

-(void)fetchServicersWithServiceId:(NSNumber *)serviceId subType:(NSString *)subType block:(ArrayResultBlock)block{
    NSDictionary *params = @{@"serviceId":serviceId,@"subType":subType};
    [[HttpClient sharedClient] GET:FETCH_SERVICERS parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL _success = [[responseObject objectForKey:@"Success"] boolValue];
        if(_success){
            NSArray *array = [responseObject objectForKey:@"Data"];
            NSMutableArray *result = [[NSMutableArray alloc] init];
            for(int i = 0; i < array.count ; i++){
                [result addObject:[[[ServicerServiceModel alloc] init] parse:[array objectAtIndex:i]]];
            }
            block(nil,result);
        }
        else{
            block([ReservationManager errorWithNoData],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([ReservationManager errorWithConnectionError],nil);
    }];
}

-(void) closeReservationWithId:(NSNumber *)reservationId block:(BooleanResultBlock)block{
    NSDictionary *params = @{@"reservationId":reservationId};
    [[HttpClient sharedClient] GET:CLOSE_RESERVATION_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block([[responseObject objectForKey:@"Success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block(NO);
    }];
}

@end
