//
//  WGThrowLineAnimationTool.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/5/21.
//  Copyright © 2019 WG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^WGThorwLineAnimationFinisnBlock)(BOOL finish);
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface WGThrowLineAnimationTool : NSObject <CAAnimationDelegate>
@property (strong , nonatomic) CALayer *layer;
@property (copy , nonatomic) WGThorwLineAnimationFinisnBlock animationFinisnBlock;
/**
 *  初始化
 *
 *  @return 单列tool
 */
+(instancetype)shareTool;
/**
 *  开始动画
 *
 *  @param view        添加动画的view
 *  @param rect        view 的绝对frame
 *  @param finishPoint 下落的位置
 *  @param completion 动画完成回调
 */
-(void)startAnimationandView:(UIView *)view andRect:(CGRect)rect andFinisnRect:(CGPoint)finishPoint andFinishBlock:(WGThorwLineAnimationFinisnBlock)completion;
/**
 *  摇晃动画
 *
 *  @param shakeView 晃动的视图
 */
+(void)shakeAnimation:(UIView *)shakeView;
@end
