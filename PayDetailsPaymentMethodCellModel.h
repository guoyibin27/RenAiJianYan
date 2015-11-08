//
//  PayDetailsPaymentWayCellModel.h
//  RenAiJianYan
//
//  Created by Sylar on 9/10/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    PaymentMethodWeChatPay,
    PaymentMethodUnionPay,
    PaymentMethodAliPay
}PaymentMethod;

@interface PayDetailsPaymentMethodCellModel : NSObject

@property (nonatomic) int paymetMethod;
@property (retain, nonatomic) NSString *title;
@property (retain, nonatomic) NSString *subTitle;
@property (retain, nonatomic) NSString *icon;
@property (nonatomic) BOOL isChecked;

+ (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle method:(PaymentMethod)paymentMethod icon:(NSString *)icon isChecked:(BOOL)isChecked;
@end
