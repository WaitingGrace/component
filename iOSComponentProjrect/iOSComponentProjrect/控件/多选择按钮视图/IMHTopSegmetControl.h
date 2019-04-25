//
//  IMHTopSegmetControl.h
//  IMHJM
//
//  Created by 帅棋 on 2018/6/13.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ChengeSelecteBlock) (NSInteger);
@interface IMHTopSegmetControl : UIView

@property (nonatomic, copy) ChengeSelecteBlock selectedBlock;
//选中的btn的tag值
@property (nonatomic, assign) NSInteger selectedTagOfBtn;
@property (nonatomic ,strong) NSArray * titlesArray;

/**
 初始化---选择选中的按钮

 @param titlesArray 标题数组
 @param index 选中的
 @param size 尺寸
 @return view
 */
+ (instancetype)createChooseView:(NSArray *)titlesArray selectedIndex:(NSInteger)index size:(CGSize)size;

@end
