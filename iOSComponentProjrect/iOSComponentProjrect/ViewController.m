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
#import "WGPageMenuVC.h"
#import "WGWebViewVC.h"
#import "WGScreeningVC.h"
#import "WGFloatWindow.h"
#import "WGVideoPlayerVC.h"

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
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"菜单" style:(UIBarButtonItemStyleDone) target:self action:@selector(outPutView)];
    self.titleArray = @[@"时间选择",@"预约时间",@"验证码输入",@"二维码",@"版本更新",@"不规则按钮标签/搜索导航",@"打分",@"身份证扫描",@"多图片选择",@"图片任意裁剪",@"多图浏览/dropview",@"自定义AlertView",@"PageMenu/brdgeView",@"WKWebView",@"筛选菜单",@"视频播放"];
    
#warning mark -===============tabbar badge==适用于原生tabbar==自定义的会有位移
    NSString * countNum = [NSString stringWithFormat:@"%ld",(long)self.titleArray.count];
//    [self.navigationController.tabBarController.tabBar updateBadge:countNum atIndex:1];
    [self.tabBarController.tabBar updateBadge:countNum atIndex:0];
#warning mark -========= WGFloatWindow 与视频播放器全屏模式冲突，暂未解决
    // 1.add floating button
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [WGFloatWindow wg_addWindowOnTarget:self onClick:^{
//            NSLog(@"Floating button clicked!!!");
//        }];
//    });
/*
     // 2.resize the button after 2 secs
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [WGFloatWindow wg_setWindowSize:100];
     });
 
     // 3.hide or not test
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [XHFloatWindow wg_setHideWindow:YES];
     });
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [WGFloatWindow wg_setHideWindow:NO];
     });
 
     // 4.reset the background image
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [WGFloatWindow wg_setBackgroundImage:@"default_normal" forState:UIControlStateSelected];
         [WGFloatWindow wg_setBackgroundImage:@"default_selected" forState:UIControlStateNormal];
     });
 */
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [WGFloatWindow wg_setHideWindow:YES];
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
            [self makeAppointmentTime];
        }
            break;
        case 2:
        {
            WGPasswordVerificationCodeVC * inputVC = [[WGPasswordVerificationCodeVC alloc]init];
            [self toTargetController:(UIViewController *)inputVC];
        }
            break;
        case 3:
        {
            WGScanViewController * qrVc = [[WGScanViewController alloc]init];
            [self toTargetController:(UIViewController *)qrVc];
        }
            break;
        case 4:
        {
            [self getNewVersion];
        }
            break;
        case 5:
        {
            WGTagButtonVC * tagVC = [[WGTagButtonVC alloc]init];
            [self toTargetController:(UIViewController *)tagVC];
        }
            break;
        case 6:
        {
            WGScoreViewController * scoreVC = [[WGScoreViewController alloc]init];
            [self toTargetController:(UIViewController *)scoreVC];
        }
            break;
        case 7:
        {
            WGIdentificationVC * idVC = [[WGIdentificationVC alloc]init];
            [self toTargetController:(UIViewController *)idVC];
        }
            break;
        case 8:
        {
            WGMoreImageVC * moreVC = [[WGMoreImageVC alloc]init];
            [self toTargetController:(UIViewController *)moreVC];
        }
            break;
        case 9:
        {
            WGImageCroppingVC * croppingVC = [[WGImageCroppingVC alloc]init];
            [self toTargetController:(UIViewController *)croppingVC];
        }
            break;
        case 10:
        {
            WGSeePhotosVC * seeVC = [[WGSeePhotosVC alloc]init];
            [self toTargetController:(UIViewController *)seeVC];
        }
            break;
        case 11:
        {
            WGAlertViewVC * alertVC = [[WGAlertViewVC alloc]init];
            [self toTargetController:(UIViewController *)alertVC];
        }
            break;
        case 12:
        {
            WGPageMenuVC * pageMenuVC = [[WGPageMenuVC alloc]init];
            [self toTargetController:(UIViewController *)pageMenuVC];
        }
            break;
        case 13:
        {
            WGWebViewVC * webVC = [[WGWebViewVC alloc]init];
            [self toTargetController:(UIViewController *)webVC];
        }
            break;
        case 14:
        {
            WGScreeningVC * screeingVC = [[WGScreeningVC alloc]init];
            [self toTargetController:(UIViewController *)screeingVC];
        }
            break;
        case 15:
        {
            WGVideoPlayerVC * playerVC = [[WGVideoPlayerVC alloc]init];
            [self toTargetController:(UIViewController *)playerVC];
        }
            break;
        default:
            break;
    }
}

- (void)toTargetController:(UIViewController *)vc{
    self.hidesBottomBarWhenPushed = YES;
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
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
/**
 时间预约
 */
- (void)makeAppointmentTime{
    WGTimerPicker *picker = [[WGTimerPicker alloc]initWithSuperView:[UIApplication sharedApplication].keyWindow.rootViewController.view WithDays:7 timeInterval:10 BenginTimeDely:30 response:^(NSString *selectedStr) {
        [WGPromptBoxView popUpPromptBoxWithTitle:@"预约的时间" message:selectedStr action:@"OK"];
    }];
    [picker show];
}
/**
 版本更新
 */
- (void)getNewVersion{
    [self detectionOfUpdateVersionWith:NO hint:@"有新版本更新" Version:@"2.0.0"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
