//
//  SelectProductViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 8/21/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ServiceTableViewCell.h"
#import "ServiceListViewController.h"
#import "ServiceModel.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"
#import "ReservationManager.h"

@interface ServiceListViewController ()
@property (retain, nonatomic) NSString *subType;
@end

@implementation ServiceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView];
    self.subType = @"M";
    self.servicesArray = [[NSMutableArray alloc] init];
    
    [self showNavigationRightButton:@"完成" selector:@selector(finishSelected)];
    
    [self showProgress:nil];
    [[ReservationManager manager] fetchServicesWithBlock:^(NSError *error, NSMutableArray *array) {
        [self dismissProgress];
        if(error){
            [self showToastWithError:error.localizedDescription];
        }else{
            self.servicesArray = array;
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

- (void) finishSelected{
    if (!self.serviceModel) {
        [self showToastWithError:@"请选择咨询项目"];
    }else{
        if(_callback){
            _callback(self.serviceModel,self.subType);
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.servicesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ServiceModel *model = self.servicesArray[indexPath.row];
    cell.name.text = model.name;
    cell.descriptionLabel.text = model.serviceDescription;
    cell.priceLabel.text = [NSString stringWithFormat:@"%@ ~ %@",model.priceLevel1,model.priceLevel5];
    cell.expertNumber.text = [NSString stringWithFormat:@"%u (位)",(unsigned int)model.services.count];
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",IMAGE_SERVER_HOST,model.image];
    [cell.icon sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"PhotoNotAvailable"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.serviceModel = self.servicesArray[indexPath.row];
}

- (IBAction)onSegmentValueChanged:(id)sender {
    UISegmentedControl *ctrl = sender;
    
    if(ctrl.selectedSegmentIndex == 0){
        self.subType = @"M";
    }else{
        self.subType = @"T";
    }
    [self.tableView reloadData];
}
@end
