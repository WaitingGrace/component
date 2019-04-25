//
//  WGQrCodeViewController.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/3/25.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGQrCodeViewController.h"
#import "Config.h"

@interface WGQrCodeViewController ()
@property (nonatomic ,strong) UIImageView * imageView;
@property (nonatomic ,strong) UILabel * label;

@end

@implementation WGQrCodeViewController


- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}
- (UILabel *)label{
    if (_label == nil) {
        _label = [[UILabel alloc]init];
        _label.numberOfLines = 0;
    }
    return _label;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;
    
    
    self.navigationItem.title = @"生成二维码";
    self.imageView.image = self.qrImage;
    self.label.text = [NSString stringWithFormat:@"扫描结果：%@ ",self.qrString];

    
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(90);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-100, ScreenWidth-100));
    }];
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(20);
    }];
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
