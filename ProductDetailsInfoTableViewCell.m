//
//  ProductDetailsInfoTableViewCell.m
//  RenAiJianYan
//
//  Created by Sylar on 15/11/17.
//  Copyright © 2015年 Gyb. All rights reserved.
//


#import "ProductDetailsInfoTableViewCell.h"
#import "Constants.h"

@implementation ProductDetailsInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.primaryPicture = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 80)];
        self.primaryPicture.layer.masksToBounds = YES;
        self.primaryPicture.layer.cornerRadius = 4;
        self.primaryPicture.userInteractionEnabled = YES;
        
        self.productName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.primaryPicture.frame) + 10, 10,SCREEN_WIDTH - CGRectGetWidth(self.primaryPicture.frame) - 20 , 22)];
        self.productName.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
        
        self.supplierName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.primaryPicture.frame) + 10, CGRectGetMaxY(self.productName.frame) + 10, SCREEN_WIDTH - CGRectGetWidth(self.primaryPicture.frame) - 20 , 22)];
        self.supplierName.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_SMALL];
        
        self.productDesc = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.primaryPicture.frame) + 10, CGRectGetMaxY(self.supplierName.frame) , SCREEN_WIDTH - CGRectGetWidth(self.primaryPicture.frame) - 20, 22)];
        self.productDesc.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_SMALL];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.productDesc.frame) + 10, SCREEN_WIDTH - 20, 1)];
        line.backgroundColor = Hex2UIColor(0xe6e6e6);
        
        self.productPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(line.frame) + 10, SCREEN_WIDTH / 2, 30)];
        self.productPrice.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
        self.productPrice.textColor = Hex2UIColor(0xEA9D11);
        self.productPrice.textAlignment = NSTextAlignmentLeft;
        
        self.productStorage = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productPrice.frame) + 10 , CGRectGetMaxY(line.frame) + 10, SCREEN_WIDTH / 2 - 30, 30)];
        self.productStorage.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_SMALL];
        self.productStorage.textAlignment = NSTextAlignmentRight;
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.productPrice.frame) + 20, SCREEN_WIDTH, 20)];
        line2.backgroundColor = Hex2UIColor(0xe6e6e6);
        
        [self.contentView addSubview:self.primaryPicture];
        [self.contentView addSubview:self.productName];
        [self.contentView addSubview:self.supplierName];
        [self.contentView addSubview:self.productDesc];
        [self.contentView addSubview:line];
        [self.contentView addSubview:self.productPrice];
        [self.contentView addSubview:self.productStorage];
        [self.contentView addSubview:line2];
    }
    return self;
}
@end
