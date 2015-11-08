//
//  LoginViewController.h
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "BaseViewController.h"

@class UserModel;
@interface LoginViewController : BaseViewController<UITextFieldDelegate>

@property (retain, nonatomic) UIImageView *logo;
@property (retain, nonatomic) UITextField *usernameFeild;
@property (retain, nonatomic) UITextField *passwordField;
@property (retain, nonatomic) UIButton *loginButton;
@property (retain, nonatomic) UIButton *registerLabel;

@end
