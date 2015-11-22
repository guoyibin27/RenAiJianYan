//
//  ReservationTypeViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 8/24/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ReservationTypeViewController.h"
#import "Constants.h"
#import "AvailableReservationModel.h"

@interface ReservationTypeViewController ()
@property (nonatomic) int reservationType;

@end

@implementation ReservationTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _reservationType = ReservationTypeNone;
    
    [_phoneConsultingIcon setHidden:YES];
    [_appConsultingIcon setHidden:YES];
    [_contactView setHidden:YES];
    
    _appConsulting.hidden = YES;
    _phoneConsulting.hidden = YES;
    
    BOOL hasAllowedApp = NO;
    if(![self isStringNilOrEmpty:self.reservationModel.allowedMethods]){
        NSArray *methods = [self.reservationModel.allowedMethods componentsSeparatedByString:@"|"];
        if([methods containsObject:@"A"]){
            _appConsulting.hidden = NO;
            hasAllowedApp = YES;
        }
        if([methods containsObject:@"P"]){
            _phoneConsulting.hidden = NO;
            if(!hasAllowedApp){
                self.appHeightConstraint.constant = 0.0f;
            }
        }
    }
    UITapGestureRecognizer *appConsultingViewClick = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(selectedApp)];

    UITapGestureRecognizer *phoneConsultingViewClick = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                             action:@selector(selectedPhone)];
    [_appConsulting addGestureRecognizer:appConsultingViewClick];
    [_phoneConsulting addGestureRecognizer:phoneConsultingViewClick];
    
    [self showNavigationRightButton:@"完成" selector:@selector(finished)];
    
    _telephoneField.delegate = self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location >= 11)
        return NO;
    return YES;
}

- (BOOL) isMobile:(NSString *)telephone{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9]|7[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:telephone];
}

- (void) finished{
    if ( _reservationType == ReservationTypeNone){
        [self showToastWithError:@"请选择咨询方式"];
        return;
    }
    
    if (_reservationType == ReservationTypePhone) {
        if([self isStringNilOrEmpty:_telephoneField.text]){
            [self showToastWithError:@"请输入联系电话"];
            return;
        }
        
        if(![self isMobile:_telephoneField.text]){
            [self showToastWithError:@"电话号码格式不正确"];
            return;
        }
    }
    
    if (_callback) {
        _callback(_telephoneField.text,_reservationType);
    }
    [[self navigationController ] popViewControllerAnimated:YES];
}

- (void) selectedApp{
    [self setReservationType:ReservationTypeApp];
}

- (void) selectedPhone{
    [self setReservationType:ReservationTypePhone];
}

- (void) setReservationType:(int)reservationType{
    _reservationType = reservationType;
    switch (_reservationType) {
        case ReservationTypePhone:
            [_phoneConsultingIcon setHidden:NO];
            [_appConsultingIcon setHidden:YES];
            [_contactView setHidden:NO];
            break;
        case ReservationTypeApp:
            [_phoneConsultingIcon setHidden:YES];
            [_appConsultingIcon setHidden:NO];
            [_contactView setHidden:YES];
            break;
    }
}

@end
