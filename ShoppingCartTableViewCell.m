//
//  ShoppingCartTableViewCell.m
//  RenAiJianYan
//
//  Created by Sylar on 15/11/18.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"
#import "Constants.h"

@implementation ShoppingCartTableViewCell
@synthesize productName,productPicture,productPrice,checkedImage,addButton,subButton,totalCount;

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if(selected){
        checkedImage.image = [UIImage imageNamed:@"checked"];
    }else{
        checkedImage.image = [UIImage imageNamed:@"check_normal"];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        checkedImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40, 20, 20)];
        checkedImage.image = [UIImage imageNamed:@"check_normal"];
        
        productPicture = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(checkedImage.frame) + 10, 10, 100, 80)];
        productPicture.layer.cornerRadius = 5;
        productPicture.layer.masksToBounds = YES;
        
        productName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(productPicture.frame) + 10, 20, SCREEN_WIDTH - CGRectGetMaxX(productPicture.frame) - 20, 22)];
        productName.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
        
        productPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(productPicture.frame) + 10, CGRectGetMaxY(productName.frame) + 14, SCREEN_WIDTH- CGRectGetMaxX(productPicture.frame) - 110, 22)];
        productPrice.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_SMALL];
        productPrice.textColor = Hex2UIColor(0xEA9D11);
        
        addButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 50, CGRectGetMaxY(productName.frame) + 20, 30, 30)];
        [addButton setTitle:@" + " forState:UIControlStateNormal];
        addButton.layer.borderWidth = 1;
        addButton.titleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_SMALL];
        addButton.layer.borderColor = [UIColor grayColor].CGColor;
        [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:addButton.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight    cornerRadii:CGSizeMake(4, 4)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = addButton.bounds;
        maskLayer.path = maskPath.CGPath;
        addButton.layer.mask = maskLayer;
        
        totalCount = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, CGRectGetMaxY(productName.frame) + 20, 40, 30)];
        totalCount.layer.borderWidth = 1;
        totalCount.textAlignment = NSTextAlignmentCenter;
        totalCount.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_SMALL];
        totalCount.layer.borderColor = [UIColor grayColor].CGColor;
        totalCount.enabled = NO;
    
        subButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 120, CGRectGetMaxY(productName.frame) + 20, 30, 30)];
        [subButton setTitle:@" - " forState:UIControlStateNormal];
        subButton.titleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_SMALL];
        [subButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        subButton.layer.borderWidth = 1;
        subButton.layer.borderColor = [UIColor grayColor].CGColor;
        UIBezierPath *submaskPath = [UIBezierPath bezierPathWithRoundedRect:addButton.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft    cornerRadii:CGSizeMake(4, 4)];
        CAShapeLayer *submaskLayer = [[CAShapeLayer alloc] init];
        submaskLayer.frame = addButton.bounds;
        submaskLayer.path = submaskPath.CGPath;
        subButton.layer.mask = submaskLayer;
        
        [self.contentView addSubview:self.checkedImage];
        [self.contentView addSubview:self.productPicture];
        [self.contentView addSubview:self.productName];
        [self.contentView addSubview:self.productPrice];
        [self.contentView addSubview:self.addButton];
        [self.contentView addSubview:self.totalCount];
        [self.contentView addSubview:self.subButton];
    }
    return self;
}

@end
