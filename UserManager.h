//
//  UserManager.h
//  RenAiJianYan
//
//  Created by Sylar on 9/16/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "BaseManager.h"

@class UserModel;
@interface UserManager : BaseManager

+ (instancetype)manager;

- (void) loginWithUserName:(NSString *)username password:(NSString *)password block:(ObjectResultBlock)block;

- (void) resetPasswordWithUserId:(NSNumber *)userId oldPassword:(NSString *)oldPassword newPassword:(NSString *)password block:(ObjectResultBlock)block;

- (void) registerUser:(UserModel *)userModel block:(ObjectResultBlock)block;

- (void) fetchVerifyCodeWithPhone:(NSString *)phone block:(ObjectResultBlock)block;

- (void) validateVerifyCodeWithPhone:(NSString *)phone code:(NSString *)code block:(ObjectResultBlock)block;

- (void) findPasswordWithUserName:(NSString *)username phone:(NSString *)phone block:(ObjectResultBlock)block;

@end
