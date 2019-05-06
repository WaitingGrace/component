//
//  WGDorpView.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/6.
//  Copyright © 2019 WG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WGDorpView : UITableView

-(instancetype)initWithTitleArray:(NSArray *)titleA orignPoint:(CGPoint)orginPoint listWidth:(CGFloat)listWidth selectResult:(void (^)(NSInteger index))selectResult;


-(void)show;
@end

NS_ASSUME_NONNULL_END
