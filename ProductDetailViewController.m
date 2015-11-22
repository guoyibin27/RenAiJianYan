//
//  ProductDetailViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 15/11/16.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductManager.h"
#import "ProductModel.h"
#import "ProductDetailsDescTableViewCell.h"
#import "ProductDetailsInfoTableViewCell.h"
#import "ShoppingCartManager.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface ProductDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) UIButton *addToCartButton;
@property (retain, nonatomic) UIButton *buyButton;
@end

@implementation ProductDetailViewController

-(void)loadView{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 54)];
    [self.tableView setSeparatorColor:[UIColor darkGrayColor]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.addToCartButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 45, CGRectGetWidth(self.view.frame) / 2, 44)];
    self.addToCartButton.layer.borderWidth = 1;
    self.addToCartButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.addToCartButton.titleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
    [self.addToCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    [self.addToCartButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.addToCartButton addTarget:self action:@selector(addToShoppingCart) forControlEvents:UIControlEventTouchUpInside];
    
    self.buyButton= [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.addToCartButton.frame), CGRectGetHeight(self.view.frame) - 45, CGRectGetWidth(self.view.frame) / 2, 44)];
    self.buyButton.layer.borderWidth = 1;
    self.buyButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.buyButton.titleLabel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
    [self.buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    [self.buyButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.buyButton addTarget:self action:@selector(buyNow) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addToCartButton];
    [self.view addSubview:self.buyButton];
}

-(void)addToShoppingCart{
    [[ShoppingCartManager manager] addToCart:self.product];
    [self showToast:@"商品已添加到购物车"];
}

-(void)buyNow{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView];
    
    [[ProductManager manager] productDetails:self.product.productId block:^(NSError *error, id object) {
        if(error){
            [self showToastWithError:error.localizedDescription];
        }else{
            self.product = object;
            [self.tableView reloadData];
        }
    }];
}

- (void) configureTableView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 0)];
    titleView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = titleView;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0)
        return 180;
    else return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *productInfoId = @"ProductInfoCell";
    static NSString *productDescId = @"ProductDescCell";
    
    if(indexPath.row == 0){
        ProductDetailsInfoTableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:productInfoId];
        if(!infoCell){
            infoCell = [[ProductDetailsInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productInfoId];
            infoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSString *imgUrl = [NSString stringWithFormat:@"%@%@",IMAGE_SERVER_HOST,self.product.primaryPicture];
        [infoCell.primaryPicture sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"PhotoNotAvailable"]];
        infoCell.productName.text = self.product.productName;
        infoCell.supplierName.text = [NSString stringWithFormat:@"%@ - (%@)",self.product.supplierName,self.product.productNo];
        infoCell.productDesc.text = self.product.productDescription;
        infoCell.productPrice.text = [NSString stringWithFormat:@"¥ %@",self.product.productPrice];
        infoCell.productStorage.text = [NSString stringWithFormat:@"库存量: %@件", [NSNumber numberWithInt:0]];
        return infoCell;
    }else if(indexPath.row == 1){
        ProductDetailsDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:productDescId];
        if(!cell){
            cell = [[ProductDetailsDescTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productDescId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setProductData:self.product];
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
