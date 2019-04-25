//
//  WGPromptBoxView.m
//
//  Created by WG on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import "WGPromptBoxView.h"

@implementation WGPromptBoxView
+ (void)popUpPromptBoxWithTitle:(NSString *)title
                        message:(NSString *)messge
                         action:(NSString *)action{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:messge preferredStyle:(UIAlertControllerStyleAlert)];
    [alertController addAction:[UIAlertAction actionWithTitle:action style:(UIAlertActionStyleCancel) handler:nil]];
    UIApplication *ap = [UIApplication sharedApplication];
    [ap.keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

+ (void)popUpOptionPromptBoxWithTitle:(NSString *)title
                              message:(NSString *)messge
                      controllerStyle:(UIAlertControllerStyle)controllerStyle
                               action:(NSArray  *)action
                                style:(NSArray  *)styles
                               cancle:(NSString *)cancle
                          cancleStyle:(UIAlertActionStyle)cancleStyle
                                block:(ButtonClickBlock)block
                          cancleBlock:(CancleClickBlock)cancleBlock{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:messge preferredStyle:(controllerStyle)];
    for (int i = 0 ; i < action.count; i++) {
        [alertController addAction:[UIAlertAction actionWithTitle:action[i] style:[styles[i] integerValue] handler:^(UIAlertAction * _Nonnull action) {
            block(i);
        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:cancle style:cancleStyle handler:^(UIAlertAction * _Nonnull action) {
        if (cancleBlock) {
            cancleBlock();
        }
    }]];
    UIApplication *ap = [UIApplication sharedApplication];
    [ap.keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}
+ (void)popUpRadioOperationPromptBoxWith:(NSString *)title
                                 message:(NSString *)messge
                                  action:(NSString *)action
                             optionBlock:(OptionClickBlock)optionBlock{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:messge preferredStyle:(UIAlertControllerStyleAlert)];
    [alertController addAction:[UIAlertAction actionWithTitle:action style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        if (optionBlock) {
            optionBlock();
        }
    }]];
    UIApplication *ap = [UIApplication sharedApplication];
    [ap.keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}
@end
