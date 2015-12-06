//
//  BaseViewController.h
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface BaseViewController : UIViewController

- (void) setNavigationBarTitle:(NSString *)title;
- (BOOL) isStringNilOrEmpty:(NSString *)str;
- (void) showMessage:(NSString *) message;

//设置导航右按钮
- (void) showNavigationRightButton:(NSString *) buttonText selector:(SEL) selector;

- (void) hiddenNavigationRightButton;

//隐藏输入键盘
- (void) dismissKeyboard:(UIView *) view;

- (void) showProgress:(NSString *) message;

- (void) dismissProgress;

- (void) forwardToUnavailableController;

- (void) showToast:(NSString *) message;

- (void) showToastWithError:(NSString *) message;
@end
