//
//  AvailableReservationModel.h
//  RenAiJianYan
//
//  Created by Sylar on 8/31/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseViewController;
@class AdminUserModel;
@class ServiceModel;

@interface AvailableReservationModel : NSObject

@property (retain, nonatomic) NSNumber *reservationId;
@property (retain, nonatomic) NSString *reservationDesc;
@property (retain, nonatomic) NSString *reservationInfo;
@property (retain, nonatomic) NSString *reservationMethod;
@property (retain, nonatomic) NSString *reserveBy;
@property (retain, nonatomic) NSNumber *serviceId;
@property (retain, nonatomic) NSNumber *serviceExpertId;
@property (retain, nonatomic) NSString *start;
@property (retain, nonatomic) NSString *end;
@property (retain, nonatomic) NSString *startLabel;
@property (retain, nonatomic) NSString *endLabel;
@property (retain, nonatomic) NSString *status;
@property (retain, nonatomic) NSNumber *amount;
@property (retain, nonatomic) NSString *allowedMethods;

@property (retain, nonatomic) AdminUserModel *serviceExpertModel;
@property (nonatomic) BOOL isChecked;

- (instancetype) parse:(NSDictionary *)dict;

@end
