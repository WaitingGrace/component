//
//  WGLinkageSheetRightItem.m
//

#import "WGLinkageSheetRightItem.h"

@interface WGLinkageSheetRightItem ()

@property (nonatomic, weak) UIView *rightLine;
@property (nonatomic, weak) UIView *bottomLine;

@end

@implementation WGLinkageSheetRightItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        _lineWidth = 1.0f;
    }
    
    return self;
}

- (void)setupUI {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(width - _lineWidth, 0, _lineWidth, height)];
    rightLine.hidden = YES;
    self.rightLine = rightLine;
    [self addSubview:rightLine];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, height - _lineWidth, width - _lineWidth, _lineWidth)];
    bottomLine.hidden = YES;
    self.bottomLine = bottomLine;
    [self addSubview:bottomLine];
    
}

- (void)setShowBorder:(BOOL)showBorder {
    _showBorder = showBorder;
    _rightLine.hidden = !showBorder;
    _bottomLine.hidden = !showBorder;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    _rightLine.backgroundColor = lineColor;
    _bottomLine.backgroundColor = lineColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    _rightLine.frame = CGRectMake(width - _lineWidth, 0, _lineWidth, height);
    _bottomLine.frame = CGRectMake(0, height - _lineWidth, width - _lineWidth, _lineWidth);
    
}

@end
