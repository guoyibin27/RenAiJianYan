//
//  CreateAddressViewController.h
//  RenAiJianYan
//
//  Created by Sylar on 15/11/21.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^CreateAddressCallback)(BOOL needReloadData);
@interface CreateAddressViewController : BaseViewController

@property (copy,nonatomic) CreateAddressCallback callback;
@end
