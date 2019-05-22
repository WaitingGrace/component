//
//  WGDropMenuOptionCell.h
//  
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WGDropMenuModel,WGDropMenuOptionCell;

/**
 选项菜单cell
 */
@interface WGDropMenuOptionCell : UITableViewCell
/**
 模型
 */
@property (nonatomic , strong) WGDropMenuModel *dropMenuModel;
@end

NS_ASSUME_NONNULL_END
