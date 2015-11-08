//
//  MeTableViewCell.m
//  RenAiJianYan
//
//  Created by Sylar on 8/30/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "BasicTableViewCell.h"
#import "Constants.h"

@implementation BasicTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 24, 24)];
        _badge = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 12, 20, 20)];
        _badge.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_SMALL];
        _badge.backgroundColor = [UIColor redColor];
        _badge.layer.cornerRadius = 10;
        _badge.layer.masksToBounds = YES;
        _badge.textAlignment = NSTextAlignmentCenter;
        _badge.textColor = [UIColor whiteColor];
        _badge.hidden = YES;
        _title = [[UILabel alloc] initWithFrame:CGRectMake(_image.frame.origin.x +_image.frame.size.width + 15, 11, SCREEN_WIDTH - 104 - _badge.frame.size.width, 22)];
        _title.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_LARGE];
        [self.contentView addSubview:_image];
        [self.contentView addSubview:_badge];
        [self.contentView addSubview:_title];
    }
    return self;
}
@end
