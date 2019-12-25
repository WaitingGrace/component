//
//  WGPolygonalRadarConfig.m
//  WGPolygonalRadar
//
//

#import "WGPolygonalRadarConfig.h"

#define ColorRGB(_red, _green, _blue) [UIColor colorWithRed:(_red)/255.0f green:(_green)/255.0f blue:(_blue)/255.0f alpha:1]
#define ColorRGBA(_red, _green, _blue, _alpha) [UIColor colorWithRed:(_red)/255.0f green:(_green)/255.0f blue:(_blue)/255.0f alpha:(_alpha)]

#define ColorRed ColorRGB(235, 35, 35)
#define ColorOrange ColorRGBA(255, 148, 53, .9)
#define ColorYellow ColorRGB(229, 230, 0)
#define ColorGreen ColorRGB(164, 230, 78)
#define ColorCyan ColorRGBA(38, 172, 235, .9)
#define ColorBlue ColorRGBA(1, 139, 242, .9)
#define ColorPurple ColorRGB(99, 91, 151)
#define ColorGray ColorRGB(153, 153, 153)
#define ColorBlack ColorRGB(10, 10, 10)

@implementation WGPolygonalRadarBgStyleConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _bgStyle = ENUM_WGPOLYGONALRADAR_BG_STYLE_DEFAULT;
        
        //刻度线
        _showScaleLine = YES;
        _scaleLineCount = 7;
        _scaleLineStyles = @[@(ENUM_WGPOLYGONALRADAR_LINE_STYLE_DASH_LINE),
                             @(ENUM_WGPOLYGONALRADAR_LINE_STYLE_SOLID_LINE),
                             @(ENUM_WGPOLYGONALRADAR_LINE_STYLE_DASH_LINE),
                             @(ENUM_WGPOLYGONALRADAR_LINE_STYLE_SOLID_LINE),
                             @(ENUM_WGPOLYGONALRADAR_LINE_STYLE_DASH_LINE),
                             @(ENUM_WGPOLYGONALRADAR_LINE_STYLE_SOLID_LINE),
                             @(ENUM_WGPOLYGONALRADAR_LINE_STYLE_DASH_LINE)];
        _scaleLineColors = @[ColorBlack,
                             ColorBlack,
                             ColorBlack,
                             ColorBlack,
                             ColorBlack,
                             ColorBlack,
                             ColorBlack];
        _scaleLineWidths = @[@1.f,@1.f,@1.f,@1.f,@1.f,@1.f,@1.f];
        _scaleDashLineLengths = @[@4.f,@0.f,@8.f,@0.f,@20.f,@.0f,@40.f];
        _scaleDashLineSpacings = @[@2.f,@0.f,@4.f,@0.f,@10.f,@0.f,@20.f];
        
        //对称轴
        _showSymmetryAxis = YES;
        _symmetryAxisStyle = ENUM_WGPOLYGONALRADAR_LINE_STYLE_SOLID_LINE;
        _symmetryAxisColor = ColorBlue;
        _symmetryAxisWidth = 1.f;
        _symmetryAxisDashLineLength = 2.f;
        _symmetryAxisDashLineSpacing = 2.f;
        
        //刻度线间隔区颜色
        _showScaleLineSection = YES;
        _scaleLineSectionColors = @[ColorRed,
                                    ColorOrange,
                                    ColorYellow,
                                    ColorGreen,
                                    ColorCyan,
                                    ColorBlue,
                                    ColorPurple];
        
        _customBgImage = [UIImage imageNamed:@"custombg"];
        
        //标题
        _showTitleLabel = YES;
    }
    return self;
}

@end

@implementation WGPolygonalRadarStyleConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        //动画时长
        _animationDuration = 1.5f;
        
        //边框
        _showPolygonalBorder = YES;
        _borderStyleConfig = [WGPolygonalRadarBorderStyleConfig new];
        
        //填充
        _showPolygonalFill = YES;
        _fillStyleConfig = [WGPolygonalRadarFillStyleConfig new];
        
        //顶点
        _showPolygonalVertexIcon = YES;
        _vertexStyleConfig = [WGPolygonalRadarVertexStyleConfig new];
    }
    return self;
}

@end

@implementation WGPolygonalRadarBorderStyleConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _borderStyle = ENUM_WGPOLYGONALRADAR_LINE_STYLE_SOLID_LINE;
        _borderColor = ColorPurple;
        _borderWidth = 1.5f;
        _borderDashLineLength = 4.f;
        _borderDashLineSpacing = 1.f;
    }
    return self;
}

@end

@implementation WGPolygonalRadarFillStyleConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _fillStyle = ENUM_WGPOLYGONALRADAR_FILL_STYLE_GRADIENT_COLOR;
        _solidColor = ColorOrange;
        _gradientColors = @[ColorRed,
                            ColorOrange,
                            ColorYellow];
        
        CGFloat d = 1.f / _gradientColors.count;
        NSMutableArray *arrLocations = [NSMutableArray array];
        for (NSInteger i = 0; i < _gradientColors.count; i++) {
            [arrLocations addObject:@(i*d)];
        }
        
        _gradientLocations = @[@.25,@.5,@.75];
        _gradientStartPoint = CGPointMake(0.2, 0.2);
        _gradientEndPoint = CGPointMake(1, 1);
    }
    return self;
}

@end

@implementation WGPolygonalRadarVertexStyleConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _vertexStyle = ENUM_WGPOLYGONALRADAR_VERTEX_ICON_STYLE_HOLLOW_CIRCLE;
        _vertexColor = ColorPurple;
        _vertexCircleRadius = 5.f;
        _vertexHollowCircleWidth = 2.f;
    }
    return self;
}

@end
