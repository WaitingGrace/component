//
//  WGLinkageSheetRightCell.h
//

#import "WGBaseTableViewCell.h"

@protocol WGLinkageSheetRightCellDataSourse <NSObject>

- (UIView *)createRightItemWithContentView:(UIView *)contentView indexPath:(NSIndexPath *)indexPath itemIndex:(NSInteger)itemIndex;

@end

@interface WGLinkageSheetRightCell : WGBaseTableViewCell

@property (nonatomic, assign) NSInteger itemCount;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) BOOL showBorder;

@property (nonatomic, weak) id<WGLinkageSheetRightCellDataSourse> dataSourse;

@end
