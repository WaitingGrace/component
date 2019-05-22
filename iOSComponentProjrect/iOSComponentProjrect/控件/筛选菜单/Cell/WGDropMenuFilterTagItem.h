//
//  WGDropMenuFilterTagItem.h
//  
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WGDropMenuFilterTagItem,WGDropMenuModel;

@protocol WGDropMenuFilterTagItemDelegate <NSObject>
- (void)dropMenuFilterTagItem: (WGDropMenuFilterTagItem *)item dropMenuModel:(WGDropMenuModel *)dropMenuModel;

@end

@interface WGDropMenuFilterTagItem : UICollectionViewCell
@property (nonatomic , strong) WGDropMenuModel *dropMenuModel;
@property (nonatomic , weak) id <WGDropMenuFilterTagItemDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
