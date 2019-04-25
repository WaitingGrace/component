//
//  AVCaptureViewController.h
//
//  Created by 帅棋 on 2019/3/28.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IDInfo;

typedef void (^ScanIdCardBlock)(IDInfo *info,UIImage *image);
@interface AVCaptureViewController : UIViewController

@property (nonatomic ,strong) ScanIdCardBlock scanIdCard;
@property (nonatomic ,copy) NSString * formVC;

@end

