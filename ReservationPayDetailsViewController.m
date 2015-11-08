//
//  ReservationPayDetailsViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 9/10/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ReservationPayDetailsViewController.h"
#import "SectionModel.h"
#import "PayDetailsOrderInfoCellModel.h"
#import "PayDetailsPaymentMethodCellModel.h"
#import "CellModel.h"
#import "AvailableReservationModel.h"
#import "UserModel.h"
#import "AppDelegate.h"
#import "WxPayData.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "Constants.h"
#import "ReservationPayResultErrorViewController.h"
#import "ReservationPayResultSuccessViewController.h"

@interface ReservationPayDetailsViewController () <UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) NSMutableArray *data;
@property (retain, nonatomic) PayDetailsPaymentMethodCellModel *selectedCell;
@end

@implementation ReservationPayDetailsViewController

- (void)initDataSource {
    PayDetailsOrderInfoCellModel *s1r1 = [PayDetailsOrderInfoCellModel initWithLabel:@"支付项目:" value:self.reservationModel.reservationDesc selector:nil];
    PayDetailsOrderInfoCellModel *s1r2 = [PayDetailsOrderInfoCellModel initWithLabel:@"订单金额:" value:[NSString stringWithFormat:@"%@",self.reservationModel.amount] selector:nil];
    
    PayDetailsPaymentMethodCellModel *s2r1 = [PayDetailsPaymentMethodCellModel initWithTitle:@"微信支付" subTitle:@"推荐安装微信5.0及以上版本" method:PaymentMethodWeChatPay icon:@"WeChatPay" isChecked:YES];
    _selectedCell = s2r1;
    
    CellModel *s3r1 = [CellModel makeCellWith:@"确认支付" image:nil selector:@"performPay"];
    
    SectionModel *s1 = [SectionModel initWithTitle:nil cells:@[s1r1,s1r2]];
    SectionModel *s2 = [SectionModel initWithTitle:nil cells:@[s2r1]];
    SectionModel *s3 = [SectionModel initWithTitle:nil cells:@[s3r1]];
    
    _data = [NSMutableArray arrayWithArray:@[s1,s2,s3]];
}

- (void)setupViews {
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStyleGrouped];
    
    [self.view addSubview:self.tableView];
}

- (void)configureTableView {
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
    titleView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = titleView;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
}

- (void)viewDidLoad {
    [self initDataSource];
    [self setupViews];
    [self configureTableView];
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxpayResponseHandler:) name:kNotificationWxPayResponse object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationWxPayResponse object:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SectionModel *sectionModel = _data[section];
    return sectionModel.cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 2){
        return 20;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 2){
        return 20;
    }
    if(section ==0){
        return 0;
    }
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *orderInfoCell = @"orderInfoCell";
    static NSString *paymentCell = @"paymentCell";
    static NSString *actionCell = @"actionCell";
    UITableViewCell *cell = nil;
    
    if(indexPath.section == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:orderInfoCell];
        SectionModel *sectionModel = _data[indexPath.section];
        PayDetailsOrderInfoCellModel *model = sectionModel.cells[indexPath.row];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:orderInfoCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = model.labelText;
        cell.detailTextLabel.text = model.valueText;
    }
    
    if(indexPath.section == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:paymentCell];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:paymentCell];
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unchecked"]];
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        }
        SectionModel *s = _data[indexPath.section];
        PayDetailsPaymentMethodCellModel *m = s.cells[indexPath.row];
        cell.textLabel.text = m.title;
        cell.detailTextLabel.text = m.subTitle;
        cell.imageView.image = [UIImage imageNamed:m.icon];
        cell.textLabel.font = [UIFont systemFontOfSize:DEFAULT_FONT_SIZE_MIDDLE];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        if(m.isChecked){
            ((UIImageView *)cell.accessoryView).image = [UIImage imageNamed:@"checked"];
        }else{
            ((UIImageView *)cell.accessoryView).image = [UIImage imageNamed:@"unchecked"];
        }
    }
    
    if(indexPath.section == 2){
        cell = [tableView dequeueReusableCellWithIdentifier:actionCell];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:actionCell];
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        }
        SectionModel *s = _data[indexPath.section];
        CellModel *m = s.cells[indexPath.row];
        cell.textLabel.text = m.title;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 1){
        SectionModel *s = _data[indexPath.section];
        for(int i =0;i< s.cells.count ;i++){
            PayDetailsPaymentMethodCellModel *m = s.cells[i];
            if(i == indexPath.row){
                _selectedCell = m;
                m.isChecked = YES;
            }else{
                m.isChecked = NO;
            }
        }
        [tableView reloadData];
    }
    if(indexPath.section == 2){
        SectionModel *sectionModel = _data[indexPath.section];
        CellModel *cellModel = sectionModel.cells[indexPath.row];
        SEL selector = NSSelectorFromString(cellModel.selectorName);
        if([self respondsToSelector:selector]){
            IMP imp = [self methodForSelector:selector];
            void (*func)(id, SEL) = (void *)imp;
            func(self, selector);
        }
    }
}

-(void)performPay{
    if(![WXApi isWXAppInstalled]){
        [self showMessage:@"请安装微信客户端"];
        return;
    }
    
    if(![WXApi isWXAppSupportApi]){
        [self showMessage:@"微信版本太低，建议升级微信"];
        return;
    }
    [self showProgress:nil];
    [WxPayData unifiedOrderWithUserId:[AppDelegate getCurrentLogonUser].userId block:^(WxPayData *wxpayData) {
        [self dismissProgress];
        if(wxpayData){
            PayReq *req = [[PayReq alloc] init];
            req.openID = wxpayData.appId;
            req.partnerId = wxpayData.partnerId;
            req.nonceStr = wxpayData.nonceStr;
            req.prepayId = wxpayData.prepayId;
            req.package = wxpayData.package;
            req.sign= wxpayData.sign;
            req.timeStamp = wxpayData.timeStamp.intValue;
            [WXApi sendReq:req];
        }else{
            [self showMessage:@"微信支付失败，请稍后重试"];
        }
    }];
}

- (void)wxpayResponseHandler:(id)sender{
    BaseResp *resposne = [[sender userInfo] objectForKey:@"WxPayResp"];
    switch (resposne.errCode) {
        case WXSuccess:
            [self queryTradeState];
            break;
        case WXErrCodeUserCancel:
            [self showMessage:@"支付取消"];
            break;
        default:
            break;
    }
}

- (void)queryTradeState{
    [self showProgress:nil];
    [WxPayData queryPayStateWithReservationId:self.reservationModel.reservationId block:^(BOOL success) {
        [self dismissProgress];
        if(success){
            ReservationPayResultSuccessViewController *successVC = [[ReservationPayResultSuccessViewController alloc] init];
            [self showViewController:successVC sender:nil];
        }else {
            ReservationPayResultErrorViewController *errorVC = [[ReservationPayResultErrorViewController alloc] init];
            errorVC.reservationModel = self.reservationModel;
            [self showViewController:errorVC sender:nil];
        }
    }];
}
@end
