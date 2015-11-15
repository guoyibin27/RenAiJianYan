//
//  ShoppingCartManager.h
//  RenAiJianYan
//
//  Created by Sylar on 15/11/16.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProductModel;

@interface ShoppingCartManager : NSObject

+(instancetype)manager;

-(void) addToCart:(ProductModel *) product;

-(void) subProductCount:(ProductModel *) product;

-(void) deleteProductFromCart:(ProductModel *)product;

-(NSMutableDictionary *) getShoppingCart;

-(void) clear;

@end
