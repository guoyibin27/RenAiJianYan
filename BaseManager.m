//
//  BaseManager.m
//  RenAiJianYan
//
//  Created by Sylar on 9/16/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "BaseManager.h"
#import "MessageConstants.h"

@implementation BaseManager

+(NSError *)errorWithText:(NSString *)text{
    return [NSError errorWithDomain:@"RenAiJianYan" code:0 userInfo:@{NSLocalizedDescriptionKey:text}];
}

+(NSError *)errorWithConnectionError{
    return [self errorWithText:MESSAGE_CONNECTION_ERROR];
}

+(NSError *)errorWithNoData{
    return [self errorWithText:MESSAGE_NO_DATA];
}

@end
