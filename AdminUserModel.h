//
//  AdminUserModel.h
//  RenAiJianYan
//
//  Created by Sylar on 8/31/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdminUserModel : NSObject

@property (retain, nonatomic) NSNumber *userId;
@property (retain, nonatomic) NSString *userName;
@property (retain, nonatomic) NSString *name;

- (instancetype) parse:(NSDictionary *) dict;

@end
