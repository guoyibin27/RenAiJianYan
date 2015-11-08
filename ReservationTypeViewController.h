//
//  ReservationTypeViewController.h
//  RenAiJianYan
//
//  Created by Sylar on 8/24/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "BaseViewController.h"

@class AvailableReservationModel;
typedef void(^SelectReservationTypeCallback)(NSString *mobile, ReservationType reservationType);

@interface ReservationTypeViewController : BaseViewController<UITextFieldDelegate>

@property (copy, nonatomic) SelectReservationTypeCallback callback;
@property (retain, nonatomic) AvailableReservationModel *reservationModel;
@property (weak, nonatomic) IBOutlet UIView *contactView;
@property (weak, nonatomic) IBOutlet UIView *appConsulting;
@property (weak, nonatomic) IBOutlet UIView *phoneConsulting;
@property (weak, nonatomic) IBOutlet UIImageView *phoneConsultingIcon;
@property (weak, nonatomic) IBOutlet UIImageView *appConsultingIcon;
@property (weak, nonatomic) IBOutlet UITextField *telephoneField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *appHeightConstraint;

@end
