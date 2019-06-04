//
//  WGCellImage.m
//  MCSH
//
//  Created by 张帅棋 on 2016/11/3.
//  Copyright © 2016年 WaitingGrace. All rights reserved.
//

#import "WGCellImage.h"

@implementation WGCellImage

//设置cell的imageView的image
+ (UIImage * )tableViewCell:(UITableViewCell *)cell imageName:(NSString *)imageName imageW:(CGFloat)imageW imageH:(CGFloat)imageH{
    cell.imageView.image = [UIImage imageNamed:imageName];
    CGSize itemSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return cell.imageView.image;
}
+ (UIImage * )tableViewCell:(UITableViewCell *)cell image:(UIImage *)image imageW:(CGFloat)imageW imageH:(CGFloat)imageH{
    cell.imageView.image = image;
    CGSize itemSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return cell.imageView.image;
}
@end
