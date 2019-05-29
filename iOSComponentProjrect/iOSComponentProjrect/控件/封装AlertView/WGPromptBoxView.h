//
//  WGPromptBoxView.h
//
//  Created by WG on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ButtonClickBlock) (NSInteger btnTag);
typedef void (^CancleClickBlock) (void);
typedef void (^OptionClickBlock) (void);
@interface WGPromptBoxView : NSObject

/**
 系统提示框,不做任何处理
 
 @param title 名称
 @param messge 信息
 @param action 取消
 */
+ (void)popUpPromptBoxWithTitle:(NSString *)title
                        message:(NSString *)messge
                         action:(NSString *)action;

/**
 单按钮提示框
 
 @param title 标题
 @param messge 信息
 @param action 按钮
 @param optionBlock 回调
 */
+ (void)popUpRadioOperationPromptBoxWith:(NSString *)title
                                 message:(NSString *)messge
                                  action:(NSString *)action
                             optionBlock:(OptionClickBlock)optionBlock;
/**
 多按钮提示框
 
 @param title 标题
 @param messge 信息
 @param controllerStyle UIAlertControllerStyle
 @param action 操作按钮名称集合
 @param styles 按钮样式集合
 @param cancle 取消
 @param block 按钮点击回调
 */
+ (void)popUpOptionPromptBoxWithTitle:(NSString *)title
                              message:(NSString *)messge
                      controllerStyle:(UIAlertControllerStyle)controllerStyle
                               action:(NSArray  *)action
                                style:(NSArray  *)styles
                               cancle:(NSString *)cancle
                          cancleStyle:(UIAlertActionStyle)cancleStyle
                                block:(ButtonClickBlock)block
                          cancleBlock:(CancleClickBlock)cancleBlock;


@end
