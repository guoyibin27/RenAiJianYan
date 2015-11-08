//
//  PayDetailsPaymentWayCellModel.m
//  RenAiJianYan
//
//  Created by Sylar on 9/10/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "PayDetailsPaymentMethodCellModel.h"

@implementation PayDetailsPaymentMethodCellModel

+ (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle method:(PaymentMethod)paymentMethod icon:(NSString *)icon isChecked:(BOOL)isChecked{
    PayDetailsPaymentMethodCellModel *m = [[PayDetailsPaymentMethodCellModel alloc] init];
    m.title = title;
    m.subTitle = subTitle;
    m.icon = icon;
    m.isChecked = isChecked;
    m.paymetMethod = paymentMethod;
    return m;
}

@end
