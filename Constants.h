//
//  Constants.h
//  RenAiJianYan
//
//  Created by Sylar on 8/25/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#ifndef RenAiJianYan_Constants_h
#define RenAiJianYan_Constants_h

#include "MessageConstants.h"

#define LEANCLOUD_APP_ID @"inji87dzdnwf2op2136765atp3wnmmquxzhkxz8138sacpye"
#define LEANCLOUD_KEY @"vuf2a48luq7acrrgda40nho4fapzsfr1y3dc4se2ihwmrcmq"

#define WeChat_APP_ID @"wx2989d1fc9d539313"

#define kNotificationWxPayResponse @"kNotificationWxPayResponse"


#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)

#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define Rgb2UIColor(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define Hex2UIColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define DEFAULT_FONT_SIZE_LARGE 16
#define DEFAULT_FONT_SIZE_MIDDLE 14
#define DEFAULT_FONT_SIZE_SMALL 12

typedef enum{
    ReservationTypeNone,
    ReservationTypeApp,
    ReservationTypePhone
}ReservationType;

#define CURRENT_USER @"CurrentUser"
#define SHOPPING_CART @"ShoppingCart"

//#define SERVER_HOST @"http://192.168.31.154:9000/api/"
#define SERVER_HOST @"http://192.168.0.120:9000/api/"
//#define SERVER_HOST @"http://www.renaijianyan.com:9095/api"
//#define SERVER_HOST @"http://192.168.1.104:9000/api/"
//#define IMAGE_SERVER_HOST @"http://192.168.1.104:9001/cui/pages/showimage.aspx?filename="
//#define IMAGE_SERVER_HOST @"http://192.168.1.148:9001/cui/pages/showimage.aspx?filename="
#define IMAGE_SERVER_HOST @"http://www.renaijianyan.com:9091/cui/pages/showimage.aspx?filename="

//USER CONTROLLER
#define LOGIN_URL @"user/login"
#define RESET_PASSWORD_URL @"user/resetPassword"
#define REGISTER_URL @"user/register"
#define VALIDATE_VERIFY_CODE_URL @"user/validateVerifyCode"
#define GET_VERIFY_CODE_URL @"user/verifyCode"
#define FIND_PASSWORD_URL @"user/findPassword"

//REPORT CONTROLLER
#define QUERY_EXAMINATION_REPORT_URL @"report/query"
#define COLLECT_EXAMINATION_REPORT_URL @"report/collect"
#define FETCH_COLLECT_REPORTS_URL @"report/reports"
#define REMOVE_REPORT_URL @"report/remove"


//RESERVATION CONTROLLER
#define FETCH_SERVICES @"reservation/services"
#define FETCH_SERVICERS @"reservation/servicers"
#define FETCH_RESERVATIONS @"reservation/availableReservations"
#define CHECK_RESERVATION_FOR_PAY @"reservation/checkReservationForPay"
#define FETCH_RESERVED_SERVICE @"reservation/getReservedServices"
#define RESERVE_URL @"reservation/reserve"
#define COMMIT_RESERVATION_URL @"reservation/commitReservation"
#define CLOSE_RESERVATION_URL @"reservation/closeReservation"

//PAYMENT CONTROLLER
#define UNIFIED_ORDER @"payment/unifiedOrder"
#define QUERY_RESERVATION_PAY_STATE @"payment/queryReservationPayState"

//product controller
#define QUERY_PRODUCT @"product/products"
#define PRODUCT_DETAILS @"product/productDetails"


//block define
typedef void (^ArrayResultBlock)(NSError *error, NSMutableArray *array);
typedef void (^ObjectResultBlock)(NSError *error, id object);
typedef void (^BooleanResultBlock)(BOOL success);

#endif
