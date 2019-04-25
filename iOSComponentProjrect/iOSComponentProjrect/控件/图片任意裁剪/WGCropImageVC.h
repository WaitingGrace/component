//
//  WGCropImageVC.h
//
//  Created by 帅棋 on 2018/6/29.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ResultsImageBlock) (UIImage * image);
@interface WGCropImageVC : UIViewController
@property (nonatomic ,strong) UIImage *image;//图片源
@property (nonatomic ,strong) ResultsImageBlock imageBlock;

@end
