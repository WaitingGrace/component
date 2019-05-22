//
//  UIImage+WGExpand.h
//
//  Created by 帅棋 on 2018/11/26.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WGExpand)

#pragma mark ---
#pragma mark ----------------------------------
/**
 base64转image
 
 @param imageData data
 @return image
 */
+ (UIImage *)decodedImage:(NSString *)imageData;

/**
 image 转base64
 
 @param image image
 @return data
 */
+ (NSString *)encodedImageString:(UIImage *)image;

/**
 颜色转换为图片
 
 @param color 颜色
 @return 图片image
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


+ (instancetype)originalImageNamed:(NSString *)imageName;

#pragma mark ---
#pragma mark ----------------------------------
/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize;

/**
 *  返回一张可以随意拉伸不变形的图片(单色背景图)
 *
 *  @param name 图片名字
 */
+ (UIImage *)resizableImage:(NSString *)name;

/**
 修改图片的frame
 
 @param size 图片size
 @return 新的image
 */
- (UIImage*)scaleToSize:(CGSize)size;

#pragma mark ---
#pragma mark ----------------------------------
/**
 剪切显示图片中心
 
 @param image image
 @param viewsize 视图size
 @return image
 */
+ (UIImage *)image:(UIImage *)image centerInSize:(CGSize)viewsize;

/**
 按视图比例填充
 
 @param image image
 @param viewsize 视图size
 @return image
 */
+ (UIImage *)image:(UIImage *)image fillSize:(CGSize)viewsize;


/**
 按比例显示图片
 
 @param image image
 @param viewsize 视图size
 @return image
 */
+ (UIImage *)image:(UIImage *)image fitInSize:(CGSize)viewsize;
@end
