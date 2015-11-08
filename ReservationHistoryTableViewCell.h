//
//  ReservationHistoryTableViewCell.h
//  RenAiJianYan
//
//  Created by Sylar on 9/8/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReservationHistoryTableViewCell : UITableViewCell

@property (retain, nonatomic) UILabel *reservationName;

@property (retain, nonatomic) UILabel *amount;

@property (retain, nonatomic) UILabel *reserveDate;

@property (retain, nonatomic) UILabel *reserveType;

@property (retain, nonatomic) UILabel *reserveBy;

@property (retain, nonatomic) UILabel *reservationStatus;

@property (retain, nonatomic) UIImageView *line;

@property (retain, nonatomic) UIImageView *entryRoom;

@end
