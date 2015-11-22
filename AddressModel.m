//
//  AddressModel.m
//  RenAiJianYan
//
//  Created by Sylar on 15/11/21.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

- (instancetype) initWithJson:(NSDictionary *)json{
    self = [super init];
    if(self){
        self.userId = [json objectForKey:@"CustomerId"];
        self.addressId = [json objectForKey:@"Id"];
        self.isDefault = [json objectForKey:@"IsDefault"];
        self.status = [json objectForKey:@"Status"];
        self.contact = [json objectForKey:@"Contact"];
        self.tel = [json objectForKey:@"Tel"];
        self.address = [json objectForKey:@"Address"];
        self.comment = [json objectForKey:@"Comment"];
    }
    return self;
}

@end
