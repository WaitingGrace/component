//
//  ViewController.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "ViewController.h"
#import "Config.h"
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
#import "WGFloatTipsVC.h"
#import "WGTheModalViewController.h"
#import "WGAnimationStarView.h"
#import "WGWaterfallFlowVC.h"
#import "WGOtherViewController.h"
#import "WGSphereMarkVC.h"


@interface ViewController ()<WGOutputViewDelegate ,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic ,strong) UITableView * tableView;
@property (nonatomic ,strong) WGOutPutView  * popView;
@property (nonatomic ,strong) NSArray * titleArray;
@property (nonatomic ,strong) UIButton * flowBtn;

@end

@implementation ViewController

#pragma mark ---
#pragma mark --- 懒加载
- (WGOutPutView *)popView{
    if (_popView == nil) {
        WGCellModel * model1 = [[WGCellModel alloc]initWithTitle:@"体能记录" imageName:@"百度"];
        WGCellModel * model2 = [[WGCellModel alloc]initWithTitle:@"健康记录" imageName:nil];
        WGCellModel * model3 = [[WGCellModel alloc]initWithTitle:@"此番记录" imageName:@"百度"];
        WGCellModel * model4 = [[WGCellModel alloc]initWithTitle:@"成长记录" imageName:nil];
        WGCellModel * model5 = [[WGCellModel alloc]initWithTitle:@"用药记录" imageName:@"百度"];
        
        NSArray * popArray = @[model1,model2,model3,model4,model5];
        _popView = [[WGOutPutView alloc]initWithDataArray:popArray origin:CGPointMake(ScreenWidth-15, NavHeight-5) width:150 height:40 direction:(kWGOutputViewDirectionRight)];
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
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self launchAnimation];
    NSArray * images = @[@"image_1",@"image_2",@"image_3",@"image_4",@"image_5",@"image_6"];
    [WGGuideView showGudieView:images];
    
    
    
    [self.view addSubview:self.tableView];
    UIImage *maskImage = [UIImage imageNamed:@"btn_link_fill"];
    UIImage *lineImage = [UIImage imageNamed:@"btn_link_line"];
    
    WGAnimationStarView *starView = [[WGAnimationStarView alloc] init];
    starView.frame = CGRectMake(0, 0, maskImage.size.width, maskImage.size.height);
    starView.maskImage = maskImage;
    starView.borderImage = lineImage;
    starView.fillColor = [UIColor colorWithRed:0.94 green:0.27 blue:0.32 alpha:1];
    UIBarButtonItem * collectionItem = [[UIBarButtonItem alloc]initWithCustomView:starView];
    
    UIBarButtonItem * rightIKtem = [[UIBarButtonItem alloc]initWithTitle:@"菜单" style:(UIBarButtonItemStyleDone) target:self action:@selector(outPutView)];
    
    self.navigationItem.rightBarButtonItems = @[rightIKtem,collectionItem];
    
    
    self.titleArray = @[@"时间选择",@"预约时间",@"验证码输入",@"二维码",@"版本更新",@"不规则按钮标签/搜索导航",@"打分",@"身份证扫描",@"多图片选择",@"图片任意裁剪",@"多图浏览/dropview",@"自定义AlertView+sheetView",@"PageMenu+brdgeView",@"WKWebView",@"筛选菜单",@"视频播放",@"浮动提示",@"自定义控制器模态动画",@"瀑布流",@"常用支付操作提示",@"球体标签"];
    
#warning mark - tabbar badge==适用于原生tabbar==自定义的会有位移
    NSString * countNum = [NSString stringWithFormat:@"%ld",(long)self.titleArray.count];
//    [self.navigationController.tabBarController.tabBar updateBadge:countNum atIndex:1];
    [self.tabBarController.tabBar updateBadge:countNum atIndex:0];
    
#warning mark - WGFloatWindow 与视频播放器全屏模式冲突，暂未解决
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
    
    [self addFlowWindow];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [WGFloatWindow wg_setHideWindow:YES];
}
#pragma mark ---
#pragma mark --- 启动页动画消失
- (void)launchAnimation {
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateInitialViewController];
    
    UIView *launchView = viewController.view;
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    launchView.frame = [UIApplication sharedApplication].keyWindow.frame;
    [mainWindow addSubview:launchView];
    
    [UIView animateWithDuration:1.0f delay:0.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        launchView.alpha = 0.0f;
        //转换成3d 规模
        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0f, 2.0f, 1.0f);
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
    }];
}

#pragma mark ---
#pragma mark --- 屏幕可拖动按钮
- (void)addFlowWindow{
    UIButton *whiteSpotsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    whiteSpotsButton.frame = CGRectMake(0, 300, 55, 55);
    whiteSpotsButton.backgroundColor = RGBA(51, 51, 51, 0.6);
    whiteSpotsButton.layer.cornerRadius = 27.5;
    [whiteSpotsButton setTitle:@"白点" forState:UIControlStateNormal];
    [whiteSpotsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [whiteSpotsButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.flowBtn = whiteSpotsButton;
    [self.view addSubview:whiteSpotsButton];
    
//    UIButton * dismissBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [whiteSpotsButton addSubview:dismissBtn];
//    dismissBtn.frame = CGRectMake(45, 0, 10, 10);
//    dismissBtn.backgroundColor = [UIColor clearColor];
    //拖动的 UIPanGestureRecognizer
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [self.view bringSubviewToFront:whiteSpotsButton];//放到最前面
    [whiteSpotsButton addGestureRecognizer:panRecognizer];//关键语句，添加一个手势监测；
    panRecognizer.maximumNumberOfTouches = 1;
    panRecognizer.delegate = self;
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
    cell.textLabel.text = [NSString stringWithFormat:@"%@----%@",@(indexPath.row),self.titleArray[indexPath.row]];
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
        case 16:
        {
            WGFloatTipsVC * tipsVC = [[WGFloatTipsVC alloc]init];
            [self toTargetController:(UIViewController *)tipsVC];
        }
            break;
        case 17:
        {
            WGTheModalViewController * modalVC = [[WGTheModalViewController alloc]init];
            [self toTargetController:(UIViewController *)modalVC];
        }
            break;
        case 18:
        {
            WGWaterfallFlowVC * fallFlowVC = [[WGWaterfallFlowVC alloc]init];
            [self toTargetController:(UIViewController *)fallFlowVC];
        }
            break;
        case 19:
        {
            WGOtherViewController * otherVC = [[WGOtherViewController alloc]init];
            [self toTargetController:(UIViewController *)otherVC];
        }
            break;
        case 20:
        {
            WGSphereMarkVC * markVC = [[WGSphereMarkVC alloc]init];
            [self toTargetController:(UIViewController *)markVC];
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
 pop视图
 */
- (void)outPutView{
    [self.popView pop];
}
/**
 白点按钮点击
 */
- (void)btnClick:(UIButton *)sender{
    NSLog(@"白点被点击");
}
-(void)handlePanFrom:(UIPanGestureRecognizer*)recognizer
{
    NSLog(@"拖动操作");
    //处理拖动操作,拖动是基于imageview，如果经过旋转，拖动方向也是相对imageview上下左右移动，而不是屏幕对上下左右
    CGPoint translation = [recognizer translationInView:recognizer.view];
    
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    NSLog(@"%f %f",recognizer.view.center.y+translation.y,ScreenHeight-49);
    [recognizer setTranslation:CGPointZero inView:recognizer.view];
    if(recognizer.state == UIGestureRecognizerStateEnded){
        if (recognizer.view.center.x + translation.x<ScreenWidth/2) {
            [UIView animateWithDuration:0.5f animations:^{
                recognizer.view.center = CGPointMake(recognizer.view.frame.size.width/2, recognizer.view.center.y + translation.y);
            }];
        }else{
            [UIView animateWithDuration:0.5f animations:^{
                recognizer.view.center = CGPointMake(ScreenWidth-recognizer.view.frame.size.width/2, recognizer.view.center.y + translation.y);
            }];
        }
        if (recognizer.view.center.y+translation.y<recognizer.view.frame.size.width/2 || recognizer.view.center.y+translation.y>ScreenHeight-NavHeight-recognizer.view.frame.size.width/2) {
            [UIView animateWithDuration:0.5f animations:^{
                recognizer.view.center = CGPointMake(ScreenWidth-44/2-5, ScreenHeight-NavHeight-100+44/2);
            }];
        }
    }
}


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
