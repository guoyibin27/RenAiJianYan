//
//  CreateAddressViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 15/11/21.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "CreateAddressViewController.h"
#import "GCPlaceholderTextView.h"
#import "AddressModel.h"
#import "AddressManager.h"
#import "UserModel.h"
#import "AppDelegate.h"

@interface CreateAddressViewController ()<UITextFieldDelegate>
@property(retain,nonatomic) UITextField *contact;
@property(retain,nonatomic) UITextField *tel;
@property(retain,nonatomic) GCPlaceholderTextView *address;
@property(retain,nonatomic) UISwitch *isDefault;
@property(retain,nonatomic) AddressModel *addressModel;

@end

@implementation CreateAddressViewController

-(void)loadView{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    _contact = [[UITextField alloc] initWithFrame:CGRectMake(0, 74, CGRectGetWidth(self.view.frame), 44)];
    _contact.placeholder = @"收件人姓名";
    _contact.backgroundColor = [UIColor whiteColor];
    _contact.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 44)];
    _contact.leftViewMode = UITextFieldViewModeAlways;
    _contact.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_LARGE];
    
    _tel = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_contact.frame) + 1, CGRectGetWidth(self.view.frame), 44)];
    _tel.backgroundColor = [UIColor whiteColor];
    _tel.placeholder = @"手机号码";
    _tel.delegate = self;
    _tel.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 44)];
    _tel.leftViewMode = UITextFieldViewModeAlways;
    _tel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_LARGE];
    _tel.keyboardType = UIKeyboardTypePhonePad;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tel.frame) + 1, CGRectGetWidth(self.view.frame), 44)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 11 , 200, 22)];
    label.text = @"是否为默认地址";
    label.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_LARGE];
    
    _isDefault = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 71, 5, 51, 31)];
    _isDefault.selected = NO;
    [_isDefault addTarget:self action:@selector(onSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [view addSubview:label];
    [view addSubview:_isDefault];
    
    _address = [[GCPlaceholderTextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame) + 1, CGRectGetWidth(self.view.frame), 96)];
    _address.backgroundColor = [UIColor whiteColor];
    _address.placeholder = @"详细地址";
    [_address setTextContainerInset:UIEdgeInsetsMake(10, 20, 10, 20)];
    _address.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_LARGE];

    [self.view addSubview:_contact];
    [self.view addSubview:_tel];
    [self.view addSubview:view];
    [self.view addSubview:_address];
}

- (void)onSwitchValueChanged:(UISwitch *)sender{
    _addressModel.isDefault = sender.selected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _addressModel = [[AddressModel alloc] init];
    [self setNavigationBarTitle:@"添加地址"];
    [self showNavigationRightButton:@"确定" selector:@selector(confirmCreate)];
}

- (void)confirmCreate{
    if([self isStringNilOrEmpty:_contact.text]){
        [self showToastWithError:@"收件人姓名不能为空!"];
        return;
    }
    
    if([self isStringNilOrEmpty:_tel.text]){
        [self showToastWithError:@"手机号码不能为空!"];
        return;
    }
    
    if(![self isMobile:_tel.text]){
        [self showToastWithError:@"电话号码格式不正确"];
        return;
    }
    
    if([self isStringNilOrEmpty:_address.text]){
        [self showToastWithError:@"详细地址不能为空!"];
        return;
    }
    
    _addressModel.userId = [AppDelegate getCurrentLogonUser].userId;
    _addressModel.address = _address.text;
    _addressModel.tel = _tel.text;
    _addressModel.contact = _contact.text;
    
    [[AddressManager manager] addAddress:_addressModel block:^(BOOL success) {
        if(success){
            if(_callback){
                _callback(success);
                [[self navigationController] popViewControllerAnimated:YES];
            }
        }else{
            [self showToastWithError:@"添加地址失败!"];
        }
    }];
}

- (BOOL) isMobile:(NSString *)telephone{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9]|7[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:telephone];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location >= 11)
        return NO;
    return YES;
}

@end
