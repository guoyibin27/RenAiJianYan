//
//  PayDetailsCellModel.m
//  RenAiJianYan
//
//  Created by Sylar on 9/10/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "PayDetailsOrderInfoCellModel.h"

@implementation PayDetailsOrderInfoCellModel

+ (instancetype) initWithLabel:(NSString *)label value:(NSString *)value  selector:(NSString *)selector{
    PayDetailsOrderInfoCellModel *m = [[PayDetailsOrderInfoCellModel alloc] init];
    m.labelText = label;
    m.valueText = value;
    m.selector = selector;
    return m;
}

@end
