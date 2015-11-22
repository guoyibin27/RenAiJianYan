//
//  AddressTableViewCell.m
//  RenAiJianYan
//
//  Created by Sylar on 15/11/21.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "Constants.h"

@implementation AddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:  reuseIdentifier];
    if(self){
        _contact = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH / 3, 22)];
        _contact.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_LARGE];
        
        _tel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_contact.frame), 10, 2 * SCREEN_WIDTH / 3 - 30, 22)];
        _tel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_LARGE];
        _tel.textAlignment = NSTextAlignmentLeft;
        
        _address = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_contact.frame) + 10, SCREEN_WIDTH - 30, 22)];
        _address.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
        _address.textColor = [UIColor grayColor];
        _address.numberOfLines = 1;
        
        [self.contentView addSubview:_contact];
        [self.contentView addSubview:_tel];
        [self.contentView addSubview:_address];
    }
    return self;
}
@end
