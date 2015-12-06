//
//  WxPayData.m
//  RenAiJianYan
//
//  Created by Sylar on 9/14/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "WxPayData.h"
#import "HttpClient.h"
#import "ProductModel.h"

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

+(void)productUnifiedOrderWithUserId:(NSNumber *)userId productList:(NSArray *)productList address:(NSNumber *)addressId block:(void (^)(WxPayData *wxpayData))block{
    NSMutableArray *list = [NSMutableArray array];
    for(ProductModel *product in productList){
        [list addObject:[NSString stringWithFormat:@"%@#%@",product.productId,product.buyCount]];
    }
    NSDictionary *params = @{@"CustomerId":userId,@"AddressId":addressId,@"ProductList":list,@"PaymentMethod":[NSNumber numberWithInt:1]};

    [[HttpClient sharedClient] POST:PRODUCT_UNIFIED_ORDER parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

+(void)queryPayStateWithReceipt:(NSString *)receiptNumber block:(BooleanResultBlock)block{
    NSDictionary *param = @{@"receiptNumber":receiptNumber};
    [[HttpClient sharedClient] GET:QUERY_RECEIPT_PAY_STATE parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    self.userObject = [dict  objectForKey:@"receipt_number"];
    return self;
}

@end
