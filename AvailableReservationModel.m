//
//  AvailableReservationModel.m
//  RenAiJianYan
//
//  Created by Sylar on 8/31/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "AvailableReservationModel.h"
#import "BaseViewController.h"
#import "HttpClient.h"
#import "Constants.h"
#import "AvailableReservationModel.h"
#import "AppDelegate.h"
#import "NSDate+FSExtension.h"
#import "AdminUserModel.h"
#import "UserModel.h"

@implementation AvailableReservationModel

static NSDateFormatter *dateFormatter;
static NSDateFormatter *stringDateFormatter;
static NSDateFormatter *dateWithoutMinuteFormmater;

- (instancetype)init
{
    self = [super init];
    NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:local];
    [dateFormatter setDateFormat:@"aaaHH点mm分"];
    [dateFormatter setPMSymbol:@"下午"];
    [dateFormatter setAMSymbol:@"上午"];
    stringDateFormatter = [[NSDateFormatter alloc] init];
    [stringDateFormatter setLocale:local];
    [stringDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    dateWithoutMinuteFormmater = [[NSDateFormatter alloc] init];
    [dateWithoutMinuteFormmater setLocale:local];
    [dateWithoutMinuteFormmater setDateFormat:@"aaaHH点"];
    [dateWithoutMinuteFormmater setPMSymbol:@"下午"];
    [dateWithoutMinuteFormmater setAMSymbol:@"上午"];
    return self;
}

- (instancetype) parse:(NSDictionary *)dict{
    self.reservationId = [dict objectForKey:@"Id"];
    self.reservationDesc = [dict objectForKey:@"ReservationDesc"];
    self.reservationInfo = [dict objectForKey:@"ReservationInfo"];
    self.reservationMethod = [dict objectForKey:@"ReservationMethod"];
    self.reserveBy = [dict objectForKey:@"ReserveBy"];
    self.serviceId = [dict objectForKey:@"ServiceId"];
    self.serviceExpertId = [dict objectForKey:@"ServicerId"];
    self.end = [[dict objectForKey:@"End"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    self.start = [[dict objectForKey:@"Start"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSDate *startDate = [stringDateFormatter dateFromString:self.start];
    if([startDate fs_minute] == 0){
        self.startLabel = [dateWithoutMinuteFormmater stringFromDate:startDate];
    }else{
        self.startLabel = [dateFormatter stringFromDate:startDate];
    }
    
    NSDate *endDate = [stringDateFormatter dateFromString:self.end];
    if([endDate fs_minute] == 0){
        self.endLabel = [dateWithoutMinuteFormmater stringFromDate:endDate];
    }else{
        self.endLabel = [dateFormatter stringFromDate:endDate];
    }
    self.status = [dict objectForKey:@"Status"];
    self.amount = [dict objectForKey:@"Amount"];
    self.allowedMethods = [dict objectForKey:@"AllowedMethods"];

    NSDictionary *servicerDict = [dict objectForKey:@"Servicer"];
    if(![servicerDict isKindOfClass:[NSNull class]] && servicerDict && servicerDict.count > 0){
        AdminUserModel *adminUser = [[AdminUserModel alloc] init];
        self.serviceExpertModel = [adminUser parse:servicerDict];
    }
    return self;
}
@end
