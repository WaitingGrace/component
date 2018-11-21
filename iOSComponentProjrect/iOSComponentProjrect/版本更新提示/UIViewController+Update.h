//
//  UIViewController+Update.h
//
//  Created by WG on 2017/7/27.
//  Copyright © 2017年 WG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

typedef void (^GetNewVersionBlock)(BOOL update ,NSString * localVersion ,NSString * freshVersion);
@interface UIViewController (Update)<SKStoreProductViewControllerDelegate>


/**
 获取AppStore信息

 @param success 成功block
 */
+ (void)getNewVersionSuccess:(GetNewVersionBlock)success;

/**
 获取更新

 @param mandatory 是否强制更新
 @param hint 更新提示信息
 */
- (void)detectionOfUpdateVersionWith:(BOOL)mandatory hint:(NSString *)hint Version:(NSString *)version;

@end
