//
//  WxPayData.h
//  RenAiJianYan
//
//  Created by Sylar on 9/14/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@class WXErrCode;
@interface WxPayData : NSObject

@property (retain, nonatomic) NSString *appId;
@property (retain, nonatomic) NSString *partnerId;
@property (retain, nonatomic) NSString *nonceStr;
@property (retain, nonatomic) NSString *prepayId;
@property (retain, nonatomic) NSString *sign;
@property (retain, nonatomic) NSString *timeStamp;
@property (retain, nonatomic) NSString *package;


+(void)unifiedOrderWithUserId:(NSNumber *)userId block:(void (^)(WxPayData *wxpayData))block;

+(void)queryPayStateWithReservationId:(NSNumber *)reservationId block:(BooleanResultBlock)block;
@end
