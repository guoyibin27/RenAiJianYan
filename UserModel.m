//
//  UserModel.m
//  RenAiJianYan
//
//  Created by Sylar on 8/25/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (instancetype) parseUser:(NSDictionary *)dict{
    self.userId = [dict objectForKey:@"_id"];
    self.userName = [dict objectForKey:@"_nickname"];
    self.password = [dict objectForKey:@"_password"];
    self.email = [dict objectForKey:@"_email"];
    self.status = [dict objectForKey:@"_status"];
    self.phone = [dict objectForKey:@"_phone"];
    self.gender = [dict objectForKey:@"_gender"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userId    forKey:@"userId"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.email forKey:@"email"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self.userId = [aDecoder decodeObjectForKey:@"userId"];
    self.userName = [aDecoder decodeObjectForKey:@"userName"];
    self.password = [aDecoder decodeObjectForKey:@"password"];
    self.gender = [aDecoder decodeObjectForKey:@"gender"];
    self.status = [aDecoder decodeObjectForKey:@"status"];
    self.phone = [aDecoder decodeObjectForKey:@"phone"];
    self.email = [aDecoder decodeObjectForKey:@"email"];
    return self;
}

@end
