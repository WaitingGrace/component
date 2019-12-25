//
//  WGBaseTableViewCell.m
//

#import "WGBaseTableViewCell.h"

@implementation WGBaseTableViewCell

+ (instancetype _Nullable )createCellWithTableView:(UITableView *_Nullable)tableView {
    
    NSString *reuseIdentifier = NSStringFromClass([self class]);
    WGBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault
                          reuseIdentifier:reuseIdentifier];
        cell.tableView = tableView;
    }
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCellStyle];
        [self setupUI];
    }
    return self;
}

#pragma mark - 设置控件约束
- (void)setupUI {
    
}

#pragma mark - 修改cell属性
- (void)setupCellStyle {
    
}

@end
