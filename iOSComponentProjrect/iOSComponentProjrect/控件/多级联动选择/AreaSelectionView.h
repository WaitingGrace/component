//
//  AreaSelectionView.h
//  IMHJM
//
//  Created by 帅棋 on 2018/7/9.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGAddressModel;
typedef void (^AreaSelectionBlock) (WGAddressModel *model);
typedef void (^ChooseCompleteBlock) (NSDictionary *dict);
@interface AreaSelectionView : UIView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic ,strong) AreaSelectionBlock selectionBlock;
@property (nonatomic ,strong) ChooseCompleteBlock areaFinish;

/**
 刷新数据

 @param dataArray 数据源
 @param level 级别
 */
- (void)reloadDataWith:(NSArray *)dataArray level:(NSString *)level;

/*! 显示 */
-(void)show;
/*! 消失 */
-(void)dismiss;
@end
