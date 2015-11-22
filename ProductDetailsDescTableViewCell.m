//
//  ProductDetalisDescTableViewCell.m
//  RenAiJianYan
//
//  Created by Sylar on 15/11/17.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "ProductDetailsDescTableViewCell.h"
#import "Constants.h"
#import "ProductModel.h"

@interface ProductDetailsDescTableViewCell()
@property (retain, nonatomic) ProductModel *product;
@end

@implementation ProductDetailsDescTableViewCell


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
        self.segmentedContrl = [[UISegmentedControl alloc] initWithItems:@[@"产品介绍",@"使用说明"]];
        self.segmentedContrl.frame = CGRectMake(30, 10, SCREEN_WIDTH - 60, 40);
        self.segmentedContrl.selectedSegmentIndex = 0;
        [self.segmentedContrl addTarget:self action:@selector(onSegmentValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        self.desc = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.segmentedContrl.frame) + 20,SCREEN_WIDTH - 20, 22)];
        self.desc.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
        
        [self.contentView addSubview:self.segmentedContrl];
        [self.contentView addSubview:self.desc];
    }
    return self;
}

-(void)setProductData:(ProductModel *)product{
    self.product = product;
    self.desc.text = self.product.instruction;
}

-(void)onSegmentValueChanged:(UISegmentedControl *)segmentedCtrl{
    switch (segmentedCtrl.selectedSegmentIndex) {
        case 0:
            self.desc.text = self.product.instruction;
            break;
        case 1:
            self.desc.text = self.product.statement;
            break;
    }
}
@end
