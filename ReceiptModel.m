//
//  ReceiptModel.m
//  RenAiJianYan
//
//  Created by Sylar on 15/12/5.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "ReceiptModel.h"
#import "ProductModel.h"

@implementation ReceiptModel

- (instancetype) initWithJson:(NSDictionary *)json{
    self = [super init];
    if(self){
        self.receitId = [json objectForKey:@"_id"];
        self.receiptNumber = [json objectForKey:@"_receiptNumber"];
        self.totalAmount = [json objectForKey:@"_totalAmount"];
        self.receiptDetails = [NSMutableArray array];
        NSDictionary *details = [json objectForKey:@"_receiptDetails"];
        for(NSDictionary *dict in details){
            ProductModel *product = [[ProductModel alloc] initWithJson:[dict objectForKey:@"_product"]];
            product.buyCount = [dict objectForKey:@"_quantity"];
            [self.receiptDetails addObject:product];
        }
    }
    return self;
}

@end
