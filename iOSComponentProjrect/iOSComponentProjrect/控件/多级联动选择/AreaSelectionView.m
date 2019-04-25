//
//  AreaSelectionView.m
//  IMHJM
//
//  Created by 帅棋 on 2018/7/9.
//  Copyright © 2018年 xinyihua. All rights reserved.
//

#import "AreaSelectionView.h"
#import "Config.h"
#import "WGAddressTableViewcell.h"
#import "WGAddressModel.h"
#import "WGAddressBtnView.h"

static  CGFloat  const  kWGTopViewHeight = 40; //顶部标题视图的高度
static  CGFloat  const  kWGTopTabbarHeight = 40; //地址标签栏的高度
@interface AreaSelectionView ()
@property (nonatomic ,strong) WGAddressBtnView *topTabbar;
@property (nonatomic ,strong) UIView           *baseView;
@property (nonatomic ,assign) CGFloat           baseViewHeight;
@property (nonatomic ,strong) UITableView      *tableView;
@property (nonatomic ,strong) NSMutableArray   *topTabbarItems;
@property (nonatomic ,strong) UIButton         *selectedBtn;
@property (nonatomic ,strong) NSArray          *dataArray;
@property (nonatomic ,strong) NSArray          *cityDataSouce;
@property (nonatomic ,strong) NSArray          *districtDataSouce;
@property (nonatomic ,strong) NSArray          *levels;
@property (nonatomic ,copy)   NSString         *level;
@property (nonatomic ,copy)   NSString         *province;//省
@property (nonatomic ,copy)   NSString         *city;//市
@property (nonatomic ,copy)   NSString         *county;//县区
@property (nonatomic ,copy)   NSString         *areaStr;
@end
@implementation AreaSelectionView
- (void)reloadDataWith:(NSArray *)dataArray level:(NSString *)level{
    self.level = level;
    if ([level isEqualToString:@"1"]) {
        self.dataArray = dataArray;
    }
    if ([level isEqualToString:@"2"]) {
        self.cityDataSouce = dataArray;
    }
    if ([level isEqualToString:@"3"]) {
        self.districtDataSouce = dataArray;
    }
    if ([level isEqualToString:@"4"]) {
        
    }
    if ([level isEqualToString:@"5"]) {
        
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationLeft)];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:(UITableViewScrollPositionNone) animated:NO];
}
#pragma amrk ---- 懒加载
- (WGAddressBtnView *)topTabbar{
    if (_topTabbar == nil) {
        _topTabbar = [[WGAddressBtnView alloc]init];
    }
    return _topTabbar;
}
- (UIView *)baseView{
    if (_baseView == nil) {
        _baseView = [[UIView alloc]init];
        _baseView.backgroundColor = BackColor;
    }
    return _baseView;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BackColor;
        [_tableView registerClass:[WGAddressTableViewcell class] forCellReuseIdentifier:@"WGAddressTableViewcell"];
    }
    return _tableView;
}
#pragma mark ---- 初始化
- (instancetype)init{
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

/**
 视图设置
 */
- (void)setupView{
    self.areaStr = [[NSMutableString alloc]init];
    self.topTabbarItems = [NSMutableArray array];
    self.baseViewHeight = iPhoneXAll?(ScreenHeight*0.4+44):(ScreenHeight*0.4);//内容视图总高度
    UIView * tapView = [[UIView alloc]init];
    tapView.backgroundColor = [UIColor clearColor];
    [self addSubview:tapView];
    [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo((iPhoneXAll?ScreenHeight+44:ScreenHeight) - self.baseViewHeight);
    }];
    UITapGestureRecognizer * sigleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [sigleTap setNumberOfTapsRequired:1];
    [tapView addGestureRecognizer:sigleTap];
    
    self.backgroundColor = RGBA(0, 0, 0, 0.4);
    UIView * topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.baseView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(kWGTopViewHeight);
    }];
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"请选择您所在地区";
    [titleLabel sizeToFit];
    [topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
    UIView * separateLine = [[UIView alloc]init];
    separateLine.backgroundColor = BackColor;
    [topView addSubview: separateLine];
    [separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    [self.baseView addSubview:self.topTabbar];
    [self.topTabbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(kWGTopViewHeight);
        make.height.mas_equalTo(kWGTopTabbarHeight);
    }];
    [self addTopBarItem];
    [self.baseView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(kWGTopViewHeight+kWGTopTabbarHeight+1);
    }];
}

/**
 添加按钮视图
 */
- (void)addTopBarItem {
    UIButton * topBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
    topBarItem.tag = 101+[self.level integerValue];
    [topBarItem setTitle:@"请选择" forState:UIControlStateNormal];
    [topBarItem setTitleColor:RGB(43, 43, 43) forState:UIControlStateNormal];
    [topBarItem setTitleColor:RGB(255, 85, 0) forState:UIControlStateSelected];
    [topBarItem sizeToFit];
    [self.topTabbarItems addObject:topBarItem];
    [self.topTabbar addSubview:topBarItem];
    [topBarItem addTarget:self action:@selector(topBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark ----
#pragma maek ----
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.level isEqualToString:@"1"]) {
        return self.dataArray.count;
    }
    if ([self.level isEqualToString:@"2"]) {
        return self.cityDataSouce.count;
    }
    if ([self.level isEqualToString:@"3"]) {
        return self.districtDataSouce.count;
    }
    if ([self.level isEqualToString:@"4"]) {
        
    }
    if ([self.level isEqualToString:@"5"]) {
        
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WGAddressTableViewcell * cell = [tableView dequeueReusableCellWithIdentifier:@"WGAddressTableViewcell"];
    if ([self.level isEqualToString:@"1"]) {
        cell.model = self.dataArray[indexPath.row];
    }
    if ([self.level isEqualToString:@"2"]) {
        cell.model = self.cityDataSouce[indexPath.row];
    }
    if ([self.level isEqualToString:@"3"]) {
        cell.model = self.districtDataSouce[indexPath.row];
    }
    if ([self.level isEqualToString:@"4"]) {
        
    }
    if ([self.level isEqualToString:@"5"]) {
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger level = [self.level integerValue];
    if (self.selectionBlock) {
        switch (level) {
            case 1:{//
                WGAddressModel *model = self.dataArray[indexPath.row];
                for (WGAddressModel *model1 in self.dataArray) {
                    model1.isSelected = NO;
                }
                model.isSelected = YES;
                self.province = model.name;
                [self addTopBarItem];
                [self setUpAddress:model.name];
                self.selectionBlock(model);
                
            }
                break;
            case 2:{//
                WGAddressModel *model = self.cityDataSouce[indexPath.row];
                for (WGAddressModel *model1 in self.cityDataSouce) {
                    model1.isSelected = NO;
                }
                model.isSelected = YES;
                self.city = model.name;
                [self addTopBarItem];
                [self setUpAddress:model.name];
                self.selectionBlock(model);
            }
                break;
            case 3:{//
                WGAddressModel *model = self.districtDataSouce[indexPath.row];
                for (WGAddressModel *model1 in self.districtDataSouce) {
                    model1.isSelected = NO;
                }
                model.isSelected = YES;
                self.county = model.name;
                self.areaStr = [NSString stringWithFormat:@"%@ %@ %@",self.province,self.city,self.county];
                [self setUpAddress:model.name];
                NSDictionary * dict = @{@"areaCode":model.code,
                                        @"address":self.areaStr,
                                        @"orgId":model.ID
                                        };
                if (self.areaFinish) {
                    self.areaFinish(dict);
                }
            }
                break;
            case 4:{//
                
            }
                break;
            default:{//
                
            }
                break;
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationNone)];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:(UITableViewScrollPositionNone)];
    }
}

#pragma mark --- 私有方法

/**
 设置按钮name
 */
- (void)setUpAddress:(NSString *)address {
    NSInteger idx = [self.level integerValue]-1;
    UIButton * btn = self.topTabbarItems[idx];
    [btn setTitle:address forState:UIControlStateNormal];
    [btn sizeToFit];
    [_topTabbar layoutIfNeeded];
}

/**
 地址按钮点击
 */
- (void)topBarItemClick:(UIButton *)sender{
    self.level = [NSString stringWithFormat:@"%ld",(long)sender.tag - 100];
    if (sender.tag == 101) {
        if ([NSString stringIsNULL:self.province]) {
            return;
        }
        [self.topTabbarItems[1] performSelector:@selector(removeFromSuperview) withObject:nil];
        [self.topTabbarItems.lastObject performSelector:@selector(removeFromSuperview) withObject:nil];
        [self.topTabbarItems removeLastObject];
        [self.topTabbarItems removeLastObject];
    }
    if (sender.tag == 102) {
    
        [self.topTabbarItems.lastObject performSelector:@selector(removeFromSuperview) withObject:nil];
        [self.topTabbarItems removeLastObject];
    }
    if (sender.tag == 103) {

    }
    if (sender.tag == 104) {
        
    }
    if (sender.tag == 105) {
        
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationRight)];
}

/*! 显示 */
-(void)show{
    [self addSubview:self.baseView];
    [self.baseView setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, self.baseViewHeight)];
    [UIView animateWithDuration:.3 animations:^{
        [self.baseView setFrame:CGRectMake(0, (iPhoneXAll?ScreenHeight+44:ScreenHeight) - self.baseViewHeight, ScreenWidth, self.baseViewHeight)];
        self.backgroundColor = RGBA(0, 0, 0, 0.4);
        [self layoutIfNeeded];
    }];
}
/*! 消失 */
-(void)dismiss{
    [UIView animateWithDuration:.3 animations:^{
        [self.baseView setFrame:CGRectMake(0, (iPhoneXAll?ScreenHeight+44:ScreenHeight), ScreenWidth, self.baseViewHeight)];
        self.backgroundColor = RGBA(0, 0, 0, 0);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
}


@end
