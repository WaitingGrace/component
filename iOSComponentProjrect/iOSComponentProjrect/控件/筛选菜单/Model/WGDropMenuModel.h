//
//  WGDropMenuModel.h
//  
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/** 菜单类型 */
typedef NS_ENUM (NSUInteger,WGDropMenuFilterCellType ) {
    /** 标签 */
    WGDropMenuFilterCellTypeTag = 1,
    /** 输入 */
    WGDropMenuFilterCellTypeInput,
    /** 输入 */
    WGDropMenuFilterCellTypeSingleInput,
    /** 输入 */
    WGDropMenuFilterCellTypeTagCollection,
};
/** 菜单类型 */
typedef NS_ENUM (NSUInteger,WGDropMenuType ) {
    /** 标题菜单 */
    WGDropMenuTypeTitle = 1,
    /** 侧滑筛选菜单 */
    WHDropMenuTypeFilter,
    WGDropMenuTypeOptionCollection,
    WGDropMenuTypeWaterFall,
};
/** 筛选菜单模型 */
@interface WGDropMenuModel : NSObject
@property (nonatomic , strong) NSArray *waterFallTags;
/** menu菜单的最大宽度 */
@property (nonatomic , assign) CGFloat menuWidth;
/** 每行多少个 */
@property (nonatomic , assign) CGFloat sectionCount;
@property (nonatomic , strong) UIColor *titleViewBackGroundColor;
/** 选项正常文字颜色 */
@property (nonatomic , strong) UIColor *optionNormalColor;
/** 选项选中文字颜色 */
@property (nonatomic , strong) UIColor *optionSeletedColor;
/** 选项文字大小 */
@property (nonatomic , strong) UIFont *optionFont;
/** 标题菜单标题正常图片 */
@property (nonatomic , copy) NSString *titleNormalImageName;
/** 标题菜单标题选中图片 */
@property (nonatomic , copy) NSString *titleSeletedImageName;
/** 标题菜单标题正常文字颜色 */
@property (nonatomic , strong) UIColor *titleNormalColor;
/** 标题菜单标题选中文字颜色 */
@property (nonatomic , strong) UIColor *titleSeletedColor;
/** 标题菜单是否记录用户菜单选择 默认是NO */
@property (nonatomic , assign) BOOL recordSeleted;
/** 筛选菜单类型 */
@property (nonatomic , assign) WGDropMenuFilterCellType filterCellType;
@property (nonatomic , copy) NSString *singleInput;
/** 最小价格 */
@property (nonatomic , copy) NSString *minPrice;
/** 最大价格 */
@property (nonatomic , copy) NSString *maxPrice;
/** 是否是多选  NO 单选 YES 多选 */
@property (nonatomic , assign) BOOL isMultiple;
/** 记录cell是否被选中 */
@property (nonatomic , assign) BOOL cellSeleted;
/** 记录section是否被选中 */
@property (nonatomic , assign) BOOL sectionSeleted;
/** 记录标签是否被选中 */
@property (nonatomic , assign) BOOL tagSeleted;
/** 记录标题是否被选中 */
@property (nonatomic , assign) BOOL titleSeleted;
/** 存放tag section数组 */
@property (nonatomic , strong) NSArray *sections;
/** tag id */
@property (nonatomic , assign) NSInteger tagIdentifier;
/** tag 模型 */
@property (nonatomic , strong) WGDropMenuModel *dropMenuTagModel;
/** sectionHeaderTitle */
@property (nonatomic , copy) NSString *sectionHeaderTitle;
/** sectionHeaderDetails */
@property (nonatomic , copy) NSString *sectionHeaderDetails;
/** 标签名称 */
@property (nonatomic , copy) NSString *tagName;
/** 菜单类型 */
@property (nonatomic , assign) WGDropMenuType dropMenuType;
/** 标题 */
@property (nonatomic , copy) NSString *title;
/** 唯一标识符 */
@property (nonatomic , assign) NSInteger identifier;
@property (nonatomic , strong) UIFont *titleFont;
@property (nonatomic , assign) CGFloat menuHeight;
/** 标题数组 */
@property (nonatomic , strong) NSArray *titles;
/** 数据源数组 */
@property (nonatomic , strong) NSArray *dataArray;
@property (nonatomic , assign) CGRect frame;
/** 记录indexPath */
@property (nonatomic , strong) NSIndexPath *indexPath;

/** 构造筛选菜单数据 */
- (NSMutableArray *)creaDropMenuData;
- (NSMutableArray *)creaFilterDropMenuData;
- (NSMutableArray *)creatNormalDropMenuData;
- (NSMutableArray *)creatRandomDropMenuData;

@end

NS_ASSUME_NONNULL_END
