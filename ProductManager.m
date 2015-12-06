//
//  ProductManager.m
//  RenAiJianYan
//
//  Created by Sylar on 15/11/15.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "ProductManager.h"
#import "HttpClient.h"
#import "ProductModel.h"

@implementation ProductManager

static ProductManager *instance;

+ (instancetype)manager {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[ProductManager alloc] init];
    });
    return instance;
}

-(void) queryProduct:(NSString *)keyword block:(ArrayResultBlock)block{
    NSDictionary *param;
    if(keyword != nil && keyword.length !=0 ){
        param = @{@"keyword":keyword};
    }

    [[HttpClient sharedClient] POST:QUERY_PRODUCT parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *productDict = [responseObject objectForKey:@"Data"];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(int i = 0;i< [productDict count];i++){
            [array addObject:[[ProductModel alloc] initWithJson:productDict[i]]];
        }
        if(array.count>0){
            block(nil,array);
        }else{
            block([ProductManager errorWithNoData],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([ProductManager errorWithConnectionError],nil);
    }];
}

-(void) productDetails:(NSNumber *)productId block:(ObjectResultBlock)block{
    NSDictionary *params = @{@"id":productId};
    
    [[HttpClient sharedClient] GET:PRODUCT_DETAILS parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(nil,[[ProductModel alloc] initWithJson:[responseObject objectForKey:@"Data"]]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([ProductManager errorWithConnectionError],nil);
    }];
}

-(void) receiptTotal:(NSArray *)productList uid:(NSNumber *)uid address:(NSNumber *)addressId block:(ObjectResultBlock) block{
    NSMutableArray *list = [NSMutableArray array];
    for(ProductModel *product in productList){
        [list addObject:[NSString stringWithFormat:@"%@#%@",product.productId,product.buyCount]];
    }
    NSDictionary *params = @{@"CustomerId":uid,@"AddressId":addressId,@"ProductList":list};
    [[HttpClient sharedClient] POST:RECEIPT_TOTAL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        block(nil,[responseObject objectForKey:@"Data"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        block([ProductManager errorWithConnectionError] ,nil);
    }];
}

@end
