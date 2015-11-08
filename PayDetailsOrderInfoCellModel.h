//
//  PayDetailsCellModel.h
//  RenAiJianYan
//
//  Created by Sylar on 9/10/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayDetailsOrderInfoCellModel : NSObject
@property (retain, nonatomic) NSString *labelText;
@property (retain, nonatomic) NSString *valueText;
@property (retain, nonatomic) NSString *selector;

+ (instancetype) initWithLabel:(NSString *)label value:(NSString *)value selector:(NSString *)selector;

@end
