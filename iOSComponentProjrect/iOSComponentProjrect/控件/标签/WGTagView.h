//
//  WGTagView.h
//
//  Created by 帅棋 on 2019/3/27.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WGTag.h"

NS_ASSUME_NONNULL_BEGIN

@interface WGTagView : UIView


@property (assign, nonatomic) UIEdgeInsets padding;
@property (assign, nonatomic) CGFloat lineSpacing;
@property (assign, nonatomic) CGFloat interitemSpacing;
@property (assign, nonatomic) CGFloat preferredMaxLayoutWidth;
@property (assign, nonatomic) CGFloat regularWidth; //!< 固定宽度
@property (nonatomic,assign ) CGFloat regularHeight; //!< 固定高度
@property (assign, nonatomic) BOOL singleLine;
@property (copy, nonatomic, nullable) void (^didTapTagAtIndex)(NSUInteger index);

/**
 添加tag
 
 @param tag 标签
 */
- (void)addTag: (nonnull WGTag *)tag;

/**
 插入标签
 
 @param tag 标签
 @param index 位置
 */
- (void)insertTag: (nonnull WGTag *)tag atIndex:(NSUInteger)index;

/**
 移除标签
 
 @param tag 标签
 */
- (void)removeTag: (nonnull WGTag *)tag;

/**
 移除标签
 
 @param index 标签位置
 */
- (void)removeTagAtIndex: (NSUInteger)index;

/**
 移除所有标签
 */
- (void)removeAllTags;

@end

NS_ASSUME_NONNULL_END
