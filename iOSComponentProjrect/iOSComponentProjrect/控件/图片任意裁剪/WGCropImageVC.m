//
//  WGCropImageVC.m
//
//  Created by 帅棋 on 2018/6/29.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import "WGCropImageVC.h"
#import "WGTackImgaeView.h"
#import "Config.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define CROP_PROPORTION_IMAGE_WIDTH 30.0f
#define CROP_PROPORTION_IMAGE_SPACE 48.0f
#define CROP_PROPORTION_IMAGE_PADDING 20.0f
@interface WGCropImageVC ()
{
    NSArray *proportionImageNameArr;
    NSArray *proportionImageNameHLArr;
    NSArray *proportionArr;
    NSMutableArray *proportionBtnArr;
    CGFloat currentProportion;
}
@property (nonatomic ,strong) WGTackImgaeView *tkImageView;
@property (nonatomic ,strong) UIButton * cancleBtn;
@property (nonatomic ,strong) UIButton * tailoringBtn;

@end

@implementation WGCropImageVC
#pragma mark ---
#pragma mark --- 懒加载
- (UIButton *)cancleBtn{
    if (_cancleBtn == nil) {
        UIButton * cancleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [cancleBtn setTitle:String(@"取消") forState:(UIControlStateNormal)];
        [cancleBtn setBackgroundColor:[UIColor clearColor]];
        [cancleBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [cancleBtn addTarget:self action:@selector(cancleChoose) forControlEvents:(UIControlEventTouchUpInside)];
        _cancleBtn = cancleBtn;
    }
    return _cancleBtn;
}
- (UIButton *)tailoringBtn{
    if (_tailoringBtn == nil) {
        UIButton * tailoringBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [tailoringBtn setTitle:String(@"选取") forState:(UIControlStateNormal)];
        [tailoringBtn setBackgroundColor:[UIColor clearColor]];
        [tailoringBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [tailoringBtn addTarget:self action:@selector(ConfirmTheCutting) forControlEvents:(UIControlEventTouchUpInside)];
        _tailoringBtn = tailoringBtn;
    }
    return _tailoringBtn;
}
- (WGTackImgaeView *)tkImageView{
    if (_tkImageView == nil) {
        _tkImageView = [[WGTackImgaeView alloc]initWithFrame:CGRectZero];
        _tkImageView.toCropImage = self.image;
        _tkImageView.showMidLines = YES;
        _tkImageView.needScaleCrop = YES;
        _tkImageView.showCrossLines = YES;
        _tkImageView.cornerBorderInImage = NO;
        _tkImageView.cropAreaCornerWidth = 50;
        _tkImageView.cropAreaCornerHeight = 50;
        _tkImageView.minSpace = 30;
        _tkImageView.cropAreaCornerLineColor = [UIColor whiteColor];
        _tkImageView.cropAreaBorderLineColor = [UIColor whiteColor];
        _tkImageView.cropAreaCornerLineWidth = 2;
        _tkImageView.cropAreaBorderLineWidth = 2;
        _tkImageView.cropAreaMidLineWidth = 20;
        _tkImageView.cropAreaMidLineHeight = 6;
        _tkImageView.cropAreaMidLineColor = [UIColor whiteColor];
        _tkImageView.cropAreaCrossLineColor = [UIColor whiteColor];
        _tkImageView.cropAreaCrossLineWidth = 1;
        _tkImageView.initialScaleFactor = .8f;
        _tkImageView.cropAspectRatio = 0.0;
    }
    return _tkImageView;
}
#pragma mark ---
#pragma mark --- 生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
#pragma mark ----
#pragma mark ---- 视图设置
/**
 设置视图
 */
- (void)setupView{
    self.view.backgroundColor = [UIColor blackColor];
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(NavHeight);
    }];
    UILabel * label = [[UILabel alloc]init];
    label.text = String(@"图片裁剪");
    label.textColor = RGB(51, 51, 51);
    label.font = BoldFONT(iPad?22:18);
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(view.mas_bottom).offset(-22);
    }];
    [self.view addSubview:self.tkImageView];
    [self.tkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-60);
        make.top.mas_equalTo(NavHeight);
    }];
    UIView * view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(55);
    }];
    [view1 addSubview:self.cancleBtn];
    [view1 addSubview:self.tailoringBtn];
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(16);
    }];
    [self.tailoringBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-16);
    }];

}

#pragma mark ----
#pragma mark ---- 私有方法
- (void)cancleChoose{
    [self.navigationController popViewControllerAnimated:YES];
    self.hidesBottomBarWhenPushed = NO;
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)ConfirmTheCutting{
    UIImage * image = [self.tkImageView currentCroppedImage];
    if (self.imageBlock) {
        self.imageBlock(image);
    }
    [self cancleChoose];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
