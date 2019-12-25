//
//  WGPolygonalRadarEnumDefine.h
//  iOSComponentProjrect
//
//  Created by 帅棋 on 2019/11/7.
//  Copyright © 2019 WG. All rights reserved.
//

#ifndef WGPolygonalRadarEnumDefine_h
#define WGPolygonalRadarEnumDefine_h
/**
 雷达图背景风格
 
 - ENUM_WGPOLYGONALRADAR_BG_STYLE_DEFAULT: 默认背景
 - ENUM_WGPOLYGONALRADAR_BG_STYLE_CUSTOM_IMAGE: 自定义图片
 */
typedef NS_ENUM(NSUInteger, ENUM_WGPOLYGONALRADAR_BG_STYLE) {
    ENUM_WGPOLYGONALRADAR_BG_STYLE_DEFAULT,
    ENUM_WGPOLYGONALRADAR_BG_STYLE_CUSTOM_IMAGE
};

/**
 雷达图顶点Icon风格
 
 - ENUM_WGPOLYGONALRADAR_VERTEX_ICON_STYLE_SOLID_CIRCLE: 实心圆Icon
 - ENUM_WGPOLYGONALRADAR_VERTEX_ICON_STYLE_HOLLOW_CIRCLE: 空心圆Icon
 */
typedef NS_ENUM(NSUInteger, ENUM_WGPOLYGONALRADAR_VERTEX_ICON_STYLE) {
    ENUM_WGPOLYGONALRADAR_VERTEX_ICON_STYLE_SOLID_CIRCLE,
    ENUM_WGPOLYGONALRADAR_VERTEX_ICON_STYLE_HOLLOW_CIRCLE
};

/**
 雷达图填充风格
 
 - ENUM_WGPOLYGONALRADAR_FILL_STYLE_SOLID_COLOR: 纯色填充
 - ENUM_WGPOLYGONALRADAR_FILL_STYLE_GRADIENT_COLOR: 渐变色填充
 */
typedef NS_ENUM(NSUInteger, ENUM_WGPOLYGONALRADAR_FILL_STYLE) {
    ENUM_WGPOLYGONALRADAR_FILL_STYLE_SOLID_COLOR,
    ENUM_WGPOLYGONALRADAR_FILL_STYLE_GRADIENT_COLOR
};

/**
 雷达图线条风格
 
 - ENUM_WGPOLYGONALRADAR_LINE_STYLE_SOLID_LINE: 实线
 - ENUM_WGPOLYGONALRADAR_LINE_STYLE_DASH_LINE: 虚线
 */
typedef NS_ENUM(NSUInteger, ENUM_WGPOLYGONALRADAR_LINE_STYLE) {
    ENUM_WGPOLYGONALRADAR_LINE_STYLE_SOLID_LINE,
    ENUM_WGPOLYGONALRADAR_LINE_STYLE_DASH_LINE
};


#endif /* WGPolygonalRadarEnumDefine_h */
