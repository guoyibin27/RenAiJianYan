//
//  HttpClient.h
//  RenAiJianYan
//
//  Created by Sylar on 8/25/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface HttpClient : AFHTTPRequestOperationManager

+ (HttpClient *) sharedClient;

@end
