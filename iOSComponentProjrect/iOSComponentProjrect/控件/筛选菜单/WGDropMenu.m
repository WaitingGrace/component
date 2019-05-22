//
//  WGDropMenu.m
//  
//
//  Created by 帅棋 on 17/10/26.
//  Copyright © 2017年 WaitingGrace. All rights reserved.
//

#import "WGDropMenu.h"
#import "NSArray+Bounds.h"
#import "NSString+Size.h"
#import "UIView+Extension.h"
#import "WGDropMenuModel.h"
#import "WGDropMenuTitleItem.h"
#import "WGDropMenuOptionCell.h"
#import "WGDropMenuFilterSectionHeader.h"
#import "WGDropMenuFilterSingleInputItem.h"
#import "WGDropMenuFilterInputItem.h"
#import "WGDropMenuFilterTagItem.h"
#import "WGDropMenuWaterFallCell.h"

#pragma mark - - - - -- - - - WGDropMenu 筛选菜单开始
/** 按钮类型 */
typedef NS_ENUM (NSUInteger,WGDropMenuButtonType) {
    /** 确定 */
    GHDropMenuButtonTypeSure = 1,
    /** 重置 */
    GHDropMenuButtonTypeReset,
};

typedef NS_ENUM (NSUInteger,WGDropMenuShowType) {
    GHDropMenuShowTypeCommon = 1,
    GHDropMenuShowTypeOnlyFilter,
};

@interface WGDropMenu()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate,WGDropMenuFilterTagItemDelegate,WGDropMenuFilterInputItemDelegate,WGDropMenuFilterSingleInputItemDelegate,WGDropMenuTitleItemDelegate,WGDropMenuFilterSectionHeaderDelegate>

/** 顶部菜单 */
@property (nonatomic , strong) UICollectionView *collectionView;
/** 顶部菜单布局 */
@property (nonatomic , strong) UICollectionViewFlowLayout *flowLayout;
/** 弹出菜单 */
@property (nonatomic , strong) UITableView *tableView;
/** 弹出菜单内容数组 */
@property (nonatomic , strong) NSArray *contents;
/** 菜单的高度 */
@property (nonatomic , assign) CGFloat menuHeight;
@property (nonatomic , strong) UIView *topLine;
@property (nonatomic , strong) UIView *bottomLine;
@property (nonatomic , strong) UIView *bottomView;
/** 弹出菜单选中index */
@property (nonatomic , assign) NSInteger currentIndex;
/** 筛选器 */
@property (nonatomic , strong) UICollectionView *filter;
@property (nonatomic , strong) UICollectionViewFlowLayout *filterFlowLayout;
/** 重置 */
@property (nonatomic , strong) UIButton *reset;
/** 确定 */
@property (nonatomic , strong) UIButton *sure;
/** 遮罩 */
@property (nonatomic , strong) UIControl *filterCover;

@property (nonatomic , strong) NSIndexPath *currentIndexPath;

@property (nonatomic , strong) UIControl *titleCover;

@property (nonatomic , strong) DropMenuTitleBlock dropMenuTitleBlock;

@property (nonatomic , strong) DropMenuTagArrayBlock dropMenuTagArrayBlock;

@property (nonatomic , assign) WGDropMenuShowType dropMenuShowType;
/** 标记菜单是否展开 */
@property (nonatomic , assign) BOOL isShow;


@end
@implementation WGDropMenu
#pragma mark - 初始化
+ (instancetype)creatDropFilterMenuWidthConfiguration: (WGDropMenuModel *)configuration
                                dropMenuTagArrayBlock: (DropMenuTagArrayBlock)dropMenuTagArrayBlock {
    WGDropMenu *dropMenu = [[WGDropMenu alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight)];
    dropMenu.dropMenuShowType = GHDropMenuShowTypeOnlyFilter;
    dropMenu.titles = configuration.titles.mutableCopy;
    dropMenu.dropMenuTagArrayBlock = dropMenuTagArrayBlock;
    [dropMenu setupFilterUI];
    return dropMenu;
}

#pragma mark - 初始化
+ (instancetype)creatDropMenuWithConfiguration: (WGDropMenuModel *)configuration frame: (CGRect)frame dropMenuTitleBlock: (DropMenuTitleBlock)dropMenuTitleBlock dropMenuTagArrayBlock: (DropMenuTagArrayBlock)dropMenuTagArrayBlock {
    WGDropMenu *dropMenu = [[WGDropMenu alloc]initWithFrame:CGRectMake(0, frame.origin.y, frame.size.width, frame.size.height)];
    dropMenu.configuration = configuration;
    dropMenu.menuHeight = frame.size.height;
    dropMenu.tableY = frame.origin.y + frame.size.height;
    dropMenu.dropMenuTitleBlock = dropMenuTitleBlock;
    dropMenu.dropMenuTagArrayBlock = dropMenuTagArrayBlock;
    dropMenu.dropMenuShowType = GHDropMenuShowTypeCommon;
    [dropMenu setupUI];
    return dropMenu;
}

#pragma mark - set方法
- (void)setDataSource:(id<WGDropMenuDataSource>)dataSource {
    _dataSource = dataSource;
    
    if (dataSource == nil) {
        return;
    }
    
    NSArray *tempArray = nil;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(columnTitlesInMeun:)]) {
        tempArray = [self.dataSource columnTitlesInMeun:self];
    }
    NSMutableArray *titles = [NSMutableArray array];
    for (NSInteger index = 0; index < tempArray.count; index++) {
        WGDropMenuModel *dropMenuModel = [[WGDropMenuModel alloc]init];
        dropMenuModel.title = [tempArray by_ObjectAtIndex:index];
        dropMenuModel.dropMenuType = WGDropMenuTypeTitle;
        dropMenuModel.indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
        dropMenuModel.identifier = index;
        [titles addObject:dropMenuModel];
    }
    self.titles = titles;
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(menu:numberOfColumns:)]) {
        for (NSInteger index = 0; index < titles.count; index++) {
            WGDropMenuModel *dropMenuTitleModel = [titles by_ObjectAtIndex:index];
            NSArray *temp = [self.dataSource menu:self numberOfColumns:index];
            
            NSMutableArray *dataArray = [NSMutableArray array];
            for (NSInteger j = 0; j < temp.count; j++) {
                WGDropMenuModel *dropMenuModel = [[WGDropMenuModel alloc]init];
                dropMenuModel.title = [temp by_ObjectAtIndex:j];
                [dataArray addObject: dropMenuModel];
            }
            dropMenuTitleModel.dataArray = dataArray;
        }
    }
    [self.collectionView reloadData];
}
- (void)setTitles:(NSMutableArray *)titles {
    _titles = titles;
    [self.tableView reloadData];
    [self.collectionView reloadData];
}
- (void)setTableY:(CGFloat)tableY {
    _tableY = tableY;
    self.tableView.y = tableY;
    self.titleCover.y = self.tableView.y;
}
- (void)setCellHeight:(CGFloat)cellHeight {
    _cellHeight = cellHeight;
}
- (void)setOptionNormalColor:(UIColor *)optionNormalColor {
    _optionNormalColor = optionNormalColor;
    for (WGDropMenuModel *dropMenuTitleModel in self.titles) {
        for (WGDropMenuModel *dropMenuOptionModel in dropMenuTitleModel.dataArray) {
            dropMenuOptionModel.optionNormalColor = optionNormalColor;
        }
    }
    [self.tableView reloadData];
}
- (void)setOptionSeletedColor:(UIColor *)optionSeletedColor {
    _optionSeletedColor = optionSeletedColor;
    for (WGDropMenuModel *dropMenuTitleModel in self.titles) {
        for (WGDropMenuModel *dropMenuOptionModel  in dropMenuTitleModel.dataArray) {
            dropMenuOptionModel.optionSeletedColor = optionSeletedColor;
        }
    }
    [self.tableView reloadData];
}
- (void)setOptionFont:(UIFont *)optionFont {
    _optionFont = optionFont;
    for (WGDropMenuModel *dropMenuTitleModel in self.titles) {
        for (WGDropMenuModel *dropMenuOptionModel  in dropMenuTitleModel.dataArray) {
            dropMenuOptionModel.optionFont = optionFont;
        }
    }
    [self.tableView reloadData];
}
- (void)setTitleNormalImageName:(NSString *)titleNormalImageName {
    _titleNormalImageName = titleNormalImageName;
    for (WGDropMenuModel *dropMenuTitleModel in self.titles) {
        dropMenuTitleModel.titleNormalImageName = titleNormalImageName;
    }
    [self.collectionView reloadData];
}
- (void)setTitleSeletedImageName:(NSString *)titleSeletedImageName {
    _titleSeletedImageName = titleSeletedImageName;
    for (WGDropMenuModel *dropMenuTitleModel in self.titles) {
        dropMenuTitleModel.titleSeletedImageName = titleSeletedImageName;
    }
    [self.collectionView reloadData];
}
- (void)setTitleSeletedColor:(UIColor *)titleSeletedColor {
    _titleSeletedColor = titleSeletedColor;
    for (WGDropMenuModel *dropMenuTitleModel in self.titles) {
        dropMenuTitleModel.titleSeletedColor = titleSeletedColor;
    }
    [self.collectionView reloadData];
}
- (void)setTitleNormalColor:(UIColor *)titleNormalColor {
    _titleNormalColor = titleNormalColor;
    for (WGDropMenuModel *dropMenuTitleModel in self.titles) {
        dropMenuTitleModel.titleNormalColor = titleNormalColor;
    }
    [self.collectionView reloadData];
}
- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    for (WGDropMenuModel *dropMenuTitleModel in self.titles) {
        dropMenuTitleModel.titleFont = titleFont;
    }
    [self.collectionView reloadData];
}
- (void)setTitleViewBackGroundColor:(UIColor *)titleViewBackGroundColor {
    for (WGDropMenuModel *dropMenuTitleModel in self.titles) {
        dropMenuTitleModel.titleViewBackGroundColor = titleViewBackGroundColor;
    }
    [self.collectionView reloadData];
}

- (void)setConfiguration:(WGDropMenuModel *)configuration {
    _configuration = configuration;
    self.titles = configuration.titles.copy;
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

#pragma mark - set方法 end
- (instancetype)new {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"请使用方法 creatDropMenuWithConfiguration: or creatDropFilterMenuWidthConfiguration: 代替初始化" userInfo:nil];
}
- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"请使用方法 creatDropMenuWithConfiguration: or creatDropFilterMenuWidthConfiguration: 代替初始化" userInfo:nil];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self defaultConfiguration];
    }
    return self;
}
- (void)defaultConfiguration {
    self.menuHeight = 44;
    self.currentIndex = 0;
    self.cellHeight = 44;
    self.isShow = NO;
}

#pragma mark - 消失
- (void)dismiss {
    
    WGDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex:self.currentIndex];
    self.filterCover.backgroundColor = [UIColor clearColor];
    self.titleCover.backgroundColor = [UIColor clearColor];
    if (dropMenuTitleModel.dropMenuType == WGDropMenuTypeOptionCollection /** 普通菜单 */) {
        self.sure.alpha = 0;
        self.reset.alpha = 0;
    }
    [UIView animateWithDuration:self.durationTime animations:^{
        if (dropMenuTitleModel.dropMenuType == WGDropMenuTypeTitle /** 普通菜单 */) {
            self.tableView.frame = CGRectMake(0, self.tableY , self.frame.size.width, 0);
            self.titleCover.frame = CGRectMake(0, self.tableY, ScreenWidth, 0);
        } else if (dropMenuTitleModel.dropMenuType == WHDropMenuTypeFilter /** 筛选菜单 */) {
            self.filterCover.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
            
        }  else if (dropMenuTitleModel.dropMenuType == WGDropMenuTypeOptionCollection) {
            self.filter.frame = CGRectMake(0, self.tableY, self.frame.size.width, 0);
            self.titleCover.frame = CGRectMake(0, self.tableY, ScreenWidth, 0);
            self.sure.frame = CGRectMake(0, CGRectGetMaxY(self.filter.frame), self.filter.width * 0.5, kFilterButtonHeight);
            self.reset.frame = CGRectMake(self.filter.width * .5, CGRectGetMaxY(self.filter.frame), self.filter.width * 0.5, kFilterButtonHeight);
        }
    } completion:^(BOOL finished) {
        if (self.dropMenuShowType == GHDropMenuShowTypeOnlyFilter) {
            [self.layer setOpacity:0.0];
        }
        self.isShow = NO;
        [self.tableView reloadData];
        [self.collectionView reloadData];
        
    }];
}
#pragma mark - 弹出
- (void)show {
    [self.tableView reloadData];
    [self.filter reloadData];
    self.sure.alpha = 0;
    self.reset.alpha = 0;
    if (self.dropMenuShowType == GHDropMenuShowTypeOnlyFilter) {
        [self.layer setOpacity:1];
    }
    WGDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex:self.currentIndex];
    if (dropMenuTitleModel.dropMenuType == WGDropMenuTypeTitle /** 筛选菜单 */) {
        self.titleCover.backgroundColor = [UIColor clearColor];
        self.filter.frame = CGRectMake(0, self.tableY, ScreenWidth, 0);
        
    } else if (dropMenuTitleModel.dropMenuType == WGDropMenuTypeOptionCollection) {
        self.tableView.frame = CGRectMake(0, self.tableY, self.frame.size.width, 0);
        [kKeyWindow addSubview:self.filter];
        
        self.filter.frame =  CGRectMake(0, self.tableY, self.frame.size.width, 0);
        [kKeyWindow addSubview:self.sure];
        [kKeyWindow addSubview:self.reset];
        self.reset.frame = CGRectMake(0, CGRectGetMaxY(self.filter.frame), ScreenWidth * 0.5, kFilterButtonHeight);
        self.sure.frame = CGRectMake(ScreenWidth * .5, CGRectGetMaxY(self.filter.frame), ScreenWidth * 0.5, kFilterButtonHeight);
        self.sure.alpha = 1;
        self.reset.alpha = 1;
        
    } else if (dropMenuTitleModel.dropMenuType == WHDropMenuTypeFilter) {
        [self dismiss];
        [kKeyWindow addSubview:self.filterCover];
        [self.filterCover addSubview:self.filter];
        self.filter.frame = CGRectMake(ScreenWidth * 0.1, 0, ScreenWidth * 0.9, ScreenHeight - kFilterButtonHeight - SafeAreaBottomHeight);
        [self.filterCover addSubview:self.sure];
        [self.filterCover addSubview:self.reset];
        self.reset.frame = CGRectMake(self.filter.x, self.filter.frame.size.height, self.filter.width * 0.5, kFilterButtonHeight);
        self.sure.frame = CGRectMake(self.filter.frame.size.width * 0.5 +ScreenWidth * 0.1 , CGRectGetMaxY(self.filter.frame), self.filter.width * 0.5, kFilterButtonHeight);
        self.sure.alpha = 1;
        self.reset.alpha = 1;
    }
    [UIView animateWithDuration:self.durationTime animations:^{
        if (dropMenuTitleModel.dropMenuType == WGDropMenuTypeTitle /** 普通菜单 */) {
            self.tableView.frame = CGRectMake(0, self.tableY, self.frame.size.width, dropMenuTitleModel.dataArray.count * self.cellHeight);
            self.titleCover.frame = CGRectMake(0, self.tableY, ScreenWidth, ScreenHeight - self.menuHeight - SafeAreaTopHeight);
            
        } else if (dropMenuTitleModel.dropMenuType == WHDropMenuTypeFilter /** 筛选菜单 */) {
            self.tableView.frame = CGRectMake(0, self.tableY, self.frame.size.width, 0);
            self.titleCover.frame = CGRectMake(0, self.tableY, self.frame.size.width, 0);
            self.filterCover.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        }  else if (dropMenuTitleModel.dropMenuType == WGDropMenuTypeOptionCollection /** 筛选菜单 */) {
            self.filter.frame =  CGRectMake(0, self.tableY, self.frame.size.width, 500);
            self.titleCover.frame = CGRectMake(0, self.tableY, ScreenWidth, ScreenHeight - self.menuHeight - SafeAreaTopHeight);
            
            self.reset.frame = CGRectMake(0, CGRectGetMaxY(self.filter.frame), self.filter.width * 0.5, kFilterButtonHeight);
            self.sure.frame = CGRectMake(self.filter.width * .5, CGRectGetMaxY(self.filter.frame), self.filter.width * 0.5, kFilterButtonHeight);
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            if (dropMenuTitleModel.dropMenuType == WHDropMenuTypeFilter /** 筛选菜单 */) {
                self.filterCover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];
            } else if (dropMenuTitleModel.dropMenuType == WGDropMenuTypeTitle) {
                self.titleCover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];
            } else if (dropMenuTitleModel.dropMenuType == WGDropMenuTypeOptionCollection) {
                self.titleCover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];
            }
        } completion:^(BOOL finished) {
            self.isShow = YES;
        }];
    }];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, ScreenWidth, self.menuHeight);
    self.topLine.frame = CGRectMake(0, 0, ScreenWidth, 1);
    self.bottomLine.frame = CGRectMake(0, self.menuHeight - 1, ScreenWidth, 1);
    self.tableView.frame = CGRectMake(0, self.tableY, self.frame.size.width, 0);
}
#pragma mark - 创建UI 添加控件
- (void)setupUI {
    [self addSubview:self.collectionView];
    [kKeyWindow addSubview:self.filterCover];
    [kKeyWindow addSubview:self.titleCover];
    [self.titleCover addSubview:self.sure];
    [self.titleCover addSubview:self.reset];
    [self.filterCover addSubview:self.filter];
    [self.filterCover addSubview:self.bottomView];
    [self.filterCover addSubview:self.sure];
    [self.filterCover addSubview:self.reset];
    [self.collectionView addSubview:self.bottomLine];
    [kKeyWindow addSubview:self.tableView];
}

- (void)setupFilterUI {
    [kKeyWindow addSubview:self];
    [self addSubview:self.filterCover];
    [self.filterCover addSubview:self.filter];
    [self.filterCover addSubview:self.bottomView];
    [self.filterCover addSubview:self.sure];
    [self.filterCover addSubview:self.reset];
}
- (void)closeMenu {
    
    [self.tableView removeFromSuperview];
    [self.titleCover removeFromSuperview];
    [self.filter removeFromSuperview];
    [self.filterCover removeFromSuperview];
    [self.sure removeFromSuperview];
    [self.reset removeFromSuperview];
    [self.collectionView removeFromSuperview];
}
/** 重置menu 状态 */
- (void)resetMenuStatus {
    for (WGDropMenuModel *dropMenuModel in self.titles) {
        dropMenuModel.titleSeleted = NO;
    }
    [self.filter reloadData];
    [self.collectionView reloadData];
    [self dismiss];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self resetMenuStatus];
}
- (void)dropMenuFilterSingleInputItem:(WGDropMenuFilterSingleInputItem *)item
                        dropMenuModel:(WGDropMenuModel *)dropMenuModel {
    WGDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex: self.currentIndex];
    WGDropMenuModel *dropMenuSectionModel = [dropMenuTitleModel.sections by_ObjectAtIndex: dropMenuModel.indexPath.section];
    WGDropMenuModel *dropMenuTagModel = [dropMenuSectionModel.dataArray by_ObjectAtIndex:dropMenuModel.indexPath.row];
    dropMenuTagModel.singleInput = dropMenuModel.singleInput;
}

- (void)dropMenuFilterEndInputItem:(WGDropMenuFilterInputItem *)item dropMenuModel:(WGDropMenuModel *)dropMenuModel {
    if (dropMenuModel.minPrice.length && dropMenuModel.maxPrice.length) {
        if (dropMenuModel.minPrice.doubleValue > dropMenuModel.maxPrice.doubleValue) {
            
            if (@available(iOS 9.0, *)) {
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"最小价格不能大于最大价格,请重新选择" preferredStyle:(UIAlertControllerStyleAlert)];
                [alertController addAction:[UIAlertAction actionWithTitle:@"我知道了" style:(UIAlertActionStyleCancel) handler:nil]];
                UIApplication *ap = [UIApplication sharedApplication];
                [ap.keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
            }
//            else {
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"最小价格不能大于最大价格,请重新选择" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
//                [alert show];
//            }
            
            dropMenuModel.minPrice = @"";
            dropMenuModel.maxPrice = @"";
            [self.filter reloadData];
        }
    }
}
- (void)dropMenuFilterInputItem:(WGDropMenuFilterInputItem *)item
                  dropMenuModel:(WGDropMenuModel *)dropMenuModel {
    
    WGDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex: self.currentIndex];
    WGDropMenuModel *dropMenuSectionModel = [dropMenuTitleModel.sections by_ObjectAtIndex: dropMenuModel.indexPath.section];
    WGDropMenuModel *dropMenuTagModel = [dropMenuSectionModel.dataArray by_ObjectAtIndex:dropMenuModel.indexPath.row];
    dropMenuTagModel.minPrice = dropMenuModel.minPrice;
    dropMenuTagModel.maxPrice = dropMenuModel.maxPrice;
}

- (void)dropMenuFilterSectionHeader:(WGDropMenuFilterSectionHeader *)header
                      dropMenuModel:(WGDropMenuModel *)dropMenuModel {
    dropMenuModel.sectionSeleted = !dropMenuModel.sectionSeleted;
    [self.filter reloadData];
}

#pragma mark - tag标签点击方法
- (void)dropMenuFilterTagItem:(WGDropMenuFilterTagItem *)item
                dropMenuModel:(WGDropMenuModel *)dropMenuModel {
    WGDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex: self.currentIndex];
    WGDropMenuModel *dropMenuSectionModel = [dropMenuTitleModel.sections by_ObjectAtIndex: dropMenuModel.indexPath.section];
    /** 处理多选 单选*/
    [self actionMultipleWithDropMenuModel:dropMenuModel dropMenuSectionModel:dropMenuSectionModel];
    /** 处理sectionDetails */
    [self actionSectionHeaderDetailsWithDropMenuModel:dropMenuModel dropMenuSectionModel:dropMenuSectionModel];
    [self.filter reloadData];
}

#pragma mark - 处理sectionHeaderDetails
- (void)actionSectionHeaderDetailsWithDropMenuModel: (WGDropMenuModel *)dropMenuModel
                               dropMenuSectionModel: (WGDropMenuModel *)dropMenuSectionModel {
    
    NSMutableString *details = [NSMutableString string];
    for (WGDropMenuModel *dropMenuTagModel in dropMenuSectionModel.dataArray) {
        if (dropMenuTagModel.tagSeleted) {
            [details appendFormat:@"%@,", dropMenuTagModel.tagName];
        }
    }
    if (details.length) {
        [details deleteCharactersInRange:NSMakeRange(details.length - 1, 1)];
    }
    dropMenuSectionModel.sectionHeaderDetails = details;
}
#pragma mark - 处理单选 多选
- (void)actionMultipleWithDropMenuModel: (WGDropMenuModel *)dropMenuModel
                   dropMenuSectionModel: (WGDropMenuModel *)dropMenuSectionModel {
    
    /** 处理单选 */
    NSString *currentSeletedStr = [NSString string];
    if (dropMenuSectionModel.isMultiple) {
        
    } else {
        for (WGDropMenuModel *dropMenuTagModel in dropMenuSectionModel.dataArray) {
            if (dropMenuTagModel.tagSeleted) {
                currentSeletedStr = dropMenuTagModel.tagName;
            }
            dropMenuTagModel.tagSeleted = NO;
        }
    }
    if (self.currentIndexPath != dropMenuModel.indexPath /** 不是第一次选中 */) {
        if ([currentSeletedStr isEqualToString:dropMenuModel.tagName]) {
            dropMenuModel.tagSeleted = NO;
        } else {
            dropMenuModel.tagSeleted = !dropMenuModel.tagSeleted ;
        }
        self.currentIndexPath = dropMenuModel.indexPath;
    } else {
        if ([currentSeletedStr isEqualToString:dropMenuModel.tagName]) {
            if (dropMenuSectionModel.isMultiple) {
                dropMenuModel.tagSeleted = YES;
            } else {
                dropMenuModel.tagSeleted = NO;
            }
        } else {
            dropMenuModel.tagSeleted = !dropMenuModel.tagSeleted ;
        }
        self.currentIndexPath = nil;
    }
    
}

#pragma mark - 点击顶部titleView 代理回调
- (void)dropMenuTitleItem: (WGDropMenuTitleItem *)item
            dropMenuModel: (WGDropMenuModel *)dropMenuModel {
    
    dropMenuModel.titleSeleted = !dropMenuModel.titleSeleted;
    self.currentIndex = dropMenuModel.indexPath.row;
    
    if (dropMenuModel.titleSeleted) {
        self.contents = dropMenuModel.dataArray.copy;
        for (WGDropMenuModel *model in self.titles) {
            if (model.identifier != dropMenuModel.identifier) {
                model.titleSeleted = NO;
            }
        }
        
        [self show];
    } else {
        [self dismiss];
    }
    
    [self.collectionView reloadData];
}

#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WGDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex:self.currentIndex];
    
    if (dropMenuTitleModel.dropMenuType == WGDropMenuTypeWaterFall) {
        WGDropMenuWaterFallCell *cell = (WGDropMenuWaterFallCell *)[tableView.dataSource tableView:self.tableView cellForRowAtIndexPath:indexPath];
        return [cell getCellHeight];
    } else {
        return 44;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WGDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex:self.currentIndex];
    
    WGDropMenuModel *dropMenuModel = [dropMenuTitleModel.dataArray by_ObjectAtIndex: indexPath.row];
    dropMenuModel.indexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:dropMenuTitleModel.indexPath.row];
    
    if (dropMenuTitleModel.dropMenuType == WGDropMenuTypeWaterFall) {
        WGDropMenuWaterFallCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WGDropMenuWaterFallCellID"];
        cell.tags = [NSMutableArray arrayWithArray:dropMenuModel.waterFallTags];
        return cell;
  
    } else {
        NSString *cellIdentifier = [NSString stringWithFormat:@"WGDropMenuOptionCellID%ld%ld%ld",indexPath.section,indexPath.row,(long)dropMenuTitleModel.identifier];
        
        WGDropMenuOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[WGDropMenuOptionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        cell.dropMenuModel = dropMenuModel;
        return cell;
    }
    return [UITableViewCell new];

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WGDropMenuModel *dropMenuModel = [self.titles by_ObjectAtIndex: self.currentIndex];
    for (WGDropMenuModel *dropMenuContentModel in dropMenuModel.dataArray) {
        dropMenuContentModel.cellSeleted = NO;
    }
    WGDropMenuModel *contentModel = [dropMenuModel.dataArray by_ObjectAtIndex:indexPath.row];
    if (self.configuration.recordSeleted) {
        dropMenuModel.title = contentModel.title;
    }
    
    contentModel.cellSeleted = !contentModel.cellSeleted;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenu:dropMenuTitleModel:)]) {
        [self.delegate dropMenu:self dropMenuTitleModel:contentModel];
    }
    
    if (self.dropMenuTitleBlock) {
        self.dropMenuTitleBlock(contentModel);
    }
    
    [self resetMenuStatus];
}
#pragma mark - collectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section  {
    if (self.filter == collectionView) {
        return CGSizeMake(ScreenWidth * 0.8, 10);
    } else {
        return CGSizeZero;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (self.filter == collectionView) {
        return CGSizeMake(ScreenWidth * 0.8, 44);
    } else {
        return CGSizeZero;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    WGDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex:self.currentIndex];
    WGDropMenuModel *dropMenuSectionModel = [dropMenuTitleModel.sections by_ObjectAtIndex:indexPath.section];
    dropMenuSectionModel.indexPath = indexPath;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && self.filter == collectionView) {
        WGDropMenuFilterSectionHeader *header  = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"WGDropMenuFilterSectionHeaderID" forIndexPath:indexPath];
        header.dropMenuModel = dropMenuSectionModel;
        header.delegate = self;
        return header;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter] && self.filter == collectionView) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableViewID" forIndexPath:indexPath];
    } else {
        return [UICollectionReusableView new];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    WGDropMenuModel *dropMenuModel = [self.titles by_ObjectAtIndex: self.currentIndex];
    
    if (collectionView == self.collectionView) {
        return CGSizeMake(ScreenWidth /self.titles.count, self.menuHeight - 0.01f);
    } else if (collectionView == self.filter) {
        WGDropMenuModel *dropMenuSectionModel = [dropMenuModel.sections by_ObjectAtIndex:indexPath.section];
        if (dropMenuSectionModel.filterCellType == WGDropMenuFilterCellTypeTag) {
            return CGSizeMake((dropMenuModel.menuWidth - (dropMenuModel.sectionCount + 1) * 10) /dropMenuModel.sectionCount , 30.01f);
        } else if (dropMenuSectionModel.filterCellType == WGDropMenuFilterCellTypeInput ||
                   dropMenuSectionModel.filterCellType == WGDropMenuFilterCellTypeSingleInput) {
            return CGSizeMake(dropMenuModel.menuWidth - (dropMenuModel.sectionCount -1) * 10,30.01f);
        } else if (dropMenuSectionModel.filterCellType == WGDropMenuFilterCellTypeTagCollection) {
            return CGSizeMake((dropMenuModel.menuWidth - (dropMenuModel.sectionCount + 1) * 10) / (dropMenuModel.sectionCount + 1), 30.01f);
        } else {
            return CGSizeZero;
        }
    } else {
        return CGSizeZero;
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    WGDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex: self.currentIndex];
    if (self.filter == collectionView) {
        return dropMenuTitleModel.sections.count;
    } else if (collectionView == self.collectionView){
        
        return 1;
    } else {
        
        return 0;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.collectionView == collectionView) {
        return self.titles.count;
    } else if (self.filter == collectionView) {
        WGDropMenuModel *dropMenuModel = [self.titles by_ObjectAtIndex: self.currentIndex];
        WGDropMenuModel *dropMenuSectionModel = [dropMenuModel.sections by_ObjectAtIndex: section];
        if (dropMenuSectionModel.filterCellType == WGDropMenuFilterCellTypeTag) {
            return dropMenuSectionModel.sectionSeleted ? dropMenuSectionModel.dataArray.count:dropMenuSectionModel.dataArray.count > 3 ? 3:dropMenuSectionModel.dataArray.count;
        } else if (dropMenuSectionModel.filterCellType == WGDropMenuFilterCellTypeInput ||
                   dropMenuSectionModel.filterCellType == WGDropMenuFilterCellTypeSingleInput) {
            return 1;
        } else {
            return dropMenuSectionModel.dataArray.count;
        }
    } else {
        return 0;
    }
}
#pragma mark - - - 返回collectionView item
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.collectionView) {
        NSString *identifier = [NSString stringWithFormat:@"WGDropMenuTitleItemID%ld%ld",(long)indexPath.section,(long)indexPath.row];
        [collectionView registerClass:[WGDropMenuTitleItem class] forCellWithReuseIdentifier:identifier];
        WGDropMenuModel *dropMenuModel = [self.titles by_ObjectAtIndex:indexPath.row];
        dropMenuModel.indexPath = indexPath;
        WGDropMenuTitleItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.dropMenuModel = dropMenuModel;
        cell.delegate = self;
        return cell;
    } else if (collectionView == self.filter) {
        NSString *identifier = [NSString stringWithFormat:@"WGDropMenuFilterTagItemID%ld%ld",(long)indexPath.section,(long)indexPath.row];
        [self.filter registerClass:[WGDropMenuFilterTagItem class] forCellWithReuseIdentifier:identifier];
        
        WGDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex: self.currentIndex];
        WGDropMenuModel *dropMenuSectionModel = [dropMenuTitleModel.sections by_ObjectAtIndex: indexPath.section];
        WGDropMenuModel *dropMenuTagModel = [dropMenuSectionModel.dataArray by_ObjectAtIndex: indexPath.row];
        dropMenuTagModel.indexPath = indexPath;
        if (dropMenuSectionModel.filterCellType == WGDropMenuFilterCellTypeTag) {
            WGDropMenuFilterTagItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
            cell.dropMenuModel = dropMenuTagModel;
            cell.delegate = self;
            return cell;
        } else if (dropMenuSectionModel.filterCellType == WGDropMenuFilterCellTypeInput) {
            WGDropMenuFilterInputItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WGDropMenuFilterInputItemID" forIndexPath:indexPath];
            cell.dropMenuModel = dropMenuTagModel;
            cell.delegate = self;
            return cell;
        } else if (dropMenuSectionModel.filterCellType == WGDropMenuFilterCellTypeSingleInput) {
            WGDropMenuFilterSingleInputItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WGDropMenuFilterSingleInputItemID" forIndexPath:indexPath];
            cell.dropMenuModel = dropMenuTagModel;
            cell.delegate = self;
            return cell;
        }  else  {
            return [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
        }
    } else {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCellID" forIndexPath:indexPath];
    }
}

- (void)tap:(UITapGestureRecognizer *)gesture {
    [self resetMenuStatus];
}

- (void)clickButton: (UIButton *)button {
    WGDropMenuModel *dropMenuTitleModel = [self.titles by_ObjectAtIndex:self.currentIndex];
    if (button.tag == GHDropMenuButtonTypeSure) {
        NSMutableArray *dataArray = [NSMutableArray array];
        for (WGDropMenuModel *dropMenuSectionModel in dropMenuTitleModel.sections) {
            for (WGDropMenuModel *dropMenuTagModel in dropMenuSectionModel.dataArray) {
                if (dropMenuTagModel.tagSeleted) {
                    [dataArray addObject:dropMenuTagModel];
                }
                if (dropMenuSectionModel.filterCellType == WGDropMenuFilterCellTypeInput ||
                    dropMenuSectionModel.filterCellType == WGDropMenuFilterCellTypeSingleInput) {
                    [dataArray addObject:dropMenuTagModel];
                }
            }
        }
        [self resetMenuStatus];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(dropMenu:tagArray:)]) {
            [self.delegate dropMenu:self tagArray:dataArray.copy];
        }
        if (self.dropMenuTagArrayBlock) {
            self.dropMenuTagArrayBlock(dataArray.copy);
        }
    } else if (button.tag == GHDropMenuButtonTypeReset){
        for (WGDropMenuModel *dropMenuSectionModel in dropMenuTitleModel.sections) {
            dropMenuSectionModel.sectionHeaderDetails = @"";
            for (WGDropMenuModel *dropMenuTagModel in dropMenuSectionModel.dataArray) {
                dropMenuTagModel.tagSeleted = NO;
                dropMenuTagModel.minPrice = @"";
                dropMenuTagModel.maxPrice = @"";
            }
        }
        [self.filter reloadData];
    }
}
- (void)clickControl {
    [self resetMenuStatus];
}
#pragma mark - 懒加载
- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.frame = CGRectMake(self.filter.frame.origin.x, self.filter.frame.size.height + self.filter.frame.origin.y + kFilterButtonHeight,self.filter.frame.size.width , SafeAreaBottomHeight);
    }
    return _bottomView;
}
- (UIControl *)titleCover {
    if (_titleCover == nil) {
        _titleCover = [[UIControl alloc]init];
        _titleCover.frame = CGRectMake(0, self.frame.size.height + SafeAreaTopHeight, ScreenWidth, 0);
        [_titleCover addTarget:self action:@selector(clickControl) forControlEvents:UIControlEventTouchUpInside];
        _titleCover.backgroundColor = [UIColor clearColor];
    }
    return _titleCover;
}
- (UIControl *)filterCover {
    if (_filterCover == nil) {
        _filterCover = [[UIControl alloc]init];
        _filterCover.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
        [_filterCover addTarget:self action:@selector(clickControl) forControlEvents:UIControlEventTouchUpInside];
        _filterCover.backgroundColor = [UIColor clearColor];
    }
    return _filterCover;
}
- (UIButton *)reset {
    if (_reset == nil) {
        _reset = [[UIButton alloc]init];
        _reset.frame = CGRectMake(self.filter.frame.origin.x, self.filter.frame.size.height, self.filter.frame.size.width * 0.5, kFilterButtonHeight);
        _reset.backgroundColor = [UIColor whiteColor];
        [_reset setTitle:@"重置" forState:UIControlStateNormal];
        [_reset setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_reset addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _reset.tag = GHDropMenuButtonTypeReset;
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor lightGrayColor];
        line.alpha = .1;
        line.frame = CGRectMake(0, 0, _reset.frame.size.width, 1);
        [_reset addSubview:line];
        _reset.alpha = 0;
    }
    return _reset;
}
- (UIButton *)sure {
    if (_sure == nil) {
        _sure = [[UIButton alloc]init];
        _sure.frame = CGRectMake(ScreenWidth - self.filter.frame.size.width * 0.5, self.filter.frame.size.height, self.filter.frame.size.width * 0.5, kFilterButtonHeight);
        _sure.backgroundColor = [UIColor orangeColor];
        [_sure setTitle:@"确定" forState:UIControlStateNormal];
        [_sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sure.tag = GHDropMenuButtonTypeSure;
        [_sure addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _sure.alpha = 0;
    }
    return _sure;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.tableY, 0, 0) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[WGDropMenuOptionCell class] forCellReuseIdentifier:@"WGDropMenuOptionCellID"];
        [_tableView registerClass:[WGDropMenuWaterFallCell class] forCellReuseIdentifier:@"WGDropMenuWaterFallCellID"];
    }
    return _tableView;
}
- (UICollectionViewFlowLayout *)filterFlowLayout {
    if (_filterFlowLayout == nil) {
        _filterFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        _filterFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _filterFlowLayout.minimumLineSpacing = 10.01f;
        _filterFlowLayout.minimumInteritemSpacing = 10.01f;
    }
    return _filterFlowLayout;
}
- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 0.01f;
        _flowLayout.minimumInteritemSpacing = 0.01f;
    }
    return _flowLayout;
}
- (UICollectionView *)filter {
    if (_filter == nil) {
        _filter = [[UICollectionView alloc]initWithFrame:CGRectMake(ScreenWidth * 0.1, 0, ScreenWidth * 0.9, ScreenHeight - kFilterButtonHeight - SafeAreaBottomHeight) collectionViewLayout:self.filterFlowLayout];
        _filter.delegate = self;
        _filter.dataSource = self;
        _filter.contentInset = UIEdgeInsetsMake(20, 10, 0, 10);
        _filter.backgroundColor = [UIColor whiteColor];
        [_filter registerClass:[WGDropMenuFilterTagItem class] forCellWithReuseIdentifier:@"WGDropMenuFilterTagItemID"];
        [_filter registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
        [_filter registerClass:[WGDropMenuFilterSectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WGDropMenuFilterSectionHeaderID"];
        [_filter registerClass:[WGDropMenuFilterInputItem class] forCellWithReuseIdentifier:@"WGDropMenuFilterInputItemID"];
        [_filter registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableViewID"];
        [_filter registerClass:[WGDropMenuFilterSingleInputItem class] forCellWithReuseIdentifier:@"WGDropMenuFilterSingleInputItemID"];
    }
    return _filter;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, self.menuHeight) collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.layer.borderColor = [UIColor clearColor].CGColor;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCellID"];
        [_collectionView registerClass:[WGDropMenuTitleItem class] forCellWithReuseIdentifier:@"WGDropMenuTitleItemID"];
    }
    return _collectionView;
}


- (UIView *)bottomLine {
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = [UIColor darkGrayColor];
        _bottomLine.alpha = .1;
    }
    return _bottomLine;
}
- (UIView *)topLine {
    if (_topLine == nil) {
        _topLine = [[UIView alloc]init];
        _topLine.backgroundColor = [UIColor darkGrayColor];
        _topLine.alpha = .1;
    }
    return _topLine;
}

- (void)dealloc {
    NSLog(@"释放了");
}
@end
