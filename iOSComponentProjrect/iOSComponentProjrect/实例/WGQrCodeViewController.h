//
//  WGQrCodeViewController.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/3/25.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WGQrCodeViewController : UIViewController
@property (nonatomic, strong) UIImage * qrImage;

@property (nonatomic, copy) NSString * qrString;
@end

NS_ASSUME_NONNULL_END
