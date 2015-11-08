//
//  WxPayData.m
//  RenAiJianYan
//
//  Created by Sylar on 9/14/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "WxPayData.h"
#import "HttpClient.h"

@implementation WxPayData

+(void)unifiedOrderWithUserId:(NSNumber *)userId block:(void (^)(WxPayData *wxpayData))block{
    NSDictionary *parmas = @{@"paymentMethod":[NSNumber numberWithInt:1],@"cid":userId};
    
    [[HttpClient sharedClient] GET:UNIFIED_ORDER parameters:parmas success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL _success = [[responseObject objectForKey:@"Success"] boolValue];
        if(_success){
            NSError *error = nil;
            NSData *responseData = [[responseObject objectForKey:@"Data"] dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error: &error];
            if(!error){
                WxPayData *wxPayData = [[WxPayData alloc] init];
                block([wxPayData parser:data]);
            }else{
                block(nil);
            }
        }else{
            block(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block(nil);
    }];
}

+(void)queryPayStateWithReservationId:(NSNumber *)reservationId block:(BooleanResultBlock)block{
    NSDictionary *param = @{@"reservationId":reservationId};
    
    [[HttpClient sharedClient] GET:QUERY_RESERVATION_PAY_STATE parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block([[responseObject objectForKey:@"Success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block(NO);
    }];
}

- (instancetype)parser:(NSDictionary *)dict{
    self.appId = [dict objectForKey:@"appid"];
    self.partnerId = [dict objectForKey:@"partnerid"];
    self.nonceStr = [dict objectForKey:@"noncestr"];
    self.prepayId = [dict objectForKey:@"prepayid"];
    self.sign = [dict objectForKey:@"sign"];
    self.timeStamp = [dict objectForKey:@"timestamp"];
    self.package = [dict objectForKey:@"package"];
    return self;
}

@end
