//
//  WGHDropMenuFilterSectionHeader.h
//
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WGDropMenuModel,WGDropMenuFilterSectionHeader;

@protocol WGDropMenuFilterSectionHeaderDelegate <NSObject>
- (void)dropMenuFilterSectionHeader: (WGDropMenuFilterSectionHeader *)header dropMenuModel: (WGDropMenuModel *)dropMenuModel;

@end

@interface WGDropMenuFilterSectionHeader : UICollectionReusableView
@property (nonatomic , strong) WGDropMenuModel *dropMenuModel;

@property (nonatomic , weak) id <WGDropMenuFilterSectionHeaderDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
