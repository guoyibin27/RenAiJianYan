//
//  RegisterViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "RegisterViewController.h"
#import "UserModel.h"
#import "AppDelegate.h"
#import "UserManager.h"

@interface RegisterViewController ()
@property (retain, nonatomic) NSTimer *timer;
@property (assign ,nonatomic) int timerInterval;
@end

@implementation RegisterViewController

-(void)setupViews{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.phone = [[UITextField alloc] initWithFrame:CGRectMake(10, 74, CGRectGetWidth(self.view.frame) - 20, 44)];
    self.phone.placeholder = @"手机号码";
    self.phone.borderStyle = UITextBorderStyleRoundedRect;
    self.phone.keyboardType = UIKeyboardTypePhonePad;
    
    self.fetchVerifyCodeButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.frame) - 120 + 10, CGRectGetMaxY(self.phone.frame) + 10, 100, 44)];
    [self.fetchVerifyCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.fetchVerifyCodeButton setBackgroundColor:Hex2UIColor(0x2987EA)];
    self.fetchVerifyCodeButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.fetchVerifyCodeButton.layer.masksToBounds = YES;
    self.fetchVerifyCodeButton.layer.cornerRadius = 5;
    [self.fetchVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.fetchVerifyCodeButton addTarget:self action:@selector(getVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    
    self.verifyCodeField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.phone.frame) + 10, CGRectGetWidth(self.view.frame) - CGRectGetWidth(self.fetchVerifyCodeButton.frame) - 24, 44)];
    self.verifyCodeField.placeholder = @"验证码";
    self.verifyCodeField.borderStyle = UITextBorderStyleRoundedRect;
    self.verifyCodeField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.username = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.verifyCodeField.frame) + 10, CGRectGetWidth(self.view.frame) - 20, 44)];
    self.username.borderStyle = UITextBorderStyleRoundedRect;
    self.username.placeholder = @"用户名";
    
    self.password = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.username.frame) + 10, CGRectGetWidth(self.view.frame) - 20, 44)];
    self.password.placeholder = @"密码";
    self.password.borderStyle = UITextBorderStyleRoundedRect;
    self.password.secureTextEntry = YES;
    
    self.registerButton = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.password.frame) + 20, CGRectGetWidth(self.view.frame) - 20, 44)];
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    self.registerButton.backgroundColor = Hex2UIColor(0x2987EA);
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.layer.cornerRadius = 5;
    [self.registerButton addTarget:self action:@selector(registerCustomer) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.phone];
    [self.view addSubview:self.fetchVerifyCodeButton];
    [self.view addSubview:self.verifyCodeField];
    [self.view addSubview:self.username];
    [self.view addSubview:self.password];
    [self.view addSubview:self.registerButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self dismissKeyboard:self.view];
}

- (void)getVerifyCode {
    if([self isStringNilOrEmpty:self.phone.text]){
        [self showMessage:@"请输入手机号码"];
        return;
    }
    [self showProgress:nil];
    self.fetchVerifyCodeButton.enabled = NO;
    self.fetchVerifyCodeButton.backgroundColor = [UIColor lightGrayColor];
    [[UserManager manager] fetchVerifyCodeWithPhone:self.phone.text block:^(NSError *error, id object) {                [self dismissProgress];
        if(error){
            [self showMessage:error.localizedDescription];
            self.fetchVerifyCodeButton.enabled = YES;
            [self.fetchVerifyCodeButton setBackgroundColor:Hex2UIColor(0x2987EA)];
        }else{
            [self showMessage:object];
            _timerInterval = 60;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        }
    }];
}

- (void)countDown{
    [self.fetchVerifyCodeButton setTitle:[NSString stringWithFormat:@"获取验证码(%d)",_timerInterval] forState:UIControlStateNormal];
    if(_timerInterval == 0){
        [self.fetchVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.fetchVerifyCodeButton setBackgroundColor:Hex2UIColor(0x2987EA)];
        self.fetchVerifyCodeButton.enabled = YES;
        [self.timer invalidate];
    }
    _timerInterval --;
}

- (void)registerCustomer {
    if([self validate]){
        [self showProgress:nil];
        [[UserManager manager] validateVerifyCodeWithPhone:self.phone.text code:self.verifyCodeField.text block:^(NSError *error, id object) {
            if(error){
                [self dismissProgress];
                [self showMessage:error.localizedDescription];
            }else{
                UserModel *user = [[UserModel alloc] init];
                user.userName = self.username.text;
                user.password = self.password.text;
                user.phone = self.phone.text;
                [[UserManager manager] registerUser:user block:^(NSError *error, id object) {
                    [self dismissProgress];
                    if(error){
                        [self showMessage:error.localizedDescription];
                    }else{
                        [AppDelegate putCurrentLogonUser:object];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                }];
            }
        }];
    }
}

- (BOOL) validate{
    if([self isStringNilOrEmpty:self.phone.text]){
        [self showMessage:@"请输入手机号码"];
        return NO;
    }
    
    if([self isStringNilOrEmpty:self.verifyCodeField.text]){
        [self showMessage:@"请输入验证码"];
        return NO;
    }
    
    if([self isStringNilOrEmpty:self.username.text]){
        [self showMessage:@"请输入用户名"];
        return NO;
    }
    
    if([self isStringNilOrEmpty:self.password.text]){
        [self showMessage:@"请输入密码"];
        return NO;
    }
    
    return YES;
}
@end
