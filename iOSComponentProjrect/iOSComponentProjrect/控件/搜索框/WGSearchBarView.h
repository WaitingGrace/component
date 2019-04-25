//
//  WGSearchBarView.h
//
//  Created by 帅棋 on 2018/6/13.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SearchBarBlock) (NSString * keyWord);
typedef void (^CancleSearchBlock) (void);
@interface WGSearchBarView : UIView
@property (nonatomic ,strong) SearchBarBlock searchBlock;
@property (nonatomic ,strong) CancleSearchBlock cancleSearch;
@property (nonatomic ,strong) NSString * searchInfo;
@property (nonatomic ,strong) UIColor * backColor;//背景颜色
@property (nonatomic ,strong) UIColor * borderColor;//边框颜色

@end
