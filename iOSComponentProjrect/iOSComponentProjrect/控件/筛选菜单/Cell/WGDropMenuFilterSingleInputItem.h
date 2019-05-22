//
//  WGDropMenuFilterSingleInputItem.h
//  
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WGDropMenuFilterSingleInputItem,WGDropMenuModel;

@protocol WGDropMenuFilterSingleInputItemDelegate <NSObject>
- (void)dropMenuFilterSingleInputItem: (WGDropMenuFilterSingleInputItem *)item
                        dropMenuModel: (WGDropMenuModel *)dropMenuModel;
@end

@interface WGDropMenuFilterSingleInputItem : UICollectionViewCell
@property (nonatomic , strong) WGDropMenuModel *dropMenuModel;
@property (nonatomic , weak) id <WGDropMenuFilterSingleInputItemDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
