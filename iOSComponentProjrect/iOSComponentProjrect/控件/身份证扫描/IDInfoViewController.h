//
//  IDInfoViewController.h
//
//  Created by 帅棋 on 2019/3/28.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IDInfo;

@interface IDInfoViewController : UIViewController

// 身份证信息
@property (nonatomic,strong) IDInfo *IDInfo;

// 身份证图像
@property (nonatomic,strong) UIImage *IDImage;


@property (nonatomic,copy)   NSString * formVC;
@end
