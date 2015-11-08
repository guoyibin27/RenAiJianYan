//
//  UserManager.m
//  RenAiJianYan
//
//  Created by Sylar on 9/16/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "UserManager.h"
#import "HttpClient.h"
#import "UserModel.h"

static UserManager *instance;
@implementation UserManager

+ (instancetype)manager {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[UserManager alloc] init];
    });
    return instance;
}

- (void) loginWithUserName:(NSString *)username password:(NSString *)password block:(ObjectResultBlock)block{
    NSDictionary *params = @{@"username":username,@"password":password};
    [[HttpClient sharedClient] GET:LOGIN_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        BOOL _success = [[responseObject objectForKey:@"Success"] boolValue];
        if(_success)
        {
            block(nil,[[[UserModel alloc] init] parseUser:[responseObject objectForKey:@"Data"]]);
        }else{
            NSString *_message = [responseObject objectForKey:@"Message"];
            block([UserManager errorWithText:_message],nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([UserManager errorWithConnectionError],nil);
    }];
}

- (void) resetPasswordWithUserId:(NSNumber *)userId oldPassword:(NSString *)oldPassword newPassword:(NSString *)password block:(ObjectResultBlock)block{
    NSDictionary *params= @{@"id":userId,@"newPassword":password,@"oldPassword":oldPassword};
    
    [[HttpClient sharedClient] GET:RESET_PASSWORD_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if([[responseObject objectForKey:@"Success"] boolValue]){
            block(nil,[responseObject objectForKey:@"Message"]);
        }else{
            block([UserManager errorWithText:[responseObject objectForKey:@"Message"]],nil);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([UserManager errorWithConnectionError],nil);
    }];

}

- (void) registerUser:(UserModel *)userModel block:(ObjectResultBlock)block{
    NSDictionary *params = @{@"Nickname":userModel.userName,
                             @"Password":userModel.password,
                             @"Phone":userModel.phone,
                             @"Email":@" "};
    
    [[HttpClient sharedClient] POST:REGISTER_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL _success = [[responseObject objectForKey:@"Success"] boolValue];
        if(_success){
            block(nil,[[[UserModel alloc] init] parseUser:[responseObject objectForKey:@"Data"]]);
        }else{
            block([UserManager errorWithText:[responseObject objectForKey:@"Message"]],nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([UserManager errorWithConnectionError],nil);
    }];
}

- (void) fetchVerifyCodeWithPhone:(NSString *)phone block:(ObjectResultBlock)block{
    NSDictionary *params= @{@"phone":phone};
    
    [[HttpClient sharedClient] GET:GET_VERIFY_CODE_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *_message = [responseObject objectForKey:@"Message"];
        BOOL _success = [[responseObject objectForKey:@"Success"] boolValue];
        if(_success){
            block(nil,_message);
        }else{
            block([UserManager errorWithText:_message],nil);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([UserManager errorWithConnectionError],nil);
    }];
}

- (void) validateVerifyCodeWithPhone:(NSString *)phone code:(NSString *)code block:(ObjectResultBlock)block{
    NSDictionary *params = @{@"phone":phone,@"code":code};
    
    [[HttpClient sharedClient] GET:VALIDATE_VERIFY_CODE_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        BOOL _success = [[responseObject objectForKey:@"Success"] boolValue];
        if(_success){
            block(nil,nil);
        }else{
            block([UserManager errorWithText:[responseObject objectForKey:@"Message"]],nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([UserManager errorWithConnectionError],nil);
    }];
}

- (void) findPasswordWithUserName:(NSString *)username phone:(NSString *)phone block:(ObjectResultBlock)block{
    NSDictionary *params = @{@"username":username,@"phone":phone};
    
    [[HttpClient sharedClient] GET:FIND_PASSWORD_URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *message = [responseObject objectForKey:@"Message"];
        if([[responseObject objectForKey:@"Success"] boolValue]){
            block(nil,message);
        }else{
            block([UserManager errorWithText:[responseObject objectForKey:@"Message"]],nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        block([UserManager errorWithConnectionError],nil);
    }];
}


@end
