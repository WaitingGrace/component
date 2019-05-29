//
//  WGWebView.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/13.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

typedef void (^NavTitleBlock) (NSString * _Nullable title);
NS_ASSUME_NONNULL_BEGIN

@interface WGWebView : UIView
@property (nonatomic ,copy) NSString * link;
@property (nonatomic ,copy) NavTitleBlock titleBlock;

@end

NS_ASSUME_NONNULL_END
