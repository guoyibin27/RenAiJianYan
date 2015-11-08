//
//  RegisterViewController.h
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "BaseViewController.h"

@class UserModel;

@interface RegisterViewController : BaseViewController

@property (retain, nonatomic) UITextField *username;
@property (retain, nonatomic) UITextField *phone;
@property (retain, nonatomic) UITextField *password;
@property (retain, nonatomic) UITextField *verifyCodeField;
@property (retain, nonatomic) UIButton *fetchVerifyCodeButton;
@property (retain, nonatomic) UIButton *registerButton;
@end
