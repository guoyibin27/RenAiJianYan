//
//  ReceiptAddressTableViewCell.m
//  RenAiJianYan
//
//  Created by Sylar on 15/11/22.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "ReceiptAddressTableViewCell.h"
#import "Constants.h"

@implementation ReceiptAddressTableViewCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:  reuseIdentifier];
    if(self){
        _contact = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH / 3, 22)];
        _contact.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
        
        _tel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_contact.frame), 10, 2 * SCREEN_WIDTH / 3 - 30, 22)];
        _tel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
        _tel.textAlignment = NSTextAlignmentLeft;
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_contact.frame) + 10, SCREEN_WIDTH - 30, 22)];
        _addressLabel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_SMALL];
        _addressLabel.textColor = [UIColor grayColor];
        _addressLabel.numberOfLines = 1;
        
        [self.contentView addSubview:_contact];
        [self.contentView addSubview:_tel];
        [self.contentView addSubview:_addressLabel];
    }
    return self;
}

@end
