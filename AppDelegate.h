//
//  AppDelegate.h
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@class UserModel;
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (UserModel *) getCurrentLogonUser;

+ (void) putCurrentLogonUser:(UserModel *) logonUser;

+ (void)removeUserFromNSUserDefaults;

+ (NSArray *) getReportItemResult:(NSString *) key;

+ (void) cacheChattingUser:(NSString *)userId username:(NSString *) username;
+ (NSString *) getCacheChattingUser:(NSString *)userId;
@end

