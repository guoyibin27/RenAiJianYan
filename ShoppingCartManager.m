//
//  ShoppingCartManager.m
//  RenAiJianYan
//
//  Created by Sylar on 15/11/16.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "ShoppingCartManager.h"
#import "Constants.h"
#import "ProductModel.h"

@implementation ShoppingCartManager

static ShoppingCartManager *instance;

+ (instancetype)manager {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[ShoppingCartManager alloc] init];
    });
    return instance;
}

-(void) addToCart:(ProductModel *) product{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [self getShoppingCart];
    if(!dict){//购物车空的
        dict = [[NSMutableDictionary alloc] init];
    }
    ProductModel *pm = [dict  objectForKey:product.productId];
    if(pm){//购物车中找到要加入的商品
        product.buyCount = [NSNumber numberWithInt:pm.buyCount.intValue + 1];
    }else{//找不到，则把当前要加入的商品加进去
        product.buyCount = [NSNumber numberWithInt:1];
    }
    //将商品放进字典中
    [dict setObject:product forKey:product.productId];
    //将字典写入UserDefault中。
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [userDefaults setObject:data forKey:SHOPPING_CART];
    [userDefaults synchronize];
}

-(void) subProductCount:(ProductModel *) product{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [self getShoppingCart];
    ProductModel *pm = [dict  objectForKey:product.productId];
    if(pm){//购物车中找到要加入的商品
        product.buyCount = [NSNumber numberWithInt:pm.buyCount.intValue - 1];
    }
    //将商品放进字典中
    [dict setObject:product forKey:product.productId];
    //将字典写入UserDefault中。
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [userDefaults setObject:data forKey:SHOPPING_CART];
    [userDefaults synchronize];
}

-(void) deleteProductFromCart:(ProductModel *)product{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dict = [self getShoppingCart];
    [dict removeObjectForKey:product.productId];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [userDefaults setObject:data forKey:SHOPPING_CART];
    [userDefaults synchronize];
}

-(NSMutableDictionary *) getShoppingCart{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:SHOPPING_CART];
    NSMutableDictionary *dict;
    if(data){
        dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return dict;
}

-(void) clear{
    
}

@end
