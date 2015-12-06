//
//  ProductManager.h
//  RenAiJianYan
//
//  Created by Sylar on 15/11/15.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "BaseManager.h"

@interface ProductManager : BaseManager

+(instancetype)manager;

-(void) queryProduct:(NSString *)keyword block:(ArrayResultBlock)block;

-(void) productDetails:(NSNumber *)productId block:(ObjectResultBlock)block;

-(void) receiptTotal:(NSArray *)productList uid:(NSNumber *)uid address:(NSNumber *)addressId block:(ObjectResultBlock) block;
@end
