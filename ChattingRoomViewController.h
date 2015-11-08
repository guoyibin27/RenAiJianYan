//
//  ChattingRoomViewController.h
//  RenAiJianYan
//
//  Created by Sylar on 9/2/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "BaseViewController.h"
#import "LeanChatLib.h"

@class AvailableReservationModel;
@interface ChattingRoomViewController : CDChatRoomVC

@property (retain, nonatomic) AvailableReservationModel *currentReservation;

@end
