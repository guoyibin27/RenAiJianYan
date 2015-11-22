//
//  AddressListViewController.h
//  RenAiJianYan
//
//  Created by Sylar on 15/11/21.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "BaseViewController.h"
#import "Constants.h"

@class AddressModel;

typedef void(^SelectAddressCallback)(AddressModel *address);
@interface AddressListViewController : BaseViewController

@property (assign, nonatomic) AddressListMode displayMode;
@property (copy, nonatomic) SelectAddressCallback callback;

@end
