//
//  AddressManager.m
//  RenAiJianYan
//
//  Created by Sylar on 15/11/21.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "AddressManager.h"
#import "HttpClient.h"
#import "AddressModel.h"

@implementation AddressManager

static AddressManager *instance;

+(instancetype)manager{
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[AddressManager alloc] init];
    });
    return instance;
}

-(void) fetchAddressList:(NSNumber *)cid block:(ArrayResultBlock)block{
    NSDictionary *param = @{@"cid":cid};
    [[HttpClient sharedClient] GET:ADDRESS_LIST parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *json = [responseObject objectForKey:@"Data"];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(int i = 0;i< [json count];i++){
            [array addObject:[[AddressModel alloc] initWithJson:json[i]]];
        }
        block(nil,array);
 
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([AddressManager errorWithConnectionError],nil);
    }];
}

-(void) addAddress:(AddressModel *)address block:(BooleanResultBlock)block{
    NSDictionary *params = @{@"Contact":address.contact,
                             @"Address":address.address,
                             @"CustomerId":address.userId,
                             @"Tel":address.tel,
                             @"IsDefault":[NSNumber numberWithBool:address.isDefault],
                             @"Status":@"A",
                             @"Comment":@" "};
    [[HttpClient sharedClient] POST:ADD_ADDRESS parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block([[responseObject objectForKey:@"Success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block(NO);
    }];
}

-(void) deleteAddress:(NSNumber *)addressId userId:(NSNumber *)userId block:(BooleanResultBlock)block{
    NSDictionary *params = @{@"id":addressId,@"cid":userId};
    [[HttpClient sharedClient] GET:DELETE_ADDRESS parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block([[responseObject objectForKey:@"Success"] boolValue]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block(NO);
    }];
}

@end
