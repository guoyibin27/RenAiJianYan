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
        
        self.desc = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.segmentedContrl.frame) + 20,SCREEN_WIDTH - 20, 22)];
        self.desc.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
        self.desc.scrollEnabled = NO;
        
        [self.contentView addSubview:self.segmentedContrl];
        [self.contentView addSubview:self.desc];
    }
    return self;
}

-(void)setProductData:(ProductModel *)product{
    self.product = product;
//    self.desc.text = [self filterHTML:_product.statement];
    [self setDescLabel:[self filterHTML:product.statement]];
}

-(NSString *)filterHTML:(NSString *)html  {
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {  //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];  //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        NSString *divTag = [NSString stringWithFormat:@"%@>",text];
        if([divTag isEqualToString:@"</div>"]){
            html = [html stringByReplacingOccurrencesOfString:divTag withString:@"\r"];
        }else{
            html = [html stringByReplacingOccurrencesOfString:divTag withString:@""];
        }
    }
    return html;
}  

- (void) setDescLabel:(NSString *)string{
    self.desc.text = string;
    float height = [self heightForString:string fontSize:DEFAULT_FONT_SIZE_MIDDLE andWidth:CGRectGetWidth(self.desc.frame)];
    self.desc.frame = CGRectMake(self.desc.frame.origin.x, self.desc.frame.origin.y, CGRectGetWidth(self.desc.frame), height);
}

- (float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize]
                         constrainedToSize:CGSizeMake(width -16.0, CGFLOAT_MAX)
                             lineBreakMode:NSLineBreakByWordWrapping];
    return sizeToFit.height + 16.0;
}

-(float) cacluateCellHeight{
    NSLog(@"%f",self.segmentedContrl.frame.size.height);
    NSLog(@"%f",self.desc.frame.size.height);
    return self.segmentedContrl.frame.size.height + self.desc.frame.size.height + 40;
}

-(void)onSegmentValueChanged:(UISegmentedControl *)segmentedCtrl{
    switch (segmentedCtrl.selectedSegmentIndex) {
        case 0:{
            [self setDescLabel:[self filterHTML:_product.statement]];
        }
            break;
        case 1:
        {
            [self setDescLabel:[self filterHTML:_product.instruction]];
        }
            break;
    }
}
@end
