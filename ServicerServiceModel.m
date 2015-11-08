//
//  ServicerService.m
//  RenAiJianYan
//
//  Created by Sylar on 8/31/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ServicerServiceModel.h"
#import "HttpClient.h"
#import "Constants.h"
#import "BaseViewController.h"
#import "AdminUserModel.h"

@implementation ServicerServiceModel

- (instancetype) parse:(NSDictionary *)dict
{
    self.serviceId = [dict objectForKey:@"ServiceId"];
    self.serviceExpertId = [dict objectForKey:@"ServicerId"];
    self.level = [dict objectForKey:@"Level"];
    self.qualificationDescription = [dict objectForKey:@"QualificationDescription"];
    self.adminUser = [[[AdminUserModel alloc] init] parse:[dict objectForKey:@"Servicer"]];
    return self;
}

@end
