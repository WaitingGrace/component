//
//  WGHeaderView.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/6.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^SelectionFilterClickBlock) (NSInteger type);

@interface WGHeaderView : UIView

@property (nonatomic ,strong) UIView * conditionsView;//类型

@property (nonatomic ,copy) NSString * startDate;
@property (nonatomic ,copy) NSString * endDate;
@property (nonatomic ,copy) NSString * type;

@property (nonatomic ,strong) SelectionFilterClickBlock selectionFilter;

@end

NS_ASSUME_NONNULL_END
