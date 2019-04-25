//
//  WGIdentificationVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/3/28.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGIdentificationVC.h"
#import "AVCaptureViewController.h"
#import "Config.h"

@interface WGIdentificationVC ()

@end

@implementation WGIdentificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份证扫描";
    self.view.backgroundColor = BackColor;
    UIButton * scanBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [scanBtn addTarget:self action:@selector(scanIdcard) forControlEvents:(UIControlEventTouchUpInside)];
    [scanBtn setTitle:@"开始扫描" forState:(UIControlStateNormal)];
    [scanBtn setTitleColor:TitleColor forState:(UIControlStateNormal)];
    [self.view addSubview:scanBtn];
    [scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(0);
    }];
}

- (void)scanIdcard{
    AVCaptureViewController *AVCaptureVC = [[AVCaptureViewController alloc] init];
    AVCaptureVC.formVC = @"WGIdentificationVC";
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:AVCaptureVC animated:YES];
}

@end
