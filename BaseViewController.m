//
//  BaseViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "BaseViewController.h"
#import "ProgressHUD/ProgressHUD.h"
#import "UnavailableViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Hex2UIColor(0xe6e6e6);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setNavigationBarTitle:(NSString *)title{
    UITabBarController *tabBarController = [self tabBarController];
    if(tabBarController){
        [[tabBarController navigationItem] setTitle:title];
    }else{
        [self setTitle:title];
    }
}

- (void) hiddenNavigationRightButton
{
    UITabBarController *tabBarController = [self tabBarController];
    if(tabBarController){
        [[tabBarController navigationItem] setRightBarButtonItem:nil];
    }else{
        [[self navigationItem] setRightBarButtonItem:nil];
    }
}

- (BOOL) isStringNilOrEmpty:(NSString *)str {
    if(nil == str || str.length == 0)
        return YES;
    return NO;
}

- (void) showMessage:(NSString *) message {
    if(self.view.window){
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [view show];
    }
}

- (void) showNavigationRightButton:(NSString *) buttonText selector:(SEL) selector{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:buttonText style:UIBarButtonItemStyleDone target:self action:selector];
    UITabBarController *tabBarController = [self tabBarController];
    if(tabBarController){
        [[tabBarController navigationItem] setRightBarButtonItem:rightButton];
    }else{
        [[self navigationItem] setRightBarButtonItem:rightButton];
    }
}

- (void) dismissKeyboard:(UIView *) view{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [view addGestureRecognizer:tapGestureRecognizer];
}

- (void) keyboardHide:(id)sender{
    UITapGestureRecognizer *recognizer = (UITapGestureRecognizer *)sender;
    [recognizer.view endEditing:YES];
}

- (void) showProgress:(NSString *) message{
    [ProgressHUD show:message Interaction:NO];
}

- (void) dismissProgress{
    [ProgressHUD dismiss];
}

- (void) viewDidDisappear:(BOOL)animated{
    if(self.view.window){
        [ProgressHUD dismiss];
    }
}

- (void) forwardToUnavailableController
{
    UnavailableViewController *unavailableVC = [[UnavailableViewController alloc] init];
    [[self navigationController] showViewController:unavailableVC sender:nil];
}

- (void) showToast:(NSString *) message{
    [ProgressHUD showSuccess:message];
}

- (void) showToastWithError:(NSString *) message{
    [ProgressHUD showError:message];
}
@end
