//
//  WGPasswordVerificationCodeVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/3/25.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGPasswordVerificationCodeVC.h"
#import "Config.h"

@interface WGPasswordVerificationCodeVC ()

@end

@implementation WGPasswordVerificationCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    WGVerCodeInputView *verView = [[WGVerCodeInputView alloc]initWithFrame:CGRectMake(40, 0, ScreenWidth-80, 50)];
    verView.maxLenght = 6;//最大长度
    verView.keyBoardType = UIKeyboardTypeNumberPad;
    [verView mq_verCodeViewWithMaxLenght];
    verView.block = ^(NSString *text){
        NSLog(@"text = %@",text);
    };
    verView.center = self.view.center;
    [self.view addSubview:verView];
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
