//
//  WGPolygonalRadarView.h
//  WGPolygonalRadar
//
//

#import <UIKit/UIKit.h>
#import "WGPolygonalRadarEnumDefine.h"
#import "WGPolygonalRadarConfig.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WGPolygonalRadarViewDataSource <NSObject>

- (CGFloat)WGPolygonalRadarValueAtIndex:(NSInteger)index radarIndex:(NSInteger)radarIndex;

@optional
- (UILabel *)WGPolygonalRadarTitleLabelAtIndex:(NSInteger)index;

@end

@interface WGPolygonalRadarView : UIView

/**
 初始化方法

 @param center 中心点
 @param dataSource 数据源
 @param isVertexUp 顶点朝上
 @param radius 半径
 @param edgeCount 多边形边数
 @param bgStyleConfig 背景风格配置项
 @param radarStyleConfig 雷达图风格配置项
 @return WGPolygonalRadarView
 */
- (instancetype)initWithCenter:(CGPoint)center
                    dataSource:(id<WGPolygonalRadarViewDataSource>)dataSource
                    isVertexUp:(BOOL)isVertexUp
                        radius:(CGFloat)radius
                     edgeCount:(NSInteger)edgeCount
                 bgStyleConfig:(WGPolygonalRadarBgStyleConfig *)bgStyleConfig
              radarStyleConfig:(NSArray<WGPolygonalRadarStyleConfig *> *)radarStyleConfig;

@end

NS_ASSUME_NONNULL_END
