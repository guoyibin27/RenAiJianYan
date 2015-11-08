//
//  ServiceModel.h
//  RenAiJianYan
//
//  Created by Sylar on 8/31/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//
//  服务项目Model
//

#import <Foundation/Foundation.h>

@interface ServiceModel : NSObject

@property (retain, nonatomic) NSNumber *serviceId;
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *serviceDescription;
@property (retain, nonatomic) NSString *status;
@property (retain, nonatomic) NSString *priceLevel1;
@property (retain, nonatomic) NSString *priceLevel2;
@property (retain, nonatomic) NSString *priceLevel3;
@property (retain, nonatomic) NSString *priceLevel4;
@property (retain, nonatomic) NSString *priceLevel5;
@property (retain, nonatomic) NSString *image;
@property (retain, nonatomic) NSArray *services;
@property (nonatomic) BOOL isChecked;

- (instancetype) parse:(NSDictionary *)dict;

@end
