//
//  MyReceiptItemTableViewCell.m
//  RenAiJianYan
//
//  Created by Sylar on 15/12/5.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "MyReceiptItemTableViewCell.h"
#import "Constants.h"

@implementation MyReceiptItemTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.productPicture = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 60)];
        self.productPicture.layer.masksToBounds = YES;
        self.productPicture.layer.cornerRadius = 5;
        
        self.productName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productPicture.frame) + 10, 10, SCREEN_WIDTH - CGRectGetMaxX(self.productPicture.frame) - 20, 22)];
        self.productName.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
        [self.productName setUserInteractionEnabled:NO];
        self.productName.numberOfLines = 1;
        self.productName.lineBreakMode = NSLineBreakByTruncatingTail;
        
        
        self.buyCount = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 110 ,CGRectGetMaxY(self.productName.frame) + 10, 100, 30)];
        self.buyCount.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_SMALL];
        self.buyCount.textAlignment = NSTextAlignmentRight;
        self.buyCount.textColor = [UIColor grayColor];

        
        self.productPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productPicture.frame) + 10, CGRectGetMaxY(self.productName.frame) + 10,  SCREEN_WIDTH - CGRectGetMaxX(self.productPicture.frame) - 120, 22)];
        self.productPrice.textColor = Hex2UIColor(0xEA9D11);
        
        [self.contentView addSubview:self.productPrice];
        [self.contentView addSubview:self.productName];
        [self.contentView addSubview:self.buyCount];
        [self.contentView addSubview:self.productPicture];
        
    }
    return self;
}

@end
