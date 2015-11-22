//
//  ShoppingCartViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 15/11/18.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartManager.h"
#import "ShoppingCartTableViewCell.h"
#import "ProductModel.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "ReceiptDetailViewController.h"

@interface ShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) UILabel *productCountLabel;
@property (retain, nonatomic) UILabel *totalPriceLabel;
@property (retain, nonatomic) UIButton *payButton;
@property (retain, nonatomic) NSMutableArray *datasource;
@property (nonatomic) float totalPrice;
@end

@implementation ShoppingCartViewController

- (void)loadView{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 55) style:UITableViewStylePlain];
    
    self.productCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 44, CGRectGetWidth(self.view.frame) / 3, 44)];
    self.productCountLabel.backgroundColor = [UIColor whiteColor];
    self.productCountLabel.text = @"选择 0 件商品";
    self.productCountLabel.textAlignment = NSTextAlignmentCenter;
    self.productCountLabel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
    self.productCountLabel.textColor = Hex2UIColor(0xEA9D11);
    
    self.totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.productCountLabel.frame), CGRectGetHeight(self.view.frame) - 44, CGRectGetWidth(self.view.frame) / 3, 44)];
    self.totalPriceLabel.backgroundColor = [UIColor whiteColor];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计:¥ %0.2f",self.totalPrice];
    self.totalPriceLabel.textAlignment = NSTextAlignmentCenter;
    self.totalPriceLabel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
    self.totalPriceLabel.textColor = Hex2UIColor(0xEA9D11);
    
    self.payButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.totalPriceLabel.frame), CGRectGetHeight(self.view.frame) - 44, CGRectGetWidth(self.view.frame) / 3, 44)];
    self.payButton.titleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
    [self.payButton setTitle:@"结算" forState:UIControlStateNormal];
    [self.payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.payButton addTarget:self action:@selector(buyNow) forControlEvents:UIControlEventTouchUpInside];
    self.payButton.backgroundColor = Hex2UIColor(0x174C80);
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.totalPriceLabel];
    [self.view addSubview:self.productCountLabel];
    [self.view addSubview:self.payButton];
}

- (void)buyNow{
    NSArray *array = [self.tableView indexPathsForSelectedRows];
    if(array == NULL){
        [self showToastWithError:@"请选择商品"];
        return;
    }
    
    ReceiptDetailViewController *vc = [[ReceiptDetailViewController alloc] init];
    NSMutableArray *productArray = [NSMutableArray array];
    for (NSIndexPath *indexPath in array) {
        [productArray addObject:_datasource[indexPath.row]];
    }
    vc.productArray = productArray;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"购物车"];
    [self configureTableView];
    self.totalPrice = 0.00f;
    self.datasource = [NSMutableArray array];
    [self loadData];
}

- (void)loadData{
    [self.datasource removeAllObjects];
    NSMutableDictionary *dict = [[ShoppingCartManager manager] getShoppingCart];
    [self.datasource addObjectsFromArray:dict.allValues];
    [self.tableView reloadData];
}

- (void) configureTableView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 0)];
    titleView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = titleView;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.allowsMultipleSelection = YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"shoppingCartCell";
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[ShoppingCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ProductModel *p = self.datasource[indexPath.row];
    cell.productPrice.text = [NSString stringWithFormat:@"¥ %@",p.productPrice];
    cell.productName.text = p.productName;
    cell.totalCount.text = [p.buyCount stringValue];
    [cell.productPicture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_SERVER_HOST,p.primaryPicture]] placeholderImage:[UIImage imageNamed:@"PhotoNotAvailable"]];
    [cell.addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.subButton addTarget:self action:@selector(subButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)addButtonClick:(UIButton *)sender{
    ShoppingCartTableViewCell *cell =(ShoppingCartTableViewCell *) sender.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ProductModel *p = self.datasource[indexPath.row];
    [[ShoppingCartManager manager] addToCart:p];
    [self calculateTotalPrice:p type:0 atIndex:indexPath];
}

- (void)subButtonClick:(UIButton *)sender{
    ShoppingCartTableViewCell *cell = (ShoppingCartTableViewCell *) sender.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    ProductModel *p = self.datasource[indexPath.row];
    if(cell.totalCount.text.intValue <= 1){
        return;
    }

    [[ShoppingCartManager manager] subProductCount:p];
    [self calculateTotalPrice:p type:1 atIndex:indexPath];
}

- (void)calculateTotalPrice:(ProductModel *)product type:(int)calculateType atIndex:(NSIndexPath *)indexPath{
    NSArray *array = [self.tableView indexPathsForSelectedRows];
    if([array containsObject:indexPath]){
        if(calculateType == 0){
            self.totalPrice = decimalNumberAddingWithString([NSString stringWithFormat:@"%f",self.totalPrice], product.productPrice.stringValue);
//            self.totalPrice += product.productPrice.floatValue;
        }else{
//            self.totalPrice -= product.productPrice.floatValue;
            self.totalPrice = decimalNumberSubtractingWithString([NSString stringWithFormat:@"%f",self.totalPrice], product.productPrice.stringValue);
        }
        [self setTotalPriceLabelValue];
    }

    [self.datasource removeAllObjects];
    NSMutableDictionary *dict = [[ShoppingCartManager manager] getShoppingCart];
    [self.datasource addObjectsFromArray:dict.allValues];
    ProductModel *p = [self.datasource objectAtIndex:indexPath.row];
    ShoppingCartTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.totalCount.text = p.buyCount.stringValue;
}

- (void)setTotalPriceLabelValue{
    if(self.totalPrice < 0.00f){
        self.totalPrice = 0.00f;
    }
    self.totalPriceLabel.text = [NSString stringWithFormat:@"合计:¥ %0.2f",self.totalPrice];
}

- (void)setProductCountLabelValue{
    NSArray *array = [self.tableView indexPathsForSelectedRows];
    int count = 0;
    if(array != NULL){
        count = (int)array.count;
    }
    self.productCountLabel.text =[NSString stringWithFormat:@"选择 %d 件商品",count] ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductModel *p = self.datasource[indexPath.row];
    self.totalPrice = decimalNumberAddingWithString([NSString stringWithFormat:@"%f",self.totalPrice], decimalNumberMutiplyWithString(p.buyCount.stringValue, p.productPrice.stringValue));
    [self setTotalPriceLabelValue];
    [self setProductCountLabelValue];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductModel *p = self.datasource[indexPath.row];
    self.totalPrice = decimalNumberSubtractingWithString([NSString stringWithFormat:@"%f",self.totalPrice], decimalNumberMutiplyWithString(p.buyCount.stringValue, p.productPrice.stringValue));
    [self setTotalPriceLabelValue];
    [self setProductCountLabelValue];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[ShoppingCartManager manager] deleteProductFromCart:self.datasource[indexPath.row]];
        [self.datasource removeObjectAtIndex:indexPath.row];
        self.totalPrice = 0.00f;
        [self setTotalPriceLabelValue];
        [self setProductCountLabelValue];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//乘
NSString *decimalNumberMutiplyWithString(NSString *multiplierValue,NSString *multiplicandValue){
    NSDecimalNumber *multiplierNumber = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber *multiplicandNumber = [NSDecimalNumber decimalNumberWithString:multiplicandValue];
    NSDecimalNumber *product = [multiplicandNumber decimalNumberByMultiplyingBy:multiplierNumber];
    return [product stringValue];
}


//加
float decimalNumberAddingWithString(NSString *value1,NSString *value2){
    NSDecimalNumber *n1 = [NSDecimalNumber decimalNumberWithString:value1];
    NSDecimalNumber *n2 = [NSDecimalNumber decimalNumberWithString:value2];
    NSDecimalNumber *result = [n1 decimalNumberByAdding:n2];
    return [result floatValue];
}


//减
float decimalNumberSubtractingWithString(NSString *value,NSString *value2){
    NSDecimalNumber *n1 = [NSDecimalNumber decimalNumberWithString:value];
    NSDecimalNumber *n2 = [NSDecimalNumber decimalNumberWithString:value2];
    NSDecimalNumber *result = [n1 decimalNumberBySubtracting:n2];
    return [result floatValue];
}

@end
