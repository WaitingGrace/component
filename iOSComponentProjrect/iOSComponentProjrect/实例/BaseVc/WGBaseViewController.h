//
//  WGBaseViewController.h
//  
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WGBaseViewController : UIViewController
@property (nonatomic , copy) NSString *navTitle;
- (void)back;
@end

NS_ASSUME_NONNULL_END
