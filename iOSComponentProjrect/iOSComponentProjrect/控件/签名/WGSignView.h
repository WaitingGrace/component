//
//  WGSignView.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/17.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGSignView : UIView
/**
 * 获取签名图片
 */
- (UIImage *)getSignatureImage;
/**
 * 清除签名
 */
- (void)clearSignature;
@end
