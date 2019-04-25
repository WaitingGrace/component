//
//  IDInfoViewController.m
//
//  Created by 帅棋 on 2019/3/28.
//  Copyright © 2019 WG. All rights reserved.

#import "IDInfoViewController.h"
#import "IDInfo.h"
#import "AVCaptureViewController.h"
#import "Config.h"

#import "WGIdentificationVC.h"//要返回的控制器

@interface IDInfoViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *IDImageView;
@property (strong, nonatomic) IBOutlet UILabel *IDNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *minzu;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end

@implementation IDInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"身份证信息";

    
    self.IDImageView.layer.cornerRadius = 8;
    self.IDImageView.layer.masksToBounds = YES;
    self.IDImageView.image = _IDImage;
    
    self.IDNumLabel.text = _IDInfo.num;
    self.name.text = _IDInfo.name;
    self.sex.text = _IDInfo.gender;
    self.minzu.text = _IDInfo.nation;
    self.address.text = _IDInfo.address;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self drawFaceWithImageView:self->_IDImage];
    });
}
-(void)drawFaceWithImageView:(UIImage *)image{
    CIImage* ciimage = [CIImage imageWithCGImage:image.CGImage];
    NSDictionary* opts = [NSDictionary dictionaryWithObject:
                          CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:nil options:opts];
    //所有的人脸数据
    NSArray* features = [detector featuresInImage:ciimage];
    for(CIFaceFeature* faceFeature in features){
        CGRect origRect = faceFeature.bounds;
        CGRect biggerRect = CGRectInset(origRect
                                        ,origRect.size.width*-0.35
                                        ,origRect.size.height*-0.4);
        CGRect flipRect = biggerRect;
        flipRect.origin.y = image.size.height - (biggerRect.origin.y + biggerRect.size.height);
        flipRect.origin.y = flipRect.origin.y;
        CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], flipRect);
        UIImage* faceImage = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.iconImage.image = faceImage;
            self->_IDInfo.image = faceImage;
        });
        break;
    }
}
#pragma mark - 错误，重新拍摄
- (IBAction)shootAgain:(UIButton *)sender {    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 正确，下一步
- (IBAction)nextStep:(UIButton *)sender {

    NSDictionary * para = @{@"idCode":_IDInfo.num,
                            @"name":_IDInfo.name,
                            @"image":_IDInfo.image,
                            @"address":_IDInfo.address,
                            @"sex":_IDInfo.gender,
                            @"minzu":_IDInfo.nation
                            };
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([self.formVC isEqualToString:@"WGIdentificationVC"]) {
            if ([controller isKindOfClass:[WGIdentificationVC class]]) {
                WGIdentificationVC * addVC = (WGIdentificationVC *)controller;
                addVC.dict = para;
                [self.navigationController popToViewController:addVC animated:YES];
            }
        }
        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationAVCaptureViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
