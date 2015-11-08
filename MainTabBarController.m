//
//  MainTabBarController.m
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "MainTabBarController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "UserModel.h"
#import "Constants.h"

@interface MainTabBarController ()<UIAlertViewDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UserModel *_currentLogonUser = [AppDelegate getCurrentLogonUser];
    if(!_currentLogonUser){
        [self forwardToLogin];
    }else{
        [[CDChatManager manager] openWithClientId:[NSString stringWithFormat:@"user_%@",_currentLogonUser.userName] callback: ^(BOOL succeeded, NSError *error) {
            if (error) {
                if(self.view.window){
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户账号异常，请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [view show];
                }else{
                    [AppDelegate removeUserFromNSUserDefaults];
                }
            }
        }];
    }

}

- (void)forwardToLogin
{
    LoginViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginView];
    navigationController.navigationBar.barTintColor = Hex2UIColor(0x174C80);
    navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self forwardToLogin];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
