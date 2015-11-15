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
    NSDictionary *param = nil;
    if(nil == keyword || keyword.length == 0){
    }else{
         param = @{@"keyword":keyword};
    }
    [[HttpClient sharedClient] POST:QUERY_PRODUCT parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        NSArray *productDict = [responseObject objectForKey:@"Data"];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(int i = 0;i< [productDict count];i++){
            [array addObject:[[ProductModel alloc] initWithJson:productDict[i]]];
        }
        block(nil,array);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([ProductManager errorWithConnectionError],nil);
    }];
}

-(void) productDetails:(NSNumber *)productId block:(ObjectResultBlock)block{
    
}

@end
