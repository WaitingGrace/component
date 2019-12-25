//
//  WGTextView.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/10/9.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^PlaceholderTextViewBlock) (NSString * _Nullable text);

@interface WGTextView : UIView

@property (nonatomic ,strong) PlaceholderTextViewBlock _Nullable textBlock;
/**  */
@property (nonatomic, strong, nullable) UITextView  *textView;

/** 占位*/
@property (nonatomic, strong, nullable) UITextView  *placeholderTextView;


+ (instancetype _Nullable)placeholderTextView;

@end

NS_ASSUME_NONNULL_END
