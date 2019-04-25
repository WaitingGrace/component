//
//  ChooseRank.h
//  LvjFarm
//
//  Created by 帅棋 on 2018/11/21.
//  Copyright © 2018年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Extension.h"

@protocol ChooseRankDelegate <NSObject>
@required
-(void)selectBtnTitle:(NSString *)title andBtn:(UIButton *)btn;

@end

@interface ChooseRank : UIView

@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSArray *rankArray;

@property(nonatomic,strong)UIButton *selectBtn;

@property(nonatomic,strong)UIView *packView;
@property(nonatomic,strong)UIView *btnView;

@property(nonatomic,assign)id<ChooseRankDelegate> delegate;



-(instancetype)initWithTitle:(NSString *)title titleArr:(NSArray *)titleArr andFrame:(CGRect)frame;


@end


