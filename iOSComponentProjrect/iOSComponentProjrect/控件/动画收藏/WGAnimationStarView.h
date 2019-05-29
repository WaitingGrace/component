//
//  LCStarView.h
//  StarView
//
//  Created by bawn on 9/15/15.
//  Copyright (c) 2015 bawn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGAnimationStarView : UIView
//变化后的图片
@property (nonatomic, strong) UIImage *maskImage;
//原图
@property (nonatomic, strong) UIImage *borderImage;
//变化后的图片渲染色
@property (nonatomic, strong) UIColor *fillColor;

@end
