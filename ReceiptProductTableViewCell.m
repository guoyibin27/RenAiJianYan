//
//  ReceiptProductTableViewCell.m
//  RenAiJianYan
//
//  Created by Sylar on 15/11/22.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "ReceiptProductTableViewCell.h"
#import "Constants.h"

@implementation ReceiptProductTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        _productPicture = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 78, 78)];
        
        _productName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_productPicture.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(_productPicture.frame) - 60, 22)];
        _productName.numberOfLines = 1;
        _productName.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];

        _buyCount = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_productPicture.frame) + 10, CGRectGetMaxY(_productName.frame) + 6, 200, 22)];
        _buyCount.numberOfLines = 1;
        _buyCount.textColor = [UIColor grayColor];
        _buyCount.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_SMALL];
        
        _productPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_productPicture.frame) + 10, CGRectGetMaxY(_buyCount.frame) + 6, 200, 22)];
        _productPrice.numberOfLines = 1;
        _productPrice.textColor = Hex2UIColor(0xEA9D11);
        _productPrice.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_SMALL];
        
        [self.contentView addSubview:_productPicture];
        [self.contentView addSubview:_productName];
        [self.contentView addSubview:_buyCount];
        [self.contentView addSubview:_productPrice];
    }
    return self;
}

@end
