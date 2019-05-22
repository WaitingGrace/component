//
//  WGWebViewVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/13.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGWebViewVC.h"
#import "Config.h"
#import "WGWebView.h"

@interface WGWebViewVC ()<UIGestureRecognizerDelegate>
@property (nonatomic ,strong) NavigationView * navView;
@property (nonatomic ,strong) WGWebView * desView;
@property (nonatomic, strong) id <UIGestureRecognizerDelegate>delegate;

@end

@implementation WGWebViewVC

#pragma mark --- 懒加载
- (NavigationView *)navView{
    if (_navView == nil) {
        NavigationView * navView = [NavigationView createdNavigationView];
        navView.backgroundColor = [UIColor whiteColor];
        NSDictionary * titileInfo = @{@"title":@"webView",@"font":iPad?@"22":(iPhone4_5?@"18":@"19")};
        [navView setInitNavigationviewWith:titileInfo backItem:@{} contentitem:nil isHidden:YES];
        _navView = navView;
        @WeakObj(self)
        _navView.backItemClick = ^{
            [selfWeak.navigationController popViewControllerAnimated:YES];
        };
    }
    return _navView;
}
- (WGWebView *)desView{
    if (_desView == nil) {
        _desView = [[WGWebView alloc]init];
        @WeakObj(self)
        _desView.titleBlock = ^(NSString *title) {
            selfWeak.navView.titleText = title;
        };
    }
    return _desView;
}

#pragma mark --- 视图生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count > 1) {
        self.delegate = self.navigationController.interactivePopGestureRecognizer.delegate;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    self.navigationController.navigationBar.hidden = YES;
    [self setupView];
    [IMHAFttpTool NetworkMonitoringStatus:^(NSUInteger status) {
        if (status == 2) {//wifi

        }else{
            
        }
    }];
    self.desView.link = @"https://www.baidu.com";
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = self.delegate;
    DISMISS;
}

/**
 视图设置
 */
- (void)setupView{
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(NavHeight);
    }];
    [self.view addSubview:self.desView];
    [self.desView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(NavHeight+1);
    }];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.navigationController.viewControllers.count > 1;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return self.navigationController.viewControllers.count > 1;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
