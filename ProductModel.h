//
//  ProductModel.h
//  RenAiJianYan
//
//  Created by Sylar on 15/11/15.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject<NSCoding>

@property (retain, nonatomic) NSNumber *productId;
@property (retain, nonatomic) NSNumber *supplierId;
@property (retain, nonatomic) NSString *productNo;
@property (retain, nonatomic) NSString *productDescription;
@property (retain, nonatomic) NSString *status;
@property (retain, nonatomic) NSString *type;
@property (retain, nonatomic) NSString *statement;
@property (retain, nonatomic) NSString *instruction;
@property (retain, nonatomic) NSNumber *sold;
@property (retain, nonatomic) NSNumber *quantity;
@property (retain, nonatomic) NSString *productName;

@property (retain, nonatomic) NSString *primaryPicture;
@property (retain, nonatomic) NSMutableArray *productPictures;
@property (retain, nonatomic) NSNumber *buyCount;
@property (retain, nonatomic) NSString *supplierName;
@property (retain, nonatomic) NSDictionary *fees;

- (instancetype) initWithJson:(NSDictionary *)json;

- (double) calculateProductAmount;
@end
