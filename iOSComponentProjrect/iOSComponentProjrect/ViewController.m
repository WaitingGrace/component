//
//  ViewController.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "ViewController.h"
#import "Config.h"
#import "ChooseView.h"
#import "UIViewController+NavBarHidden.h"
#import "UIViewController+Update.h"
#import "WGScoreViewController.h"
#import "WGScanViewController.h"
#import "WGPasswordVerificationCodeVC.h"
#import "WGTagButtonVC.h"
#import "UITabBar+Badge.h"
#import "WGIdentificationVC.h"
#import "WGMoreImageVC.h"
#import "WGImageCroppingVC.h"
#import "WGSeePhotosVC.h"
#import "WGGuideView.h"
#import "WGAlertViewVC.h"

@interface ViewController ()<WGOutputViewDelegate ,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView * tableView;
@property (nonatomic ,strong) WGOutPutView  * popView;
@property (nonatomic ,strong) NSArray * titleArray;

@end

@implementation ViewController

#pragma mark ---
#pragma mark --- 懒加载
- (WGOutPutView *)popView{
    if (_popView == nil) {
        WGCellModel * model1 = [[WGCellModel alloc]initWithTitle:@"添加体能记录" imageName:nil];
        WGCellModel * model2 = [[WGCellModel alloc]initWithTitle:@"添加健康记录" imageName:nil];
        WGCellModel * model3 = [[WGCellModel alloc]initWithTitle:@"添加此番记录" imageName:nil];
        WGCellModel * model4 = [[WGCellModel alloc]initWithTitle:@"添加成长记录" imageName:nil];
        WGCellModel * model5 = [[WGCellModel alloc]initWithTitle:@"添加用药记录" imageName:nil];
        
        NSArray * popArray = @[model1,model2,model3,model4,model5];
        _popView = [[WGOutPutView alloc]initWithDataArray:popArray origin:CGPointMake(ScreenWidth-12, 50) width:150 height:40 direction:(kWGOutputViewDirectionRight)];
        _popView.delegate = self;
        @WeakObj(self)
        _popView.dismissOperation = ^{
            selfWeak.popView = nil;
        };
    }
    return _popView;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark ---
#pragma mark --- 生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray * images = @[@"123",@"233",@"u=2365",@"u=34521",@"u=34946jpg",@"u=186425"];
    [WGGuideView showGudieView:images];
    
    [self setKeyScrollView:self.tableView scrolOffsetY:60.f options:HYHidenControlOptionTitle];
    [self setInViewWillAppear];//设置导航栏渐变
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x47ae21);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"菜单" style:(UIBarButtonItemStyleDone) target:self action:@selector(outPutView)];
    self.titleArray = @[@"时间选择",@"验证码输入",@"二维码",@"版本更新",@"不规则按钮标签/搜索导航",@"打分",@"身份证扫描",@"多图片选择",@"图片任意裁剪",@"多图浏览/dropview",@"AlertView"];
    NSString * countNum = [NSString stringWithFormat:@"%ld",(long)self.titleArray.count];
    //tabbar badge
    [self.navigationController.tabBarController.tabBar updateBadge:countNum atIndex:1];
    [self.tabBarController.tabBar updateBadge:countNum atIndex:0];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setInViewWillDisappear];
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)outPutView{
    [self.popView pop];
}
#pragma mark ---
#pragma mark --- WGOutputViewDelegate
- (void)didSelectedAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
}


#pragma mark ---
#pragma mark --- UItableView  delegate && dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:nil];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 40.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40.f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            [self chooseDate];
        }
            break;
        case 1:
        {
            WGPasswordVerificationCodeVC * inputVC = [[WGPasswordVerificationCodeVC alloc]init];
            [self toTargetController:(UIViewController *)inputVC];
        }
            break;
        case 2:
        {
            WGScanViewController * qrVc = [[WGScanViewController alloc]init];
            [self toTargetController:(UIViewController *)qrVc];
        }
            break;
        case 3:
        {
            [self getNewVersion];
        }
            break;
        case 4:
        {
            WGTagButtonVC * tagVC = [[WGTagButtonVC alloc]init];
            [self toTargetController:(UIViewController *)tagVC];
        }
            break;
        case 5:
        {
            WGScoreViewController * scoreVC = [[WGScoreViewController alloc]init];
            [self toTargetController:(UIViewController *)scoreVC];
        }
            break;
        case 6:
        {
            WGIdentificationVC * idVC = [[WGIdentificationVC alloc]init];
            [self toTargetController:(UIViewController *)idVC];
        }
            break;
        case 7:
        {
            WGMoreImageVC * moreVC = [[WGMoreImageVC alloc]init];
            [self toTargetController:(UIViewController *)moreVC];
        }
            break;
        case 8:
        {
            WGImageCroppingVC * croppingVC = [[WGImageCroppingVC alloc]init];
            [self toTargetController:(UIViewController *)croppingVC];
        }
            break;
        case 9:
        {
            WGSeePhotosVC * seeVC = [[WGSeePhotosVC alloc]init];
            [self toTargetController:(UIViewController *)seeVC];
        }
            break;
        case 10:
        {
            WGAlertViewVC * alertVC = [[WGAlertViewVC alloc]init];
            [self toTargetController:(UIViewController *)alertVC];
        }
            break;
            
        default:
            break;
    }
}

- (void)toTargetController:(UIViewController *)vc{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark ---
#pragma mark --- Private methods
/**
 时间选择
 */
- (void)chooseDate{
    WGDatePickerView *datepicker = [[WGDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *startDate) {
        NSString * date = [startDate stringWithFormat:@"yyyy-MM-dd"];
        [WGPromptBoxView popUpPromptBoxWithTitle:@"选择的时间" message:date action:@"OK"];
    }];
    datepicker.doneButtonColor = BASEColor;
    datepicker.maxLimitDate = [NSDate date];
    datepicker.currentDate = [NSDate date];
    [datepicker show];
}

- (void)getNewVersion{
    [self detectionOfUpdateVersionWith:NO hint:@"有新版本更新" Version:@"2.0.0"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
