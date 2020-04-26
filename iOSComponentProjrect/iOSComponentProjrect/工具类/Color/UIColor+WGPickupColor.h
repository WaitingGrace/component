//
//  UIColor+WGPickupColor.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2020/4/26.
//  Copyright © 2020 WG. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (WGPickupColor)
/**

 *  获取图片的主色调

 */

+ (UIColor*)mostColor:(UIImage*)image;

/**

 *  获取图片某一区域的主色调

 *  @paramrect 获取色调的图片区域

 */

+ (UIColor*)mostColor:(UIImage*)image inRect:(CGRect)rect;


@end

NS_ASSUME_NONNULL_END
