//
//  WGScanViewController.m
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/3/26.
//  Copyright © 2019 WG. All rights reserved.
//

#import "WGScanViewController.h"
#import "Config.h"
#import "WGQrCodeViewController.h"

@interface WGScanViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong)  WGScanView * scanView;
@property (nonatomic, strong)  WGNativeScanTool * scanTool;

@end

@implementation WGScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"相册" style:(UIBarButtonItemStyleDone) target:self action:@selector(photoBtnClicked)];

    self.navigationItem.title = @"二维码/条码";
    //输出流视图
    UIView *preview  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0)];
    [self.view addSubview:preview];
    @WeakObj(self)
    //构建扫描样式视图
    _scanView = [[WGScanView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0)];
    _scanView.scanRetangleRect = CGRectMake(60, 120, (self.view.frame.size.width - 2 * 60),  (self.view.frame.size.width - 2 * 60));
    _scanView.colorAngle = [UIColor greenColor];
    _scanView.photoframeAngleW = 20;
    _scanView.photoframeAngleH = 20;
    _scanView.photoframeLineW = 2;
    _scanView.isNeedShowRetangle = YES;
    _scanView.colorRetangleLine = [UIColor whiteColor];
    _scanView.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _scanView.animationImage = [UIImage imageNamed:@"scanLine"];
    _scanView.myQRCodeBlock = ^{
        WGQrCodeViewController * qrvc = [[WGQrCodeViewController alloc]init];
        qrvc.qrImage = [WGNativeScanTool createQRCodeImageWithString:@"想知道自己百度" andSize:CGSizeMake(ScreenWidth-100, ScreenWidth-100) andBackColor:UIColorFromRGB(0xF0F0F0) andFrontColor:UIColorFromRGB(0x750000) andCenterImage:[UIImage imageNamed:@"百度"]];
        qrvc.qrString = @"想知道自己百度";
        [selfWeak.navigationController pushViewController:qrvc animated:YES];
    };
    _scanView.flashSwitchBlock = ^(BOOL open) {
        [selfWeak.scanTool openFlashSwitch:open];
    };
    [self.view addSubview:_scanView];
    
    //初始化扫描工具
    _scanTool = [[WGNativeScanTool alloc] initWithPreview:preview andScanFrame:_scanView.scanRetangleRect];
    _scanTool.scanFinishedBlock = ^(NSString *scanString) {
        NSLog(@"扫描结果 %@",scanString);
        [selfWeak.scanView handlingResultsOfScan];
        WGQrCodeViewController * qrvc = [[WGQrCodeViewController alloc]init];
        qrvc.qrImage =  [WGNativeScanTool createQRCodeImageWithString:scanString andSize:CGSizeMake(250, 250) andBackColor:[UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1.0] andFrontColor:[UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1.0] andCenterImage:[UIImage imageNamed:@"piao"]];
        qrvc.qrString = scanString;
        [selfWeak.navigationController pushViewController:qrvc animated:YES];
        [selfWeak.scanTool sessionStopRunning];
        [selfWeak.scanTool openFlashSwitch:NO];
    };
    _scanTool.monitorLightBlock = ^(float brightness) {
        NSLog(@"环境光感 ： %f",brightness);
        if (brightness < 0) {
            // 环境太暗，显示闪光灯开关按钮
            [selfWeak.scanView showFlashSwitch:YES];
        }else if(brightness > 0){
            // 环境亮度可以,且闪光灯处于关闭状态时，隐藏闪光灯开关
            if(!selfWeak.scanTool.flashOpen){
                [selfWeak.scanView showFlashSwitch:NO];
            }
        }
    };
    
    [_scanTool sessionStartRunning];
    [_scanView startScanAnimation];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_scanView startScanAnimation];
    [_scanTool sessionStartRunning];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_scanView stopScanAnimation];
    [_scanView finishedHandle];
    [_scanView showFlashSwitch:NO];
    [_scanTool sessionStopRunning];
}
#pragma mark -- Events Handle
- (void)photoBtnClicked{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController * _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        _imagePickerController.allowsEditing = YES;
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }else{
        NSLog(@"不支持访问相册");
    }
}
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message handler:(void (^) (UIAlertAction *action))handler{
    [WGPromptBoxView popUpPromptBoxWithTitle:title message:message action:@"确定"];

}
#pragma mark UIImagePickerControllerDelegate
//该代理方法仅适用于只选取图片时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage * newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [self dismissViewControllerAnimated:YES completion:nil];
    [_scanTool scanImageQRCode:newPhoto];
}


@end
