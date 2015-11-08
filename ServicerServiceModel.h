//
//  ServicerService.h
//  RenAiJianYan
//
//  Created by Sylar on 8/31/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//
//  专家Model
//
//

#import <Foundation/Foundation.h>

@class AdminUserModel;
@interface ServicerServiceModel : NSObject

@property (retain, nonatomic) NSNumber *serviceExpertId;
@property (retain, nonatomic) NSNumber *serviceId;
@property (retain, nonatomic) NSString *level;
@property (retain, nonatomic) NSString *qualificationDescription;
@property (retain, nonatomic) AdminUserModel *adminUser;
@property (nonatomic) BOOL isChecked;

- (instancetype) parse:(NSDictionary *)dict;

@end
