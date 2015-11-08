//
//  BaseManager.h
//  RenAiJianYan
//
//  Created by Sylar on 9/16/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseManager : NSObject

+(NSError *)errorWithText:(NSString *)text;

+(NSError *)errorWithConnectionError;

+(NSError *)errorWithNoData;
@end
