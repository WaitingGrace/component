//
//  WGSpeechRecognitionVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/27.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGSpeechRecognitionVC.h"
#import "NavigationView.h"
#import "Config.h"


@interface WGSpeechRecognitionVC ()
@property (nonatomic ,strong) NavigationView * navView;

@end

@implementation WGSpeechRecognitionVC

#pragma mark ---
#pragma mark --- 懒加载
- (NavigationView *)navView{
    if (_navView == nil) {
        NavigationView * navView = [NavigationView createdNavigationView];
        navView.backgroundColor = [UIColor whiteColor];
        NSDictionary * titileInfo = @{@"title":@"语音转换",@"font":iPad?@"22":(iPhone4_5?@"18":@"19"),@"color":TitleColor};
        [navView setInitNavigationviewWith:titileInfo backItem:@{} contentitem:nil isHidden:YES];
        _navView = navView;
        @WeakObj(self)
        _navView.backItemClick = ^{
            [selfWeak dismissViewControllerAnimated:YES completion:nil];
        };
    }
    return _navView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
 
    [self setupView];
}

- (void)setupView{
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(NavHeight);
    }];

}


@end
