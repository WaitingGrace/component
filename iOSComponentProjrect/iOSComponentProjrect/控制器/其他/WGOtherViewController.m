//
//  WGOtherViewController.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/3/27.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGOtherViewController.h"
#import "Config.h"
#import "WGPlaymentHUD.h"

@interface WGOtherViewController ()

@end

@implementation WGOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;

    UIBarButtonItem * startItem = [[UIBarButtonItem alloc] initWithTitle:@"开始支付" style:UIBarButtonItemStylePlain target:self action:@selector(showLoadingAnimation)];
    UIBarButtonItem * successItem = [[UIBarButtonItem alloc] initWithTitle:@"支付完成" style:UIBarButtonItemStylePlain target:self action:@selector(showSuccessAnimation)];
    self.navigationItem.rightBarButtonItems = @[startItem,successItem];
}

-(void)showLoadingAnimation{
    
    self.title = @"正在付款...";
    
    //隐藏支付完成动画
    [WGOperationSuccessHUD hideIn:self.view];
    //显示支付中动画
    [WGOperationLoadingHUD showIn:self.view];
}

-(void)showSuccessAnimation{
    
    self.title = @"付款完成";
    
    //隐藏支付中成动画
    [WGOperationLoadingHUD hideIn:self.view];
    //显示支付完成动画
    [WGOperationSuccessHUD showIn:self.view];
}


@end
