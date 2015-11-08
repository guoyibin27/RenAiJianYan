//
//  AppDelegate.m
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "Constants.h"
#import "LeanCloudUserFactory.h"
#import "UserModel.h"
#import "ProgressHUD.h"
#import "LZPushManager.h"
#import "WXApi.h"

static NSDictionary *examinationReportItemDictionary;

@implementation AppDelegate

+ (NSArray *) getReportItemResult:(NSString *) key{
    return [examinationReportItemDictionary objectForKey:key];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self netWorkStatusListening];
    [WXApi registerApp:WeChat_APP_ID withDescription:@"仁爱检验"];
    
    examinationReportItemDictionary = @{@"method_1_result":@[@"HIV抗体检测",@"阴性"],@"method_2_result":@[@"尿HIV抗体检测",@"阴性"],@"method_3_result":@[@"孕检",@"阴性"]
                                        ,@"method_4_result":@[@"尿蛋白",@"阴性"]
                                        ,@"method_5_result":@[@"尿糖",@"阴性"]};
//    [AVPush setProductionMode:YES];
    [AVOSCloud setApplicationId:LEANCLOUD_APP_ID clientKey:LEANCLOUD_KEY];
    [CDChatManager manager].userDelegate = [[LeanCloudUserFactory alloc] init];
    [AVOSCloud setLastModifyEnabled:YES];
#ifdef DEBUG
    //    [AVOSCloud setAllLogsEnabled:YES];
#endif
    [[LZPushManager manager] registerForRemoteNotification];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [[LZPushManager manager] syncBadge];
    [[LZPushManager manager] cleanBadge];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [application cancelAllLocalNotifications];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[LZPushManager manager] syncBadge];
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[LZPushManager manager] saveInstallationWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    DLog(@"%@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if (application.applicationState == UIApplicationStateActive) {
        // 应用在前台时收到推送，只能来自于普通的推送，而非离线消息推送
        NSLog(@"didReceiveRemoteNotification");
    }
    else {
        //  当使用 https://github.com/leancloud/leanchat-cloudcode 云代码更改推送内容的时候
        //        {
        //            aps =     {
        //                alert = "lzwios : sdfsdf";
        //                badge = 4;
        //                sound = default;
        //            };
        //            convid = 55bae86300b0efdcbe3e742e;
        //        }
        
        [[CDChatManager manager] didReceiveRemoteNotification:userInfo];
        NSLog(@"didReceiveRemoteNotification %@",userInfo);
    }
}

+ (UserModel *) getCurrentLogonUser{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:CURRENT_USER];
    UserModel *currentUser = nil;
    if(data){
        currentUser = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return currentUser;
}

+(void)removeUserFromNSUserDefaults{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:CURRENT_USER];
    [userDefaults synchronize];
}

+ (void) putCurrentLogonUser:(UserModel *) logonUser{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:logonUser];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:data forKey:CURRENT_USER];
    [userDefaults synchronize];
}

-(void)netWorkStatusListening
{
    NSURL *baseUrl = [NSURL URLWithString:SERVER_HOST];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseUrl];
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            {
                [operationQueue setSuspended:YES];
                [ProgressHUD showError:@"无网络可用"];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                [operationQueue setSuspended:NO];
                NSLog(@"WIFI");
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                [operationQueue setSuspended:NO];
                NSLog(@"WWAN");
            }
                break;
            default:
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];
}

+ (void) cacheChattingUser:(NSString *)userId username:(NSString *) username{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:username forKey:userId];
    [userDefaults synchronize];
}

+ (NSString *) getCacheChattingUser:(NSString *)userId{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaults objectForKey:userId];
    return username;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return  [WXApi handleOpenURL:url delegate:self];
}

-(void) onResp:(BaseResp*)resp{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationWxPayResponse object:nil userInfo:@{@"WxPayResp":resp}];
}
@end
