//
//  ExaminationResultReportViewController.m
//  RenAiJianYan
//
//  Created by Sylar on 8/27/15.
//  Copyright (c) 2015 Gyb. All rights reserved.
//

#import "ExaminationResultReportViewController.h"
#import "ExaminationReportModel.h"
#import "AppDelegate.h"
#import "ReportHeaderTableViewCell.h"
#import "ReportItemTableViewCell.h"
#import "ReportFooterTableViewCell.h"
#import "ReportDescriptionTableViewCell.h"
#import "ProgressHUD/ProgressHUD.h"
#import "ExaminationReportManager.h"
#import "UserModel.h"

NSString *const ReportTableHeader = @"ReportTableHeader";
NSString *const ReportTableItem = @"ReportTableItem";
NSString *const ReportTableFooter = @"ReportTableFooter";
NSString *const ReportTableDescription = @"ReportTableDescription";

@interface ReportBaseModel : NSObject

@end

@implementation ReportBaseModel

@end

@interface ReportHeaderModel : ReportBaseModel

@property (retain, nonatomic) NSString *reportName;
@property (retain, nonatomic) NSString *reportDate;
@property (retain, nonatomic) NSString *libraryName;
@property (retain, nonatomic) NSString *examinationNumber;
@property (retain, nonatomic) NSString *specimenType;
@property (retain, nonatomic) NSString *examinationMethod;
@property (retain, nonatomic) NSString *receiveMethod;

+ (ReportHeaderModel *) makeHeader:(NSString *) reportName
                              date:(NSString *) reportDate
                       libraryName:(NSString *) libraryName
                 examinationNumber:(NSString *) number
                      specimenType:(NSString *) specimenType
                 examinationMethod:(NSString *) examMethod
                     recevieMethod:(NSString *) receiveMethod;
@end

@implementation ReportHeaderModel

+ (ReportHeaderModel *) makeHeader:(NSString *) reportName
                              date:(NSString *) reportDate
                       libraryName:(NSString *) libraryName
                 examinationNumber:(NSString *) number
                      specimenType:(NSString *) specimenType
                 examinationMethod:(NSString *) examMethod
                     recevieMethod:(NSString *) receiveMethod{
    ReportHeaderModel *m = [[ReportHeaderModel alloc] init];
    m.reportName = reportName;
    m.reportDate = reportDate;
    m.libraryName = libraryName;
    m.examinationNumber = number;
    m.specimenType = specimenType;
    m.examinationMethod = examMethod;
    m.receiveMethod = receiveMethod;
    return m;
}
@end


@interface ReportFooterModel : ReportBaseModel

@property (retain, nonatomic) NSString *tester;
@property (retain, nonatomic) NSString *reviewer;
@property (retain, nonatomic) NSString *receiveDate;
@property (retain, nonatomic) NSString *testDate;
@property (retain, nonatomic) NSString *comment;

+ (ReportFooterModel *) makeFooter:(NSString *) tester reviewer:(NSString *) reviewer receiveDate:(NSString *) receiveDate testDate:(NSString *) testDate comment:(NSString *) comment;
@end

@implementation ReportFooterModel
+ (ReportFooterModel *) makeFooter:(NSString *) tester reviewer:(NSString *) reviewer receiveDate:(NSString *) receiveDate testDate:(NSString *) testDate comment:(NSString *) comment{
    ReportFooterModel *m = [[ReportFooterModel alloc] init];
    m.tester = tester;
    m.testDate = testDate;
    m.receiveDate = receiveDate;
    m.reviewer = reviewer;
    m.comment = comment;
    return m;
}
@end

@interface ReportItemModel : ReportBaseModel

@property (retain, nonatomic) NSString *itemName;
@property (retain, nonatomic) NSString *itemResult;
@property (retain, nonatomic) NSString *itemBase;

+ (ReportItemModel *) makeItem:(NSString *) resultKey resultValue:(NSString *)value;
+ (ReportItemModel *) makeTitleItem;

@end

@implementation ReportItemModel

+ (ReportItemModel *) makeItem:(NSString *) resultKey resultValue:(NSString *)value{
    ReportItemModel *model = [[ReportItemModel alloc] init];
    NSArray *array = [AppDelegate getReportItemResult:resultKey];
    if(array){
        model.itemName = array[0];
        model.itemBase = array[1];
        model.itemResult = value;
    }
    return model;
}

+ (ReportItemModel *) makeTitleItem{
    ReportItemModel *model = [[ReportItemModel alloc] init];
    model.itemName = @"项目";
    model.itemBase = @"检验结果";
    model.itemResult = @"参考范围";
    return model;
}

@end


@implementation ExaminationResultReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureTableView];
    

    if(!_showCollectButton){
        _collectContainer.hidden = !_showCollectButton;
        float newTableViewHeight = SCREEN_HEIGHT - 64;
        [_tableView setFrame:CGRectMake(_tableView.frame.origin.x
                                        , _tableView.frame.origin.y, _tableView.frame.size.width, newTableViewHeight)];
        _collectContainerViewHeightConstrant.constant = 0.0f;
    }

    
    ReportHeaderModel *headerModel = [ReportHeaderModel makeHeader:self.resultReport.reportName date:self.resultReport.reportDate libraryName:self.resultReport.libraryName examinationNumber:self.resultReport.examinationNumber specimenType:self.resultReport.specimenType examinationMethod:self.resultReport.examinationMethod recevieMethod:self.resultReport.receiveMethod];
    
    ReportFooterModel *footerModel = [ReportFooterModel makeFooter:self.resultReport.tester reviewer:self.resultReport.reviewer receiveDate:[NSString stringWithFormat:@"%@年%@月%@日", self.resultReport.receiveYear,self.resultReport.receiveMonth,self.resultReport.receiveDay] testDate:[NSString stringWithFormat:@"%@年%@月%@日", self.resultReport.testYear,self.resultReport.testMonth,self.resultReport.testDate] comment:self.resultReport.comment];
    
    NSMutableArray *itemModelArray = [[NSMutableArray alloc] init];
    ReportItemModel *titleItem = [ReportItemModel makeTitleItem];
    [itemModelArray addObject:titleItem];
    
    [self addItem:itemModelArray result:self.resultReport.methodResult1 key:@"method_1_result"];
    [self addItem:itemModelArray result:self.resultReport.methodResult2 key:@"method_2_result"];
    [self addItem:itemModelArray result:self.resultReport.methodResult3 key:@"method_3_result"];
    [self addItem:itemModelArray result:self.resultReport.methodResult4 key:@"method_4_result"];
    [self addItem:itemModelArray result:self.resultReport.methodResult5 key:@"method_5_result"];
    
    self.dataSourceDict = @[headerModel,itemModelArray,footerModel,[[ReportBaseModel alloc] init]];
}

- (void) configureTableView{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
    titleView.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = titleView;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource = self;
}

- (void) addItem:(NSMutableArray *) array result:(NSString *)result key:(NSString *)key{
    if(![self isStringNilOrEmpty:result]){
        ReportItemModel *item = [ReportItemModel makeItem:key resultValue:result];
        [array addObject:item];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSourceDict.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id sec = self.dataSourceDict[section];
    if([sec isKindOfClass:[ReportBaseModel class]]){
        return 1;
    }else if([sec isKindOfClass:[NSArray class]]){
        NSArray *array = (NSArray *) sec;
        return array.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id sec = self.dataSourceDict[indexPath.section];
    if([sec isKindOfClass:[ReportHeaderModel class]]){
        ReportHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
        ReportHeaderModel *header = (ReportHeaderModel *) sec;
        cell.reportNameLabel.text = header.reportName;
        cell.reprtDateLabel.text = header.reportDate;
        cell.libraryNameLabel.text = header.libraryName;
        cell.examinationMethodLabel.text = header.examinationMethod;
        cell.receiveMethodLabel.text = header.receiveMethod;
        _reportCommentSize = cell.bounds.size;
        return cell;
    }else if([sec isKindOfClass:[NSArray class]]){
        NSArray *array = (NSArray *) sec;
        ReportItemModel *item = array[indexPath.row];
        ReportItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell"];
        cell.itemNameLabel.text = item.itemName;
        cell.itemResultLabel.text = item.itemResult;
        cell.itemBaseLabel.text = item.itemBase;
        return cell;
    }else if([sec isKindOfClass:[ReportFooterModel class]]){
        ReportFooterModel *f = (ReportFooterModel *) sec;
        ReportFooterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"footerCell"];
        cell.testerLabel.text = f.tester;
        cell.reviewerLabel.text = f.reviewer;
        cell.receiveDateLabel.text = f.receiveDate;
        cell.testDateLabel.text = f.testDate;
        cell.commentLabel.text = f.comment;
        _reportCommentSize = [self sizeWithString:f.comment font:cell.commentLabel.font];
        return cell;
    } else {
        ReportDescriptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"descriptionCell"];
        return cell;
    }
}

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(340, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id sec = self.dataSourceDict[indexPath.section];
    if([sec isKindOfClass:[ReportHeaderModel class]]){
        return 253;
    }else if([sec isKindOfClass:[NSArray class]]){
        return 45;
    }else if([sec isKindOfClass:[ReportFooterModel class]]){
        return 128 + _reportCommentSize.height ;
    } else {
        return 175;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)collectReport:(id)sender {
    [[ExaminationReportManager manager] collectExaminationReportWithUserId:[AppDelegate getCurrentLogonUser].userId reportId:self.resultReport.reportId reportNumber:self.resultReport.examinationNumber block:^(NSError *error, id object) {
        if(error){
            [self showMessage:error.localizedDescription];
        }else{
            UIButton *button = (UIButton *)sender;
            button.enabled = NO;
            [button setBackgroundColor:[UIColor grayColor]];
        }
    }];
}
@end
