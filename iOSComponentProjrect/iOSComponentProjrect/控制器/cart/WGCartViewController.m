//
//  WGCartViewController.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGCartViewController.h"
#import "Config.h"
#import "CellModel.h"
#import "SectionModel.h"
#import "HeaderView.h"
#import "TableViewCell.h"

#import "FingerprintViewController.h"
#import "DeviceMotionViewController.h"
#import "AccelerometerViewController.h"
#import "DistanceSensorViewController.h"
#import "LightSensitiveViewController.h"
#import "CompassViewController.h"
#import "GyroscopeViewController.h"

@interface WGCartViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) NSMutableArray * dataSource;

@property (nonatomic, strong) NSArray * classArray;

@property (nonatomic, strong) NSArray * titleArray;

@end

@implementation WGCartViewController

#pragma mark --- 懒加载

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;

    _titleArray = @[@"指纹识别", @"运动传感器 - 图片旋转", @"加速计 物理学 - 滚动小球", @"距离传感器 - 扬声器/听筒切换", @"环境光感 - 利用摄像头捕捉光感参数", @"磁力计 - 仿系统的指南针", @"陀螺仪"];
    
    _classArray = @[[FingerprintViewController class], [DeviceMotionViewController class], [AccelerometerViewController class], [DistanceSensorViewController class], [LightSensitiveViewController class], [CompassViewController class], [GyroscopeViewController class]];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self.view addSubview:self.tableView];
    
    /**
     Invalid parameter not satisfying: !stayUp || CLClientIsBackgroundable(internal->fClient)解决方法
     配置.plist文件 :
     <!--开启Background Modes中的Location updates-->
     
     <key>UIBackgroundModes</key>
     <array>
     <string>location</string>
     </array>
     
     */
}



#pragma mark -- UITableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SectionModel *sectionModel = [self dataSource][section];
    return sectionModel.isExpanded ? sectionModel.cellModels.count : 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"id";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.cellModel = [[self dataSource][indexPath.section] cellModels][indexPath.row];
    return cell;
    
}
/**
 *  返回headerView
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *idenfifer = @"id";
    HeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:idenfifer];
    if (header == nil) {
        header = [[HeaderView alloc] initWithReuseIdentifier:idenfifer];
    }
    header.sectionModel = [self dataSource][section];
    header.expandCallBack = ^(BOOL isExpanded) {
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    };
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        id  class = (UIViewController *)_classArray[indexPath.row];
        UIViewController * vc = [[class alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:NO];
        self.hidesBottomBarWhenPushed = NO;
    }
    if (indexPath.section == 1) {
        
    }
    
}

#pragma mark -- Getter

-(UITableView *)tableView{
    
    if (_tableView == nil) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
    
}

// 初始化数据
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
        
        for (NSInteger i = 0; i < 2; i ++) {
            SectionModel *sectionModel = [[SectionModel alloc] init];
            sectionModel.isExpanded = NO;
            if (i==0) {
                sectionModel.sectionTitle = [NSString stringWithFormat:@"传感器"];
                NSMutableArray *cellModels = [NSMutableArray array];
                for (NSInteger j = 0; j < self.titleArray.count; j ++) {
                    CellModel *cellModel = [[CellModel alloc] init];
                    cellModel.cellTitle = [NSString stringWithFormat:@"%ld----%@",j,self.titleArray[j]];
                    [cellModels addObject:cellModel];
                }
                sectionModel.cellModels = cellModels;
                [self.dataSource addObject:sectionModel];
            }
            if (i==1) {
                sectionModel.sectionTitle = [NSString stringWithFormat:@"其他"];
                NSMutableArray *cellModels = [NSMutableArray array];
                for (NSInteger j = 0; j < self.titleArray.count; j ++) {
                    CellModel *cellModel = [[CellModel alloc] init];
                    cellModel.cellTitle = [NSString stringWithFormat:@"第%ld行",j+1];
                    [cellModels addObject:cellModel];
                }
                sectionModel.cellModels = cellModels;
                [self.dataSource addObject:sectionModel];
            }
        }
    }
    return _dataSource;
}

@end
