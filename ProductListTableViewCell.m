//
//  ProductListTableViewCell.m
//  RenAiJianYan
//
//  Created by Sylar on 15/11/15.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "ProductListTableViewCell.h"
#import "Constants.h"

@implementation ProductListTableViewCell

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
        
        
        self.addShoppingCartButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 110 ,CGRectGetMaxY(self.productName.frame) + 10, 100, 30)];
        self.addShoppingCartButton.layer.masksToBounds = YES;
        self.addShoppingCartButton.layer.borderColor = Hex2UIColor(0xEA9D11).CGColor;
        self.addShoppingCartButton.layer.borderWidth = 1;
        self.addShoppingCartButton.layer.cornerRadius = 5;
        self.addShoppingCartButton.titleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
        [self.addShoppingCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        [self.addShoppingCartButton setTitleColor:Hex2UIColor(0xEA9D11) forState:UIControlStateNormal];
        
        self.productPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productPicture.frame) + 10, CGRectGetMaxY(self.productName.frame) + 10,  SCREEN_WIDTH - CGRectGetMaxX(self.productPicture.frame) - 120, 22)];
        self.productPrice.textColor = Hex2UIColor(0xEA9D11);
        
        [self.contentView addSubview:self.productPrice];
        [self.contentView addSubview:self.productName];
        [self.contentView addSubview:self.addShoppingCartButton];
        [self.contentView addSubview:self.productPicture];
        
    }
    return self;
}

@end
