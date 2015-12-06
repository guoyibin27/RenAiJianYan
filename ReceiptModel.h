//
//  ReceiptModel.h
//  RenAiJianYan
//
//  Created by Sylar on 15/12/5.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReceiptModel : NSObject
@property(retain, nonatomic) NSNumber *receitId;
@property(retain, nonatomic) NSString *receiptNumber;
@property(retain, nonatomic) NSNumber *totalAmount;
@property(retain, nonatomic) NSMutableArray *receiptDetails;

- (instancetype) initWithJson:(NSDictionary *)json;

@end
