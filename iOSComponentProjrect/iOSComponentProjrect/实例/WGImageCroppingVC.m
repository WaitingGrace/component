//
//  WGImageCroppingVC.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/3/29.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGImageCroppingVC.h"
#import "Config.h"
#import "WGCropImageVC.h"

@interface WGImageCroppingVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic ,strong) UIImageView * imageView;
@end

@implementation WGImageCroppingVC

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackColor;

    UIButton * tackPhotoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [tackPhotoBtn setTitleColor:BASEColor forState:(UIControlStateNormal)];
    [tackPhotoBtn setTitle:@"获取图片" forState:(UIControlStateNormal)];
    [tackPhotoBtn addTarget:self action:@selector(takePhoto) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:tackPhotoBtn];
    [tackPhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.top.mas_equalTo(100);
        make.size.mas_equalTo(CGSizeMake(90, 50));
    }];
    
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.width.mas_equalTo(200);
        make.top.mas_equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(200);
    }];
    
}

- (void)takePhoto{
    @WeakObj(self)
    [WGPromptBoxView popUpOptionPromptBoxWithTitle:nil message:nil controllerStyle:(UIAlertControllerStyleActionSheet) action:@[@"拍照",@"去相册选择"] style:@[@(UIAlertActionStyleDestructive),@(UIAlertActionStyleDefault)] cancle:@"取消" cancleStyle:(UIAlertActionStyleCancel) block:^(NSInteger btnTag) {
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        if (btnTag == 1) {
            PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else{
            PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        PickerImage.allowsEditing = NO;
        PickerImage.delegate = self;
        [selfWeak presentViewController:PickerImage animated:YES completion:nil];
    } cancleBlock:^{
    }];
}

/**
 PickerImage完成后的代理方法
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage * newPhoto = info[UIImagePickerControllerOriginalImage];
    [self cropImage:newPhoto];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cropImage: (UIImage *)image{
    WGCropImageVC * cropVC = [[WGCropImageVC alloc]init];
    cropVC.image = image;
    @WeakObj(self);
    cropVC.imageBlock = ^(UIImage *image) {
        selfWeak.imageView.image = image;
    };
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cropVC animated:YES];
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
