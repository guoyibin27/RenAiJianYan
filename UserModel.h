//
//  UserModel.h
//  RenAiJianYan
//
//  Created by Sylar on 8/25/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeanChatLib.h"

@interface UserModel : NSObject<NSCoding>

@property (nonatomic) NSNumber *userId;
@property (retain, nonatomic) NSString *userName;
@property (retain, nonatomic) NSString *password;
@property (retain, nonatomic) NSString *email;
@property (retain, nonatomic) NSString *status;
@property (retain, nonatomic) NSString *gender;
@property (retain, nonatomic) NSString *phone;


- (instancetype) parseUser:(NSDictionary *) dict;

@end
