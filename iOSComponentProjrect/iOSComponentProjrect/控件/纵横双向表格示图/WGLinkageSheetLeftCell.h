//
//  WGLinkageSheetLeftCell.h
//

#import "WGBaseTableViewCell.h"

@protocol WGLinkageSheetLeftCellDataSourse <NSObject>

- (UIView *)createLeftItemWithContentView:(UIView *)contentView indexPath:(NSIndexPath *)indexPath;

@end

@interface WGLinkageSheetLeftCell : WGBaseTableViewCell

@property (nonatomic, weak) id<WGLinkageSheetLeftCellDataSourse> dataSourse;

@property (nonatomic, assign) BOOL showBorder;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat cellWidth;

@end
