//
//  LoginViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "LoginViewController.h"
#import "HttpClient.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "UserModel.h"
#import "UserManager.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize usernameFeild,passwordField,loginButton,logo,registerLabel;

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    self.title = @"登陆";
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    logo = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 180) / 2, 104, 180, 100)];
    logo.image = [UIImage imageNamed:@"AppLogo"];
    
    usernameFeild = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(logo.frame) + 40, CGRectGetWidth(self.view.frame) - 20, 44)];
    [usernameFeild setPlaceholder:@"用户名"];
    usernameFeild.borderStyle = UITextBorderStyleRoundedRect;
    usernameFeild.delegate = self;
//    usernameFeild.text = @"rivneg";
    
    passwordField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(usernameFeild.frame) + 10, CGRectGetWidth(self.view.frame) - 20, 44)];
    passwordField.placeholder = @"密码";
    passwordField.secureTextEntry = YES;
    passwordField.borderStyle = UITextBorderStyleRoundedRect;
    passwordField.delegate = self;
//    passwordField.text = @"8forxiao";
    
    loginButton = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(passwordField.frame) + 20, CGRectGetWidth(self.view.frame) - 20, 44)];
    loginButton.backgroundColor = Hex2UIColor(0x2987EA);
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    loginButton.layer.cornerRadius = 5;
    loginButton.layer.masksToBounds = YES;
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    registerLabel = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 41, SCREEN_WIDTH, 21)];
    [registerLabel setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerLabel setTitleColor:Hex2UIColor(0x2987EA) forState:UIControlStateNormal];
    registerLabel.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [registerLabel addTarget:self action:@selector(showRegister) forControlEvents:UIControlEventTouchUpInside];
    
    [self dismissKeyboard:self.view];
    [self.view addSubview:logo];
    [self.view addSubview:registerLabel];
    [self.view addSubview:usernameFeild];
    [self.view addSubview:passwordField];
    [self.view addSubview:loginButton];
    
    [self dismissKeyboard:self.view];
    [self showNavigationRightButton:@"找回密码" selector:@selector(showForgotPassword)];
}

- (void)showRegister{
    [self performSegueWithIdentifier:@"showRegister" sender:nil];
}

- (void) showForgotPassword{
    [self performSegueWithIdentifier:@"showForgotPassword" sender:nil];
}

- (void)login{
    if([self validateInputFieldValue]){
        [self showProgress:nil];
        [[UserManager manager] loginWithUserName:usernameFeild.text password:passwordField.text block:^(NSError *error, id object) {
            [self dismissProgress];
            if(error){
                [self showToastWithError:error.localizedDescription];
            }else{
                [AppDelegate putCurrentLogonUser:object];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    }
}

- (BOOL) validateInputFieldValue{
    if([self isStringNilOrEmpty:usernameFeild.text]){
        [self showToastWithError:@"请输入用户名"];
        return NO;
    }
    
    if([self isStringNilOrEmpty:passwordField.text]){
        [self showToastWithError:@"请输入密码"];
        return NO;
    }
    
    return YES;
}
@end
