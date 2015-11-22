//
//  AppointmentViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "SectionModel.h"
#import "CellModel.h"
#import "ReservationViewController.h"
#import "ServiceListViewController.h"
#import "BasicTableViewCell.h"
#import "ServiceListViewController.h"
#import "ServicerServiceListViewController.h"
#import "ServiceModel.h"
#import "ServicerServiceModel.h"
#import "AdminUserModel.h"
#import "AvailableReservationModel.h"
#import "AvailableReservationListViewController.h"
#import "ReservationTypeViewController.h"
#import "ReservationPayDetailsViewController.h"
#import "AppDelegate.h"
#import "UserModel.h"
#import "ReservationManager.h"

@interface ReservationViewController ()
@property (retain, nonatomic) UIView *headerView;
@property (retain, nonatomic) UILabel *textLabel;
@property (retain, nonatomic) UIImageView *imageView;
@property (retain, nonatomic) UIImageView *disclosureIndicator;
@property (retain, nonatomic) UIView *defaultHeaderView;
@property (nonatomic) ReservationType reservationType;
@property (retain, nonatomic) NSString *phoneNumber;
@property (retain, nonatomic) NSString *subType;

@property (retain, nonatomic) AvailableReservationModel *readyForPayReservation;
@end

static NSString *cellIdentifier = @"tableViewCell";
static NSArray *reservationTypeArray;

@implementation ReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    reservationTypeArray = @[@"",@"在线咨询",@"电话咨询"];
    [self initDataSource];
    [self setupHeaderView];
    [self configureTableView];
}

- (void) setupHeaderView
{
    _defaultHeaderView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
    _defaultHeaderView.backgroundColor = [UIColor clearColor];
    
    _headerView = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 42)];
    _headerView.backgroundColor = [UIColor yellowColor];
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, CGRectGetWidth(self.view.frame) - 20, 22)];
    _textLabel.font = [UIFont systemFontOfSize:14];
    _textLabel.textColor = [UIColor redColor];
    _textLabel.text = @"您有一个未支付预约";
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 20, 20)];
    _imageView.image = [UIImage imageNamed:@"ExclamationIcon"];
    _disclosureIndicator = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) - 40, 11, 20, 20)];
//    _disclosureIndicator.image = [UIImage imageNamed:@"MeIcon"];
    [_headerView addSubview:_textLabel];
    [_headerView addSubview:_imageView];
    [_headerView addSubview:_disclosureIndicator];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewHeaderOnClick:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [_headerView addGestureRecognizer:tapGestureRecognizer];
}

- (void) tableViewHeaderOnClick:(id) sender
{
    if(_readyForPayReservation){
        ReservationPayDetailsViewController *payVC = [self.storyboard instantiateViewControllerWithIdentifier:@"reservationPayDetails"];
        payVC.reservationModel = _readyForPayReservation;
        [self showViewController:payVC sender:nil];
    }
}

- (void) showPayDetails:(AvailableReservationModel *)reservation
{
    
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavigationBarTitle:@"预约"];
//    [self showNavigationRightButton:@"预约纪录" selector:@selector(showReservationHistory)];
    UserModel *currentLogonUser = [AppDelegate getCurrentLogonUser];
    if(!currentLogonUser || !currentLogonUser.userId){
        return;
    }
    [[ReservationManager manager] checkReservationForPay:currentLogonUser.userId block:^(NSError *error, id object) {
        if(!error){
            _readyForPayReservation = object;
            self.tableView.tableHeaderView = _headerView;
        }else{
            self.tableView.tableHeaderView = _defaultHeaderView;
        }
    }];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self hiddenNavigationRightButton];
}

- (void) showReservationHistory
{
    [self performSegueWithIdentifier:@"showResvervationHistory" sender:nil];
}

- (void) initDataSource{
    CellModel *s0r0 = [CellModel makeCellWith:@"项目名称" image:@"SelectServiceIcon" selector:@"selectService:"];
    CellModel *s1r0 = [CellModel makeCellWith:@"选择专家" image:@"SelectServicerIcon" selector:@"selectServicer:"];
    CellModel *s1r1 = [CellModel makeCellWith:@"选择时间" image:@"SelectReservationIcon" selector:@"selectDate:"];
    CellModel *s2r0 = [CellModel makeCellWith:@"咨询方式" image:@"ReservationTypeIcon" selector:@"setContactInfo:"];
    
    SectionModel *s0 = [SectionModel initWithTitle:nil cells:@[s0r0]];
    SectionModel *s1 = [SectionModel initWithTitle:nil cells:@[s1r0,s1r1]];
    SectionModel *s2 = [SectionModel initWithTitle:nil cells:@[s2r0]];
    _data = [NSMutableArray arrayWithArray:@[s0,s1,s2]];
}

- (void) resetData:(NSIndexPath *)indexPath{
    CellModel *s1r0 = [CellModel makeCellWith:@"选择专家" image:@"SelectServicerIcon" selector:@"selectServicer:"];
    CellModel *s1r1 = [CellModel makeCellWith:@"选择时间" image:@"SelectReservationIcon" selector:@"selectDate:"];
    CellModel *s2r0 = [CellModel makeCellWith:@"咨询方式" image:@"ReservationTypeIcon" selector:@"setContactInfo:"];
    
    SectionModel *s1 = [SectionModel initWithTitle:nil cells:@[s1r0,s1r1]];
    SectionModel *s2 = [SectionModel initWithTitle:nil cells:@[s2r0]];
    if(indexPath.section == 0){
        [_data replaceObjectAtIndex:1 withObject:s1];
        [_data replaceObjectAtIndex:2 withObject:s2];
        self.selectedExpert = nil;
        self.selectedReservation = nil;
        self.reservationType = ReservationTypeNone;
        self.phoneNumber = nil;
    }else if(indexPath.section == 1){
        if(indexPath.row == 0){
            SectionModel *sectionModel = [_data objectAtIndex:indexPath.section];
            NSMutableArray *_array = [NSMutableArray arrayWithArray:sectionModel.cells];
            [_array replaceObjectAtIndex:1 withObject:s1r1];
            sectionModel.cells = _array;
            self.selectedReservation = nil;
        }
        [_data replaceObjectAtIndex:2 withObject:s2];
        self.reservationType = ReservationTypeNone;
        self.phoneNumber = nil;
    }
}

- (void) configureTableView{
    _tableView.tableHeaderView = _defaultHeaderView;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
}

- (void) selectService:(id) sender{
    [self performSegueWithIdentifier:@"selectService" sender:sender];
}

- (void) selectServicer:(id) sender{
    if(!self.selectedService){
        [self showToastWithError:@"请先选择项目"];
        return;
    }
    [self performSegueWithIdentifier:@"showServiceExpert" sender:sender];
}

- (void) selectDate:(id) sender{
    if(!self.selectedService){
        [self showToastWithError:@"请先选择项目"];
        return;
    }
    
    if(!self.selectedExpert){
        [self showToastWithError:@"请先选择专家"];
        return;
    }
    
    [self performSegueWithIdentifier:@"showReservation" sender:sender];
}

- (void) setContactInfo:(id) sender{
    if(!self.selectedReservation){
        [self showToastWithError:@"请先选择预约时间"];
        return;
    }
    
    [self performSegueWithIdentifier:@"showReservationType" sender:sender];
}

- (IBAction)makeAnAppointment:(id)sender {
    if(!self.selectedService){
        [self showToastWithError:@"请选择项目"];
        return;
    }
    
    if(!self.selectedExpert){
        [self showToastWithError:@"请先选择专家"];
        return;
    }
    
    if(!self.selectedReservation){
        [self showToastWithError:@"请先选择预约时间"];
        return;
    }
    
    if(self.reservationType == ReservationTypeNone){
        [self showToastWithError:@"请选择咨询方式"];
        return;
    }
    
    NSString *method = nil;
    NSString *info = nil;
    if(self.reservationType == ReservationTypeApp){
        method = @"A";
        info = @"图文聊天系统";
    }else if(self.reservationType == ReservationTypePhone){
        method = @"P";
        info = self.phoneNumber;
    }
    
    [self showProgress:nil];
    [[ReservationManager manager] reserveWithUserId:[AppDelegate getCurrentLogonUser].userId reservationId:self.selectedReservation.reservationId info:info method:method block:^(NSError *error, id object) {
        [self dismissProgress];
        if(!error){
            [self initDataSource];
            [self.tableView reloadData];
            ReservationPayDetailsViewController *payVC = [self.storyboard instantiateViewControllerWithIdentifier:@"reservationPayDetails"];
            payVC.reservationModel = object;
            [self showViewController:payVC sender:nil];
        }else{
            [self showToastWithError:error.localizedDescription];
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _data.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SectionModel *sectionModel = _data[section];
    return sectionModel.cells.count;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[BasicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    SectionModel *sectionModel = _data[indexPath.section];
    CellModel *cellModel = sectionModel.cells[indexPath.row];
    cell.title.text = cellModel.title;
    cell.image.image = [UIImage imageNamed:cellModel.image];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SectionModel *sectionModel = _data[indexPath.section];
    CellModel *cellModel = sectionModel.cells[indexPath.row];
    SEL selector = NSSelectorFromString(cellModel.selectorName);
    if([self respondsToSelector:selector]){
        IMP imp = [self methodForSelector:selector];
        void (*func)(id, SEL,id) = (void *)imp;
        func(self, selector,indexPath);
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"selectService"]){
        ServiceListViewController * controller = [segue destinationViewController];
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        SectionModel *sectionModel = _data[indexPath.section];
        CellModel *cellModel = sectionModel.cells[indexPath.row];
        controller.callback = ^(ServiceModel *selectedModel,NSString *subType){
            cellModel.title = selectedModel.name;
            if(self.selectedService.serviceId.intValue != selectedModel.serviceId.intValue || ![subType isEqualToString:self.subType]){
                [self resetData:indexPath];
            }
            self.selectedService = selectedModel;
            self.subType = subType;
            [self.tableView reloadData];
        };
    }else if([[segue identifier] isEqualToString:@"showServiceExpert"]){
        ServicerServiceListViewController *controller = [segue destinationViewController];
        NSIndexPath *indexPath = (NSIndexPath *) sender;
        SectionModel *sectionModel = _data[indexPath.section];
        CellModel *cellModel = sectionModel.cells[indexPath.row];
        controller.selectedService = self.selectedService;
        controller.subType = self.subType;
        controller.callback = ^(ServicerServiceModel *servicerServiceModel){
            cellModel.title = servicerServiceModel.adminUser.name;
            if(self.selectedExpert.serviceExpertId.intValue != servicerServiceModel.serviceExpertId.intValue){
                [self resetData:indexPath];
            }
            self.selectedExpert = servicerServiceModel;
            [self.tableView reloadData];
        };
    }else if([[segue identifier] isEqualToString:@"showReservation"]){
        AvailableReservationListViewController *controller = [segue destinationViewController];
        NSIndexPath *indexPath = (NSIndexPath *) sender;
        SectionModel *sectionModel = _data[indexPath.section];
        CellModel *cellModel = sectionModel.cells[indexPath.row];
        controller.selectedService = self.selectedService;
        controller.selectedServiceExpertModel = self.selectedExpert;
        controller.callback = ^(AvailableReservationModel *availableReservation,NSString *selectrdDateLabel){
            cellModel.title = [NSString stringWithFormat:@"%@ %@%@",availableReservation.reservationDesc,selectrdDateLabel,availableReservation.startLabel];
            if(self.selectedReservation.reservationId.intValue != availableReservation.reservationId.intValue){                            [self resetData:indexPath];
            }
            self.selectedReservation = availableReservation;
            [self.tableView reloadData];
        };
    }else if ([[segue identifier] isEqualToString:@"showReservationType"]){
        ReservationTypeViewController *controller = [segue destinationViewController];
        NSIndexPath *indexPath = (NSIndexPath *) sender;
        SectionModel *sectionModel = _data[indexPath.section];
        CellModel *cellModel = sectionModel.cells[indexPath.row];
        controller.reservationModel = self.selectedReservation;
        controller.callback = ^(NSString *mobile,ReservationType reservationType){
            self.reservationType = reservationType;
            self.phoneNumber = mobile;
            cellModel.title = reservationTypeArray[reservationType];
            [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
    }
}

@end
