//
//  WGDropMenuFilterInputItem.h
//  
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WGDropMenuFilterInputItem,WGDropMenuModel;
@protocol WGDropMenuFilterInputItemDelegate <NSObject>
- (void)dropMenuFilterInputItem: (WGDropMenuFilterInputItem *)item dropMenuModel: (WGDropMenuModel *)dropMenuModel;
- (void)dropMenuFilterEndInputItem: (WGDropMenuFilterInputItem *)item dropMenuModel: (WGDropMenuModel *)dropMenuModel;

@end

@interface WGDropMenuFilterInputItem : UICollectionViewCell
@property (nonatomic , strong) WGDropMenuModel *dropMenuModel;
@property (nonatomic , weak) id <WGDropMenuFilterInputItemDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
