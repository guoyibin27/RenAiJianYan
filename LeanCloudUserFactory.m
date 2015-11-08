//
//  LeanCloudUserFactory.m
//  RenAiJianYan
//
//  Created by Sylar on 9/4/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "LeanCloudUserFactory.h"
#import "UserModel.h"
#import "AppDelegate.h"


@interface LeanCloudUserModel : NSObject<CDUserModel>

@property (retain, nonatomic) NSString *userId;
@property (retain, nonatomic) NSString *username;
@property (retain, nonatomic) NSString *avatarUrl;

@end

@implementation LeanCloudUserModel

@end


@implementation LeanCloudUserFactory

// cache users that will be use in getUserById
- (void)cacheUserByIds:(NSSet *)userIds block:(AVBooleanResultBlock)block {
    block(YES, nil); // don't forget it
}

- (id <CDUserModel> )getUserById:(NSString *)userId {
    NSString *username = [AppDelegate getCacheChattingUser:userId];
    LeanCloudUserModel *model = [[LeanCloudUserModel alloc] init];
    if(username == nil || username.length == 0){
        UserModel *usermodel = [AppDelegate getCurrentLogonUser];
        if([userId isEqualToString:[NSString stringWithFormat:@"user_%@",usermodel.userName]]){
            model.userId = [NSString stringWithFormat:@"user_%@",usermodel.userId];
            model.username = usermodel.userName;
            model.avatarUrl = nil;
        }
        return model;
    }else{
        model.userId = userId;
        model.username = username;
        model.avatarUrl = nil;
        return model;
    }
}

@end
