//
//  PicturePreviewViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 15/12/4.
//  Copyright © 2015年 Gyb. All rights reserved.
//

#import "PicturePreviewViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "Constants.h"

NSString *const previewCell = @"previewCell";

@interface PicturePreviewViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (retain, nonatomic) UICollectionView * collection;
@property (retain, nonatomic) UIPageControl *pageCtrl;
@end

@implementation PicturePreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预览";
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:layout];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.backgroundColor = [UIColor blackColor];
    self.collection.alwaysBounceHorizontal = YES;
    self.collection.alwaysBounceVertical = NO;
    self.collection.showsHorizontalScrollIndicator = NO;
    self.collection.showsVerticalScrollIndicator = NO;
    self.collection.pagingEnabled = YES;
    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:previewCell];
    
    _pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 40, CGRectGetWidth(self.view.frame), 20)];
    _pageCtrl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageCtrl.pageIndicatorTintColor = [UIColor grayColor];
    _pageCtrl.hidesForSinglePage = YES;
    if(_prodductPicutre != nil && _prodductPicutre.count > 0){
        _pageCtrl.numberOfPages = _prodductPicutre.count;
    }
    [self.view addSubview:_collection];
    [self.view addSubview:_pageCtrl];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _prodductPicutre != nil ? _prodductPicutre.count:0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:previewCell forIndexPath:indexPath];
    NSString *picUrl = _prodductPicutre[indexPath.row];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_SERVER_HOST,picUrl]] placeholderImage:[UIImage imageNamed:@"PhotoNotAvailable"]];
    [cell addSubview:imageView];
    return cell;
}


@end
