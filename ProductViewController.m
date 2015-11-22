//
//  ProductViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductManager.h"
#import "ProductModel.h"
#import "UIImageView+WebCache.h"
#import "ProductListTableViewCell.h"
#import "ShoppingCartManager.h"
#import "ProductDetailViewController.h"

@interface ProductViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (retain, nonatomic) UISearchBar *searchBar;
@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) NSMutableArray *dataSource;
@end

@implementation ProductViewController

-(void)loadView{
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _searchBar = [[UISearchBar alloc] initWithFrame:(CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 44))];
    _searchBar.placeholder = @"关键字";
    _searchBar.delegate = self;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_searchBar.frame) + 70, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetHeight(_searchBar.frame) - 114 ) style:UITableViewStylePlain];
    
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
}

- (void) configureTableView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 0)];
    titleView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = titleView;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataSource = [NSMutableArray array];
    [self configureTableView];
    
    [[ProductManager manager] queryProduct:@"" block:^(NSError *error, NSMutableArray *array) {
        if(error){
            [self showToastWithError:error.localizedDescription];
        }else{
            self.dataSource = array;
            [self.tableView reloadData];
        }
    }];
    
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBarTitle:@"商品"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"productListCell";
    ProductListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[ProductListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    ProductModel *pm = self.dataSource[indexPath.row];
    [cell.productPicture sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_SERVER_HOST,pm.primaryPicture]] placeholderImage:[UIImage imageNamed:@"PhotoNotAvailable"]];
    cell.productName.text = pm.productName;
    cell.productPrice.text = [NSString stringWithFormat:@"¥ %@",[pm.productPrice stringValue]];
    [cell.addShoppingCartButton setTag:indexPath.row];
    [cell.addShoppingCartButton addTarget:self action:@selector(addToShoppingCart:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)addToShoppingCart:(UIButton *)sender{
    ProductModel *currentPm = self.dataSource[sender.tag];
    [[ShoppingCartManager manager] addToCart:currentPm];
    [self showToast:@"商品已添加进购物车"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductModel *p = self.dataSource[indexPath.row];
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    vc.product = p;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
