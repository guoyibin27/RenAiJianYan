//
//  ChattingRoomViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 9/2/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ChattingRoomViewController.h"
#import "AvailableReservationModel.h"
#import "ReservationManager.h"

@interface ChattingRoomViewController ()

@end

@implementation ChattingRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:self.currentReservation.reservationDesc];
    [self setBackgroundColor:Hex2UIColor(0xf5f5f5)];
    if(self.showInputView){
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"结束咨询" style:UIBarButtonItemStylePlain target:self action:@selector(finishReservation)];
        [self navigationItem].rightBarButtonItem = rightButton;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kickedByOwner) name:kCDNotificationKickedByOwner object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCDNotificationMessageReceived object:nil];
}

- (void) kickedByOwner{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"咨询已经结束" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)finishReservation{
    [[ReservationManager manager] closeReservationWithId:self.currentReservation.reservationId block:^(BOOL success) {
        if(success){
            [[CDChatManager manager] quiteConversation:self.conv block:^(BOOL succeeded, NSError *error) {
                if(error){
                    [self alert:@"结束咨询请求发送失败，请重试!"];
                }else{
                    [[CDChatManager manager] deleteConversation:self.conv];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }else{
            [self alert:@"结束咨询请求发送失败，请重试!"];
        }
    }];
}

- (void)alert:(NSString *)msg {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:nil message:msg delegate:nil
                              cancelButtonTitle   :@"确定" otherButtonTitles:nil];
    [alertView show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
