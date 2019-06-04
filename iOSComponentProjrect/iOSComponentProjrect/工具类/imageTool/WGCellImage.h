//
//  WGCellImage.h
//  MCSH
//
//  Created by 张帅棋 on 2016/11/3.
//  Copyright © 2016年 WaitingGrace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGCellImage : UIImage
/**
 *  通过图片名称imageName设置
 **/

+ (UIImage * )tableViewCell:(UITableViewCell *)cell imageName:(NSString *)imageName imageW:(CGFloat)imageW imageH:(CGFloat)imageH;
/**
 *  通过图片image设置
 **/

+ (UIImage * )tableViewCell:(UITableViewCell *)cell image:(UIImage *)image imageW:(CGFloat)imageW imageH:(CGFloat)imageH;
@end
