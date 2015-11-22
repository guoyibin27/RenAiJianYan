//
//  ForgotPasswordViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "UserModel.h"
#import "UserManager.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void) setupViews{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.phoneField = [[UITextField alloc] initWithFrame:CGRectMake(10, 74, CGRectGetWidth(self.view.frame) - 20, 44)];
    self.phoneField.placeholder = @"手机号码";
    self.phoneField.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneField.keyboardType = UIKeyboardTypePhonePad;
    
    self.usernameField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.phoneField.frame) + 10, CGRectGetWidth(self.view.frame) - 20, 44)];
    self.usernameField.borderStyle = UITextBorderStyleRoundedRect;
    self.usernameField.placeholder = @"用户名";
    
    self.sendPasswordButton = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.usernameField.frame) + 20, CGRectGetWidth(self.view.frame) - 20, 44)];
    [self.sendPasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sendPasswordButton setTitle:@"发送密码到手机(免费)" forState:UIControlStateNormal];
    self.sendPasswordButton.backgroundColor = Hex2UIColor(0x2987EA);
    self.sendPasswordButton.layer.masksToBounds = YES;
    self.sendPasswordButton.layer.cornerRadius = 5;
    [self.sendPasswordButton addTarget:self action:@selector(sendPassword) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.usernameField];
    [self.view addSubview:self.sendPasswordButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self dismissKeyboard:self.view];
}

- (void)sendPassword{
    if([self validate]){
        [self showProgress:nil];
        [[UserManager manager] findPasswordWithUserName:self.usernameField.text phone:self.phoneField.text block:^(NSError *error, id object) {
            [self dismissProgress];
            if(error){
                [self showToastWithError:error.localizedDescription];
            }else{
                [self showToastWithError:object];
            }
        }];
    }
}

- (BOOL) validate{
    if([self isStringNilOrEmpty:self.phoneField.text]){
        [self showToastWithError:@"请输入手机号码"];
        return NO;
    }
    
    if([self isStringNilOrEmpty:self.usernameField.text]){
        [self showToastWithError:@"请输入用户名"];
        return NO;
    }
    
    return YES;
}

@end
