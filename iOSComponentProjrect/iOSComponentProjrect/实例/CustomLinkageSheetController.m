//
//  CustomLinkageSheetController.m
//  CXLinkageSheetDemo
//
//

#import "CustomLinkageSheetController.h"
#import "WGLinkageSheetView.h"
#import "CarModel.h"
#import <YYModel.h>


#define LightGrayColor  RGBA(242, 241, 239, 1)
#define DarkGrayColor   RGBA(119, 119, 119, 1)

@interface CustomLinkageSheetController ()<WGLinkageSheetViewDataSource>

@property (nonatomic, strong) WGLinkageSheetView *linkageSheetView;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) CarModel *firstCarModel;
@property (nonatomic, strong) GroupParamsModel *firstGroupParamsModel;

@end

@implementation CustomLinkageSheetController

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].copy;
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    
    self.linkageSheetView = [[WGLinkageSheetView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, ScreenWidth, ScreenHeight - SafeAreaTopHeight)];
    _linkageSheetView.dataSource = self;
    _linkageSheetView.sheetHeaderHeight = 60;
    _linkageSheetView.sheetRowHeight = 50;
    _linkageSheetView.sheetLeftTableWidth = ScreenWidth / 4;
    _linkageSheetView.sheetRightTableWidth = ScreenWidth / 4;
    _linkageSheetView.showAllSheetBorder = YES;
    _linkageSheetView.pagingEnabled = YES;
    _linkageSheetView.dataSource = self;
    _linkageSheetView.outLineColor = LightGrayColor;
    _linkageSheetView.outLineWidth = 0.5f;
    _linkageSheetView.innerLineColor = LightGrayColor;
    _linkageSheetView.innerLineWidth = 1.0f;
    [self.view addSubview:_linkageSheetView];
    
}

- (void)loadData {
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"custom_data" ofType:@"json"]];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    self.dataArray = [NSArray yy_modelArrayWithClass:[CarModel class] json:dict[@"data"]].mutableCopy;
    self.firstCarModel = self.dataArray.firstObject;
    self.firstGroupParamsModel = _firstCarModel.groupParamsViewModelList.firstObject;
    
    self.linkageSheetView.rightTableCount = self.dataArray.count;
    [self.linkageSheetView reloadData];    
}

#pragma mark - CXLinkageSheetViewDataSource

#pragma mark - 表格section数目

- (NSInteger)numberOfSectionsInSheetView {
    return self.firstCarModel.groupParamsViewModelList.count;
}

#pragma mark - 自定义表格section头部视图

- (UIView *)viewForSheetViewHeaderInSection:(NSInteger)section {
    UIView *sectionHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    sectionHeader.backgroundColor = LightGrayColor;
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 0, ScreenWidth / 4 - 16, 30)];
    titleLabel.font = [UIFont systemFontOfSize:10];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor blackColor];
    GroupParamsModel *groupParamsModel = self.firstCarModel.groupParamsViewModelList[section];
    titleLabel.text = groupParamsModel.groupName;
    [sectionHeader addSubview:titleLabel];
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - 80, 0, 80, 30)];
    detailLabel.font = [UIFont systemFontOfSize:10];
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.numberOfLines = 0;
    detailLabel.textColor = DarkGrayColor;
    detailLabel.text = @"标配   选配 - 无";
    [sectionHeader addSubview:detailLabel];
    
    return sectionHeader;
}

#pragma mark - 表格section头部视图高度

- (CGFloat)heightForSheetViewHeaderInSection:(NSInteger)section {
    return 30;
}

#pragma mark - 表格每一个section的行数

- (NSInteger)numberOfRowsInSheetViewSection:(NSInteger)section {
    GroupParamsModel *groupParamsModel = self.firstCarModel.groupParamsViewModelList[section];
    
    return groupParamsModel.paramList.count;
}

#pragma mark - 自定义表格左侧标题视图

- (UIView *)createLeftItemWithContentView:(UIView *)contentView indexPath:(NSIndexPath *)indexPath {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, contentView.bounds.size.width - 20, contentView.bounds.size.height)];
  
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    label.textColor = DarkGrayColor;
    
    GroupParamsModel *groupParamsModel = self.firstCarModel.groupParamsViewModelList[indexPath.section];
    ParamlistModel *paramlistModel = groupParamsModel.paramList[indexPath.row];
    label.text = paramlistModel.paramName;
    
    return label;
}

#pragma mark - 自定义表格右侧每一个格子的视图

- (UIView *)createRightItemWithContentView:(UIView *)contentView indexPath:(NSIndexPath *)indexPath itemIndex:(NSInteger)itemIndex {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, contentView.bounds.size.width - 20, contentView.bounds.size.height)];
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.textColor = DarkGrayColor;
    
    CarModel *carModel = self.dataArray[itemIndex];
    GroupParamsModel *groupParamsModel = carModel.groupParamsViewModelList[indexPath.section];
    ParamlistModel *paramlistModel = groupParamsModel.paramList[indexPath.row];
    
    label.text = paramlistModel.paramValue;
    
    return label;
}

#pragma mark - 自定义表格左上角视图

- (UIView *)leftTitleView:(UIView *)titleContentView {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleContentView.bounds.size.width, titleContentView.bounds.size.height)];
    label.text = @"配置项";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = DarkGrayColor;
    return label;
}

#pragma mark - 自定义表格右侧标题视图

- (UIView *)rightTitleView:(UIView *)titleContentView index:(NSInteger)index {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, titleContentView.bounds.size.width - 20, titleContentView.bounds.size.height)];
    CarModel *carModel = self.dataArray[index];
    label.text = carModel.specName;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    
    return label;
    
}


@end
