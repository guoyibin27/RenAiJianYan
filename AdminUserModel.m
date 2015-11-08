//
//  AdminUserModel.m
//  RenAiJianYan
//
//  Created by Sylar on 8/31/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "AdminUserModel.h"

@implementation AdminUserModel

- (instancetype) parse:(NSDictionary *) dict
{
    self.userName = [dict objectForKey:@"Username"];
    self.name = [dict objectForKey:@"Name"];
    self.userId = [dict objectForKey:@"Id"];
    return  self;
}
@end
