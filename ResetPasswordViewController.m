//
//  ModifyPasswordViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 9/19/15.
//  Copyright © 2015 Gyb. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "UserManager.h"
#import "AppDelegate.h"
#import "UserModel.h"

@interface ResetPasswordViewController ()

@property (retain, nonatomic) UITextField *oldPasswordField;
@property (retain, nonatomic) UITextField *passwordField;
@property (retain, nonatomic) UITextField *rePasswordField;
@property (retain, nonatomic) UIButton *confirmButton;

@end

@implementation ResetPasswordViewController


-(void)loadView{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.oldPasswordField = [[UITextField alloc] initWithFrame:CGRectMake(10, 84, CGRectGetWidth(self.view.frame) - 20, 45)];
    self.oldPasswordField.placeholder = @"旧密码";
    self.oldPasswordField.secureTextEntry = YES;
    self.oldPasswordField.borderStyle = UITextBorderStyleRoundedRect;
    
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.oldPasswordField.frame) + 20, CGRectGetWidth(self.view.frame) - 20, 45)];
    self.passwordField.placeholder = @"新密码";
    self.passwordField.secureTextEntry = YES;
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    
    self.rePasswordField = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.passwordField.frame) + 20, CGRectGetWidth(self.view.frame) - 20, 45)];
    self.rePasswordField.placeholder = @"确认密码";
    self.rePasswordField.secureTextEntry = YES;
    self.rePasswordField.borderStyle = UITextBorderStyleRoundedRect;
    
    self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.rePasswordField.frame) + 30, CGRectGetWidth(self.view.frame) - 20 , 45)];
    self.confirmButton.layer.cornerRadius = 4;
    self.confirmButton.layer.masksToBounds = YES;
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmButton setBackgroundColor:Hex2UIColor(0x2987EA)];
    [self.confirmButton addTarget:self action:@selector(modifyPassword) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.oldPasswordField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.rePasswordField];
    [self.view addSubview:self.confirmButton];
}

-(void)modifyPassword{
    if([self isStringNilOrEmpty:self.oldPasswordField.text]){
        [self showToastWithError:@"旧密码不能为空"];
        return;
    }
    
    if([self isStringNilOrEmpty:self.passwordField.text]){
        [self showToastWithError:@"新密码不能为空"];
        return;
    }
    
    if([self isStringNilOrEmpty:self.rePasswordField.text]){
        [self showToastWithError:@"确认密码不能为空"];
        return;
    }
    
    if(![self.rePasswordField.text isEqualToString:self.passwordField.text]){
        [self showToastWithError:@"新密码和确认密码不一致"];
        self.rePasswordField.text = @"";
        self.passwordField.text = @"";
        return;
    }
    
    [self showProgress:nil];
    [[UserManager manager] resetPasswordWithUserId:[AppDelegate getCurrentLogonUser].userId oldPassword:self.oldPasswordField.text newPassword:self.passwordField.text block:^(NSError *error, id object) {
        [self dismissProgress];
        if(error){
            [self showToastWithError:error.localizedDescription];
        }else{
            [self showToastWithError:object];
            self.oldPasswordField.text = @"";
            self.passwordField.text = @"";
            self.rePasswordField.text = @"";
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dismissKeyboard:self.view];
}

@end
