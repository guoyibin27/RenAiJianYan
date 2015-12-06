//
//  AddressModel.h
//  RenAiJianYan
//
//  Created by Sylar on 15/11/21.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

@property (retain, nonatomic) NSNumber *userId;
@property (retain, nonatomic) NSNumber *addressId;
@property (nonatomic) BOOL isDefault;
@property (retain, nonatomic) NSString *status;
@property (retain, nonatomic) NSString *contact;
@property (retain, nonatomic) NSString *tel;
@property (retain, nonatomic) NSString *address;
@property (retain, nonatomic) NSString *comment;

- (instancetype) initWithJson:(NSDictionary *)json;

@end
